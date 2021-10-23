//Procs first
/proc/check_location_seen(atom/subject, turf/target_turf)
	if(!isturf(target_turf)) // Only check if I wasn't given a locker or something
		return FALSE
	// A) Check for Darkness
	if(target_turf && target_turf.lighting_object && target_turf.get_lumcount()>= 0.1)
		// B) Check for Viewers
		for(var/mob/living/nearby_viewers in viewers(target_turf))
			if(nearby_viewers != subject && isliving(nearby_viewers) && nearby_viewers.mind && !nearby_viewers.has_unlimited_silicon_privilege && !nearby_viewers.eye_blind) // M.client <--- add this in after testing!
				return TRUE
	return FALSE

/proc/return_valid_floor_in_range(atom/targeted_atom, checkRange = 8, minRange = 0, checkFloor = TRUE)
	// FAIL: Atom doesn't exist. Aren't you real?
	if(!istype(targeted_atom))
		return null

	var/deltaX = rand(minRange,checkRange)*pick(-1,1)
	var/deltaY = rand(minRange,checkRange)*pick(-1,1)
	var/turf/center = get_turf(targeted_atom)

	var/target = locate((center.x + deltaX),(center.y + deltaY),center.z)

	if(check_turf_is_valid(target, checkFloor))
		return target
	return null

/**
 * Used as a helper that checks if you can successfully teleport to a turf.
 * Returns a boolean, and checks for if the turf has density, if the turf's area has the NOTELEPORT flag,
 * and if the objects in the turf have density.
 * If checkFloor is TRUE in the argument, it will return FALSE if it's not a type of [/turf/open/floor].
 * Arguments:
 * * turf/open_turf - The turf being checked for validity.
 * * checkFloor - Checks if it's a type of [/turf/open/floor]. If this is FALSE, lava/chasms will be able to be selected.
 */
/proc/check_turf_is_valid(turf/open_turf, checkFloor = TRUE)
	// Checking for Floor...
	if(checkFloor && !istype(open_turf, /turf/open/floor))
		return FALSE
	// Checking for Density...
	if(open_turf.density)
		return FALSE
	var/area/turf_area = get_area(open_turf)
	// Checking for if the area has the NOTELEPORT flag...
	if(turf_area?.area_flags & NOTELEPORT)
		return FALSE
	// Checking for Objects...
	for(var/obj/object in open_turf)
		if(object.density)
			return FALSE
	return TRUE

/datum/brain_trauma/special/bluespace_prophet/phobetor
	name = "Sleepless Dreamer"
	desc = "The patient, after undergoing untold psychological hardship, believes they can travel between the dreamscapes of this dimension."
	scan_desc = "awoken sleeper"
	gain_text = span_notice("Your mind snaps, and you wake up. You <i>really</i> wake up.")
	lose_text = span_warning("You succumb once more to the sleepless dream of the unwoken.")


	var/list/created_firsts = list()

/datum/brain_trauma/special/bluespace_prophet/phobetor/on_life(delta_time, times_fired)
	if(!COOLDOWN_FINISHED(src, portal_cooldown))
		return

	COOLDOWN_START(src, portal_cooldown, 10 SECONDS)
	var/list/turf/possible_tears = list()
	for(var/turf/nearby_turfs as anything in RANGE_TURFS(8, owner))
		if(nearby_turfs.density)
			continue

		var/clear = TRUE
		for(var/obj/nearby_objects in nearby_turfs)
			if(nearby_objects.density)
				clear = FALSE
				break
		if(clear)
			possible_tears += nearby_turfs

	if(!LAZYLEN(possible_tears))
		return

	var/turf/first_tear
	var/turf/second_tear

	// Round One: Pick a Nearby Turf
	first_tear = return_valid_floor_in_range(owner, 6, 0, TRUE)
	if (!first_tear)
		return

	// Round Two: Pick an even Further Turf
	second_tear = return_valid_floor_in_range(first_tear, 20, 6, TRUE)
	if (!second_tear)
		return


	var/obj/effect/hallucination/simple/phobetor/first = new(first_tear, owner)
	var/obj/effect/hallucination/simple/phobetor/second = new(second_tear, owner)

	first.linked_to = second
	second.linked_to = first
	first.seer = owner
	second.seer = owner
	first.desc += " This one leads to [get_area(second)]."
	second.desc += " This one leads to [get_area(first)]."
	first.name += " ([get_area(second)])."
	second.name += " ([get_area(first)])."

	// Remember this Portal...it's gonna get checked for deletion.
	created_firsts += first

	// Delete Next Portal if it's time (it will remove its partner)
	var/obj/effect/hallucination/simple/phobetor/first_on_the_stack = created_firsts[1]
	if (created_firsts.len && world.time >= first_on_the_stack.created_on + first_on_the_stack.exist_length)
		var/targetGate = first_on_the_stack
		created_firsts -= targetGate
		qdel(targetGate)

//Called when removed from a mob
/datum/brain_trauma/special/bluespace_prophet/phobetor/on_lose(silent)
	for (var/BT in created_firsts)
		qdel(BT)

/obj/effect/hallucination/simple/phobetor
	name = "phobetor tear"
	desc = "A subdimensional rip in reality, which gives extra-spacial passage to those who have woken from the sleepless dream."
	image_icon = 'fulp_modules/main_features/species/icons/phobetor_tear.dmi'
	image_state = "phobetor_tear"
	image_layer = ABOVE_LIGHTING_PLANE // Place this above shadows so it always glows.
	var/exist_length = 500
	var/created_on
	var/obj/effect/hallucination/simple/phobetor/linked_to
	var/mob/living/carbon/seer

/obj/effect/hallucination/simple/phobetor/attack_hand(mob/user)
	if(user != seer || !linked_to)
		return
	if (user.loc != src.loc)
		to_chat(user, "Step into the Tear before using it.")
		return
	// Is this, or linked, stream being watched?
	if (check_location_seen(user, get_turf(user)))
		to_chat(user, span_warning("Not while you're being watched."))
		return
	if (check_location_seen(user, get_turf(linked_to)))
		to_chat(user, span_warning("Your destination is being watched."))
		return
	to_chat(user, span_notice("You slip unseen through the Phobetor Tear."))
	user.playsound_local(null, 'sound/magic/wand_teleport.ogg', 30, FALSE, pressure_affected = FALSE)

	user.forceMove(get_turf(linked_to))

/obj/effect/hallucination/simple/phobetor/Initialize()
	. = ..()
	created_on = world.time
	//QDEL_IN(src, 300)

/obj/effect/hallucination/simple/phobetor/Destroy()
	// Remove Linked (if exists)
	if (linked_to)
		linked_to.linked_to = null
		qdel(linked_to)
		// WHY DO THIS?	Because our trauma only gets rid of all the FIRST gates created.
	. = ..()
