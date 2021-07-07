/*									IDEAS		--
 *					An object that disguises your coffin while you're in it!
 *
 *					An object that lets your lair itself protect you from sunlight, like a coffin would (no healing tho)
 *
 *
 * Hide a random object somewhere on the station:
 *		var/turf/targetturf = get_random_station_turf()
 *		var/turf/targetturf = get_safe_random_station_turf()
 *
 *
 * 		CRYPT OBJECTS
 *
 *
 * 	PODIUM		Stores your Relics
 *
 * 	ALTAR		Transmute items into unholy items.
 *
 *	PORTRAIT	Gaze into your past to: restore mood boost?
 *
 *	BOOKSHELF	Discover secrets about crew and locations. Learn languages. Learn marial arts.
 *
 *	BRAZER		Burn rare ingredients to gleen insights.
 *
 *	RUG			Ornate, and creaks when stepped upon by any humanoid other than yourself and your vassals.
 *
 *	X COFFIN		(Handled elsewhere)
 *
 *	X CANDELABRA	(Handled elsewhere)
 *
 *	THRONE		Your mental powers work at any range on anyone inside your crypt.
 *
 *	MIRROR		Find any person
 *
 *	BUST/STATUE	Create terror, but looks just like you (maybe just in Examine?)
 *
 *
 *		RELICS
 *
 *	RITUAL DAGGER
 *
 * 	SKULL
 *
 *	VAMPIRIC SCROLL
 *
 *	SAINTS BONES
 *
 *	GRIMOIRE
 *
 *
 * 		RARE INGREDIENTS
 * Ore
 * Books (Manuals)
 *
 *
 * 										NOTE:  Look up AI and Sentient Disease to see how the game handles the selector logo that only one player is allowed to see. We could add hud for vamps to that?
 *											   ALTERNATIVELY, use the Vamp Huds on relics to mark them, but only show to relevant vamps?
 */

/obj/structure/bloodsucker
	var/mob/living/owner

/*
/obj/structure/bloodsucker/bloodthrone
	name = "wicked throne"
	desc = "Twisted metal shards jut from the arm rests. Very uncomfortable looking. It would take a masochistic sort to sit on this jagged piece of furniture."
/obj/structure/bloodsucker/bloodaltar
	name = "bloody altar"
	desc = "It is made of marble, lined with basalt, and radiates an unnerving chill that puts your skin on edge."
/obj/structure/bloodsucker/bloodstatue
	name = "bloody countenance"
	desc = "It looks upsettingly familiar..."
/obj/structure/bloodsucker/bloodportrait
	name = "oil portrait"
	desc = "A disturbingly familiar face stares back at you. Those reds don't seem to be painted in oil..."
/obj/structure/bloodsucker/bloodbrazier
	name = "lit brazier"
	desc = "It burns slowly, but doesn't radiate any heat."
/obj/structure/bloodsucker/bloodmirror
	name = "faded mirror"
	desc = "You get the sense that the foggy reflection looking back at you has an alien intelligence to it."
*/

/obj/structure/bloodsucker/vassalrack
	name = "persuasion rack"
	desc = "If this wasn't meant for torture, then someone has some fairly horrifying hobbies."
	icon = 'fulp_modules/main_features/bloodsuckers/icons/vamp_obj.dmi'
	icon_state = "vassalrack"
	anchored = FALSE
	/// Start dense. Once fixed in place, go non-dense.
	density = TRUE
	can_buckle = TRUE
	buckle_lying = 180
	/// So we can't spam buckle people onto the rack
	var/useLock = FALSE
	var/mob/buckled
	/// Resets on each new character to be added to the chair. Some effects should lower it...
	var/convert_progress = 3
	/// Mindshielded and Antagonists willingly have to accept you as their Master.
	var/disloyalty_confirm = FALSE
	/// Prevents popup spam.
	var/disloyalty_offered = FALSE

/obj/structure/bloodsucker/vassalrack/deconstruct(disassembled = TRUE)
	. = ..()
	new /obj/item/stack/sheet/iron(src.loc, 4)
	new /obj/item/stack/rods(loc, 4)
	qdel(src)

