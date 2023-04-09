/obj/item/seeds/tower
	name = "pack of tower-cap mycelium"
	desc = "This mycelium grows into tower-cap mushrooms."
	icon_state = "mycelium-tower"
	species = "towercap"
	plantname = "Tower Caps"
	product = /obj/item/grown/log
	lifespan = 80
	endurance = 50
	maturation = 15
	production = 1
	yield = 5
	potency = 50
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	icon_dead = "towercap-dead"
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	mutatelist = list(/obj/item/seeds/tower/steel)
	reagents_add = list(/datum/reagent/cellulose = 0.05)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/seeds/tower/steel
	name = "pack of steel-cap mycelium"
	desc = "This mycelium grows into steel logs."
	icon_state = "mycelium-steelcap"
	species = "steelcap"
	plantname = "Steel Caps"
	product = /obj/item/grown/log/steel
	mutatelist = null
	reagents_add = list(/datum/reagent/cellulose = 0.05, /datum/reagent/iron = 0.05)
	rarity = 20

/obj/item/grown/log
	seed = /obj/item/seeds/tower
	name = "tower-cap log"
	desc = "It's better than bad, it's good!"
	icon_state = "logs"
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "whacks")
	attack_verb_simple = list("bash", "batter", "bludgeon", "whack")
	var/plank_type = /obj/item/stack/sheet/mineral/wood
	var/plank_name = "wooden planks"
	var/static/list/accepted = typecacheof(list(
		/obj/item/food/grown/tobacco,
		/obj/item/food/grown/tea,
		/obj/item/food/grown/ash_flora/mushroom_leaf,
		/obj/item/food/grown/ambrosia/vulgaris,
		/obj/item/food/grown/ambrosia/deus,
		/obj/item/food/grown/wheat,
	))

/obj/item/grown/log/Initialize(mapload, obj/item/seeds/new_seed)
	. = ..()
	register_context()

/obj/item/grown/log/add_context(
	atom/source,
	list/context,
	obj/item/held_item,
	mob/living/user,
)

	if(isnull(held_item))
		return NONE

	if(held_item.get_sharpness())
		// May be a little long, but I think "cut into planks" for steel caps may be confusing.
		context[SCREENTIP_CONTEXT_LMB] = "Cut into [plank_name]"
		return CONTEXTUAL_SCREENTIP_SET

	if(CheckAccepted(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "Make torch"
		return CONTEXTUAL_SCREENTIP_SET

	return NONE

/obj/item/grown/log/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		user.show_message(span_notice("You make [plank_name] out of \the [src]!"), MSG_VISUAL)
		var/seed_modifier = 0
		if(seed)
			seed_modifier = round(seed.potency / 25)
		var/obj/item/stack/plank = new plank_type(user.loc, 1 + seed_modifier, FALSE)
		var/old_plank_amount = plank.amount
		for (var/obj/item/stack/ST in user.loc)
			if (ST != plank && istype(ST, plank_type) && ST.amount < ST.max_amount)
				ST.attackby(plank, user) //we try to transfer all old unfinished stacks to the new stack we created.
		if (plank.amount > old_plank_amount)
			to_chat(user, span_notice("You add the newly-formed [plank_name] to the stack. It now contains [plank.amount] [plank_name]."))
		qdel(src)

	if(CheckAccepted(W))
		var/obj/item/food/grown/leaf = W
		if(HAS_TRAIT(leaf, TRAIT_DRIED))
			user.show_message(span_notice("You wrap \the [W] around the log, turning it into a torch!"))
			var/obj/item/flashlight/flare/torch/T = new /obj/item/flashlight/flare/torch(user.loc)
			usr.dropItemToGround(W)
			usr.put_in_active_hand(T)
			qdel(leaf)
			qdel(src)
			return
		else
			to_chat(usr, span_warning("You must dry this first!"))
	else
		return ..()

/obj/item/grown/log/proc/CheckAccepted(obj/item/I)
	return is_type_in_typecache(I, accepted)

/obj/item/grown/log/tree
	seed = null
	name = "wood log"
	desc = "TIMMMMM-BERRRRRRRRRRR!"

/obj/item/grown/log/steel
	seed = /obj/item/seeds/tower/steel
	name = "steel-cap log"
	desc = "It's made of metal."
	icon_state = "steellogs"
	plank_type = /obj/item/stack/rods
	plank_name = "rods"

/obj/item/grown/log/steel/CheckAccepted(obj/item/I)
	return FALSE

/obj/structure/punji_sticks
	name = "punji sticks"
	desc = "Don't step on this."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "punji"
	resistance_flags = FLAMMABLE
	max_integrity = 30
	density = FALSE
	anchored = TRUE
	buckle_lying = 90
	/// Overlay we apply when impaling a mob.
	var/mutable_appearance/stab_overlay

/obj/structure/punji_sticks/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = 20, max_damage = 30, flags = CALTROP_BYPASS_SHOES)
	build_stab_overlay()

/obj/structure/punji_sticks/proc/build_stab_overlay()
	stab_overlay = mutable_appearance(icon, "[icon_state]_stab", layer = ABOVE_MOB_LAYER, offset_spokesman = src, plane = GAME_PLANE_FOV_HIDDEN)

/obj/structure/punji_sticks/on_changed_z_level(turf/old_turf, turf/new_turf, same_z_layer, notify_contents)
	. = ..()
	if(same_z_layer)
		return
	build_stab_overlay()
	update_appearance()

/obj/structure/punji_sticks/post_buckle_mob(mob/living/M)
	update_appearance()
	return ..()

/obj/structure/punji_sticks/post_unbuckle_mob(mob/living/M)
	update_appearance()
	return ..()

/obj/structure/punji_sticks/update_overlays()
	. = ..()
	if(length(buckled_mobs))
		. += stab_overlay

/obj/structure/punji_sticks/intercept_zImpact(list/falling_movables, levels)
	. = ..()
	for(var/mob/living/fallen_mob in falling_movables)
		if(LAZYLEN(buckled_mobs))
			return
		if(buckle_mob(fallen_mob, TRUE))
			to_chat(fallen_mob, span_userdanger("You are impaled by [src]!"))
			fallen_mob.apply_damage(25 * levels, BRUTE, sharpness = SHARP_POINTY)
			if(iscarbon(fallen_mob))
				var/mob/living/carbon/fallen_carbon = fallen_mob
				fallen_carbon.emote("scream")
				fallen_carbon.bleed(30)
	. |= FALL_INTERCEPTED | FALL_NO_MESSAGE

/obj/structure/punji_sticks/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	if(force)
		return ..()
	to_chat(buckled_mob, span_warning("You begin climbing out of [src]."))
	buckled_mob.apply_damage(5, BRUTE, sharpness = SHARP_POINTY)
	if(!do_after(buckled_mob, 5 SECONDS, target = src))
		to_chat(buckled_mob, span_userdanger("You fail to detach yourself from [src]."))
		return
	return ..()

/obj/structure/punji_sticks/spikes
	name = "wooden spikes"
	icon_state = "woodspike"
