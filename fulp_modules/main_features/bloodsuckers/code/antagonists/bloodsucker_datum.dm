/datum/antagonist/bloodsucker
	name = "Bloodsucker"
	show_in_antagpanel = TRUE
	roundend_category = "bloodsuckers"
	antagpanel_category = "Bloodsucker"
	job_rank = ROLE_BLOODSUCKER
	show_name_in_check_antagonists = TRUE
	can_coexist_with_others = FALSE
	hijack_speed = 0.5
	/// List of all Antagonists that can't be vassalized.
	var/list/vassal_banned_antags = list(
		/datum/antagonist/bloodsucker, /datum/antagonist/vassal, /datum/antagonist/monsterhunter,
		/datum/antagonist/changeling, /datum/antagonist/wizard, /datum/antagonist/wizard/apprentice,
		/datum/antagonist/cult, /datum/antagonist/xeno, /datum/antagonist/obsessed,
		/datum/antagonist/ert/safety_moth, /datum/antagonist/wishgranter,
		)

	/// Used for assigning your name
	var/bloodsucker_name
	var/bloodsucker_title
	var/bloodsucker_reputation

	/*
	 *	# Clan stuff
	 *
	 *	Used for tracking Vampireclan, which tracks Sol
	 *	Also used to track your vassals, your creator, and what clan you're in.
	 */
	var/datum/team/vampireclan/clan
	/// You get assigned a Clan once you Rank up enough
	var/my_clan = null
	/// Vassals under my control. Periodically remove the dead ones.
	var/list/datum/antagonist/vassal/vassals = list()
	/// Who made me? For both Vassals AND Bloodsuckers (though Master Vamps won't have one)
	var/datum/mind/creator

	/// Powers
	var/list/datum/action/powers = list()
	var/poweron_feed = FALSE
	var/poweron_masquerade = FALSE

	/// Stats that change throughout the round and used for Ranking up.
	var/bloodsucker_level
	var/bloodsucker_level_unspent = 1
	var/additional_regen
	var/bloodsucker_regen_rate = 0.3
	var/feed_amount = 15
	var/max_blood_volume = 600

	/// Used for Bloodsucker Objectives
	var/area/lair
	var/obj/structure/closet/crate/coffin

	/// Used in Bloodsucker huds
	var/valuecolor

	/*
	 *	# TRACKING
	 *
	 *	These are all used for Tracking Bloodsucker stats and such.
	 */
	/// How much food to throw up later. You shouldn't have eaten that.
	var/foodInGut
	/// So we only get the locker burn message once per day.
	var/warn_sun_locker
	/// So we only get the sun burn message once per day.
	var/warn_sun_burn
	/// The amount of blood we loose each bloodsucker life tick LifeTick()
	var/passive_blood_drain = -0.1
	/// Var to see if you are healing for preventing spam of the chat message inform the user of such
	var/notice_healing
	/// Have we reached final death?
	var/AmFinalDeath = FALSE
	/// Are we currently in a Frenzy? - Martial Art also used in Frenzy
	var/Frenzied = FALSE
	var/datum/martial_art/frenzygrab/frenzygrab = new
	/// Have we selected our Favorite Vassal yet? - This is Ventrue only!
	var/my_favorite_vassal = FALSE
	/// Default traits ALL Bloodsuckers get.
	var/static/list/defaultTraits = list(
		TRAIT_NOBREATH, TRAIT_SLEEPIMMUNE, TRAIT_NOCRITDAMAGE,\
		TRAIT_RESISTCOLD, TRAIT_RADIMMUNE, \
		TRAIT_STABLEHEART, TRAIT_NOSOFTCRIT, TRAIT_NOHARDCRIT,\
		TRAIT_AGEUSIA, TRAIT_NOPULSE, TRAIT_COLDBLOODED,\
		TRAIT_VIRUSIMMUNE, TRAIT_TOXIMMUNE, TRAIT_HARDLY_WOUNDED,\
		) // TRAIT_HARDLY_WOUNDED can be swapped with TRAIT_NEVER_WOUNDED if it's too unbalanced. -- Remember that Fortitude gives NODISMEMBER when balancing Traits!


/// These handles the application of antag huds/special abilities
/datum/antagonist/bloodsucker/apply_innate_effects(mob/living/mob_override)
	RegisterSignal(owner.current, COMSIG_LIVING_BIOLOGICAL_LIFE, .proc/LifeTick)
	return

/datum/antagonist/bloodsucker/remove_innate_effects(mob/living/mob_override)
	UnregisterSignal(owner.current, COMSIG_LIVING_BIOLOGICAL_LIFE)
	return

/// Called by the add_antag_datum() mind proc after the instanced datum is added to the mind's antag_datums list.
/datum/antagonist/bloodsucker/on_gain()
	forge_bloodsucker_objectives()
	/// Start Sunlight if first Bloodsucker
	clan.check_start_sunlight()
	AssignStarterPowersAndStats()
	/// Name & Title
	SelectFirstName()
	/// If I have a creator, then set as Fledgling.
	SelectTitle(am_fledgling = TRUE)
	SelectReputation(am_fledgling = TRUE)
	update_bloodsucker_icons_added(owner.current, "bloodsucker")
	. = ..()

/// Called by the remove_antag_datum() and remove_all_antag_datums() mind procs for the antag datum to handle its own removal and deletion.
/datum/antagonist/bloodsucker/on_removal()
	/// End Sunlight? (if last Vamp)
	clan.check_cancel_sunlight()
	ClearAllPowersAndStats()
	update_bloodsucker_icons_removed(owner.current)
	if(!LAZYLEN(owner.antag_datums))
		owner.current.remove_from_current_living_antags()
	return ..()