/obj/structure/bloodsucker/vassalrack/examine(mob/user)
	. = ..()
	if(!user.mind)
		. += span_cult("This is a vassal rack, which allows Bloodsuckers to thrall crewmembers into loyal minions.")
		return
	if(IS_BLOODSUCKER(user))
		. += span_cult("This is the vassal rack, which allows you to thrall crewmembers into loyal minions in your service.")
		. += span_cult("Clicking on the rack with an empty hand while it is in your lair will secure it in place.")
		. += span_cult("Simply click and hold on a victim, and then drag their sprite on the vassal rack. Right-click on the vassal rack to unbuckle them.")
		. += span_cult("To convert into a Vassal, repeatedly click on the persuasion rack. The time required scales with the tool in your off hand.")
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
		if(bloodsuckerdatum.my_clan == CLAN_VENTRUE)
			. += span_cult("As part of the Ventrue Clan, you can choose a Favorite Vassal.")
			. += span_cult("Click the Rack as a Vassal is buckled onto it to turn them into your Favorite. This can only be done once, so choose carefully!")
			. += span_cult("This process costs 150 Blood to do, and will make your Vassal unable to be deconverted, outside of you reaching FinalDeath.")
	if(IS_VASSAL(user))
		. += span_notice("This is the vassal rack, which allows your master to thrall crewmembers into their minions.")
		. += span_notice("Aid your master in bringing their victims here and keeping them secure.")
		. += span_notice("You can secure victims to the vassal rack by click dragging the victim onto the rack while it is secured.")
	if(IS_MONSTERHUNTER(user))
		. += span_cult("This is the vassal rack, which monsters use to brainwash crewmembers into their loyal slaves.")
		. += span_cult("They usually ensure that victims are handcuffed, to prevent them from running away.")
		. += span_cult("Their rituals take time, allowing us to disrupt it.")

/obj/structure/bloodsucker/vassalrack/attackby(obj/item/P, mob/living/user, params)
	/// If a Bloodsucker tries to wrench it in place, yell at them.
	if(P.tool_behaviour == TOOL_WRENCH && !anchored && IS_BLOODSUCKER(user))
		user.playsound_local(null, 'sound/machines/buzz-sigh.ogg', 70, FALSE, pressure_affected = FALSE)
		to_chat(user, span_announce("* Bloodsucker Tip: Examine the Persuasion Rack to understand how it functions!"))
		return
	/// If it is wrenched it place, let them unwrench it.
	if(P.tool_behaviour == TOOL_WRENCH && anchored && IS_BLOODSUCKER(user))
		to_chat(user, span_notice("You start unwrenching the persuasion rack..."))
		if(P.use_tool(src, user, 40, volume=50))
			to_chat(user, span_notice("You unwrench the persuasion rack."))
			owner = null
			density = TRUE
			anchored = FALSE
			return
	. = ..()

/obj/structure/bloodsucker/vassalrack/MouseDrop_T(atom/movable/O, mob/user)
	/// Please dont let them buckle Fireman carried people
	var/mob/living/L = O
	/// Default checks
	if(!O.Adjacent(src) || O == user || !isliving(user) || useLock || has_buckled_mobs() || user.incapacitated() || L.buckled)
		return
	/// Not anchored?
	if(!anchored)
		/// Let the Bloodsucker know the problem.
		if(IS_BLOODSUCKER(user))
			to_chat(user, span_danger("Until this rack is secured in place, it cannot serve its purpose."))
			to_chat(user, span_announce("* Bloodsucker Tip: Examine the Persuasion Rack to understand how it functions!"))
			return
		/// Not a Bloodsucker? Not our problem.
		else
			to_chat(user, span_danger("You dont fully understand how this works, and you're too scared to move it around."))
			return
	/// Don't buckle Silicon to it please.
	if(issilicon(O))
		to_chat(user, span_danger("You realize that Silicon cannot be vassalized, therefore it is useless to buckle them."))
		return
	/// Good to go - Buckle them!
	useLock = TRUE
	if(do_mob(user, O, 5 SECONDS))
		attach_victim(O,user)
	useLock = FALSE

