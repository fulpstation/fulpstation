//MINING WAGON--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/obj/vehicle/ridden/mining_wagon
	name = "mining wagon"
	desc = "Looks surprisingly new for a ancient mining wagon. The wheels seems to be stuck."
	icon = 'fulp_modules/maps/decals/mining_wagon.dmi'
	icon_state = "mining_wagon"
	layer = OBJ_LAYER
	max_integrity = 75
	armor = list(MELEE = 10, BULLET = 2, LASER = 5, ENERGY = 0, BOMB = 2, BIO = 0, RAD = 0, FIRE = 5, ACID = 0)
	density = TRUE
	var/mutable_appearance/activated_overlay

/obj/vehicle/ridden/mining_wagon/proc/handle_layer()
	if(has_buckled_mobs())
		layer = ABOVE_MOB_LAYER
	else
		layer = OBJ_LAYER

/obj/vehicle/ridden/mining_wagon/Initialize()
	. = ..()
	activated_overlay = mutable_appearance('fulp_modules/maps/decals/mining_wagon.dmi', "mining_wagon_overlay", OBJ_LAYER)
	add_overlay(activated_overlay)

/obj/vehicle/ridden/mining_wagon/post_buckle_mob(mob/living/M)
	M.pixel_y += 5
	handle_layer()

/obj/vehicle/ridden/mining_wagon/post_unbuckle_mob(mob/living/M)
	M.pixel_y -= 5
	handle_layer()

/obj/vehicle/ridden/mining_wagon/obj_destruction(damage_flag)
	new /obj/item/stack/rods(drop_location(), 2)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 4)
	return ..()

/obj/vehicle/ridden/mining_wagon/Moved()
	. = ..()
	playsound(src, 'sound/effects/stonedoor_openclose.ogg', 75, TRUE)

//MINING WAGON--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//RAILS---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/obj/effect/turf_decal/rails
	icon = 'fulp_modules/maps/decals/mining_wagon.dmi'
	icon_state = "rails_horizontal"

/obj/effect/turf_decal/rails/broken
	icon_state = "rails_broken"

/obj/effect/turf_decal/rails/vertical
	icon_state = "rails_vertical"

/obj/effect/turf_decal/rails/vertical_curved
	icon_state = "rails_vertical_curved"

//RAILS---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//CAVES---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/turf/closed/mineral/cave_in
	name = "ancient cave-in"
	icon = 'icons/turf/smoothrocks.dmi'
	smooth_icon = 'icons/turf/smoothrocks.dmi'
	icon_state = "smoothrocks"
	base_icon_state = "smoothrocks"
	desc = "A ancient mine that collapsed."
	var/mutable_appearance/activated_overlay

/turf/closed/mineral/cave_in/Initialize()
	. = ..()
	activated_overlay = mutable_appearance('fulp_modules/maps/decals/cave_in.dmi', "cave_in", ON_EDGED_TURF_LAYER)
	add_overlay(activated_overlay)

/turf/closed/mineral/cave_in/blood
	name = "bloody ancient cave-in"
	desc = "A ancient mine that collapsed which is housing equally ancient miners."

/turf/closed/mineral/cave_in/blood/Initialize()
	. = ..()
	activated_overlay = mutable_appearance('fulp_modules/maps/decals/cave_in.dmi', "cave_in_blood", ON_EDGED_TURF_LAYER)
	add_overlay(activated_overlay)

//CAVES---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------