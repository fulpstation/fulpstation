//improvised explosives//

/obj/item/grenade/iedcasing
	name = "improvised firebomb"
	desc = "A weak, improvised incendiary device."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/grenade.dmi'
	icon_state = "improvised_grenade"
	inhand_icon_state = "flashbang"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	active = FALSE
	det_time = 50
	display_timer = FALSE
	var/check_parts = FALSE
	var/range = 3
	var/list/times

/obj/item/grenade/iedcasing/Initialize()
	. = ..()
	add_overlay("improvised_grenade_filled")
	add_overlay("improvised_grenade_wired")
	times = list("5" = 10, "-1" = 20, "[rand(30,80)]" = 50, "[rand(65,180)]" = 20)// "Premature, Dud, Short Fuse, Long Fuse"=[weighting value]
	det_time = text2num(pickweight(times))
	if(det_time < 0) //checking for 'duds'
		range = 1
		det_time = rand(30,80)
	else
		range = pick(2,2,2,3,3,3,4)
	if(check_parts) //since construction code calls this itself, no need to always call it. This does have the downside that adminspawned ones can potentially not have cans if they don't use the /spawned subtype.
		CheckParts()

/obj/item/grenade/iedcasing/spawned
	check_parts = TRUE

/obj/item/grenade/iedcasing/spawned/Initialize()
	new /obj/item/reagent_containers/food/drinks/soda_cans/random(src)
	return ..()

/obj/item/grenade/iedcasing/CheckParts(list/parts_list)
	..()
	var/obj/item/reagent_containers/food/drinks/soda_cans/can = locate() in contents
	if(!can)
		stack_trace("[src] generated without a soda can!") //this shouldn't happen.
		qdel(src)
		return
	can.pixel_x = 0 //Reset the sprite's position to make it consistent with the rest of the IED
	can.pixel_y = 0
	var/mutable_appearance/can_underlay = new(can)
	can_underlay.layer = FLOAT_LAYER
	can_underlay.plane = FLOAT_PLANE
	underlays += can_underlay


/obj/item/grenade/iedcasing/attack_self(mob/user) //
	if(!active)
		if(!botch_check(user))
			to_chat(user, span_warning("You light the [name]!"))
			cut_overlay("improvised_grenade_filled")
			arm_grenade(user, null, FALSE)

/obj/item/grenade/iedcasing/detonate(mob/living/lanced_by) //Blowing that can up
	. = ..()
	update_mob()
	explosion(src, devastation_range = -1, heavy_impact_range = -1, light_impact_range = 2, flame_range = 4) // small explosion, plus a very large fireball.
	qdel(src)

/obj/item/grenade/iedcasing/change_det_time()
	return //always be random.

/obj/item/grenade/iedcasing/examine(mob/user)
	. = ..()
	. += "You can't tell when it will explode!"
