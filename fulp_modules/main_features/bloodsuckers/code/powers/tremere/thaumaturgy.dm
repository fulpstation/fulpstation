/*
 *	# Thaumaturgy
 *
 *	Level 1 - One shot bloodbeam spell
 *	Level 2 - Bloodbeam spell that breaks open lockers
 *	Level 3 - Bloodbeam spell that breaks open lockers/doors
 *	Level 4 - Bloodbeam spell that breaks open lockers/doors - Gives them a Blood shield until they use Bloodbeam
 *	Level 5 - Bloodbeam spell that breaks open lockers/doors, steals blood from targets - Gives them a Blood shield until they use Bloodbeam
 */

/datum/action/bloodsucker/targeted/tremere/thaumaturgy
	name = "Level 1: Thaumaturgy"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/thaumaturgy/two
	desc = "Shoot a Blood barrage at your enemy."
	tremere_level = 1
	button_icon_state = "power_strength"
	power_explanation = "<b>Fortitude</b>:\n\
		Activating Fortitude will provide pierce, stun and dismember immunity.\n\
		You will additionally gain resistance to Brute and Stamina damge, scaling with level.\n\
		While using Fortitude, attempting to run will crush you.\n\
		At level 4, you gain complete stun immunity.\n\
		Higher levels will increase Brute and Stamina resistance."
	must_be_capacitated = TRUE
	bloodcost = 30
	cooldown = 80
	must_be_concious = FALSE
	message_Trigger = "Click where you wish to fire (using your power removes blood shield)"

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/two
/datum/action/bloodsucker/targeted/tremere/thaumaturgy/three
/datum/action/bloodsucker/targeted/tremere/thaumaturgy/advanced
/datum/action/bloodsucker/targeted/tremere/thaumaturgy/advanced/two

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/CheckValidTarget(atom/A)
	return TRUE

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/CheckCanUse(display_error)
	if(!..())
		return
	if(!active) // Only do this when first activating.
		var/mob/living/user = owner
		if(user.get_inactive_held_item())
			if(display_error)
				owner.balloon_alert(owner, "off hand is full!")
		var/obj/offhand_shield = new /obj/item/shield/changeling()
		if(!user.put_in_inactive_hand(offhand_shield))
			return FALSE
		owner.balloon_alert(owner, "thaumaturgy turned on.")
		to_chat(user, span_notice("You prepare Thaumaturgy."))
	return TRUE

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/DeactivatePower()
	var/list/L = owner.get_contents()
	var/obj/item/shield/changeling/bloodshield = locate() in L
	if(bloodshield)
		qdel(bloodshield)
	owner.balloon_alert(owner, "thaumaturgy turned off.")
	return ..()

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/FireTargetedPower(atom/A)
	. = ..()

	var/mob/living/user = owner
	to_chat(user, span_warning("You fire a blood bolt!"))
	user.changeNext_move(CLICK_CD_RANGE)
	user.newtonian_move(get_dir(A, user))
	var/obj/projectile/magic/arcane_barrage/bloodsucker/LE = new(user.loc)
	LE.firer = user
	LE.def_zone = ran_zone(user.zone_selected)
	LE.preparePixelProjectile(A, user)
	INVOKE_ASYNC(LE, /obj/projectile.proc/fire)
	playsound(user, 'sound/magic/wand_teleport.ogg', 60, TRUE)
	PowerActivatedSuccessfully()

/*
 *	# Blood Bolt
 *
 *	This is the projectile this Power will fire.
 */

/obj/projectile/magic/arcane_barrage/bloodsucker
	name = "blood bolt"
	icon_state = "mini_leaper"
	damage = 20

/obj/projectile/magic/arcane_barrage/bloodsucker/on_hit(target)
	if(istype(target, /obj/structure/closet))
		var/obj/structure/closet/C = target
		if(C)
			C.welded = FALSE
			C.locked = FALSE
			C.broken = TRUE
			C.update_appearance()
			qdel(src)
			return BULLET_ACT_HIT
	if(istype(target, /obj/machinery/door))
		var/obj/machinery/door/D = target
		D.open(2)
		qdel(src)
		return BULLET_ACT_HIT
	if(ismob(target))
		qdel(src)
		return BULLET_ACT_HIT
	. = ..()