/// Attempt Release (Owner vs Non Owner)
/obj/structure/bloodsucker/vassalrack/attack_hand_secondary(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	if(!has_buckled_mobs() || !isliving(user) || useLock)
		return
	var/mob/living/carbon/C = pick(buckled_mobs)
	if(C)
		if(user == owner)
			unbuckle_mob(C)
		else
			user_unbuckle_mob(C,user)

/// Attempt Buckle
/obj/structure/bloodsucker/vassalrack/proc/attach_victim(mob/living/M, mob/living/user)
	// Standard Buckle Check
	M.forceMove(get_turf(src))
	if(!buckle_mob(M))
		return
	user.visible_message(span_notice("[user] straps [M] into the rack, immobilizing them."), \
			  		 span_boldnotice("You secure [M] tightly in place. They won't escape you now."))

	playsound(src.loc, 'sound/effects/pop_expl.ogg', 25, 1)
	//M.forceMove(drop_location()) <--- CANT DO! This cancels the buckle_mob() we JUST did (even if we foced the move)
	density = TRUE
	update_icon()

	// Set up Torture stuff now
	convert_progress = 3
	disloyalty_confirm = FALSE
	disloyalty_offered = FALSE

/// Attempt Unbuckle
/obj/structure/bloodsucker/vassalrack/user_unbuckle_mob(mob/living/M, mob/user)
	if(!IS_BLOODSUCKER(user))
		if(M == user)
			M.visible_message(span_danger("[user] tries to release themself from the rack!"), span_danger("You attempt to release yourself from the rack!"), span_hear("You hear a squishy wet noise."), null)
		else
			M.visible_message(span_danger("[user] tries to pull [M] rack!"), span_danger("[user] tries to pull [M] rack!"), span_hear("You hear a squishy wet noise."), null)
		// Monster hunters are used to this sort of stuff, they know how they work.
		if(IS_MONSTERHUNTER(user))
			if(!do_mob(user, M, 10 SECONDS))
				return
		else
			if(!do_mob(user, M, 25 SECONDS))
				return
	..()
	unbuckle_mob(M)

/obj/structure/bloodsucker/vassalrack/unbuckle_mob(mob/living/buckled_mob, force = FALSE)
	if(!..())
		return
	src.visible_message(text("<span class='danger'>[buckled_mob][buckled_mob.stat==DEAD?"'s corpse":""] slides off of the rack.</span>"))
	density = FALSE
	buckled_mob.AdjustParalyzed(3 SECONDS)
	update_icon()
	useLock = FALSE // Failsafe

/obj/structure/bloodsucker/vassalrack/attack_hand(mob/user)
	/// Tortiring someone?
	if(useLock)
		return
	var/datum/antagonist/bloodsucker/B = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	/// Claiming the Rack instead of using it?
	if(istype(B) && !owner)
		if(!B.lair)
			to_chat(user, span_danger("You don't have a lair. Claim a coffin to make that location your lair."))
			return
		if(B.lair != get_area(src))
			to_chat(user, span_danger("You may only activate this structure in your lair: [B.lair]."))
			return

		/// Radial menu for securing your Persuasion rack in place.
		to_chat(user, span_notice("Do you wish to secure this structure here?"))
		var/list/secure_options = list(
			"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
			"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no")
			)
		var/secure_response = show_radial_menu(user, src, secure_options, radius = 36, require_near = TRUE)
		switch(secure_response)
			if("Yes")
				user.playsound_local(null, 'sound/items/ratchet.ogg', 70, FALSE, pressure_affected = FALSE)
				to_chat(user, span_danger("You have secured the Persuasion rack in place."))
				to_chat(user, span_announce("* Bloodsucker Tip: Examine the Persuasion Rack to understand how it functions!"))
				owner = user
				density = FALSE
				anchored = TRUE
				return
			else
				return

	/// Is anyone on the rack?
	if(!has_buckled_mobs())
		return
	var/mob/living/carbon/C = pick(buckled_mobs)
	/// If I'm not a Bloodsucker, try to unbuckle them.
	if(!istype(B))
		user_unbuckle_mob(C, user)
		return
	var/datum/antagonist/vassal/V = IS_VASSAL(C)
	/// Are they our Vassal, or Dead?
	if(istype(V) && V.master == B || C.stat >= DEAD)
		/// Are we part of Tremere? They can do bonus things with their Vassals, so don't unbuckle!
		if(B.my_clan == CLAN_TREMERE)
			/// Limit it to only 1 time per Vassal.
			if(istype(V) && V.mutilated)
				to_chat(user, span_notice("You've already mutated [C] beyond repair!"))
				return
			tremere_perform_magic(user, C)
			return
		/// Are we part of Ventrue? Can we assign a Favorite Vassal?
		if(B.my_clan == CLAN_VENTRUE && C.stat <= CONSCIOUS)
			if(istype(V) && !B.my_favorite_vassal)
				offer_ventrue_favorites(user, C)
				return
		/// Not Tremere & They're still our Vassal, let's unbuckle them.
		unbuckle_mob(C)
		useLock = FALSE
		return
	
	/// Not our Vassal & We're a Bloodsucker, good to go!
	torture_victim(user, C)

/*
 *	Step One: Tick Down Conversion from 3 to 0
 *	Step Two: Break mindshielding/antag (on approve)
 *	Step Three: Blood Ritual
 */

/obj/structure/bloodsucker/vassalrack/proc/torture_victim(mob/living/user, mob/living/target)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	/// Prep...
	useLock = TRUE
	/// Conversion Process
	if(convert_progress > 0)
		to_chat(user, span_notice("You prepare to initiate [target] into your service."))
		if(!do_torture(user,target))
			to_chat(user, span_danger("<i>The ritual has been interrupted!</i>"))
		else
			/// Prevent them from unbuckling themselves as long as we're torturing.
			target.Paralyze(1 SECONDS)
			convert_progress--
			/// We're done? Let's see if they can be Vassal.
			if(convert_progress <= 0)
				if(RequireDisloyalty(user,target))
					to_chat(user, span_boldwarning("[target] has external loyalties! [target.p_they(TRUE)] will require more <i>persuasion</i> to break [target.p_them()] to your will!"))
				else
					to_chat(user, span_notice("[target] looks ready for the <b>Dark Communion</b>."))
			/// Otherwise, we're not done, we need to persuade them some more.
			else
				to_chat(user, span_notice("[target] could use [convert_progress == 1?"a little":"some"] more <i>persuasion</i>."))
		useLock = FALSE
		return
	/// Check: Mindshield & Antag
	if(!disloyalty_confirm && RequireDisloyalty(user,target))
		if(!do_disloyalty(user,target))
			to_chat(user, span_danger("<i>The ritual has been interrupted!</i>"))
		else if(!disloyalty_confirm)
			to_chat(user, span_danger("[target] refuses to give into your persuasion. Perhaps a little more?"))
		else
			to_chat(user, span_notice("[target] looks ready for the <b>Dark Communion</b>."))
		useLock = FALSE
		return
	user.visible_message(span_notice("[user] marks a bloody smear on [target]'s forehead and puts a wrist up to [target.p_their()] mouth!"), \
				  	  span_notice("You paint a bloody marking across [target]'s forehead, place your wrist to [target.p_their()] mouth, and subject [target.p_them()] to the Dark Communion."))
	if(!do_mob(user, src, 5 SECONDS))
		to_chat(user, span_danger("<i>The ritual has been interrupted!</i>"))
		useLock = FALSE
		return
	/// Convert to Vassal!
	if(bloodsuckerdatum && bloodsuckerdatum.attempt_turn_vassal(target))
		if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
			remove_loyalties(target)
		user.playsound_local(null, 'sound/effects/explosion_distant.ogg', 40, TRUE)
		target.playsound_local(null, 'sound/effects/explosion_distant.ogg', 40, TRUE)
		target.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)
		target.Jitter(15)
		INVOKE_ASYNC(target, /mob.proc/emote, "laugh")
		//remove_victim(target) // Remove on CLICK ONLY!
	useLock = FALSE

/obj/structure/bloodsucker/vassalrack/proc/do_torture(mob/living/user, mob/living/target, mult = 1)
	/// Fifteen seconds if you aren't using anything. Shorter with weapons and such.
	var/torture_time = 15
	var/torture_dmg_brute = 2
	var/torture_dmg_burn = 0
	/// Get Bodypart
	var/target_string = ""
	var/obj/item/bodypart/BP = null
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		BP = pick(C.bodyparts)
		if(BP)
			target_string += BP.name
	/// Get Weapon
	var/obj/item/I = user.get_active_held_item()
	if(!istype(I))
		I = user.get_inactive_held_item()
	/// Weapon Bonus
	if(I)
		torture_time -= I.force / 4
		torture_dmg_brute += I.force / 4
		//torture_dmg_burn += I.
		if(I.sharpness == SHARP_EDGED)
			torture_time -= 2
		else if(I.sharpness == SHARP_POINTY)
			torture_time -= 3
		/// This will hurt your eyes.
		else if(I.tool_behaviour == TOOL_WELDER)
			if(I.use_tool(src, user, 0, volume = 5))
				torture_time -= 6
				torture_dmg_burn += 5
		I.play_tool_sound(target)
	/// Minimum 5 seconds.
	torture_time = max(50, torture_time * 10)
	/// Now run process.
	if(!do_mob(user, target, torture_time * mult))
		return FALSE
	/// Success?
	if(I)
		playsound(loc, I.hitsound, 30, 1, -1)
		I.play_tool_sound(target)
	target.visible_message(span_danger("[user] performs a ritual, spilling some of [target]'s blood from their [target_string] and shaking them up!"), \
						   span_userdanger("[user] performs a ritual, spilling some blood from your [target_string], shaking you up!"))
	INVOKE_ASYNC(target, /mob.proc/emote, "scream")
	target.Jitter(5)
	target.apply_damages(brute = torture_dmg_brute, burn = torture_dmg_burn, def_zone = (BP ? BP.body_zone : null)) // take_overall_damage(6,0)
	return TRUE

/// Offer them the oppertunity to join now.
/obj/structure/bloodsucker/vassalrack/proc/do_disloyalty(mob/living/user, mob/living/target)
	spawn(10)
		/// Are we still torturing? Did we cancel? Are they still here?
		if(useLock && target && target.client)
			to_chat(user, span_notice("[target] has been given the opportunity for servitude. You await their decision..."))
			var/alert_text = "You are being tortured! Do you want to give in and pledge your undying loyalty to [user]?"
		/*	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
				alert_text += "\n\nYou will no longer be loyal to the station!" */
			alert_text += "\n\nYou will not lose your current objectives, but they come second to the will of your new master!"
			to_chat(target, span_cultlarge("THE HORRIBLE PAIN! WHEN WILL IT END?!"))
			var/list/torture_icons = list(
				"Accept" = image(icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi', icon_state = "power_recup"),
				"Refuse" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "stunbaton_active")
				)
			var/torture_response = show_radial_menu(target, src, torture_icons, radius = 36, require_near = TRUE)
			switch(torture_response)
				if("Accept")
					disloyalty_accept(target)
				else
					disloyalty_refuse(target)
	if(!do_torture(user,target, 2))
		return FALSE

	// NOTE: We only remove loyalties when we're CONVERTED!
	return TRUE

/obj/structure/bloodsucker/vassalrack/proc/RequireDisloyalty(mob/living/user, mob/living/target)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	return bloodsuckerdatum.AmValidAntag(target) || HAS_TRAIT(target, TRAIT_MINDSHIELD)

/obj/structure/bloodsucker/vassalrack/proc/disloyalty_accept(mob/living/target)
	// FAILSAFE: Still on the rack?
	if(!(locate(target) in buckled_mobs))
		return
	// NOTE: You can say YES after torture. It'll apply to next time.
	disloyalty_confirm = TRUE
	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
		to_chat(target, span_boldnotice("You give in to the will of your torturer. If they are successful, you will no longer be loyal to the station!"))

/obj/structure/bloodsucker/vassalrack/proc/disloyalty_refuse(mob/living/target)
	// FAILSAFE: Still on the rack?
	if(!(locate(target) in buckled_mobs))
		return
	// Failsafe: You already said YES.
	if(disloyalty_confirm)
		return
	to_chat(target, span_notice("You refuse to give in! You <i>will not</i> break!"))

/obj/structure/bloodsucker/vassalrack/proc/remove_loyalties(mob/living/target)
	// Find Mind Implant & Destroy
	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
		for(var/obj/item/implant/I in target.implants)
			if(I.type == /obj/item/implant/mindshield)
				I.removed(target,silent=TRUE)

/obj/structure/bloodsucker/vassalrack/proc/tremere_perform_magic(mob/living/user, mob/living/target)
	var/datum/antagonist/vassal/vassaldatum = target.mind.has_antag_datum(/datum/antagonist/vassal)
	/// To deal with Blood
	var/mob/living/carbon/human/C = user
	var/mob/living/carbon/human/H = target

	/// Due to the checks leding up to this, if they fail this, they're dead & Not our vassal.
	if(!vassaldatum)
		to_chat(user, span_notice("Do you wish to rebuild this body? This will remove any restraints they might have, and will cost 150 Blood!"))
		var/list/revive_options = list(
			"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
			"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no")
			)
		var/revive_response = show_radial_menu(user, src, revive_options, radius = 36, require_near = TRUE)
		switch(revive_response)
			if("Yes")
				if(prob(15))
					to_chat(user, span_danger("Something has gone terribly wrong! You have accidentally turned [target] into a High-Functioning Zombie!"))
					to_chat(target, span_announce("As Blood drips over your body, your heart fails to beat... But you still wake up."))
					H.set_species(/datum/species/zombie)
				else
					to_chat(user, span_danger("You have brought [target] back from the Dead!"))
					to_chat(target, span_announce("As Blood drips over your body, your heart begins to beat... You live again!"))
				C.blood_volume -= 150
				target.revive(full_heal = TRUE, admin_revive = TRUE)
				return
		to_chat(user, span_danger("You decide not to revive [target]."))
		// Unbuckle them now.
		unbuckle_mob(C)
		useLock = FALSE
		return

	var/static/list/races = list(
		TREMERE_ZOMBIE,
		TREMERE_HUSK,
		TREMERE_BAT,
	)
	var/list/options = list()
	options = races
	var/answer = tgui_input_list(user, "We have the chance to mutate our Vassal, how should we mutilate their corpse?", "What do we do with our Vassal?", options)
	var/blood_gained
	if(!do_mob(user, src, 5 SECONDS))
		to_chat(user, span_danger("<i>The ritual has been interrupted!</i>"))
		return
	switch(answer)
		if(TREMERE_ZOMBIE)
			to_chat(user, span_notice("You have mutated [target] into a High-Functioning Zombie, fully healing them in the process!"))
			to_chat(target, span_notice("Your master has mutated you into a High-Functioning Zombie!"))
			target.revive(full_heal = TRUE, admin_revive = TRUE)
			H.set_species(/datum/species/zombie)
			vassaldatum.mutilated = TRUE
			return
		/// Quick Feeding
		if(TREMERE_HUSK)
			to_chat(user, span_notice("You suck all the blood out of [target], turning them into a Living Husk!"))
			to_chat(target, span_notice("Your master has mutated you into a Living Husk!"))
			/// Just take it all
			blood_gained = 250
			ADD_TRAIT(target, TRAIT_MUTE, BLOODSUCKER_TRAIT)
			H.become_husk()
			vassaldatum.mutilated = TRUE
			return
		/// Chance to give Bat form, or turn them into a bat.
		if(TREMERE_BAT)
			/// Ooh, lucky!
			if(prob(60))
				to_chat(user, span_notice("You have mutated [target], giving them the ability to turn into a Bat and back at will!"))
				to_chat(target, span_notice("Your master has mutated you, giving you the ability to turn into a Bat and back at will!"))
				var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform = new
				target.AddSpell(batform)
				vassaldatum.mutilated = TRUE
				return
			else
				to_chat(user, span_notice("You have failed to mutate [target] into a Bat, forever trapping them into Bat form!"))
				to_chat(target, span_notice("Your master has mutated you into a Bat!"))
				var/mob/living/simple_animal/hostile/retaliate/bat/battransformation = new /mob/living/simple_animal/hostile/retaliate/bat(target.loc)
				target.mind.transfer_to(battransformation)
				qdel(target)
				vassaldatum.mutilated = TRUE
				return

	if(blood_gained)
		user.blood_volume += blood_gained
	to_chat(user, span_notice("You decide to leave your Vassal just the way they are."))
	return

