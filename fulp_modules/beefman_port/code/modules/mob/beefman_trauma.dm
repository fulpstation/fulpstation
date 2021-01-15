//Procs first
/proc/check_location_seen(atom/subject, turf/T)
	if (!isturf(T)) // Only check if I wasn't given a locker or something
		return FALSE
	// A) Check for Darkness
	if(T && T.lighting_object && T.get_lumcount()>= 0.1)
		// B) Check for Viewers
		for(var/mob/living/M in viewers(T))
			if(M != subject && isliving(M) && M.mind && !M.has_unlimited_silicon_privilege && !M.eye_blind) // M.client <--- add this in after testing!
				return TRUE
	return FALSE

/proc/return_valid_floor_in_range(atom/A, checkRange = 8, minRange = 0, checkFloor = TRUE)
	// FAIL: Atom doesn't exist. Aren't you real?
	if (!istype(A))
		return null

	var/deltaX = rand(minRange,checkRange)*pick(-1,1)
	var/deltaY = rand(minRange,checkRange)*pick(-1,1)
	var/turf/center = get_turf(A)

	var/target = locate((center.x + deltaX),(center.y + deltaY),center.z)

	if (check_turf_is_valid(target, checkFloor))
		return target
	return null

/proc/check_turf_is_valid(turf/T, checkFloor = TRUE)
	// Checking for Floor...
	if (checkFloor && !istype(T, /turf/open/floor))
		return FALSE
	// Checking for Density...
	if(T.density)
		return FALSE
	// Checking for Objects...
	for(var/obj/O in T)
		if(O.density)
			return FALSE
	return TRUE

/datum/brain_trauma/special/bluespace_prophet/phobetor
	name = "Sleepless Dreamer"
	desc = "The patient, after undergoing untold psychological hardship, believes they can travel between the dreamscapes of this dimension."
	scan_desc = "awoken sleeper"
	gain_text = "<span class='notice'>Your mind snaps, and you wake up. You <i>really</i> wake up.</span>"
	lose_text = "<span class='warning'>You succumb once more to the sleepless dream of the unwoken.</span>"

	var/list/created_firsts = list()

/datum/brain_trauma/special/bluespace_prophet/phobetor/on_life()

	var/turf/first_turf
	var/turf/second_turf

	// Make Next Portal
	if(world.time > next_portal)

/*
		// Round One: Pick a Nearby Turf
		var/list/turf/possible_turfs = return_valid_floors_in_range(owner, 6, 0, TRUE) // Source, Range, Has Floor
		if(!LAZYLEN(possible_turfs))
			return
		// First Pick:
		var/turf/first_turf = pick(possible_turfs)
		if(!first_turf)
			return
		// Round Two: Pick an even Further Turf
		possible_turfs = return_valid_floors_in_range(first_turf, 20, 6, TRUE) // Source, Range, Has Floor
		possible_turfs -= first_turf
		if(!LAZYLEN(possible_turfs))
			return
		// Second Pick:
		var/turf/second_turf = pick(possible_turfs)
		if(!second_turf)
			return
*/

		// Round One: Pick a Nearby Turf
		first_turf = return_valid_floor_in_range(owner, 6, 0, TRUE)
		if (!first_turf)
			next_portal = world.time + 10
			return

		// Round Two: Pick an even Further Turf
		second_turf = return_valid_floor_in_range(first_turf, 20, 6, TRUE)
		if (!second_turf)
			next_portal = world.time + 10
			return

		next_portal = world.time + 100


		var/obj/effect/hallucination/simple/phobetor/first = new (first_turf, owner)
		var/obj/effect/hallucination/simple/phobetor/second = new (second_turf, owner)

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
	image_icon = 'fulp_modules/beefman_port/icons/phobetor_tear.dmi'
	image_state = "phobetor_tear"
	image_layer = ABOVE_LIGHTING_LAYER // Place this above shadows so it always glows.
	var/exist_length = 500
	var/created_on
	use_without_hands = TRUE // A Swain addition.
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
		to_chat(user, "<span class='warning'>Not while you're being watched.</span>")
		return
	if (check_location_seen(user, get_turf(linked_to)))
		to_chat(user, "<span class='warning'>Your destination is being watched.</span>")
		return
	to_chat(user, "<span class='notice'>You slip unseen through the Phobetor Tear.</span>")
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
