///summon wraiths (weakened shades) to attack anyone who isn't a zombie. This includes non-zombified vassals. However, you can get around this by zombifying your vassals.
///to do this, you can make someone your favorite vassal, or you can kill them and then revive them with necromancy.
/datum/action/cooldown/bloodsucker/hecata/spiritcall
	name = "Spirit Call"
	desc = "Summon angry wraiths which will attack anyone whose flesh is still alive. Summon amount increases as this ability levels up."
	button_icon_state = "power_spiritcall"
	power_explanation = "Spirit Call:\n\
		Summon angry wraiths which enact vengeance from beyond the grave on those still connected to this world.\n\
		Note, that includes any of your vassals who are not undead, as wraiths will seek to kill them too!\n\
		Summons more wraiths as this ability ranks up.\n\
		These wraiths aren't very powerful, and best serve as a distraction, but in a pinch can help in a fight. \n\
		The spirits will eventually return back to their realm if not otherwise destroyed."
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY|BP_CANT_USE_WHILE_UNCONSCIOUS
	power_flags = BP_AM_STATIC_COOLDOWN
	bloodcost = 15
	cooldown_time = 60 SECONDS
	///How many spirits should be summoned when cast
	var/num_spirits = 1

/datum/action/cooldown/bloodsucker/hecata/spiritcall/vassal //this variant has to exist, as hecata favorite vassals are technically in 'torpor'
	check_flags = BP_CANT_USE_WHILE_INCAPACITATED|BP_CANT_USE_WHILE_UNCONSCIOUS

/datum/action/cooldown/bloodsucker/hecata/spiritcall/ActivatePower()
	. = ..()
	var/mob/user = owner
	switch(level_current)
		if(0)
			num_spirits = 1
		if(1)
			num_spirits = 2
		if(2)
			num_spirits = 3
		else
			num_spirits = 4
	var/list/turf/locs = list()
	for(var/direction in GLOB.alldirs) //looking for spirit spawns
		if(locs.len == num_spirits) //we found the number of spots needed and thats all we need
			break
		var/turf/T = get_step(owner, direction) //getting a loc in that direction
		if(get_path_to(user, T, 1, simulated_only = 0)) // if a path exists, so no dense objects in the way its valid salid
			locs += T
	// pad with player location
	for(var/i = locs.len + 1 to num_spirits)
		locs += user.loc
	summon_wraiths(locs, user = owner)
	cast_effect() // POOF
	DeactivatePower()

/datum/action/cooldown/bloodsucker/hecata/spiritcall/proc/summon_wraiths(list/targets, mob/living/user)
	for(var/T in targets)
		new /mob/living/basic/bloodsucker/wraith(T)

/datum/action/cooldown/bloodsucker/hecata/spiritcall/proc/cast_effect() //same as veil of many faces, makes smoke and stuff when casted
	// Effect
	playsound(get_turf(owner), 'sound/effects/magic/smoke.ogg', 20, TRUE)
	var/datum/effect_system/steam_spread/puff = new /datum/effect_system/steam_spread/bloodsucker()
	puff.effect_type = /obj/effect/particle_effect/fluid/smoke/vampsmoke
	puff.set_up(3, 0, get_turf(owner))
	puff.attach(owner) //OPTIONAL
	puff.start()
	owner.spin(8, 1) //Spin around like a loon.