/obj/structure/bloodsucker/vassalrack/proc/offer_ventrue_favorites(mob/living/user, mob/living/target)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	var/datum/antagonist/vassal/vassaldatum = target.mind.has_antag_datum(/datum/antagonist/vassal)
	/// To deal with Blood
	var/mob/living/carbon/human/C = user

	to_chat(user, span_notice("Would you like to turn this Vassal into your completely loyal Servant? This costs 150 Blood to do. You cannot undo this."))
	var/list/favorite_options = list(
		"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
		"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no")
		)
	var/favorite_response = show_radial_menu(user, src, favorite_options, radius = 36, require_near = TRUE)
	switch(favorite_response)
		if("Yes")
			bloodsuckerdatum.my_favorite_vassal = TRUE
			vassaldatum.favorite_vassal = TRUE
			to_chat(user, span_danger("You have turned [target] into your Favorite Vassal! They will no longer be deconverted upon Mindshielding!"))
			to_chat(user, span_announce("* Bloodsucker Tip: You can now upgrade your Vassal by buckling them onto a Candelabrum!"))
			to_chat(target, span_announce("As Blood drips over your body, you feel closer to your Master..."))
			C.blood_volume -= 150
			/// Make them immune to Mindshielding now
			vassaldatum.update_vassal_icons_added(target, "vassal6")
			vassaldatum.BuyPower(new /datum/action/bloodsucker/distress)
			vassaldatum.protected_from_mindshielding = TRUE
			return
		else
			to_chat(user, span_danger("You decide not to turn [target] into your Favorite Vassal."))
			/// Unbuckle them now.
			unbuckle_mob(C)
			useLock = FALSE
			return


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/structure/bloodsucker/candelabrum
	name = "candelabrum"
	desc = "It burns slowly, but doesn't radiate any heat."
	icon = 'fulp_modules/main_features/bloodsuckers/icons/vamp_obj.dmi'
	icon_state = "candelabrum"
	light_color = "#66FFFF"//LIGHT_COLOR_BLUEGREEN // lighting.dm
	light_power = 3
	light_range = 0 // to 2
	density = FALSE
	can_buckle = TRUE
	anchored = FALSE
	var/lit = FALSE

