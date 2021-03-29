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
	icon = 'fulp_modules/bloodsuckers/icons/vamp_obj.dmi'
	icon_state = "vassalrack"
	buckle_lying = FALSE
	anchored = FALSE
	density = TRUE // Start dense. Once fixed in place, go non-dense.
	can_buckle = TRUE
	var/useLock = FALSE // So we can't just keep dragging ppl on here.
	var/mob/buckled
	var/convert_progress = 3 // Resets on each new character to be added to the chair. Some effects should lower it...
	var/disloyalty_confirm = FALSE // Security & Antags need to CONFIRM they are willing to lose their role (and will only do it if the Vassal'ing succeeds)
	var/disloyalty_offered = FALSE // Has the popup been issued? Don't spam them.

/obj/structure/bloodsucker/vassalrack/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/metal(src.loc, 4)
	new /obj/item/stack/rods(loc, 4)
	qdel(src)

/obj/structure/bloodsucker/vassalrack/examine(mob/user)
	. = ..()
	if(!user.mind)
		. += {"<span class='cult'>This is a vassal rack, which allows Bloodsuckers to thrall crewmembers into loyal minions.</span>"}
		return
	if(user.mind.has_antag_datum(/datum/antagonist/bloodsucker))
		. += {"<span class='cult'>This is the vassal rack, which allows you to thrall crewmembers into loyal minions in your service.</span>"}
		. += {"<span class='cult'>You need to first secure the vassal rack by clicking on it while it is in your lair.</span>"}
		. += {"<span class='cult'>Simply click and hold on a victim, and then drag their sprite on the vassal rack. Alt click on the vassal rack to unbuckle them.</span>"}
		. += {"<span class='cult'>Make sure that the victim is handcuffed, or else they can simply run away or resist, as the process is not instant.</span>"}
		. += {"<span class='cult'>To convert the victim, simply click on the vassal rack itself. Sharp weapons work faster than other tools.</span>"}
	if(user.mind.has_antag_datum(/datum/antagonist/vassal))
		. += "<span class='notice'>This is the vassal rack, which allows your master to thrall crewmembers into his minions.</span>"
		. += "<span class='notice'>Aid your master in bringing their victims here and keeping them secure.</span>"
		. += "<span class='notice'>You can secure victims to the vassal rack by click dragging the victim onto the rack while it is secured.</span>"
	if(user.mind.has_antag_datum(/datum/antagonist/monsterhunter))
		. += {"<span class='cult'>This is the vassal rack, which monsters use to brainwash crewmembers into their loyal slaves.</span>"}
		. += {"<span class='cult'>They usually ensure that victims are handcuffed, to prevent them from running away.</span>"}
		. += {"<span class='cult'>Their rituals take time, allowing us to disrupt it.</span>"}

/obj/structure/bloodsucker/vassalrack/MouseDrop_T(atom/movable/O, mob/user)
	if(!O.Adjacent(src) || O == user || !isliving(O) || !isliving(user) || useLock || has_buckled_mobs() || user.incapacitated())
		return
	if(!anchored && AmBloodsucker(user))
		to_chat(user, "<span class='danger'>Until this rack is secured in place, it cannot serve its purpose.</span>")
		return
	// PULL TARGET: Remember if I was pullin this guy, so we can restore this
	var/waspulling = (O == owner.pulling)
	var/wasgrabstate = owner.grab_state
	// 		* MOVE! *
	O.forceMove(drop_location())
	// PULL TARGET: Restore?
	if(waspulling)
		owner.start_pulling(O, wasgrabstate, TRUE)
		// NOTE: in lunge.dm, we use [target.grabbedby(owner)], which simulates doing a grab action. We don't want that though...we're cutting directly back to where we were in a grab.
	useLock = TRUE
	if(do_mob(user, O, 5 SECONDS))
		attach_victim(O,user)
	useLock = FALSE

/// Attempt Release (Owner vs Non Owner)
/obj/structure/bloodsucker/vassalrack/AltClick(mob/user)
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
	if(!buckle_mob(M))
		return
	user.visible_message("<span class='notice'>[user] straps [M] into the rack, immobilizing them.</span>", \
			  		 "<span class='boldnotice'>You secure [M] tightly in place. They won't escape you now.</span>")

	playsound(src.loc, 'sound/effects/pop_expl.ogg', 25, 1)
	//M.forceMove(drop_location()) <--- CANT DO! This cancels the buckle_mob() we JUST did (even if we foced the move)
	M.setDir(2)
	density = TRUE
	var/matrix/m180 = matrix(M.transform)
	m180.Turn(180)
	animate(M, transform = m180, time = 2)
	M.pixel_y = -2
	update_icon()
	// Torture Stuff
	convert_progress = 3 // Goes down unless you start over.
	disloyalty_confirm = FALSE // New guy gets the chance to say NO if he's special.
	disloyalty_offered = FALSE // Prevents spamming torture window.

