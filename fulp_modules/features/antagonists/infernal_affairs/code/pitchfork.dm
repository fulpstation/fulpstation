/obj/item/pitchfork/demonic
	name = "demonic pitchfork"
	desc = "A red pitchfork, it looks like the work of the devil. Sets people on fire and deflects, but isn't that great otherwise."
	light_system = OVERLAY_LIGHT
	light_range = 3
	light_power = 6
	light_color = COLOR_RED_LIGHT
	block_chance = 50

/obj/item/pitchfork/demonic/IsReflect(def_zone)
	return HAS_TRAIT(src, TRAIT_WIELDED)

/obj/item/pitchfork/demonic/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_WIELDED) || (user == target))
		return
	target.adjust_fire_stacks(4)
	target.ignite_mob()

/obj/item/pitchfork/demonic/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] impales [user.p_them()]self in [user.p_their()] abdomen with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (BRUTELOSS)