/datum/antagonist/bloodsucker/greet()
	var/fullname = ReturnFullName(TRUE)
	to_chat(owner, "<span class='userdanger'>You are [fullname], a strain of vampire known as a bloodsucker!</span><br>")
	owner.announce_objectives()
	to_chat(owner, "<span class='announce'>* Other Bloodsuckers are not necessarily your friends, but your survival may depend on cooperation. Betray them at your own discretion and peril.<br> \
	* Bloodsucker Tip: Rest in a <i>Coffin</i> to claim it, and that area, as your lair.<br> \
	* Bloodsucker Tip: Fear the daylight! Solar flares will bombard the station periodically, and your coffin can guarantee your safety.<br> \
	* Bloodsucker Tip: You regenerate your health slowly, you're weak to fire, and you depend on blood to survive. Don't allow your blood to run too low, or you'll enter a Frenzy!<br> \
	* Bloodsucker Tip: Medical and Genetic Analyzers can sell you out, your Masquerade ability will forge results for you to prevent this.<br> \
	* You can find an in-depth guide at : https://wiki.fulp.gg/en/Bloodsucker </span>")
	if(bloodsucker_level_unspent >= 2)
		to_chat(owner, "<span class='announce'>As a latejoiner, you have [bloodsucker_level_unspent] bonus Ranks, entering your claimed coffin allows you to spend a Rank.</span><br>")
	owner.current.playsound_local(null, 'fulp_modules/main_features/bloodsuckers/sounds/BloodsuckerAlert.ogg', 100, FALSE, pressure_affected = FALSE)
	antag_memory += "Although you were born a mortal, in undeath you earned the name <b>[fullname]</b>.<br>"

/datum/antagonist/bloodsucker/farewell()
	to_chat(owner.current, "<span class='userdanger'><FONT size = 3>With a snap, your curse has ended. You are no longer a Bloodsucker. You live once more!</FONT></span>")
	/// Refill with Blood so they don't instantly die.
	owner.current.blood_volume = max(owner.current.blood_volume, BLOOD_VOLUME_NORMAL)

/datum/antagonist/bloodsucker/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/bloodsucker/proc/remove_objectives(datum/objective/O)
	objectives -= O

/// Called when using admin tools to give antag status
/datum/antagonist/bloodsucker/admin_add(datum/mind/new_owner,mob/admin)
	message_admins("[key_name_admin(admin)] made [key_name_admin(new_owner)] into [name].")
	log_admin("[key_name(admin)] made [key_name(new_owner)] into [name].")
	new_owner.add_antag_datum(src)


/*
 *	# Vampire Clan
 *
 *	This is used for dealing with the Vampire Clan. While there are comments and ideas on how this should be used,
 *	due to gamemode's removal, this was recycled to be used for Sol.
 *	We're using some workarounds, using Wizard's roundend report, to get it to show the individual Bloodsucker, rather than the team.
 *	None of this should actually be appearing in game, and all Bloodsuckers should be using their own individual roundend report.
 */

/datum/team/vampireclan
	name = "Clan" // Teravanni,

	/// Sunlight Timer. Created on first Bloodsucker assign. Destroyed on last removed Bloodsucker.
	var/obj/effect/sunlight/bloodsucker_sunlight

/datum/antagonist/bloodsucker/create_team(datum/team/vampireclan/team)
	if(!team)
		for(var/datum/antagonist/bloodsucker/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.clan)
				clan = H.clan
				return
		clan = new /datum/team/vampireclan
		addtimer(CALLBACK(src, .proc/spawn_monster_hunters), 25 MINUTES)
		return
	if(!istype(team))
		stack_trace("Wrong team type passed to [type] initialization.")
	clan = team

/// Spawn a Monster Hunter 25 minutes into the Round. The Round event control will make sure there's actually any Bloodsuckers alive.
/datum/antagonist/bloodsucker/proc/spawn_monster_hunters()
	/// Don't trigger if there's not many Bloodsuckers, please.
	if(clan.members.len <= 1)
		return
	var/datum/round_event_control/monster_hunters/DC = locate(/datum/round_event_control/monster_hunters) in SSevents.control
	DC.runEvent()

/datum/antagonist/bloodsucker/get_team()
	return clan

/datum/team/vampireclan/roundend_report()
	var/list/report = list()
	report += "<span class='header'>Lurking in the darkness, the Bloodsuckers were:</span><br>"
	for(var/datum/mind/M in members)
		for(var/datum/antagonist/bloodsucker/H in M.antag_datums)
			report += H.roundend_report()

	return "<div class='panel redborder'>[report.Join("<br>")]</div>"

/// Individual roundend report
/datum/antagonist/bloodsucker/roundend_report()
	/// Get the default Objectives
	var/list/report = list()
	/// Vamp Name
	report += "<br><span class='header'><b>\[[ReturnFullName(TRUE)]\]</b></span>"
	report += printplayer(owner)
	/// Clan Name
	if(my_clan != null)
		report += "They were part of the <b>[my_clan]</b>!"

	/// Default Report
	var/objectives_complete = TRUE
	if(objectives.len)
		report += printobjectives(objectives)
		for(var/datum/objective/objective in objectives)
			if(!objective.check_completion())
				objectives_complete = FALSE
				break

	/// Now list their vassals
	if(vassals.len > 0)
		report += "<span class='header'>Their Vassals were...</span>"
		for(var/datum/antagonist/vassal/V in vassals)
			if(V.owner)
				var/jobname = V.owner.assigned_role ? "the [V.owner.assigned_role]" : ""
				report += "<b>[V.owner.name]</b> [jobname]"

	if(objectives.len == 0 || objectives_complete)
		report += "<span class='greentext big'>The [name] was successful!</span>"
	else
		report += "<span class='redtext big'>The [name] has failed!</span>"

	return report