/obj/structure/bloodsucker/candelabrum/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/bloodsucker/candelabrum/update_icon_state()
	icon_state = "candelabrum[lit ? "_lit" : ""]"
	return ..()

/obj/structure/bloodsucker/candelabrum/examine(mob/user)
	. = ..()
	if(isobserver(user))
		. += span_cult("This is a magical candle which drains at the sanity of non Bloodsuckers and Vassals")
		. += span_cult("Vassals can turn the candle on manually, while Bloodsuckers can do it from a distance.")
		return
	if(IS_BLOODSUCKER(user))
		. += span_cult("This is a magical candle which drains at the sanity of mortals who are not under your command while it is active.")
		. += span_cult("You can right-click on it from any range to turn it on remotely, or simply be next to it and click on it to turn it on and off normally.")
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
		if(bloodsuckerdatum.my_clan == CLAN_VENTRUE)
			. += span_cult("As part of the Ventrue Clan, you can Rank Up your Favorite Vassal.")
			. += span_cult("Drag your Vassal's sprite onto the Candelabrum to secure them in place. From there, Clicking will Rank them up, while Right-click will unbuckle, as long as you are in reach.")
			. += span_cult("Ranking up a Vassal will rank up what powers you currently have, and will allow you to choose what Power your Favorite Vassal will recieve.")
	if(IS_VASSAL(user))
		. += span_notice("This is a magical candle which drains at the sanity of the fools who havent yet accepted your master, as long as it is active.")
		. += span_notice("You can turn it on and off by clicking on it while you are next to it.")

