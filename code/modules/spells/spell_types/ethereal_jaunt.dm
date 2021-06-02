/obj/effect/proc_holder/spell/targeted/ethereal_jaunt
	name = "Ethereal Jaunt"
	desc = "This spell turns your form ethereal, temporarily making you invisible and able to pass through walls."

	school = SCHOOL_TRANSMUTATION
	charge_max = 30 SECONDS
	clothes_req = TRUE
	invocation = "none"
	invocation_type = "none"
	range = -1
	cooldown_min = 10 SECONDS
	include_user = TRUE
	nonabstract_req = TRUE
	action_icon_state = "jaunt"
	/// For how long are we jaunting?
	var/jaunt_duration = 5 SECONDS
	/// For how long we become immobilized after exiting the jaunt.
	var/jaunt_in_time = 0.5 SECONDS
	/// For how long we become immobilized when using this spell.
	var/jaunt_out_time = 0 SECONDS
	/// Visual for jaunting
	var/jaunt_in_type = /obj/effect/temp_visual/wizard
	/// Visual for exiting the jaunt
	var/jaunt_out_type = /obj/effect/temp_visual/wizard/out

/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/cast_check(skipcharge = 0,mob/user = usr)
	. = ..()
	if(!.)
		return FALSE
	var/area/noteleport_check = get_area(user)
	if(noteleport_check && noteleport_check.area_flags & NOTELEPORT)
		to_chat(user, "<span class='danger'>Some dull, universal force is stopping you from jaunting here.</span>")
		return FALSE

/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/cast(list/targets,mob/user = usr) //magnets, so mostly hardcoded
	play_sound("enter",user)
	for(var/mob/living/target in targets)
		INVOKE_ASYNC(src, .proc/do_jaunt, target)

/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/proc/do_jaunt(mob/living/target)
	target.notransform = 1
	var/turf/mobloc = get_turf(target)
	var/obj/effect/dummy/phased_mob/spell_jaunt/holder = new /obj/effect/dummy/phased_mob/spell_jaunt(mobloc)
	new jaunt_out_type(mobloc, target.dir)
	target.extinguish_mob()
	target.forceMove(holder)
	target.reset_perspective(holder)
	target.notransform=0 //mob is safely inside holder now, no need for protection.
	jaunt_steam(mobloc)
	if(jaunt_out_time)
		ADD_TRAIT(target, TRAIT_IMMOBILIZED, type)
		sleep(jaunt_out_time)
		REMOVE_TRAIT(target, TRAIT_IMMOBILIZED, type)
	sleep(jaunt_duration)

	if(target.loc != holder) //mob warped out of the warp
		qdel(holder)
		return
	mobloc = get_turf(target.loc)
	jaunt_steam(mobloc)
	ADD_TRAIT(target, TRAIT_IMMOBILIZED, type)
	holder.reappearing = 1
	play_sound("exit",target)
	sleep(25 - jaunt_in_time)
	new jaunt_in_type(mobloc, holder.dir)
	target.setDir(holder.dir)
	sleep(jaunt_in_time)
	qdel(holder)
	if(!QDELETED(target))
		if(mobloc.density)
			for(var/direction in GLOB.alldirs)
				var/turf/T = get_step(mobloc, direction)
				if(T)
					if(target.Move(T))
						break
		REMOVE_TRAIT(target, TRAIT_IMMOBILIZED, type)

/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/proc/jaunt_steam(mobloc)
	var/datum/effect_system/steam_spread/steam = new /datum/effect_system/steam_spread()
	steam.set_up(10, 0, mobloc)
	steam.start()

/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/proc/play_sound(type,mob/living/target)
	switch(type)
		if("enter")
			playsound(get_turf(target), 'sound/magic/ethereal_enter.ogg', 50, TRUE, -1)
		if("exit")
			playsound(get_turf(target), 'sound/magic/ethereal_exit.ogg', 50, TRUE, -1)

/obj/effect/dummy/phased_mob/spell_jaunt
	movespeed = 2 //quite slow.
	var/reappearing = FALSE

/obj/effect/dummy/phased_mob/spell_jaunt/phased_check(mob/living/user, direction)
	if(reappearing)
		return
	. = ..()
	if(!.)
		return
	if (locate(/obj/effect/blessing, .))
		to_chat(user, "<span class='warning'>Holy energies block your path!</span>")
		return null
