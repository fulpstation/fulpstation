/obj/item/toy/plush/batong
	name = "batong"
	desc = "A cheaply made toy. Looks like it need some recharge maybe security can help you"
	icon = 'fulp_modules/toys/icon/toys.dmi'
	icon_state = "batong"
	inhand_icon_state = "baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	attack_verb_continuous = list("Tries to recharge the batong in")
	attack_verb_simple = list("try to recharge the baton in")
	// "the monkey (958) Tries to recharge the batong in you in the chest with the batong" people wanted this.
	squeak_override = list('fulp_modules/toys/sound/batong.ogg'= 1)

/obj/item/toy/plush/supermatter
	name = "Supermatter toy"
	desc = "A Supermatter plushe! you shouldnt pet the real one without Chief Engineer permission!."
	icon = 'fulp_modules/toys/icon/toys.dmi'
	icon_state = "supermatter"
	light_range = 3
	light_system = MOVABLE_LIGHT
	color = LIGHT_COLOR_YELLOW
	attack_verb_continuous = list("dust")
	attack_verb_simple = list("dust")
	squeak_override = list('sound/effects/supermatter.ogg'= 1)
