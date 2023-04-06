/obj/structure/loot_pinata
	name = "wooden barrel"
	desc = "A wooden barrel, looks very fragile."
	icon = 'icons/obj/objects.dmi'
	icon_state = "barrel"
	max_integrity = 25
	anchored = TRUE
	var/possible_loot = list(
		/obj/item/food/egg,
		/mob/living/simple_animal/hostile/retaliate/snake,
		/obj/item/coin/gold,
		/obj/item/ammo_box/c10mm,
		/obj/item/food/grown/herbs,
	)
	var/debris = /obj/item/stack/sheet/mineral/wood{amount = 5}

/obj/structure/loot_pinata/play_attack_sound(damage_amount, damage_type, damage_flag)
	playsound(src, 'sound/weapons/smash.ogg', 50, vary = TRUE)

/obj/structure/loot_pinata/deconstruct(disassembled)
	var/loot = pick(possible_loot)
	new loot(get_turf(src))
	new debris(get_turf(src))
	return ..()