/// Attempt Unbuckle
/obj/structure/bloodsucker/vassalrack/user_unbuckle_mob(mob/living/M, mob/user)
	if(!AmBloodsucker(user))
		if(M == user)
			M.visible_message("<span class='danger'>[user] tries to release themself from the rack!</span>",\
							"<span class='danger'>You attempt to release yourself from the rack!</span>") //  For sound if not seen -->  "<span class='italics'>You hear a squishy wet noise.</span>")
		else
			M.visible_message("<span class='danger'>[user] tries to pull [M] rack!</span>") //  For sound if not seen -->  "<span class='italics'>You hear a squishy wet noise.</span>")
		if(!do_mob(user, M, 45 SECONDS))
			return
	..()
	unbuckle_mob(M)

/obj/structure/bloodsucker/vassalrack/unbuckle_mob(mob/living/buckled_mob, force = FALSE)
	if(!..())
		return
	var/matrix/m180 = matrix(buckled_mob.transform)
	m180.Turn(180)
	animate(buckled_mob, transform = m180, time = 2)
	src.visible_message(text("<span class='danger'>[buckled_mob][buckled_mob.stat==DEAD?"'s corpse":""] slides off of the rack.</span>"))
	density = FALSE
	buckled_mob.AdjustParalyzed(30)
	update_icon()
	useLock = FALSE // Failsafe

/obj/structure/bloodsucker/vassalrack/attack_hand(mob/user)
	// Go away. Torturing.
	if(useLock)
		return
	var/datum/antagonist/bloodsucker/B = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	// CHECK ONE: Am I claiming this? Is it in the right place?
	if(istype(B) && !owner)
		if(!B.lair)
			to_chat(user, "<span class='danger'>You don't have a lair. Claim a coffin to make that location your lair.</span>")
		if(B.lair != get_area(src))
			to_chat(user, "<span class='danger'>You may only activate this structure in your lair: [B.lair].</span>")
			return
		switch(alert(user,"Do you wish to afix this structure here? Be aware you wont be able to unsecure it anymore", "Secure [src]", "Yes", "No"))
			if("Yes")
				owner = user
				density = FALSE
				anchored = TRUE
				return //No, you cant move this ever again
			if("No")
				return
	// No One Home
	if(!has_buckled_mobs())
		return
	// CHECK TWO: Am I a non-bloodsucker?
	var/mob/living/carbon/C = pick(buckled_mobs)
	if(!istype(B))
		// Try to release this guy
		user_unbuckle_mob(C, user)
		return
	// Bloodsucker Owner! Let the boy go.
	if(C.mind)
		var/datum/antagonist/vassal/V = C.mind.has_antag_datum(/datum/antagonist/vassal)
		if(istype(V) && V.master == B || C.stat >= DEAD)
			unbuckle_mob(C)
			useLock = FALSE // Failsafe
			return
	// Just torture the boy
	torture_victim(user, C)

/*
 * 	// Step One:	Tick Down Conversion from 3 to 0
 *	// Step Two:	Break mindshielding/antag (on approve)
 *	// Step Three:	Blood Ritual
 */

/obj/structure/bloodsucker/vassalrack/proc/torture_victim(mob/living/user, mob/living/target)
	var/datum/antagonist/bloodsucker/B = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	// Prep...
	useLock = TRUE
	// Conversion Process
	if(convert_progress > 0)
		to_chat(user, "<span class='notice'>You prepare to initiate [target] into your service.</span>")
		if(!do_torture(user,target))
			to_chat(user, "<span class='danger'><i>The ritual has been interrupted!</i></span>")
		else
			convert_progress -- // Ouch. Stop. Don't.
			// All done!
			if(convert_progress <= 0)
				if(RequireDisloyalty(target))
					to_chat(user, "<span class='boldwarning'>[target] has external loyalties! [target.p_they(TRUE)] will require more <i>persuasion</i> to break [target.p_them()] to your will!</span>")
				else
					to_chat(user, "<span class='notice'>[target] looks ready for the <b>Dark Communion</b>.</span>")
			// Still Need More Persuasion...
			else
				to_chat(user, "<span class='notice'>[target] could use [convert_progress == 1?"a little":"some"] more <i>persuasion</i>.</span>")
		useLock = FALSE
		return
	// Check: Mindshield & Antag
	if(!disloyalty_confirm && RequireDisloyalty(target))
		if(!do_disloyalty(user,target))
			to_chat(user, "<span class='danger'><i>The ritual has been interrupted!</i></span>")
		else if(!disloyalty_confirm)
			to_chat(user, "<span class='danger'>[target] refuses to give into your persuasion. Perhaps a little more?</span>")
		else
			to_chat(user, "<span class='notice'>[target] looks ready for the <b>Dark Communion</b>.</span>")
		useLock = FALSE
		return
	user.visible_message("<span class='notice'>[user] marks a bloody smear on [target]'s forehead and puts a wrist up to [target.p_their()] mouth!</span>", \
				  	  "<span class='notice'>You paint a bloody marking across [target]'s forehead, place your wrist to [target.p_their()] mouth, and subject [target.p_them()] to the Dark Communion.</span>")
	if(!do_mob(user, src, 5 SECONDS))
		to_chat(user, "<span class='danger'><i>The ritual has been interrupted!</i></span>")
		useLock = FALSE
		return
	// Convert to Vassal!
	if(B && B.attempt_turn_vassal(target))
		if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
			remove_loyalties(target)
		user.playsound_local(null, 'sound/effects/explosion_distant.ogg', 40, TRUE)
		target.playsound_local(null, 'sound/effects/explosion_distant.ogg', 40, TRUE)
		target.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)
		target.Jitter(15)
		target.emote("laugh")
		//remove_victim(target) // Remove on CLICK ONLY!
	useLock = FALSE

/obj/structure/bloodsucker/vassalrack/proc/do_torture(mob/living/user, mob/living/target, mult = 1)
	var/torture_time = 15 // Fifteen seconds if you aren't using anything. Shorter with weapons and such.
	var/torture_dmg_brute = 2
	var/torture_dmg_burn = 0
	// Get Bodypart
	var/target_string = ""
	var/obj/item/bodypart/BP = null
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		BP = pick(C.bodyparts)
		if(BP)
			target_string += BP.name
	// Get Weapon
	var/obj/item/I = user.get_active_held_item()
	if(!istype(I))
		I = user.get_inactive_held_item()
	// Weapon Bonus + SFX
	if(I)
		torture_time -= I.force / 4
		torture_dmg_brute += I.force / 4
		//torture_dmg_burn += I.
		if(I.sharpness == SHARP_EDGED)
			torture_time -= 1
		else if(I.sharpness == SHARP_POINTY)
			torture_time -= 2
		if(istype(I, /obj/item/weldingtool))
			var/obj/item/weldingtool/welder = I
			welder.welding = TRUE
			torture_time -= 5
			torture_dmg_burn += 5
		I.play_tool_sound(target)
	torture_time = max(50, torture_time * 10) // Minimum 5 seconds.
	// Now run process.
	if(!do_mob(user, target, torture_time * mult))
		return FALSE
	// SUCCESS
	if(I)
		playsound(loc, I.hitsound, 30, 1, -1)
		I.play_tool_sound(target)
	target.visible_message("<span class='danger'>[user] performs a ritual, spilling some of [target]'s blood from their [target_string] and shaking them up!</span>", \
						   "<span class='userdanger'>[user] performs a ritual, spilling some blood from your [target_string], shaking you up!</span>")
	if(!target.is_muzzled())
		target.emote("scream")
	target.Jitter(5)
	target.apply_damages(brute = torture_dmg_brute, burn = torture_dmg_burn, def_zone = (BP ? BP.body_zone : null)) // take_overall_damage(6,0)
	return TRUE

/// OFFER YES/NO NOW!
/obj/structure/bloodsucker/vassalrack/proc/do_disloyalty(mob/living/user, mob/living/target)
	spawn(10)
		if(useLock && target && target.client) // Are we still torturing? Did we cancel? Are they still here?
			to_chat(user, "<span class='notice'>[target] has been given the opportunity for servitude. You await their decision...</span>")
			var/alert_text = "You are being tortured! Do you want to give in and pledge your undying loyalty to [user]?"
		/*	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
				alert_text += "\n\nYou will no longer be loyal to the station!"
			if(SSticker.mode.AmValidAntag(target.mind))  */
			alert_text += "\n\nYou will not lose your current objectives, but they come second to the will of your new master!"
			to_chat(target, "<span class='cultlarge'>THE HORRIBLE PAIN! WHEN WILL IT END?!</span>")
			var/list/torture_icons = list(
				"Accept" = image(icon = 'fulp_modules/bloodsuckers/icons/actions_bloodsucker.dmi', icon_state = "power_recup"),
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

/obj/structure/bloodsucker/vassalrack/proc/RequireDisloyalty(mob/living/target)
	return SSticker.mode.AmValidAntag(target.mind) || HAS_TRAIT(target, TRAIT_MINDSHIELD)

/obj/structure/bloodsucker/vassalrack/proc/disloyalty_accept(mob/living/target)
	// FAILSAFE: Still on the rack?
	if(!(locate(target) in buckled_mobs))
		return
	// NOTE: You can say YES after torture. It'll apply to next time.
	disloyalty_confirm = TRUE
	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
		to_chat(target, "<span class='boldnotice'>You give in to the will of your torturer. If they are successful, you will no longer be loyal to the station!</span>")

/obj/structure/bloodsucker/vassalrack/proc/disloyalty_refuse(mob/living/target)
	// FAILSAFE: Still on the rack?
	if(!(locate(target) in buckled_mobs))
		return
	// Failsafe: You already said YES.
	if(disloyalty_confirm)
		return
	to_chat(target, "<span class='notice'>You refuse to give in! You <i>will not</i> break!</span>")

/obj/structure/bloodsucker/vassalrack/proc/remove_loyalties(mob/living/target)
	// Find Mind Implant & Destroy
	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
		for(var/obj/item/implant/I in target.implants)
			if(I.type == /obj/item/implant/mindshield)
				I.removed(target,silent=TRUE)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/structure/bloodsucker/candelabrum
	name = "candelabrum"
	desc = "It burns slowly, but doesn't radiate any heat."
	icon = 'fulp_modules/bloodsuckers/icons/vamp_obj.dmi'
	icon_state = "candelabrum"
	light_color = "#66FFFF"//LIGHT_COLOR_BLUEGREEN // lighting.dm
	light_power = 3
	light_range = 0 // to 2
	density = FALSE
	anchored = FALSE
	var/lit = FALSE

/*
/// From candle.dm
/obj/structure/bloodsucker/candelabrum/is_hot()
	return FALSE
*/

/obj/structure/bloodsucker/candelabrum/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/bloodsucker/candelabrum/update_icon_state()
	icon_state = "candelabrum[lit ? "_lit" : ""]"

/obj/structure/bloodsucker/candelabrum/examine(mob/user)
	. = ..()
	if(user.mind.has_antag_datum(/datum/antagonist/bloodsucker) || isobserver(user))
		. += "<span class='cult'>This is a magical candle which drains at the sanity of mortals who are not under your command while it is active.</span>"
		. += "<span class='cult'>You can alt click on it from any range to turn it on remotely, or simply be next to it and click on it to turn it on and off normally.</span>"
	if(user.mind.has_antag_datum(/datum/antagonist/vassal))
		. += "<span class='notice'>This is a magical candle which drains at the sanity of the fools who havent yet accepted your master, as long as it is active.\
		You can turn it on and off by clicking on it while you are next to it.</span>"
	else
		. += "<span class='notice'>In Greek myth, Prometheus stole fire from the Gods and gave it to \
		humankind. The jewelry he kept for himself.</span>"

/obj/structure/bloodsucker/candelabrum/attack_hand(mob/user)
	var/datum/antagonist/vassal/T = user.mind.has_antag_datum(/datum/antagonist/vassal)
	if(AmBloodsucker(user) || istype(T))
		toggle()

/// Bloodsuckers can turn their candles on from a distance. SPOOOOKY.
/obj/structure/bloodsucker/candelabrum/AltClick(mob/user)
	if(AmBloodsucker(user))
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

/obj/structure/bloodsucker/candelabrum/process(var/mob/living/carbon/human/H) //Currently doesnt seem to work, fix would be appreciated!
	if(!lit)
		return
	if(H.mind.has_antag_datum(/datum/antagonist/vassal))
		return
	if(H.mind.has_antag_datum(/datum/antagonist/bloodsucker))//We dont want vassals or vampires affected by this
		return
	H.hallucination = 20
	SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "vampcandle", /datum/mood_event/vampcandle)

/*
/obj/item/restraints/legcuffs/beartrap/bloodsucker
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//   OTHER THINGS TO USE: HUMAN BLOOD. /obj/effect/decal/cleanable/blood

