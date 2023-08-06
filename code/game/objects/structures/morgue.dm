///The cooldown between messages when attempting to break out of a morgue tray.
#define BREAKOUT_COOLDOWN (5 SECONDS)
///The amount of time it takes to break out of a morgue tray.
#define BREAKDOWN_TIME (60 SECONDS)

/obj/item/paper/guides/jobs/medical/morgue
	name = "morgue memo"
	default_raw_text = "<font size='2'>Since this station's medbay never seems to fail to be staffed by the mindless monkeys \
		meant for genetics experiments, I'm leaving a reminder here for anyone handling the pile of cadavers the quacks are sure \
		to leave.</font><BR><BR><font size='4'><font color=red>Red lights mean there's a plain ol' dead body inside.</font><BR><BR>\
		<font color=orange>Yellow lights mean there's non-body objects inside.</font><BR><font size='2'>Probably stuff pried off a \
		corpse someone grabbed, or if you're lucky it's stashed booze.</font><BR><BR><font color=green>Green lights mean the morgue \
		system detects the body may be able to be brought back to life.</font></font><BR><font size='2'>I don't know how that works, \
		but keep it away from the kitchen and go yell at the coroner.</font><BR><BR>- CentCom medical inspector"

/* Morgue stuff
 * Contains:
 * Morgue
 * Morgue tray
 * Crematorium
 * Creamatorium
 * Crematorium tray
 * Crematorium button
 */

/*
 * Bodycontainer
 * Parent class for morgue and crematorium
 * For overriding only
 */
GLOBAL_LIST_EMPTY(bodycontainers) //Let them act as spawnpoints for revenants and other ghosties.

/obj/structure/bodycontainer
	icon = 'icons/obj/structures.dmi'
	icon_state = "morgue1"
	density = TRUE
	anchored = TRUE
	max_integrity = 400
	pass_flags_self = LETPASSTHROW | PASSSTRUCTURE
	dir = SOUTH

	///The morgue tray this container will open/close to put/take things in/out.
	var/obj/structure/tray/connected
	///Boolean on whether we're locked and will not allow the tray to be opened.
	var/locked = FALSE
	///Cooldown between breakout msesages.
	COOLDOWN_DECLARE(breakout_message_cooldown)

/obj/structure/bodycontainer/Initialize(mapload)
	. = ..()
	if(connected)
		connected = new connected(src)
		connected.connected = src
	GLOB.bodycontainers += src
	toggle_organ_decay(src)
	register_context()

/obj/structure/bodycontainer/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!locked)
		context[SCREENTIP_CONTEXT_LMB] = "Open/Close"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/bodycontainer/Destroy()
	GLOB.bodycontainers -= src
	open()
	if(connected)
		QDEL_NULL(connected)
	return ..()

/obj/structure/bodycontainer/on_log(login)
	..()
	update_appearance(UPDATE_ICON)

/obj/structure/bodycontainer/relaymove(mob/living/user, direction)
	if(user.stat || !isturf(loc))
		return
	if(locked)
		if(COOLDOWN_FINISHED(src, breakout_message_cooldown))
			COOLDOWN_START(src, breakout_message_cooldown, BREAKOUT_COOLDOWN)
			to_chat(user, span_warning("[src]'s door won't budge!"))
		return
	open()

/obj/structure/bodycontainer/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(locked)
		to_chat(user, span_danger("It's locked."))
		return
	if(!connected)
		to_chat(user, "That doesn't appear to have a tray.")
		return
	if(connected.loc == src)
		open()
	else
		close()
	add_fingerprint(user)

/obj/structure/bodycontainer/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/bodycontainer/attack_robot(mob/user)
	if(!user.Adjacent(src))
		return
	return attack_hand(user)