/obj/structure/bloodsucker/candelabrum/attackby(obj/item/P, mob/living/user, params)
	/// Goal: Non Bloodsuckers can wrench this in place, but they cant unwrench it.
	if(P.tool_behaviour == TOOL_WRENCH && !anchored)
		to_chat(user, span_notice("You start wrenching the candelabrum into place..."))
		if(P.use_tool(src, user, 20, volume=50))
			to_chat(user, span_notice("You wrench the candelabrum into place."))
			set_anchored(TRUE)
			density = TRUE
		return
	if(P.tool_behaviour == TOOL_WRENCH && anchored && IS_BLOODSUCKER(user))
		to_chat(user, span_notice("You start unwrenching the candelabrum..."))
		if(P.use_tool(src, user, 40, volume=50))
			to_chat(user, span_notice("You unwrench the candelabrum."))
			set_anchored(FALSE)
			density = FALSE
			return
	. = ..()

/obj/structure/bloodsucker/candelabrum/attack_hand_secondary(mob/user)
	/// Are we right next to it? Let's unbuckle the person in it, then.
	if(user.Adjacent(src))
		if(!has_buckled_mobs() || !isliving(user))
			return
		var/mob/living/carbon/C = pick(buckled_mobs)
		if(C)
			unbuckle_mob(C,user)
	/// Bloodsuckers can turn their candles on from a distance.
	else
		if(IS_BLOODSUCKER(user))
			toggle()