/*
 *	# Assigning Sol
 *
 *	Sol is the sunlight, during this period, all Bloodsuckers must be in their coffin, else they burn and die.
 *	This is tied to the Vampire Clan team's datum, originally was tied to game_mode, which TG has since deleted, forcing us to use something else.
 */

/// Start Sun, called when someone is assigned Bloodsucker
/datum/team/vampireclan/proc/check_start_sunlight()
	if(members.len <= 1)
		for(var/datum/mind/M in members)
			message_admins("New Sol has been created due to Bloodsucker assignement.")
			bloodsucker_sunlight = new()

/// End Sol, if you're the last Bloodsucker
/datum/team/vampireclan/proc/check_cancel_sunlight()
	/// No minds in the clan? Delete Sol.
	if(members.len <= 1)
		message_admins("Sol has been deleted due to the lack of Bloodsuckers")
		qdel(bloodsucker_sunlight)
//		bloodsucker_sunlight = null // Note: Not sure what this is meant to do, but everything works without it.

/// Buying powers
/datum/antagonist/bloodsucker/proc/BuyPower(datum/action/bloodsucker/power)
	powers += power
	power.Grant(owner.current)

/datum/antagonist/bloodsucker/proc/AssignStarterPowersAndStats()
	/// Purchase Roundstart Powers
	BuyPower(new /datum/action/bloodsucker/feed)
	BuyPower(new /datum/action/bloodsucker/masquerade)
	BuyPower(new /datum/action/bloodsucker/veil)
	/// Give Bloodsucker Traits
	for(var/T in defaultTraits)
		ADD_TRAIT(owner.current, T, BLOODSUCKER_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_GENELESS, SPECIES_TRAIT)
	// Traits: Species
	if(iscarbon(owner.current))
		var/mob/living/carbon/human/H = owner.current
		var/datum/species/S = H.dna.species
		S.species_traits += DRINKSBLOOD
	/// Clear Addictions
	for(var/addiction_type in subtypesof(/datum/addiction))
		owner.current.mind.remove_addiction_points(addiction_type, MAX_ADDICTION_POINTS)
	/// No Skittish "People" allowed
	if(HAS_TRAIT(owner.current, TRAIT_SKITTISH))
		REMOVE_TRAIT(owner.current, TRAIT_SKITTISH, ROUNDSTART_TRAIT)
	/// Clear Disabilities
	CureDisabilities()
	/// Stats
	if(ishuman(owner.current))
		var/mob/living/carbon/human/H = owner.current
		var/datum/species/S = H.dna.species
		/// Make Changes
		S.punchdamagelow += 1 //lowest possible punch damage   0
		S.punchdamagehigh += 1 //highest possible punch damage	 9
		if(istype(H) && owner.assigned_role == "Clown")
			H.dna.remove_mutation(CLOWNMUT)
			to_chat(H, "As a vampiric clown, you are no longer a danger to yourself. Your clownish nature has been subdued by your thirst for blood.")
	/// Tongue & Language
	owner.current.grant_all_languages(FALSE, FALSE, TRUE)
	owner.current.grant_language(/datum/language/vampiric)
	/// Heart
	CheckVampOrgans()
	/// Eyes
	var/mob/living/carbon/user = owner.current
	var/obj/item/organ/eyes/E = user.getorganslot(ORGAN_SLOT_EYES)
	if(E)
		E.flash_protect -= 1
		E.sight_flags = SEE_MOBS
		E.see_in_dark = 8
		E.lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	user.update_sight()

/datum/antagonist/bloodsucker/proc/ClearAllPowersAndStats()
	/// Remove huds
	remove_hud()
	// Powers
	while(powers.len)
		var/datum/action/bloodsucker/power = pick(powers)
		powers -= power
		power.Remove(owner.current)
		// owner.RemoveSpell(power)
	/// Stats
	if(ishuman(owner.current))
		var/mob/living/carbon/human/H = owner.current
		var/datum/species/S = H.dna.species
		S.species_traits -= DRINKSBLOOD
		// Clown
		if(istype(H) && owner.assigned_role == "Clown")
			H.dna.add_mutation(CLOWNMUT)
	/// Remove ALL Traits, as long as its from BLOODSUCKER_TRAIT's source. - This is because of unique cases like Nosferatu getting Ventcrawling.
	for(var/T in owner.current.status_traits)
		REMOVE_TRAIT(owner.current, T, BLOODSUCKER_TRAIT)
	/// Update Health
	owner.current.setMaxHealth(MAX_LIVING_HEALTH)
	// Language
	owner.current.remove_language(/datum/language/vampiric)
//	owner.current.hellbound = FALSE
	/// Heart
	RemoveVampOrgans()
	/// Eyes
	var/mob/living/carbon/user = owner.current
	var/obj/item/organ/eyes/E = user.getorganslot(ORGAN_SLOT_EYES)
	if(E)
		E.flash_protect += 1
		E.sight_flags = 0
		E.see_in_dark = 2
		E.lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
	user.update_sight()

/datum/antagonist/bloodsucker/proc/RankUp()
	set waitfor = FALSE
	if(!owner || !owner.current)
		return
	bloodsucker_level_unspent++
	// Spend Rank Immediately?
	if(istype(owner.current.loc, /obj/structure/closet/crate/coffin))
		if(my_clan == CLAN_VENTRUE)
			to_chat(owner, "<span class='announce'>You have recieved a new Rank to level up your Favorite Vassal with!</span><br>")
			return
		SpendRank()
	else
		to_chat(owner, "<EM><span class='notice'>You have grown more ancient! Sleep in a coffin that you have claimed to thicken your blood and become more powerful.</span></EM>")
		if(bloodsucker_level_unspent >= 2)
			to_chat(owner, "<span class='announce'>Bloodsucker Tip: If you cannot find or steal a coffin to use, you can build one from wooden planks.</span><br>")

