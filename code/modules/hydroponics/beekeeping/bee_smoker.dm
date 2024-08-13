/// multiplier to decide how much fuel we add to a smoker
#define WEED_WINE_MULTIPLIER 0.2

/obj/item/bee_smoker
	name = "bee smoker"
	desc = "A device which can be used to hypnotize bees!"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "bee_smoker"
	inhand_icon_state = "bee_smoker"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	item_flags = NOBLUDGEON
	/// current level of fuel we have
	var/current_herb_fuel = 50
	/// maximum amount of fuel we can hold
	var/max_herb_fuel = 50
	/// are we currently activated?
	var/activated = FALSE
	/// sound to play when releasing smoke
	var/datum/looping_sound/beesmoke/beesmoke_loop
	///how much  fuel it costs to use this item
	var/single_use_cost = 5

/obj/item/bee_smoker/Initialize(mapload)
	. = ..()
	beesmoke_loop = new(src)

/obj/item/bee_smoker/attack_self(mob/user)
	. = ..()
	if(.)
		return TRUE
	if(!activated && current_herb_fuel <= 0)
		user.balloon_alert(user, "no fuel!")
		return TRUE
	alter_state()
	user.balloon_alert(user, "[activated ? "activated" : "deactivated"]")
	return TRUE

/obj/item/bee_smoker/afterattack(atom/attacked_atom, mob/living/user, proximity)
	. = ..()

	if(!proximity)
		return

	. |= AFTERATTACK_PROCESSED_ITEM

	if(!activated)
		user.balloon_alert(user, "not activated!")
		return

	if(current_herb_fuel < single_use_cost)
		user.balloon_alert(user, "not enough fuel!")
		return

	current_herb_fuel -= single_use_cost
	playsound(src, 'sound/effects/spray2.ogg', 100, TRUE)
	var/turf/target_turf = get_turf(attacked_atom)
	new /obj/effect/temp_visual/mook_dust(target_turf)

	for(var/mob/living/basic/bee/friend in target_turf)
		if(friend.flags_1 & HOLOGRAM_1)
			continue
		friend.befriend(user)

	if(!istype(attacked_atom, /obj/structure/beebox))
		return

	var/obj/structure/beebox/hive = attacked_atom
	for(var/mob/living/bee as anything in hive.bees)
		if(bee.flags_1 & HOLOGRAM_1)
			continue
		bee.befriend(user)

/obj/item/bee_smoker/attackby(obj/item/herb, mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!istype(herb, /obj/item/food/grown/cannabis))
		return
	var/obj/item/food/grown/cannabis/weed = herb
	if(isnull(weed.wine_power))
		return TRUE
	if(current_herb_fuel == max_herb_fuel)
		user.balloon_alert(user, "already at maximum fuel!")
		return TRUE
	var/fuel_worth = weed.wine_power * WEED_WINE_MULTIPLIER
	current_herb_fuel = (current_herb_fuel + fuel_worth > max_herb_fuel) ? max_herb_fuel : current_herb_fuel + fuel_worth
	user.balloon_alert(user, "fuel added")
	qdel(weed)
	return TRUE

/obj/item/bee_smoker/process(seconds_per_tick)
	current_herb_fuel--
	if(current_herb_fuel <= 0)
		alter_state()

/obj/item/bee_smoker/proc/alter_state()
	activated = !activated
	playsound(src, 'sound/items/welderdeactivate.ogg', 50, TRUE)

	if(!activated)
		beesmoke_loop.stop()
		QDEL_NULL(particles)
		STOP_PROCESSING(SSobj, src)
		return

	beesmoke_loop.start()
	START_PROCESSING(SSobj, src)
	particles = new /particles/smoke/bee_smoke

/particles/smoke/bee_smoke
	lifespan = 0.4 SECONDS
	position = list(-12, 7, 0)
	velocity = list(0, 0.15, 0)
	fade = 2

#undef WEED_WINE_MULTIPLIER