/obj/structure/bloodsucker/candelabrum/proc/toggle(mob/user)
	lit = !lit
	if(lit)
		set_light(2, 3, "#66FFFF")
		START_PROCESSING(SSobj, src)
	else
		set_light(0)
		STOP_PROCESSING(SSobj, src)
	update_icon()

/obj/structure/bloodsucker/candelabrum/process()
	if(!lit)
		return
	for(var/mob/living/carbon/H in viewers(7, src))
		/// We dont want Bloodsuckers or Vassals affected by this
		if(IS_VASSAL(H) || IS_BLOODSUCKER(H))
			continue
		H.hallucination += 5
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "vampcandle", /datum/mood_event/vampcandle)

/*
 *	# Candelabrum Ventrue Stuff
 *
 *	Ventrue Bloodsuckers can buckle Vassals onto the Candelabrum to "Upgrade" them.
 *	This is limited to a Single vassal, called 'My Favorite Vassal'.
 *	This is like Raising a Bloodsucker, but because of Balance reasons, they don't become a Bloodsucker after this.
 *
 *	Most of this is just copied over from Persuasion Rack.
 */

/obj/structure/bloodsucker/candelabrum/attack_hand(mob/living/user)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	// Checks: We're Ventrue, they're Buckled & Alive.
	if(bloodsuckerdatum && bloodsuckerdatum.my_clan == CLAN_VENTRUE)
		if(!has_buckled_mobs())
			toggle()
			return
		var/mob/living/carbon/C = pick(buckled_mobs)
		if(C.stat >= DEAD)
			unbuckle_mob(C)
			return
		// Are we spending a Rank?
		if(!bloodsuckerdatum.bloodsucker_level_unspent <= 0)
			bloodsuckerdatum.SpendVassalRank(C, TRUE)
		else if(user.blood_volume >= 550)
			// We don't have any ranks to spare? Let them upgrade... with enough Blood.
			to_chat(user, span_warning("Do you wish to spend 550 Blood to Rank [C] up?"))
			var/list/rank_options = list(
				"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
				"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no")
				)
			var/rank_response = show_radial_menu(user, src, rank_options, radius = 36, require_near = TRUE)
			switch(rank_response)
				if("Yes")
					user.blood_volume -= 550
					bloodsuckerdatum.SpendVassalRank(C, FALSE)
					return
		// Neither? Shame. Goodbye!
		to_chat(user, span_danger("You don't have any levels or enough Blood to Rank [C] up with."))
		return

	var/datum/antagonist/vassal/T = user.mind.has_antag_datum(/datum/antagonist/vassal)
	if(IS_BLOODSUCKER(user) || istype(T))
		toggle()

