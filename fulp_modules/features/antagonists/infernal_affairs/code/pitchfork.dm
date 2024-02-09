/obj/item/pitchfork/demonic
	name = "demonic pitchfork"
	desc = "A red pitchfork, it looks like the work of the devil. Sets people on fire and deflects, but isn't that great otherwise."
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_power = 6
	light_color = COLOR_RED_LIGHT
	block_chance = 50

/obj/item/pitchfork/IsReflect(def_zone)
	return HAS_TRAIT(src, TRAIT_WIELDED)

/obj/item/pitchfork/afterattack(mob/living/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_WIELDED) || (user == target) || !isliving(target))
		return
	target.fire_stacks = 4
	target.ignite_mob()

/obj/item/pitchfork/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] impales [user.p_them()]self in [user.p_their()] abdomen with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (BRUTELOSS)
