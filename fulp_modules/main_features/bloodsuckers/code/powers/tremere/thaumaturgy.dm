/*
 *	# Thaumaturgy
 *
 *	Level 1 - One shot bloodbeam spell
 *	Level 2 - Bloodbeam spell that breaks open lockers
 *	Level 3 - Bloodbeam spell that breaks open lockers/doors
 *	Level 4 - Bloodbeam spell that breaks open lockers/doors - Gives them a Blood shield until they use Bloodbeam
 *	Level 5 - Bloodbeam spell that breaks open lockers/doors, steals blood from targets - Gives them a Blood shield until they use Bloodbeam
 */


/obj/item/gun/ballistic/rifle/enchanted/arcane_barrage/bloodsucker
	name = "blood barrage"
	desc = "Blood for blood."
	color = "#ff0000"
	guns_left = 1
	fire_sound = 'sound/magic/wand_teleport.ogg'

	mag_type = /obj/item/ammo_box/magazine/internal/bloodsucker

/obj/item/ammo_box/magazine/internal/bloodsucker
	ammo_type = /obj/item/ammo_casing/magic/arcane_barrage/bloodsucker

/obj/item/ammo_casing/magic/arcane_barrage/bloodsucker
	projectile_type = /obj/projectile/magic/arcane_barrage/bloodsucker

/obj/projectile/magic/arcane_barrage/bloodsucker
	name = "blood bolt"
	icon_state = "arcane_barrage"
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

/datum/action/bloodsucker/thaumaturgy
	name = "Level 1: Thaumaturgy"
	desc = "Shoot a Blood barrage at your enemy."

	button_icon_state = "power_strength"
	power_explanation = "<b>Fortitude</b>:\n\
		Activating Fortitude will provide pierce, stun and dismember immunity.\n\
		You will additionally gain resistance to Brute and Stamina damge, scaling with level.\n\
		While using Fortitude, attempting to run will crush you.\n\
		At level 4, you gain complete stun immunity.\n\
		Higher levels will increase Brute and Stamina resistance."
	bloodcost = 30
	cooldown = 80
	constant_bloodcost = 0.2
	bloodsucker_can_buy = TRUE
	amToggle = TRUE
	must_be_concious = FALSE

/datum/action/bloodsucker/thaumaturgy/ActivatePower(mob/living/user = owner)
	var/obj/power_hand = new /obj/item/gun/ballistic/rifle/enchanted/arcane_barrage/bloodsucker()
	if(!user.put_in_hands(power_hand))
		owner.balloon_alert(owner, "need both hands free!")
		qdel(power_hand)
		return
	owner.balloon_alert(owner, "thaumaturgy turned on.")
	to_chat(user, span_notice("You prepare Thaumaturgy."))
	. = ..()

/datum/action/bloodsucker/thaumaturgy/UsePower(mob/living/carbon/user)
	// Checks that we can keep using this.
	if(!..())
		return
	var/list/L = owner.get_contents()
	var/obj/item/gun/ballistic/rifle/enchanted/arcane_barrage/bloodsucker/bloodbarrage = locate() in L
	if(!bloodbarrage)
		DeactivatePower()
		return

/datum/action/bloodsucker/thaumaturgy/DeactivatePower(mob/living/user = owner)
	if(!ishuman(owner))
		return

	owner.balloon_alert(owner, "thaumaturgy turned off.")
	return ..()