/// Buckling someone in
/obj/structure/bloodsucker/candelabrum/MouseDrop_T(mob/living/target, mob/user)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	var/datum/antagonist/vassal/vassaldatum = IS_VASSAL(target)

	/// Are you even a Bloodsucker?
	if(!bloodsuckerdatum || !vassaldatum)
		return
	/// Are you part of Ventrue? No? Then go away.
	if(!bloodsuckerdatum.my_clan == CLAN_VENTRUE)
		return
	/// Are they a Favorite Vassal?
	if(!vassaldatum.favorite_vassal)
		return
	/// They are a Favorite vassal, but are they OUR Vassal?
	if(!vassaldatum.master == bloodsuckerdatum)
		return
	/// Default checks
	if(!target.Adjacent(src) || target == user || !isliving(user) || has_buckled_mobs() || user.incapacitated() || target.buckled)
		return
	/// Not anchored?
	if(!anchored)
		/// Let the Bloodsucker know the problem.
		if(IS_BLOODSUCKER(user))
			to_chat(user, span_danger("Until the candelabrum is secured in place, it cannot serve its purpose."))
			return
		/// Not a Bloodsucker? Not our problem.
		else
			to_chat(user, span_danger("You dont fully understand how this works, and you're too scared to move it around."))
			return

	/// Good to go - Buckle them!
	if(do_mob(user, target, 5 SECONDS))
		attach_mob(target, user)

/obj/structure/bloodsucker/candelabrum/proc/attach_mob(mob/living/M, mob/living/user)
	user.visible_message(span_notice("[user] lifts and buckles [M] onto the candelabrum."), \
			  		 span_boldnotice("You buckle [M] onto the candelabrum."))

	playsound(src.loc, 'sound/effects/pop_expl.ogg', 25, 1)
	M.forceMove(get_turf(src))

	if(!buckle_mob(M))
		return
	update_icon()

/// Attempt Unbuckle
/obj/structure/bloodsucker/candelabrum/unbuckle_mob(mob/living/buckled_mob, force = FALSE)
	. = ..()
	src.visible_message(text("<span class='danger'>[buckled_mob][buckled_mob.stat==DEAD?"'s corpse":""] slides off of the candelabrum.</span>"))
	update_icon()

/*
/obj/item/restraints/legcuffs/beartrap/bloodsucker
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//   OTHER THINGS TO USE: HUMAN BLOOD. /obj/effect/decal/cleanable/blood