/datum/antagonist/bloodsucker/proc/LevelUpPowers()
	for(var/datum/action/bloodsucker/power in powers)
		power.level_current++

/datum/antagonist/bloodsucker/proc/SpendRank()
	set waitfor = FALSE

	if(bloodsucker_level_unspent <= 0 || !owner || !owner.current || !owner.current.client)
		return
	/// Purchase Power Prompt
	var/list/options = list()
	for(var/pickedpower in typesof(/datum/action/bloodsucker))
		var/datum/action/bloodsucker/power = pickedpower
		/// Check If I don't own it & I'm allowed to buy it.
		if(!(locate(power) in powers) && initial(power.bloodsucker_can_buy))
			options[initial(power.name)] = power

	/// No powers to purchase? Abort.
	if(options.len >= 1)
		/// Give them the UI to purchase a power.
		var/choice = tgui_input_list(owner.current, "You have the opportunity to grow more ancient. Select a power to advance your Rank.", "Your Blood Thickens...", options)
		/// Prevent Bloodsuckers from closing/reopning their coffin to spam Levels.
		if(bloodsucker_level_unspent <= 0)
			/// Already spent all your points, and tried opening/closing your coffin, pal.
			return
		/// Prevent Bloodsuckers from purchasing a power while outside of their Coffin.
		if(!istype(owner.current.loc, /obj/structure/closet/crate/coffin))
			to_chat(owner.current, "<span class='warning'>Return to your coffin to advance your Rank.</span>")
			return
		/// Did you choose a power? Do you already have it? - Added due to window stacking.
		if(!choice || !options[choice] || (locate(options[choice]) in powers))
			to_chat(owner.current, "<span class='notice'>You prevent your blood from thickening just yet, but you may try again later.</span>")
			return
		/// Good to go - Buy Power!
		var/datum/action/bloodsucker/P = options[choice]
		BuyPower(new P)
		to_chat(owner.current, "<span class='notice'>You have learned how to use [initial(P.name)]!</span>")
	/// No more powers available to purchase? Start levelling up anyways.
	else
		to_chat(owner.current, "<span class='notice'>You grow more ancient by the night!</span>")

	/// Advance Powers - Includes the one you just purchased.
	LevelUpPowers()
	/// Bloodsucker-only Stat upgrades
	bloodsucker_regen_rate += 0.05
	feed_amount += 2
	max_blood_volume += 100
	/// Misc. Stats Upgrades
	if(ishuman(owner.current))
		var/mob/living/carbon/human/H = owner.current
		var/datum/species/S = H.dna.species
		S.punchdamagelow += 0.5
		/// This affects the hitting power of Brawn.
		S.punchdamagehigh += 0.5
	owner.current.setMaxHealth(owner.current.maxHealth + 5) // Why is this a thing...

	/// We're almost done - Spend your Rank now.
	bloodsucker_level++
	bloodsucker_level_unspent--

	/// Ranked up enough? Let them join a Clan.
	if(bloodsucker_level == 3)
		AssignClanAndBane()

	/// Alright, enough playing around, get your true Reputation.
	if(bloodsucker_level == 4)
		SelectReputation(am_fledgling = FALSE, forced = TRUE)

	/// Done! Let them know & Update their HUD.
	to_chat(owner.current, "<span class='notice'>You are now a rank [bloodsucker_level] Bloodsucker. Your strength, health, feed rate, regen rate, and maximum blood capacity have all increased!</span>")
	to_chat(owner.current, "<span class='notice'>Your existing powers have all ranked up as well!</span>")
	update_hud(owner.current)
	owner.current.playsound_local(null, 'sound/effects/pope_entry.ogg', 25, TRUE, pressure_affected = FALSE)

/datum/antagonist/bloodsucker/proc/SpendVassalRank(mob/living/target)
	set waitfor = FALSE

	var/datum/antagonist/vassal/vassaldatum = target.mind.has_antag_datum(/datum/antagonist/vassal)
	/// Purchase Power Prompt
	var/list/options = list()
	for(var/pickedpower in typesof(/datum/action/bloodsucker))
		var/datum/action/bloodsucker/power = pickedpower
		/// Check If I don't own it & I'm allowed to buy it.
		if(!(locate(power) in vassaldatum.powers) && initial(power.vassal_can_buy))
			options[initial(power.name)] = power

	/// No powers to purchase? Abort.
	if(options.len >= 1)
		/// Give them the UI to purchase a power.
		var/choice = tgui_input_list(owner.current, "You have the opportunity to level up your Favorite Vassal at the cost of 100 Blood. Select a power you wish them to recieve.", "You feel like a Leader!", options)
		/// Safety Check
		if(bloodsucker_level_unspent <= 0)
			return
		/// Did you choose a power? Do you already have it? - Added due to window stacking.
		if(!choice || !options[choice] || (locate(options[choice]) in vassaldatum.powers))
			to_chat(owner.current, "<span class='notice'>You prevent your blood from thickening just yet, but you may try again later.</span>")
			return
		/// Good to go - Buy Power!
		owner.current.blood_volume -= 100
		var/datum/action/bloodsucker/P = options[choice]
		vassaldatum.BuyPower(new P)
		to_chat(owner.current, "<span class='notice'>You taught [target] how to use [initial(P.name)]!</span>")
		to_chat(target, "<span class='notice'>Your master taught you how to use [initial(P.name)]!</span>")

	else
		to_chat(owner.current, "<span class='notice'>You grow more ancient by the night!</span>")

	/* # As we don't level up normally, Bloodsuckers will Rank Up themselves this way.
	*/

	/// Advance your and your Vassal's Powers - Includes the one you just purchased.
	vassaldatum.LevelUpPowers()
	LevelUpPowers()
	/// Bloodsucker-only Stat upgrades
	bloodsucker_regen_rate += 0.05
	feed_amount += 2
	max_blood_volume += 100
	/// Misc. Stats Upgrades
	if(ishuman(owner.current))
		var/mob/living/carbon/human/H = owner.current
		var/datum/species/S = H.dna.species
		S.punchdamagelow += 0.5
		/// This affects the hitting power of Brawn.
		S.punchdamagehigh += 0.5
	owner.current.setMaxHealth(owner.current.maxHealth + 5) // Why is this a thing...

	/// We're almost done - Spend your Rank now.
	vassaldatum.vassal_level++
	bloodsucker_level++
	bloodsucker_level_unspent--

	/// Vassals will turn more into a 'Bloodsucker' overtime
	if(vassaldatum.vassal_level == 2)
		ADD_TRAIT(target, TRAIT_COLDBLOODED, BLOODSUCKER_TRAIT)
		ADD_TRAIT(target, TRAIT_NOBREATH, BLOODSUCKER_TRAIT)
		to_chat(target, "<span class='notice'>Your blood begins you feel cold as you stop breathing...</span>")
	if(vassaldatum.vassal_level == 3)
		ADD_TRAIT(target, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT)
		ADD_TRAIT(target, TRAIT_VIRUSIMMUNE, BLOODSUCKER_TRAIT)
		to_chat(target, "<span class='notice'>You feel your Master's blood begin to protect you from Diseases.</span>")
	if(vassaldatum.vassal_level == 4)
		ADD_TRAIT(target, TRAIT_NOPULSE, BLOODSUCKER_TRAIT)
		ADD_TRAIT(target, TRAIT_STABLEHEART, BLOODSUCKER_TRAIT)
		to_chat(target, "<span class='notice'>You feel your heart stop pumping for the last time as you begin to thirst for blood, you will no longer naturally regenerate Blood!</span>")
		vassaldatum.BuyPower(new /datum/action/bloodsucker/feed)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Assign default team and creates one for one of a kind team antagonists

