/turf/closed/indestructible/supermatter_wall
	name = "wall"
	desc = "Effectively impervious any methods of destruction."
	icon = 'icons/turf/walls.dmi'
	icon_state = "crystal_cascade_1"
	layer = AREA_LAYER
	plane = ABOVE_LIGHTING_PLANE
	opacity = FALSE
	light_power = 1
	light_range = 7
	light_color = COLOR_VIVID_YELLOW
	///All dirs we can expand to
	var/list/available_dirs = list(NORTH,SOUTH,EAST,WEST,UP,DOWN)
	///Cooldown on the expansion process
	COOLDOWN_DECLARE(sm_wall_cooldown)

/turf/closed/indestructible/supermatter_wall/Initialize(mapload)
	. = ..()
	icon_state = "crystal_cascade_[rand(1,6)]"
	START_PROCESSING(SSmachines, src)

	AddComponent(/datum/component/supermatter_crystal, null, null)

	playsound(src, 'sound/misc/cracking_crystal.ogg', 20, TRUE)

/turf/closed/indestructible/supermatter_wall/process()

	if(!COOLDOWN_FINISHED(src, sm_wall_cooldown))
		return

	if(!available_dirs || available_dirs.len <= 0)
		light_range = 0
		return PROCESS_KILL

	COOLDOWN_START(src, sm_wall_cooldown, rand(0, 5 SECONDS))

	var/picked_dir = pick_n_take(available_dirs)
	var/turf/next_turf = get_step_multiz(src, picked_dir)
	if(!istype(next_turf) || istype(next_turf, /turf/closed/indestructible/supermatter_wall))
		return

	icon_state = "crystal_cascade_[rand(1,6)]"

	for(var/atom/movable/checked_atom as anything in next_turf)
		if(isliving(checked_atom))
			qdel(checked_atom)
		else if(ismob(checked_atom)) // Observers, AI cameras.
			continue
		else if(istype(checked_atom, /obj/cascade_portal))
			continue
		else
			qdel(checked_atom)

	next_turf.ChangeTurf(type)
	var/turf/closed/indestructible/supermatter_wall/sm_wall = next_turf
	if(sm_wall.available_dirs)
		sm_wall.available_dirs -= get_dir(next_turf, src)

/turf/closed/indestructible/supermatter_wall/bullet_act(obj/projectile/projectile)
	visible_message(span_notice("[src] is unscathed!"))
	return BULLET_ACT_HIT

/turf/closed/indestructible/supermatter_wall/singularity_act()
	return

/turf/closed/indestructible/supermatter_wall/attack_tk(mob/user)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/jedi = user
	to_chat(jedi, span_userdanger("That was a really dense idea."))
	jedi.ghostize()
	var/obj/item/organ/brain/rip_u = locate(/obj/item/organ/brain) in jedi.internal_organs
	if(rip_u)
		rip_u.Remove(jedi)
		qdel(rip_u)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/cascade_portal
	name = "Bluespace Rift"
	desc = "Your mind begins to bubble and ooze as it tries to comprehend what it sees."
	icon = 'icons/effects/224x224.dmi'
	icon_state = "reality"
	anchored = TRUE
	appearance_flags = LONG_GLIDE
	density = TRUE
	plane = MASSIVE_OBJ_PLANE
	light_color = COLOR_RED
	light_power = 0.7
	light_range = 15
	move_resist = INFINITY
	pixel_x = -96
	pixel_y = -96
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/cascade_portal/Bumped(atom/movable/hit_object)
	if(isliving(hit_object))
		hit_object.visible_message(span_danger("\The [hit_object] slams into \the [src] inducing a resonance... [hit_object.p_their()] body starts to glow and burst into flames before flashing into dust!"),
			span_userdanger("You slam into \the [src] as your ears are filled with unearthly ringing. Your last thought is \"Oh, fuck.\""),
			span_hear("You hear an unearthly noise as a wave of heat washes over you."))
	else if(isobj(hit_object) && !iseffect(hit_object))
		hit_object.visible_message(span_danger("\The [hit_object] smacks into \the [src] and rapidly flashes to ash."), null,
			span_hear("You hear a loud crack as you are washed with a wave of heat."))
	else
		return

	playsound(get_turf(src), 'sound/effects/supermatter.ogg', 50, TRUE)
	consume(hit_object)

/**
 * Proc to consume the objects colliding with the portal
 *
 * Arguments: atom/movable/consumed_object is the object hitting the portal
 */
/obj/cascade_portal/proc/consume(atom/movable/consumed_object)
	if(isliving(consumed_object))
		var/mob/living/consumed_mob = consumed_object
		if(consumed_mob.status_flags & GODMODE)
			return
		message_admins("[src] has consumed [key_name_admin(consumed_mob)] [ADMIN_JMP(src)].")
		investigate_log("has consumed [key_name(consumed_mob)].", INVESTIGATE_ENGINE)
		consumed_mob.dust(force = TRUE)
	else if(consumed_object.flags_1 & SUPERMATTER_IGNORES_1)
		return
	else if(isobj(consumed_object))
		qdel(consumed_object)
