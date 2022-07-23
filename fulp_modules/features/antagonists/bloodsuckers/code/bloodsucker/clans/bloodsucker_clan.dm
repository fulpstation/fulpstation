///List of all Bloodsuckers in a clan, separated by their clans.
GLOBAL_LIST_EMPTY(bloodsucker_clan_members)

/**
 * Bloodsucker clans
 *
 * Handles everything related to clans.
 * the entire idea of datumizing this came to me in a dream
 */
/datum/bloodsucker_clan
	///The name of the clan we're in.
	var/name = CLAN_BRUJAH
	///Description of what the clan is, given when joining and through your antag UI.
	var/description = "Brujah Clan \n\
		The Bujah Clan is as basic as you can get with Bloodsuckers \n\
		No additional abilities is gained, nothing is lost, if you want a plain Bloodsucker, this is it. \n\
		the Favorite Vassal will gain the Brawn ability, to help in combat."
	///The clan objective that is required to greentext.
	var/clan_objective
	///The icon of the radial icon to join this clan.
	var/join_icon
	///Same as join_icon, but the state
	var/join_icon_state
	///Description shown when trying to join the clan.
	var/join_description = "The default, classic Bloodsucker."
	///Whether the clan can be joined by players. FALSE for flavortext-only clans.
	var/joinable_clan = TRUE

/datum/bloodsucker_clan/New(mob/living/carbon/user)
	. = ..()
	if(!GLOB.bloodsucker_clan_members["[name]"])
		GLOB.bloodsucker_clan_members["[name]"] = list()
	GLOB.bloodsucker_clan_members["[name]"] |= user
	RegisterSignal(src, BLOODSUCKER_RANK_UP, .proc/on_rank_up)
	RegisterSignal(src, BLOODSUCKER_SPEND_RANK, .proc/on_spend_rank)
	RegisterSignal(src, BLOODSUCKER_MAKE_FAVORITE, .proc/on_favorite_vassal)
	to_chat(user, span_announce("[description]"))
	give_clan_objective(user)

/datum/bloodsucker_clan/Destroy(force, mob/living/carbon/user)
	UnregisterSignal(src, BLOODSUCKER_RANK_UP)
	UnregisterSignal(src, BLOODSUCKER_SPEND_RANK)
	UnregisterSignal(src, BLOODSUCKER_MAKE_FAVORITE)
	GLOB.bloodsucker_clan_members[name] -= user
	return ..()

/datum/bloodsucker_clan/proc/give_clan_objective(mob/living/user)
	if(isnull(clan_objective))
		return
	var/datum/objective/bloodsucker/given_objective = new clan_objective
	given_objective.owner = user.mind
	given_objective.objective_name = "Clan Objective"
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	bloodsuckerdatum.objectives += given_objective
	user.mind.announce_objectives()

///legacy code support
/datum/bloodsucker_clan/proc/get_clan()
	return name

/datum/bloodsucker_clan/proc/on_rank_up(datum/source)
	SIGNAL_HANDLER
	return COMPONENT_RANK_UP

/datum/bloodsucker_clan/proc/on_spend_rank(datum/source, datum/antagonist/bloodsucker/antag_datum, mob/living/carbon/user, mob/living/carbon/target, spend_rank = TRUE)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, .proc/spend_rank, antag_datum, user, target, spend_rank)