/// Create Objectives
/datum/antagonist/bloodsucker/proc/forge_bloodsucker_objectives() // Fledgling vampires can have different objectives.

	// TEAM
	//clan = new /datum/team/vampireclan(owner)


	// Lair Objective
	var/datum/objective/bloodsucker/lair/lair_objective = new
	lair_objective.owner = owner
	lair_objective.generate_objective()
	add_objective(lair_objective)

	// Protege Objective
	var/datum/objective/bloodsucker/protege/protege_objective = new
	protege_objective.owner = owner
	protege_objective.generate_objective()
	add_objective(protege_objective)

	switch(rand(0,1))
		if(0) // Heart Thief Objective
			var/datum/objective/bloodsucker/heartthief/heartthief_objective = new
			heartthief_objective.owner = owner
			heartthief_objective.generate_objective()
			add_objective(heartthief_objective)
		if(1) // Vassalize Target Objective
			var/datum/objective/bloodsucker/vassalhim/vassalhim_objective = new
			vassalhim_objective.owner = owner
			vassalhim_objective.find_target()
			add_objective(vassalhim_objective)

	// Survive Objective
	var/datum/objective/bloodsucker/survive/survive_objective = new
	survive_objective.owner = owner
	survive_objective.generate_objective()
	add_objective(survive_objective)


/*
/// Name shown on antag list
/datum/antagonist/bloodsucker/antag_listing_name()
	return ..() + "([ReturnFullName(TRUE)])"
*/

/// Whatever interesting things happened to the antag admins should know about
/// Include additional information about antag in this part
/datum/antagonist/bloodsucker/antag_listing_status()
	if(owner && AmFinalDeath)
		return "<font color=red>Final Death</font>"
	return ..()



