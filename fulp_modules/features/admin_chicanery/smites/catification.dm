/// Catification smite
/// Allows an admin to spawn a cateor near a target and direct it at them.
/datum/smite/catify
	name = "Cateorize"

	/// Boolean indicating whether or not we stun the target before launching a cateor at them.
	var/stun_target = TRUE

/datum/smite/catify/configure(client/user)
	. = ..()
	stun_target = input(user,
						"Stun target once the cat meteor is launched?",
						"Stun Configuration",
						TRUE) in list("Yes", "No")
	if(stun_target == "Yes")
		stun_target = TRUE
	if(stun_target == "No")
		stun_target = FALSE

/datum/smite/catify/effect(client/user, mob/living/target)
	. = ..()
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
	addtimer(CALLBACK(new_cateor, PROC_REF(Destroy)), 15 SECONDS)
	new_cateor.chase_target(get_turf(target), home = TRUE)
