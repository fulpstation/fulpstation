/obj/item/toy/plush/batong
	name = "Batong"
	desc = "A cheaply made toy. Looks like it need some recharge maybe security can help you"
	icon = 'fulp_modules/things/batong/icon/toys.dmi'
	icon_state = "batong"
	inhand_icon_state = "baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	attack_verb_continuous = list("Tries to recharge the batong in")
	attack_verb_simple = list("try to recharge the baton in")
	// "the monkey (958) Tries to recharge the batong in you in the chest with the batong" people wanted like this.
	squeak_override = list('fulp_modules/things/batong/sound/batong.ogg'=1)


/obj/item/toy/plush/supermatter
	name = "supermatter"
	desc = "supermatter toy desc"
	icon = 'fulp_modules/things/batong/icon/toys.dmi'
	icon_state = "supermatter"
	light_range = 3
	light_system = MOVABLE_LIGHT
	color = LIGHT_COLOR_YELLOW
	attack_verb_continuous = list("dusted")
	attack_verb_simple = list("dust")
	squeak_override = list('sound/effects/supermatter.ogg'=1)