/*
 *			2019 Breakdown of Bloodsuckers:
 *
 *					G A M E P L A Y
 *
 *	Bloodsuckers should be inherently powerful: they never stay dead, and they can hide in plain sight
 * 	better than any other antagonist aboard the station.
 *
 *	However, only elder Bloodsuckers are the powerful creatures of legend. Ranking up as a Bloodsucker
 *	should impart slight strength and health benefits, as well as powers that can grow over time. But
 *	their weaknesses should grow as well, and not just to fire.
 *
 *
 *					A B I L I T I E S
 *
 *	* Bloodsuckers can FEIGN LIFE + DEATH.
 *		Feigning LIFE:
 *			- Warms up the body
 *			- Creates a heartbeat
 *			- Fake blood amount (550)
 *		Feign DEATH: Not yet done
 *			- When lying down or sitting, you appear "dead and lifeless"
 *
 *	* Bloodsuckers REGENERATE
 *		- Brute damage heals rather rapidly. Burn damage heals slowly.
 *		- Healing is reduced when hungry or starved.
 *		- Burn does not heal when starved. A starved vampire remains "dead" until burns can heal.
 *		- Bodyparts and organs regrow in Torpor (except for the Heart and Brain).
 *
 *	* Bloodsuckers are IMMORTAL
 *		- Brute damage cannot destroy them (and it caps very low, so they don't stack too much)
 *		- Burn damage can only kill them at very high amounts.
 *		- Removing the head kills the vamp forever.
 *		- Removing the heart kills the vamp until replaced.
 *
 *	* Bloodsuckers are DEAD
 *		- They do not breathe.
 *		- Cold affects them less.
 *		- They are immune to disease (but can spread it)
 *		- Food is useless and cause sickness.
 *		- Nothing can heal the vamp other than his own blood.
 *
 *	* Bloodsuckers are PREDATORS
 *		- They detect life/heartbeats nearby.
 *		- They know other predators instantly (Vamps, Werewolves, and alien types) regardless of disguise.
 *
 *
 *
 *	* Bloodsuckers enter Torpor when DEAD or RESTING in coffin
 *		- Torpid vampires regenerate their health. Coffins negate cost and speed up the process.
 *		** To rest in a coffin, either SLEEP or CLOSE THE LID while you're in it. You will be given a prompt to sleep until healed. Healing in a coffin costs NO blood!
 *
 *
 *
 *
 *				O B J E C T I V E S
 *
 *
 *
 *	1) GROOM AN HEIR:	Find a person with appropriate traits (hair, blood type, gender) to be turned as a Vampire. Before they rise, they must be properly trained. Raise them to great power after their change.
 *
 *	2) BIBLIOPHILE:		Research objects of interest, study items looking for clues of ancient secrets, and hunt down the clues to a Vampiric artifact of horrible power.
 *
 *	3) CRYPT LORD:		Build a terrifying sepulcher to your evil, with servants to lavish upon you in undeath. The trappings of a true crypt lord come at a grave cost.
 *
 *	4) GOURMAND:		Oh, to taste all the delicacies the station has to offer! DRINK ## BLOOD FROM VICTIMS WHO LIVE, EAT ## ORGANS FROM VICTIMS WHO LIVE
 *
 *			Vassals
 *
 *	- Loyal to their Master
 *	- Master can speak to, summon, or punish his Vassals, even while asleep or torpid.
 *	- Master may have as many Vassals as they want
 *
 *
 *
 *			Dev Notes
 *
 *	HEALING: Maybe Vamps metabolize specially? Like, they slowly drip their own blood into their system?
 *			- Give Vamps their own metabolization proc, perhaps?
 *			** shadowpeople.dm has rules for healing.
 *
 *	KILLING: It's almost impossible to track who someone has directly killed. But an Admin could be given
 *			an easy way to whip a Bloodsucker for cruel behavior, as an RP mechanic but not a punishment.
 *			**
 *
 *	HUNGER:  Just keep adjusting mob's nutrition to Blood Hunger level. No need to cancel nutrition from eating.
 *			** mob.dm /set_nutrition()
 *			** snacks.dm / attack()  <-- Stop food from doing anything?
 *
 *	ORGANS:  Liver
 *			** life.dm /handle_liver()
 *
 *	CORPSE:	Most of these effects likely go away when using "Masquerade" to appear alive.
 *			** status_procs.dm /adjust_bodytemperature()
 *			** traits.dm /TRAIT_NOBREATH /TRAIT_SLEEPIMMUNE /TRAIT_RESISTCOLD /TRAIT_RADIMMUNE  /TRAIT_VIRUSIMMUNE
 *			*  MASQUERADE ON/OFF: /TRAIT_FAKEDEATH (M)
 *			* /TRAIT_NIGHT_VISION
 *			* /TRAIT_FAKEDEATH <-- This basically makes you immobile. When using status_procs /fakedeath(), make sure to remove Coma unless we're in Torpor!
 *			* /TRAIT_NODEATH <--- ???
 *			** species  /NOZOMBIE
 *			* ADD: TRAIT_COLDBLOODED <-- add to carbon/life.dm /natural_bodytemperature_stabilization()
 *
 *	MASQUERADE	Appear as human!
 *				** examine.dm /examine() <-- Change "blood_volume < BLOOD_VOLUME_SAFE" to a new examine
 *
 *	NOSFERATU ** human.add_trait(TRAIT_DISFIGURED, "insert_vamp_datum_here") <-- Makes you UNKNOWN unless your ID says otherwise.
 *	STEALTH   ** human_helpers.dm /get_visible_name()     ** shadowpeople.dm has rules for Light.
 *
 *	FRENZY	** living.dm /update_mobility() (USED TO be update_canmove)
 *
 *	PREDATOR See other Vamps!
 *		    * examine.dm /examine()
 *
 *	WEAKNESSES:	-Poor mood in Chapel or near Chaplain.  -Stamina damage from Bible
 *
 *
 *
 *	//message_admins("DEBUG3: attempt_cast() [name] / [user_C.handcuffed] ")
 *
 *
 *	TODO:
 *
 *	Death (fire, heart, brain, head)
 *	Disable Life: BLOOD
 *	Body Temp
 *	Spend blood over time (more if imitating life) (none if sleeping in coffin)
 *	Auto-Heal (brute to 0, fire to 99) (toxin/o2 always 0)
 *
 *	Hud Icons
 *	UI Blood Counter
 *	Examine Name (+Masquerade, only "Dead and lifeless" if not standing?)
 *
 *
 *	Turn vamps
 *	Create vassals
 *
 *
 *
 *	FIX LIST
 */

/*
 *	# Bloodsucker Names
 *
 *	All Bloodsuckers get a name, and gets a better one when they hit Rank 4.
 */

/// Names
/datum/antagonist/bloodsucker/proc/SelectFirstName()
	if(owner.current.gender == MALE)
		bloodsucker_name = pick("Desmond","Rudolph","Dracula","Vlad","Pyotr","Gregor","Cristian","Christoff","Marcu","Andrei","Constantin","Gheorghe","Grigore","Ilie","Iacob","Luca","Mihail","Pavel","Vasile","Octavian","Sorin", \
						"Sveyn","Aurel","Alexe","Iustin","Theodor","Dimitrie","Octav","Damien","Magnus","Caine","Abel", // Romanian/Ancient
						"Lucius","Gaius","Otho","Balbinus","Arcadius","Romanos","Alexios","Vitellius",  // Latin
						"Melanthus","Teuthras","Orchamus","Amyntor","Axion",  // Greek
						"Thoth","Thutmose","Osorkon,","Nofret","Minmotu","Khafra", // Egyptian
						"Dio")

	else
		bloodsucker_name = pick("Islana","Tyrra","Greganna","Pytra","Hilda","Andra","Crina","Viorela","Viorica","Anemona","Camelia","Narcisa","Sorina","Alessia","Sophia","Gladda","Arcana","Morgan","Lasarra","Ioana","Elena", \
						"Alina","Rodica","Teodora","Denisa","Mihaela","Svetla","Stefania","Diyana","Kelssa","Lilith", // Romanian/Ancient
						"Alexia","Athanasia","Callista","Karena","Nephele","Scylla","Ursa",  // Latin
						"Alcestis","Damaris","Elisavet","Khthonia","Teodora",  // Greek
						"Nefret","Ankhesenpep") // Egyptian

