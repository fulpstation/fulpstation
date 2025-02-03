/// Catification smite
/// Allows an admin to spawn a cateor near a target and direct it at them.
/datum/smite/catify
	name = "Cateorize"

	/// Boolean indicating whether or not we stun the target before launching a cateor at them.
	var/stun_target = TRUE
	/// Boolean indicating whether or not the user has accepted the smite's disclaimer.
	var/warning_accepted = FALSE

/datum/smite/catify/configure(client/user)
	. = ..()
	/// Warn the admin about the exact function of the smite.
	warning_accepted = input(user,
						"This smite will spawn a cateor at a random point within a roughly three \
						tile range of its target. The cateor doesn't have perfect homing, and it is \
						liable to hit any mob between it and the target. Please ensure that no mobs \
						are present near the target unless you wish to risk hitting them.",
						"DISCLAIMER",
						FALSE) in list("ACCEPT DISCLAIMER", "ABORT")
	if(warning_accepted == "ACCEPT DISCLAIMER")
		warning_accepted = TRUE
	if(warning_accepted == "ABORT")
		warning_accepted = FALSE
		should_log = FALSE
		return FALSE

	/// Optional stunning
	stun_target = input(user,
						"Stun target once the cat meteor is launched? (Please keep the cateor's \
						imperfect homing in mind.)",
						"Stun Configuration",
						TRUE) in list("Yes", "No")
	if(stun_target == "Yes")
		stun_target = TRUE
	if(stun_target == "No")
		stun_target = FALSE

/datum/smite/catify/effect(client/user, mob/living/target)
	. = ..()
	if(warning_accepted == FALSE) //We should've returned FALSE on 'configure()', but just in case...
		return

	if(stun_target)
		if(iscarbon(target))
			var/mob/living/carbon/victim = target
			victim.Immobilize(10 SECONDS, TRUE)
		else
			var/launch_anyways
			launch_anyways = input(user,
			"Can't stun a non-carbon mob, launch cateor anyways?",
			"Launch Anyways?",
			FALSE) in list("Yes", "No")
			if(launch_anyways == "Yes")
				launch_anyways = TRUE
			if(launch_anyways == "No")
				launch_anyways = FALSE
			if(!launch_anyways)
				return

	var/turf/T = get_turf(target)
	var/list/valid_turfs = list()
	/// Copied over with adjustment from 'pandora.dm', gets a spawnpoint for our cateor at a certain
	/// distance from the target.
	for(var/t in spiral_range_turfs(3, T))
		if(get_dist(t, T) > 1)
			valid_turfs.Add(t)

	/// Spawn the cateor and launch it.
	var/obj/effect/meteor/cateor/new_cateor = new /obj/effect/meteor/cateor(pick(valid_turfs), get_turf(target))
	addtimer(CALLBACK(new_cateor, PROC_REF(Destroy)), 5 SECONDS)
	new_cateor.chase_target(get_turf(target), home = TRUE)
