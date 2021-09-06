/obj/item/gun/energy/kinetic_accelerator
	name = "proto-kinetic accelerator"
	desc = "A self recharging, ranged mining tool that does increased damage in low pressure."
	icon_state = "kineticgun"
	inhand_icon_state = "kineticgun"
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic)
	cell_type = /obj/item/stock_parts/cell/emproof
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	can_flashlight = TRUE
	flight_x_offset = 15
	flight_y_offset = 9
	automatic_charge_overlays = FALSE
	can_bayonet = TRUE
	knife_x_offset = 20
	knife_y_offset = 12
	var/overheat_time = 16
	var/holds_charge = FALSE
	var/unique_frequency = FALSE // modified by KA modkits
	var/overheat = FALSE
	var/mob/holder


	var/max_mod_capacity = 100
	var/list/modkits = list()

	var/recharge_timerid

/obj/item/gun/energy/kinetic_accelerator/examine(mob/user)
	. = ..()
	if(max_mod_capacity)
		. += "<b>[get_remaining_mod_capacity()]%</b> mod capacity remaining."
		. += span_info("You can use a <b>crowbar</b> to remove modules.")

/obj/item/gun/energy/kinetic_accelerator/crowbar_act(mob/living/user, obj/item/I)
	. = TRUE
	if(modkits.len)
		to_chat(user, span_notice("You pry the modifications out."))
		I.play_tool_sound(src, 100)
	else
		to_chat(user, span_notice("There are no modifications currently installed."))


/obj/item/gun/energy/kinetic_accelerator/proc/get_remaining_mod_capacity()
	var/current_capacity_used = 0
	return max_mod_capacity - current_capacity_used

/obj/item/gun/energy/kinetic_accelerator/proc/modify_projectile(obj/projectile/kinetic/K)
	K.kinetic_gun = src //do something special on-hit, easy!

/obj/item/gun/energy/kinetic_accelerator/cyborg
	holds_charge = TRUE
	unique_frequency = TRUE
	max_mod_capacity = 80

/obj/item/gun/energy/kinetic_accelerator/minebot
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	overheat_time = 20
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/kinetic_accelerator/Initialize()
	. = ..()
	if(!holds_charge)
		empty()

/obj/item/gun/energy/kinetic_accelerator/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	. = ..()
	attempt_reload()

/obj/item/gun/energy/kinetic_accelerator/equipped(mob/user)
	. = ..()
	holder = user
	if(!can_shoot())
		attempt_reload()

/obj/item/gun/energy/kinetic_accelerator/dropped()
	. = ..()
	holder = null
	if(!QDELING(src) && !holds_charge)
		// Put it on a delay because moving item from slot to hand
		// calls dropped().
		addtimer(CALLBACK(src, .proc/empty_if_not_held), 2)

/obj/item/gun/energy/kinetic_accelerator/proc/empty_if_not_held()
	if(!ismob(loc))
		empty()

/obj/item/gun/energy/kinetic_accelerator/proc/empty()
	if(cell)
		cell.use(cell.charge)
	update_appearance()

/obj/item/gun/energy/kinetic_accelerator/proc/attempt_reload(recharge_time)
	if(!cell)
		return
	if(overheat)
		return
	if(!recharge_time)
		recharge_time = overheat_time
	overheat = TRUE

	var/carried = 0
	if(!unique_frequency)
		for(var/obj/item/gun/energy/kinetic_accelerator/K in loc.GetAllContents())
			if(!K.unique_frequency)
				carried++

		carried = max(carried, 1)
	else
		carried = 1

	deltimer(recharge_timerid)
	recharge_timerid = addtimer(CALLBACK(src, .proc/reload), recharge_time * carried, TIMER_STOPPABLE)

/obj/item/gun/energy/kinetic_accelerator/emp_act(severity)
	return

/obj/item/gun/energy/kinetic_accelerator/proc/reload()
	cell.give(cell.maxcharge)
	if(!suppressed)
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, TRUE)
	else
		to_chat(loc, span_warning("[src] silently charges up."))
	update_appearance()
	overheat = FALSE

/obj/item/gun/energy/kinetic_accelerator/update_overlays()
	. = ..()
	if(!can_shoot())
		. += "[icon_state]_empty"

//Casing
/obj/item/ammo_casing/energy/kinetic
	projectile_type = /obj/projectile/kinetic
	select_name = "kinetic"
	e_cost = 500
	fire_sound = 'sound/weapons/kenetic_accel.ogg' // fine spelling there chap

/obj/item/ammo_casing/energy/kinetic/ready_proj(atom/target, mob/living/user, quiet, zone_override = "")
	..()
	if(loc && istype(loc, /obj/item/gun/energy/kinetic_accelerator))
		var/obj/item/gun/energy/kinetic_accelerator/KA = loc
		KA.modify_projectile(loaded_projectile)

//Projectiles
/obj/projectile/kinetic
	name = "kinetic force"
	icon_state = null
	damage = 40
	damage_type = BRUTE
	flag = BOMB
	range = 3
	log_override = TRUE

	var/pressure_decrease_active = FALSE
	var/pressure_decrease = 0.25
	var/obj/item/gun/energy/kinetic_accelerator/kinetic_gun

/obj/projectile/kinetic/Destroy()
	kinetic_gun = null
	return ..()

/obj/projectile/kinetic/prehit_pierce(atom/target)
	. = ..()
	if(. == PROJECTILE_PIERCE_PHASE)
		return
	if(!pressure_decrease_active && !lavaland_equipment_pressure_check(get_turf(target)))
		name = "weakened [name]"
		damage = damage * pressure_decrease
		pressure_decrease_active = TRUE

/obj/projectile/kinetic/on_range()
	strike_thing()
	..()

/obj/projectile/kinetic/on_hit(atom/target)
	strike_thing(target)
	. = ..()

/obj/projectile/kinetic/proc/strike_thing(atom/target)
	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		target_turf = get_turf(src)
	if(ismineralturf(target_turf))
		var/turf/closed/mineral/M = target_turf
		M.gets_drilled(firer, TRUE)
		if(iscarbon(firer))
			var/mob/living/carbon/carbon_firer = firer
			var/skill_modifier = 1
			// If there is a mind, check for skill modifier to allow them to reload faster.
			if(carbon_firer.mind)
				skill_modifier = carbon_firer.mind.get_skill_modifier(/datum/skill/mining, SKILL_SPEED_MODIFIER)
			kinetic_gun.attempt_reload(kinetic_gun.overheat_time * skill_modifier) //If you hit a mineral, you might get a quicker reload. epic gamer style.
	var/obj/effect/temp_visual/kinetic_blast/K = new /obj/effect/temp_visual/kinetic_blast(target_turf)
	K.color = color

//mecha_kineticgun version of the projectile
/obj/projectile/kinetic/mech
	range = 5