/datum/antagonist/bloodsucker/proc/SelectTitle(am_fledgling = 0, forced = FALSE)
	// Already have Title
	if(!forced && bloodsucker_title != null)
		return
	// Titles [Master]
	if(!am_fledgling)
		if(owner.current.gender == MALE)
			bloodsucker_title = pick ("Count","Baron","Viscount","Prince","Duke","Tzar","Dreadlord","Lord","Master")
		else
			bloodsucker_title = pick ("Countess","Baroness","Viscountess","Princess","Duchess","Tzarina","Dreadlady","Lady","Mistress")
		to_chat(owner, "<span class='announce'>You have earned a title! You are now known as <i>[ReturnFullName(TRUE)]</i>!</span>")
	// Titles [Fledgling]
	else
		bloodsucker_title = null

/datum/antagonist/bloodsucker/proc/SelectReputation(am_fledgling = 0, forced = FALSE)
	// Already have Reputation
	if(!forced && bloodsucker_reputation != null)
		return
	// Reputations [Master]
	if(!am_fledgling)
		bloodsucker_reputation = pick("Butcher","Blood Fiend","Crimson","Red","Black","Terror","Nightman","Feared","Ravenous","Fiend","Malevolent","Wicked","Ancient","Plaguebringer","Sinister","Forgotten","Wretched","Baleful", \
							"Inqisitor","Harvester","Reviled","Robust","Betrayer","Destructor","Damned","Accursed","Terrible","Vicious","Profane","Vile","Depraved","Foul","Slayer","Manslayer","Sovereign","Slaughterer", \
							"Forsaken","Mad","Dragon","Savage","Villainous","Nefarious","Inquisitor","Marauder","Horrible","Immortal","Undying","Overlord","Corrupt","Hellspawn","Tyrant","Sanguineous")
		if(owner.current.gender == MALE)
			if(prob(10)) // Gender override
				bloodsucker_reputation = pick("King of the Damned", "Blood King", "Emperor of Blades", "Sinlord", "God-King")
		else if(owner.current.gender == FEMALE)
			if(prob(10)) // Gender override
				bloodsucker_reputation = pick("Queen of the Damned", "Blood Queen", "Empress of Blades", "Sinlady", "God-Queen")

		to_chat(owner, "<span class='announce'>You have earned a reputation! You are now known as <i>[ReturnFullName(TRUE)]</i>!</span>")

	// Reputations [Fledgling]
	else
		bloodsucker_reputation = pick ("Crude","Callow","Unlearned","Neophyte","Novice","Unseasoned","Fledgling","Young","Neonate","Scrapling","Untested","Unproven","Unknown","Newly Risen","Born","Scavenger","Unknowing",\
							   "Unspoiled","Disgraced","Defrocked","Shamed","Meek","Timid","Broken","Fresh")

/datum/antagonist/bloodsucker/proc/AmFledgling()
	return !bloodsucker_title

/datum/antagonist/bloodsucker/proc/ReturnFullName(include_rep = FALSE)

	var/fullname
	// Name First
	fullname = (bloodsucker_name ? bloodsucker_name : owner.current.name)
	// Title
	if(bloodsucker_title)
		fullname = bloodsucker_title + " " + fullname
	// Rep
	if(include_rep && bloodsucker_reputation)
		fullname = fullname + " the " + bloodsucker_reputation

	return fullname

/////////////////////////////////////
		// HUD! //
/////////////////////////////////////

/datum/antagonist/bloodsucker/proc/update_bloodsucker_icons_added(datum/mind/m)
	var/datum/atom_hud/antag/vamphud = GLOB.huds[ANTAG_HUD_BLOODSUCKER]
	vamphud.join_hud(owner.current)
	set_antag_hud(owner.current, "bloodsucker")
	owner.current.hud_list[ANTAG_HUD].icon = image('fulp_modules/main_features/bloodsuckers/icons/bloodsucker_icons.dmi', owner.current, "bloodsucker") // FULP ADDITION! Check prepare_huds in mob.dm to see why.

/datum/antagonist/bloodsucker/proc/update_bloodsucker_icons_removed(datum/mind/m)
	var/datum/atom_hud/antag/vamphud = GLOB.huds[ANTAG_HUD_BLOODSUCKER]
	vamphud.leave_hud(owner.current)
	set_antag_hud(owner.current, null)

/// From hud.dm -- Also see data_huds.dm + antag_hud.dm
/datum/atom_hud/antag/bloodsucker

/// This checks if the Mob is a Vassal, and if the Atom is his master OR on his team.
/datum/atom_hud/antag/bloodsucker/add_to_single_hud(mob/M, atom/A)
	if(!check_valid_hud_user(M,A))
		return
	..()

 /*
 * 	// GOAL: Vassals see their Master and his other Vassals.
 *	// GOAL: Vassals can BE seen by their Bloodsucker and his other Vassals.
 *	// GOAL: Bloodsuckers can see each other.
 */

