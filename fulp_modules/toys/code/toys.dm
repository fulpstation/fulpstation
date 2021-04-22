/obj/item/toy/plush/batong
	name = "batong"
	desc = "A cheaply made toy resembling a Stunbaton."
	icon = 'fulp_modules/toys/icon/toys.dmi'
	icon_state = "batong"
	worn_icon_state = "baton"
	inhand_icon_state = "baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("batong", "charge")
	attack_verb_simple = list("batongs", "charges")
	squeak_override = list('fulp_modules/toys/sound/batong.ogg'= 1)

/obj/item/toy/plush/supermatter
	name = "Supermatter toy"
	desc = "A small plushie of the Supermatter, meant to distract you from the real one's quick delamination!"
	icon = 'fulp_modules/toys/icon/toys.dmi'
	icon_state = "supermatter"
	light_range = 3
	light_system = MOVABLE_LIGHT
	color = LIGHT_COLOR_YELLOW
	attack_verb_continuous = list("dust", "radiates")
	attack_verb_simple = list("dusts", "radiates")
	squeak_override = list('sound/effects/supermatter.ogg'= 1)