/datum/bloodsucker_clan/proc/spend_rank(datum/antagonist/bloodsucker/antag_datum, mob/living/carbon/user, mob/living/carbon/target, spend_rank = TRUE)
	// Purchase Power Prompt
	var/list/options = list()
	for(var/datum/action/cooldown/bloodsucker/power as anything in antag_datum.all_bloodsucker_powers)
		if(initial(power.purchase_flags) & BLOODSUCKER_CAN_BUY && !(locate(power) in antag_datum.powers))
			options[initial(power.name)] = power

	if(options.len < 1)
		to_chat(user, span_notice("You grow more ancient by the night!"))
	else
		// Give them the UI to purchase a power.
		var/choice = tgui_input_list(user, "You have the opportunity to grow more ancient. Select a power to advance your Rank.", "Your Blood Thickens...", options)
		// Prevent Bloodsuckers from closing/reopning their coffin to spam Levels.
		if(spend_rank && antag_datum.bloodsucker_level_unspent <= 0)
			return
		// Did you choose a power?
		if(!choice || !options[choice])
			to_chat(user, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return
		// Prevent Bloodsuckers from closing/reopning their coffin to spam Levels.
		if(locate(options[choice]) in antag_datum.powers)
			to_chat(user, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return
		// Prevent Bloodsuckers from purchasing a power while outside of their Coffin.
		if(!istype(user.loc, /obj/structure/closet/crate/coffin))
			to_chat(user, span_warning("You must be in your Coffin to purchase Powers."))
			return

		// Good to go - Buy Power!
		var/datum/action/cooldown/bloodsucker/purchased_power = options[choice]
		antag_datum.BuyPower(new purchased_power)
		user.balloon_alert(user, "learned [choice]!")
		to_chat(user, span_notice("You have learned how to use [choice]!"))

	finalize_spend_rank(antag_datum, user, spend_rank)

/datum/bloodsucker_clan/proc/finalize_spend_rank(datum/antagonist/bloodsucker/antag_datum, mob/living/user, spend_rank = TRUE)
	antag_datum.LevelUpPowers()
	antag_datum.bloodsucker_regen_rate += 0.05
	antag_datum.max_blood_volume += 100

	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/species/user_species = human_user.dna.species
		user_species.punchdamagelow += 0.5
		// This affects the hitting power of Brawn.
		user_species.punchdamagehigh += 0.5

	// We're almost done - Spend your Rank now.
	antag_datum.bloodsucker_level++
	if(spend_rank)
		antag_datum.bloodsucker_level_unspent--

	// Ranked up enough to get your true Reputation?
	if(antag_datum.bloodsucker_level == 4)
		antag_datum.SelectReputation(am_fledgling = FALSE, forced = TRUE)

	to_chat(user, span_notice("You are now a rank [antag_datum.bloodsucker_level] Bloodsucker. \
		Your strength, health, feed rate, regen rate, and maximum blood capacity have all increased! \n\
		* Your existing powers have all ranked up as well!"))
	user.playsound_local(null, 'sound/effects/pope_entry.ogg', 25, TRUE, pressure_affected = FALSE)
	antag_datum.update_hud()

/datum/bloodsucker_clan/proc/on_favorite_vassal(datum/source, datum/antagonist/vassal/vassaldatum, mob/living/bloodsucker)
	SIGNAL_HANDLER
	vassaldatum.BuyPower(new /datum/action/cooldown/bloodsucker/targeted/brawn)

/**
 * Nosferatu
 */
/datum/bloodsucker_clan/nosferatu
	name = CLAN_NOSFERATU
	description = "Nosferatu Clan \n\
		The Nosferatu Clan is unable to blend in with the crew, with no abilities such as Masquerade and Veil. \n\
		Additionally, has a permanent bad back and looks like a Bloodsucker upon a simple examine, and is entirely unidentifiable, \n\
		they can fit in the vents regardless of their form and equipment. \n\
		The Favorite Vassal is permanetly disfigured, and can also ventcrawl, but only while entirely nude."
	clan_objective = /datum/objective/bloodsucker/kindred
	join_description = "You are permanetly disfigured, look like a Bloodsucker to all who examine you, \
		lose your Masquerade ability, but gain the ability to Ventcrawl even while clothed."

/datum/bloodsucker_clan/nosferatu/New(mob/living/carbon/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	for(var/datum/action/cooldown/bloodsucker/power in bloodsuckerdatum.powers)
		if(istype(power, /datum/action/cooldown/bloodsucker/masquerade) || istype(power, /datum/action/cooldown/bloodsucker/veil))
			bloodsuckerdatum.RemovePower(power)
	if(!user.has_quirk(/datum/quirk/badback))
		user.add_quirk(/datum/quirk/badback)
	ADD_TRAIT(user, TRAIT_VENTCRAWLER_ALWAYS, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_DISFIGURED, BLOODSUCKER_TRAIT)

/datum/bloodsucker_clan/nosferatu/on_favorite_vassal(datum/source, datum/antagonist/vassal/vassaldatum, mob/living/bloodsucker)
	ADD_TRAIT(vassaldatum.owner.current, TRAIT_VENTCRAWLER_NUDE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(vassaldatum.owner.current, TRAIT_DISFIGURED, BLOODSUCKER_TRAIT)
	to_chat(vassaldatum.owner.current, span_notice("Additionally, you can now ventcrawl while naked, and are permanently disfigured."))


/**
 * Tremere
 */
/datum/bloodsucker_clan/tremere
	name = CLAN_TREMERE
	description = "Tremere Clan \n\
		The Tremere Clan is extremely weak to True Faith, and will burn when entering areas considered such, like the Chapel. \n\
		Additionally, a whole new moveset is learned, built on Blood magic rather than Blood abilities, which are upgraded overtime. \n\
		More ranks can be gained by Vassalizing crewmembers. \n\
		The Favorite Vassal gains the Batform spell, being able to morph themselves at will."
	clan_objective = /datum/objective/bloodsucker/tremere_power
	join_description = "You will burn if you enter the Chapel, lose all default powers, \
		but gain Blood Magic instead, powers you level up overtime."

/datum/bloodsucker_clan/tremere/New(mob/living/carbon/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	bloodsuckerdatum.remove_nondefault_powers()
	bloodsuckerdatum.bloodsucker_level_unspent++
	bloodsuckerdatum.BuyPower(new /datum/action/cooldown/bloodsucker/targeted/tremere/dominate)
	bloodsuckerdatum.BuyPower(new /datum/action/cooldown/bloodsucker/targeted/tremere/auspex)
	bloodsuckerdatum.BuyPower(new /datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy)

/datum/bloodsucker_clan/tremere/spend_rank(datum/antagonist/bloodsucker/antag_datum, mob/living/carbon/user, mob/living/carbon/target, spend_rank = TRUE)
	// Purchase Power Prompt
	var/list/options = list()
	for(var/datum/action/cooldown/bloodsucker/targeted/tremere/power as anything in antag_datum.powers)
		if(!(power.purchase_flags & TREMERE_CAN_BUY))
			continue
		if(isnull(power.upgraded_power))
			continue
		options[initial(power.name)] = power

	if(options.len < 1)
		to_chat(user, span_notice("You grow more ancient by the night!"))
	else
		// Give them the UI to purchase a power.
		var/choice = tgui_input_list(user, "You have the opportunity to grow more ancient. Select a power you wish to upgrade.", "Your Blood Thickens...", options)
		// Prevent Bloodsuckers from closing/reopning their coffin to spam Levels.
		if(spend_rank && antag_datum.bloodsucker_level_unspent <= 0)
			return
		// Did you choose a power?
		if(!choice || !options[choice])
			to_chat(user, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return
		// Prevent Bloodsuckers from purchasing a power while outside of their Coffin.
		if(!istype(user.loc, /obj/structure/closet/crate/coffin))
			to_chat(user, span_warning("You must be in your Coffin to purchase Powers."))
			return

		// Good to go - Buy Power!
		var/datum/action/cooldown/bloodsucker/purchased_power = options[choice]
		var/datum/action/cooldown/bloodsucker/targeted/tremere/tremere_power = purchased_power
		if(isnull(tremere_power.upgraded_power))
			user.balloon_alert(user, "cannot upgrade [choice]!")
			to_chat(user, span_notice("[choice] is already at max level!"))
			return
		antag_datum.BuyPower(new tremere_power.upgraded_power)
		antag_datum.RemovePower(tremere_power)
		user.balloon_alert(user, "upgraded [choice]!")
		to_chat(user, span_notice("You have upgraded [choice]!"))

	finalize_spend_rank(antag_datum, user, spend_rank)

/datum/bloodsucker_clan/tremere/on_favorite_vassal(datum/source, datum/antagonist/vassal/vassaldatum, mob/living/bloodsucker)
	var/datum/action/cooldown/spell/shapeshift/bat/batform = new()
	batform.Grant(vassaldatum.owner.current)

/**
 * Ventrue
 */
/datum/bloodsucker_clan/ventrue
	name = CLAN_VENTRUE
	description = "Ventrue Clan \n\
		The Ventrue Clan is extremely snobby with their meals, and refuse to drink blood from people without a mind. \n\
		There is additionally no way to rank themselves up, instead will have to rank their Favorite vassal through a Persuasion Rack. \n\
		The Favorite Vassal will slowly turn into a Bloodsucker this way, until they finally lose their last bits of Humanity."
	clan_objective = /datum/objective/bloodsucker/embrace
	join_description = "Lose the ability to drink from mindless mobs, can't level up or gain new powers, \
		instead you raise a vassal into a Bloodsucker."

/datum/bloodsucker_clan/ventrue/on_rank_up(datum/source)
	return COMPONENT_RANK_UP_VASSAL

/datum/bloodsucker_clan/ventrue/spend_rank(datum/antagonist/bloodsucker/antag_datum, mob/living/carbon/user, mob/living/carbon/target, spend_rank = TRUE)
	var/datum/antagonist/vassal/vassaldatum = target.mind.has_antag_datum(/datum/antagonist/vassal)
	// Purchase Power Prompt
	var/list/options = list()
	for(var/datum/action/cooldown/bloodsucker/power as anything in antag_datum.all_bloodsucker_powers)
		if(initial(power.purchase_flags) & VASSAL_CAN_BUY && !(locate(power) in vassaldatum.powers))
			options[initial(power.name)] = power

	if(options.len < 1)
		to_chat(user, span_notice("You grow more ancient by the night!"))
	else
		// Give them the UI to purchase a power.
		var/choice = tgui_input_list(user, "You have the opportunity to level up your Favorite Vassal. Select a power you wish them to recieve.", "Your Blood Thickens...", options)
		// Prevent Bloodsuckers from closing/reopning their coffin to spam Levels.
		if(spend_rank && antag_datum.bloodsucker_level_unspent <= 0)
			return
		// Did you choose a power?
		if(!choice || !options[choice])
			to_chat(user, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return
		// Prevent Bloodsuckers from closing/reopning their coffin to spam Levels.
		if((locate(options[choice]) in vassaldatum.powers))
			to_chat(user, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return

		// Good to go - Buy Power!
		var/datum/action/cooldown/bloodsucker/purchased_power = options[choice]
		vassaldatum.BuyPower(new purchased_power)
		user.balloon_alert(user, "taught [choice]!")
		to_chat(user, span_notice("You taught [target] how to use [choice]!"))
		target.balloon_alert(target, "learned [choice]!")
		to_chat(target, span_notice("Your master taught you how to use [choice]!"))

	vassaldatum.LevelUpPowers()
	vassaldatum.vassal_level++
	switch(vassaldatum.vassal_level)
		if(2)
			ADD_TRAIT(target, TRAIT_COLDBLOODED, BLOODSUCKER_TRAIT)
			ADD_TRAIT(target, TRAIT_NOBREATH, BLOODSUCKER_TRAIT)
			ADD_TRAIT(target, TRAIT_AGEUSIA, BLOODSUCKER_TRAIT)
			to_chat(target, span_notice("Your blood begins to feel cold, and as a mote of ash lands upon your tongue, you stop breathing..."))
		if(3)
			ADD_TRAIT(target, TRAIT_NOCRITDAMAGE, BLOODSUCKER_TRAIT)
			ADD_TRAIT(target, TRAIT_NOSOFTCRIT, BLOODSUCKER_TRAIT)
			to_chat(target, span_notice("You feel your Master's blood reinforce you, strengthening you up."))
		if(4)
			ADD_TRAIT(target, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT)
			ADD_TRAIT(target, TRAIT_VIRUSIMMUNE, BLOODSUCKER_TRAIT)
			to_chat(target, span_notice("You feel your Master's blood begin to protect you from bacteria."))
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				human_target.skin_tone = "albino"
		if(5)
			ADD_TRAIT(target, TRAIT_NOHARDCRIT, BLOODSUCKER_TRAIT)
			ADD_TRAIT(target, TRAIT_HARDLY_WOUNDED, BLOODSUCKER_TRAIT)
			to_chat(target, span_notice("You feel yourself able to take cuts and stabbings like it's nothing."))
		if(6 to INFINITY)
			if(!target.mind.has_antag_datum(/datum/antagonist/bloodsucker))
				to_chat(target, span_notice("You feel your heart stop pumping for the last time as you begin to thirst for blood, you feel... dead."))
				target.mind.add_antag_datum(/datum/antagonist/bloodsucker)
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "madevamp", /datum/mood_event/madevamp)
			vassaldatum.set_vassal_level(target)

	finalize_spend_rank(antag_datum, user, spend_rank)

/datum/bloodsucker_clan/ventrue/on_favorite_vassal(datum/source, datum/antagonist/vassal/vassaldatum, mob/living/bloodsucker)
	to_chat(bloodsucker, span_announce("* Bloodsucker Tip: You can now upgrade your Favorite Vassal by buckling them onto a Candelabrum!"))
	vassaldatum.BuyPower(new /datum/action/cooldown/bloodsucker/distress)

/**
 * Malkavian
 */
/datum/bloodsucker_clan/malkavian
	name = CLAN_MALKAVIAN
	description = "Little is documented about Malkavians. Complete insanity is the most common theme. \n\
		The Favorite Vassal will suffer the same fate as the Master."
	join_description = "Completely insane. You gain constant hallucinations, become a prophet with unintelligable rambling, \
		and become the enforcer of the Masquerade code."

/datum/bloodsucker_clan/malkavian/New(mob/living/carbon/user)
	. = ..()
	user.playsound_local(get_turf(user), 'sound/ambience/antag/creepalert.ogg', 80, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	to_chat(user, span_hypnophrase("Welcome to the Malkavian..."))
	user.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
	user.gain_trauma(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
	ADD_TRAIT(user, TRAIT_XRAY_VISION, BLOODSUCKER_TRAIT)

/datum/bloodsucker_clan/malkavian/on_favorite_vassal(datum/source, datum/antagonist/vassal/vassaldatum, mob/living/bloodsucker)
	var/mob/living/carbon/carbonowner = vassaldatum.owner.current
	carbonowner.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
	carbonowner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
	to_chat(vassaldatum.owner.current, span_notice("Additionally, you now suffer the same fate as your Master."))

/datum/bloodsucker_clan/gangrel
	name = CLAN_GANGREL
	description = "Gangrel Clan \n\
		Closer to Animals than Bloodsuckers, known as Werewolves waiting to happen, \n\
		these are the most fearful of True Faith, being the most lethal thing they would ever see the night of. \n\
		Full Moons do not seem to have an effect, despite common-told stories. \n\
		The Favorite Vassal turns into a Werewolf whenever their Master does."
	joinable_clan = FALSE

/datum/bloodsucker_clan/toreador
	name = CLAN_TOREADOR
	description = "Toreador Clan \n\
		The most charming Clan of them all, allowing them to very easily disguise among the crew. \n\
		More in touch with their morals, they suffer and benefit more strongly from humanity cost or gain of their actions. \n\
		Known as 'The most humane kind of vampire', they have an obsession with perfectionism and beauty \n\
		The Favorite Vassal gains the Mesmerize ability."
	joinable_clan = FALSE