/// Remember: A is being added to M's hud. Because M's hud is a /antag/vassal hud, this means M is the vassal here.
/datum/atom_hud/antag/bloodsucker/proc/check_valid_hud_user(mob/M, atom/A)
	// Ghost Admins always see Bloodsuckers/Vassals
	if(isobserver(M))
		return TRUE

	if(!M || !A || !ismob(A) || !M.mind)// || !A.mind)
		return FALSE
	var/mob/A_mob = A
	if(!A_mob.mind)
		return FALSE
	// Find Datums: Bloodsucker
	var/datum/antagonist/bloodsucker/atom_B = A_mob.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	var/datum/antagonist/bloodsucker/mob_B = M.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	// Check 1) Are we both Bloodsuckers?
	if(atom_B && mob_B)
		return TRUE
	// Find Datums: Vassal
	var/datum/antagonist/vassal/atom_V = A_mob.mind.has_antag_datum(/datum/antagonist/vassal)
	var/datum/antagonist/vassal/mob_V = M.mind.has_antag_datum(/datum/antagonist/vassal)
	// Check 2) If they are a BLOODSUCKER, then are they my Master?
	if(mob_V && atom_B == mob_V.master)
		return TRUE // SUCCESS!
	// Check 3) If I am a BLOODSUCKER, then are they my Vassal?
	if(mob_B && atom_V && (atom_V in mob_B.vassals))
		return TRUE // SUCCESS!
	// Check 4) If we are both VASSAL, then do we have the same master?
	if(atom_V && mob_V && atom_V.master == mob_V.master)
		return TRUE // SUCCESS!
	return FALSE

/////////////////////////////////////
//  BLOOD COUNTER & RANK MARKER !  //
/////////////////////////////////////

/// 1 tile down
#define ui_blood_display "WEST:6,CENTER-1:0"
/// 2 tiles down
#define ui_vamprank_display "WEST:6,CENTER-2:-5"
/// 6 pixels to the right, zero tiles & 5 pixels DOWN.
#define ui_sunlight_display "WEST:6,CENTER-0:0"

/datum/hud/human/New(mob/living/carbon/human/owner)
	..()
	blood_display = new /atom/movable/screen/bloodsucker/blood_counter
	infodisplay += blood_display
	vamprank_display = new /atom/movable/screen/bloodsucker/rank_counter
	infodisplay += vamprank_display
	sunlight_display = new /atom/movable/screen/bloodsucker/sunlight_counter
	infodisplay += sunlight_display

/datum/hud
	var/atom/movable/screen/bloodsucker/blood_counter/blood_display
	var/atom/movable/screen/bloodsucker/rank_counter/vamprank_display
	var/atom/movable/screen/bloodsucker/sunlight_counter/sunlight_display

/datum/antagonist/bloodsucker/proc/add_hud()
	return

/datum/antagonist/bloodsucker/proc/remove_hud()
	owner.current.hud_used.blood_display.invisibility = INVISIBILITY_ABSTRACT
	owner.current.hud_used.vamprank_display.invisibility = INVISIBILITY_ABSTRACT
	owner.current.hud_used.sunlight_display.invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/bloodsucker
	icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/bloodsucker/proc/clear()
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/bloodsucker/proc/update_counter()
	invisibility = 0

/atom/movable/screen/bloodsucker/blood_counter
	name = "Blood Consumed"
	icon_state = "blood_display"
	screen_loc = ui_blood_display

/atom/movable/screen/bloodsucker/rank_counter
	name = "Bloodsucker Rank"
	icon_state = "rank"
	screen_loc = ui_vamprank_display

/atom/movable/screen/bloodsucker/sunlight_counter
	name = "Solar Flare Timer"
	icon_state = "sunlight_night"
	screen_loc = ui_sunlight_display

/// Update Blood Counter + Rank Counter
/datum/antagonist/bloodsucker/proc/update_hud(updateRank=FALSE)
	if(AmFinalDeath)
		return
	if(!owner.current.hud_used)
		return
	if(owner.current.hud_used && owner.current.hud_used.blood_display)
		if(owner.current.blood_volume > BLOOD_VOLUME_SAFE)
			valuecolor =  "#FFDDDD"
		else if(owner.current.blood_volume > BLOOD_VOLUME_BAD)
			valuecolor =  "#FFAAAA"
		owner.current.hud_used.blood_display.update_counter(owner.current.blood_volume, valuecolor)
	if(owner.current.hud_used && owner.current.hud_used.vamprank_display)
		owner.current.hud_used.vamprank_display.update_counter(bloodsucker_level, valuecolor)
		/// Only change icon on special request.
		if(updateRank)
			owner.current.hud_used.vamprank_display.icon_state = (bloodsucker_level_unspent > 0) ? "rank_up" : "rank"

/// Update Sun Time
/datum/antagonist/bloodsucker/proc/update_sunlight(value, amDay = FALSE)
	if(!owner.current.hud_used)
		return
	if(owner.current.hud_used && owner.current.hud_used.sunlight_display)
		if(amDay)
			valuecolor =  "#FF5555"
		else if(value <= 25)
			valuecolor =  "#FFCCCC"
		else if(value < 10)
			valuecolor =  "#FF5555"
		var/value_string = (value >= 60) ? "[round(value / 60, 1)] m" : "[round(value, 1)] s"
		owner.current.hud_used.sunlight_display.update_counter(value_string, valuecolor)
		owner.current.hud_used.sunlight_display.icon_state = "sunlight_" + (amDay ? "day":"night")

/atom/movable/screen/bloodsucker/blood_counter/update_counter(value, valuecolor)
	..()
	maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>[round(value,1)]</font></div>"

/atom/movable/screen/bloodsucker/rank_counter/update_counter(value, valuecolor)
	..()
	maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>[round(value,1)]</font></div>"

/atom/movable/screen/bloodsucker/sunlight_counter/update_counter(value, valuecolor)
	..()
	maptext = "<div align='center' valign='bottom' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>[value]</font></div>"