/obj/structure/bodycontainer/deconstruct(disassembled = TRUE)
	if (!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/sheet/iron(loc, 5)
	toggle_organ_decay(src)
	qdel(src)

/obj/structure/bodycontainer/container_resist_act(mob/living/user)
	if(!locked)
		open()
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(null, \
		span_notice("You lean on the back of [src] and start pushing the tray open... (this will take about [DisplayTimeText(BREAKDOWN_TIME)].)"), \
		span_hear("You hear a metallic creaking from [src]."))
	if(!do_after(user, BREAKDOWN_TIME, target = src))
		return
	if(!user || user.stat != CONSCIOUS || user.loc != src)
		return
	user.visible_message(
		span_warning("[user] successfully broke out of [src]!"),
		span_notice("You successfully break out of [src]!"),
	)
	open()

/obj/structure/bodycontainer/get_remote_view_fullscreens(mob/user)
	if(user.stat == DEAD || !(user.sight & (SEEOBJS|SEEMOBS)))
		user.overlay_fullscreen("remote_view", /atom/movable/screen/fullscreen/impaired, 2)

/obj/structure/bodycontainer/proc/open()
	toggle_organ_decay(src)
	playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
	playsound(src, 'sound/effects/roll.ogg', 5, TRUE)
	var/turf/T = get_step(src, dir)
	if (connected)
		connected.setDir(dir)
	for(var/atom/movable/AM in src)
		AM.forceMove(T)
	update_appearance()

/obj/structure/bodycontainer/proc/close()
	playsound(src, 'sound/effects/roll.ogg', 5, TRUE)
	playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
	for(var/atom/movable/AM in connected.loc)
		if(!AM.anchored || AM == connected)
			if(isliving(AM))
				var/mob/living/living_mob = AM
				if(living_mob.incorporeal_move)
					continue
			else if(istype(AM, /obj/effect/dummy/phased_mob))
				continue
			else if(isdead(AM))
				continue
			AM.forceMove(src)
	toggle_organ_decay(src)
	update_appearance()

/*
 * Morgue
 */
/obj/structure/bodycontainer/morgue
	name = "morgue"
	desc = "Used to keep bodies in until someone fetches them. Includes a high-tech alert system."
	icon_state = "morgue1"
	base_icon_state = "morgue"
	dir = EAST

	connected = /obj/structure/tray/m_tray

	/// Whether or not this morgue beeps to alert parameds of revivable corpses.
	var/beeper = TRUE
	/// The minimum time between beeps.
	var/beep_cooldown = 5 SECONDS
	/// The cooldown to prevent this from spamming beeps.
	COOLDOWN_DECLARE(next_beep)

/obj/structure/bodycontainer/morgue/beeper_off
	name = "secure morgue"
	desc = "Used to keep bodies in until someone fetches them. Starts with their beeper off."
	beeper = FALSE

/obj/structure/bodycontainer/morgue/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[beeper ? "disable beeper" : "enable beeper"]"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/bodycontainer/morgue/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(!istype(arrived, /obj/structure/closet/body_bag))
		return
	var/obj/structure/closet/body_bag/arrived_bag = arrived
	if(!arrived_bag.tag_name)
		return
	name = "[initial(name)] - ([arrived_bag.tag_name])"
	update_appearance(UPDATE_ICON)

/obj/structure/bodycontainer/morgue/Exited(atom/movable/gone, direction)
	. = ..()
	if(istype(gone, /obj/structure/closet/body_bag))
		name = initial(name)
	update_appearance(UPDATE_ICON)

/obj/structure/bodycontainer/morgue/examine(mob/user)
	. = ..()
	. += span_notice("The speaker is [beeper ? "enabled" : "disabled"]. Alt-click to toggle it.")

/obj/structure/bodycontainer/morgue/AltClick(mob/user)
	..()
	if(!user.can_perform_action(src, (ALLOW_SILICON_REACH|ALLOW_RESTING)))
		return
	beeper = !beeper
	to_chat(user, span_notice("You turn the speaker function [beeper ? "on" : "off"]."))

/obj/structure/bodycontainer/morgue/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	balloon_alert(user, "alert system overloaded")
	obj_flags |= EMAGGED
	update_appearance(UPDATE_ICON)
	return TRUE

/obj/structure/bodycontainer/morgue/update_icon_state()
	if(!connected || connected.loc != src) // Open or tray is gone.
		icon_state = "morgue0"
		return ..()

	if(contents.len == 1)  // Empty
		icon_state = "morgue1"
		return ..()

	var/list/compiled = get_all_contents_type(/mob/living) // Search for mobs in all contents.
	if(!length(compiled)) // No mobs?
		icon_state = "morgue3"
		return ..()

	if(!(obj_flags & EMAGGED))
		for(var/mob/living/occupant as anything in compiled)
			var/mob/living/mob_occupant = get_mob_or_brainmob(occupant)
			if(!mob_occupant.client || HAS_TRAIT(mob_occupant, TRAIT_SUICIDED) || HAS_TRAIT(mob_occupant, TRAIT_BADDNA))
				continue
			icon_state = "morgue4" // Revivable
			if(mob_occupant.stat == DEAD && beeper && COOLDOWN_FINISHED(src, next_beep))
				playsound(src, 'sound/weapons/gun/general/empty_alarm.ogg', 50, FALSE) //Revive them you blind fucks
				COOLDOWN_START(src, next_beep, beep_cooldown)
			return ..()

	icon_state = "morgue2" // Dead, brainded mob.
	return ..()

/obj/structure/bodycontainer/morgue/update_overlays()
	. = ..()
	underlays.Cut()

	if(name != initial(name))
		. += "[base_icon_state]_label"

/*
 * Crematorium
 */
GLOBAL_LIST_EMPTY(crematoriums)
/obj/structure/bodycontainer/crematorium
	name = "crematorium"
	desc = "A human incinerator. Works well on barbecue nights."
	icon = 'icons/obj/machines/crematorium.dmi'
	icon_state = "crema1"
	base_icon_state = "crema"
	dir = SOUTH

	connected = /obj/structure/tray/c_tray

	var/id = 1

/obj/structure/bodycontainer/crematorium/Initialize(mapload)
	. = ..()
	GLOB.crematoriums += src

/obj/structure/bodycontainer/crematorium/Destroy()
	GLOB.crematoriums -= src
	return ..()

/obj/structure/bodycontainer/crematorium/attack_robot(mob/user) //Borgs can't use crematoriums without help
	to_chat(user, span_warning("[src] is locked against you."))
	return

/obj/structure/bodycontainer/crematorium/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	id = "[port.shuttle_id]_[id]"

/obj/structure/bodycontainer/crematorium/update_icon_state()
	if(!connected || connected.loc != src)
		icon_state = "[base_icon_state]0"
		return ..()
	if(locked)
		icon_state = "[base_icon_state]_active"
		return ..()
	icon_state = "[base_icon_state][(contents.len > 1) ? 2 : 1]"
	return ..()

/obj/structure/bodycontainer/crematorium/proc/cremate(mob/user)
	if(locked)
		return //don't let you cremate something twice or w/e
	// Make sure we don't delete the actual morgue and its tray
	var/list/conts = get_all_contents() - src - connected

	if(!conts.len)
		audible_message(span_hear("You hear a hollow crackle."))
		return

	else
		audible_message(span_hear("You hear a roar as the crematorium activates."))

		locked = TRUE
		update_appearance()

		for(var/mob/living/M in conts)
			if(M.incorporeal_move) //can't cook revenants!
				continue
			if (M.stat != DEAD)
				M.emote("scream")
			if(user)
				log_combat(user, M, "cremated")
			else
				M.log_message("was cremated", LOG_ATTACK)

			if(user.stat != DEAD)
				user.investigate_log("has died from being cremated.", INVESTIGATE_DEATHS)
			M.death(TRUE)
			if(M) //some animals get automatically deleted on death.
				M.ghostize()
				qdel(M)

		for(var/obj/O in conts) //conts defined above, ignores crematorium and tray
			if(istype(O, /obj/effect/dummy/phased_mob)) //they're not physical, don't burn em.
				continue
			qdel(O)

		if(!locate(/obj/effect/decal/cleanable/ash) in get_step(src, dir))//prevent pile-up
			new/obj/effect/decal/cleanable/ash(src)

		sleep(3 SECONDS)

		if(!QDELETED(src))
			locked = FALSE
			update_appearance()
			playsound(src.loc, 'sound/machines/ding.ogg', 50, TRUE) //you horrible people

/obj/structure/bodycontainer/crematorium/creamatorium
	name = "creamatorium"
	desc = "A human incinerator. Works well during ice cream socials."

/obj/structure/bodycontainer/crematorium/creamatorium/cremate(mob/user)
	var/list/icecreams = new()
	for(var/mob/living/i_scream as anything in get_all_contents_type(/mob/living))
		var/obj/item/food/icecream/IC = new(null, list(ICE_CREAM_MOB = list(null, i_scream.name)))
		icecreams += IC
	. = ..()
	for(var/obj/IC in icecreams)
		IC.forceMove(src)

/*
 * Generic Tray
 * Parent class for morguetray and crematoriumtray
 * For overriding only
 */
/obj/structure/tray
	icon = 'icons/obj/machines/crematorium.dmi'
	density = TRUE
	anchored = TRUE
	pass_flags_self = PASSTABLE | LETPASSTHROW
	max_integrity = 350

	///The bodycontainer we are a tray to.
	var/obj/structure/bodycontainer/connected

/obj/structure/tray/Destroy()
	if(connected)
		connected.connected = null
		connected.update_appearance()
		connected = null
	return ..()

/obj/structure/tray/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/iron (loc, 2)
	qdel(src)

/obj/structure/tray/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/tray/attack_robot(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/tray/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if (connected)
		connected.close()
	else
		to_chat(user, span_warning("That's not connected to anything!"))
	add_fingerprint(user)

/obj/structure/tray/attackby(obj/P, mob/user, params)
	if(!istype(P, /obj/item/riding_offhand))
		return ..()

	var/obj/item/riding_offhand/riding_item = P
	var/mob/living/carried_mob = riding_item.rider
	if(carried_mob == user) //Piggyback user.
		return
	user.unbuckle_mob(carried_mob)
	MouseDrop_T(carried_mob, user)

/obj/structure/tray/MouseDrop_T(atom/movable/O as mob|obj, mob/user)
	if(!ismovable(O) || O.anchored || !Adjacent(user) || !user.Adjacent(O) || O.loc == user)
		return
	if(!ismob(O))
		if(!istype(O, /obj/structure/closet/body_bag))
			return
	else
		var/mob/M = O
		if(M.buckled)
			return
	if(!ismob(user) || user.incapacitated())
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.body_position == LYING_DOWN)
			return
	O.forceMove(src.loc)
	if (user != O)
		visible_message(span_warning("[user] stuffs [O] into [src]."))
	return

/*
 * Crematorium tray
 */
/obj/structure/tray/c_tray
	name = "crematorium tray"
	desc = "Apply body before burning."
	icon_state = "cremat"

/*
 * Morgue tray
 */
/obj/structure/tray/m_tray
	name = "morgue tray"
	desc = "Apply corpse before closing."
	icon = 'icons/obj/structures.dmi'
	icon_state = "morguet"
	pass_flags_self = PASSTABLE | LETPASSTHROW

/obj/structure/tray/m_tray/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	if(locate(/obj/structure/table) in get_turf(mover))
		return TRUE

#undef BREAKOUT_COOLDOWN
#undef BREAKDOWN_TIME
