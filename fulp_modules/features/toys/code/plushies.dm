/obj/item/toy/plush/batong
	name = "batong"
	desc = "A cheaply made toy. Looks like it need some recharge maybe security can help you"
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "batong"
	worn_icon_state = "baton"
	inhand_icon_state = "baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("Tries to recharge the batong in")
	attack_verb_simple = list("try to recharge the baton in")
	// "the monkey (958) Tries to recharge the batong in you in the chest with the batong" people wanted this.
	squeak_override = list('fulp_modules/features/toys/sound/batong.ogg'= 1)

/obj/item/toy/plush/supermatter
	name = "Supermatter toy"
	desc = "A Supermatter plushie! you shouldn't pet the real one without the Chief Engineer's permission!"
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "supermatter"
	light_range = 3
	light_system = MOVABLE_LIGHT
	color = LIGHT_COLOR_DIM_YELLOW
	attack_verb_continuous = list("dust")
	attack_verb_simple = list("dust")
	squeak_override = list('sound/effects/supermatter.ogg'= 1)

/obj/item/toy/plush/pico
	name = "pico plushie"
	desc = "A plushie of an alarmed middle schooler with orange hair and a green shirt. Maybe something's happening at his school."
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "pico"
	attack_verb_continuous = list("flails at")
	attack_verb_simple = list("flail at")
	squeak_override = list('fulp_modules/features/toys/sound/pico.ogg'= 1)
	custom_price = PAYCHECK_COMMAND

/obj/item/toy/plush/fly
	name = "fly plushie"
	desc = "A plushie depicting a despicable flyperson. It looks like a discontinued human plushie dropped in a teleporter."
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "fly"
	inhand_icon_state = null
	attack_verb_continuous = list("buzzes", "swats")
	attack_verb_simple = list("buzz", "swat")
	squeak_override = list( 'sound/effects/snap.ogg'=1)

/obj/item/toy/plush/animatronic
	name = "Freddy Fazbear plushie"
	desc = "Don't look inside of the suit."
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "freddy"
	inhand_icon_state = null
	attack_verb_continuous = list("jumpscares")
	attack_verb_simple = list("jumpscare")
	squeak_override = list('fulp_modules/features/toys/sound/jumpscare.ogg'= 1)

/obj/item/toy/plush/animatronic/chica
	name = "Chica plushie"
	desc = "Despite saying let's eat on the bib, please do not attempt to feed the plush."
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "chica"

/obj/item/toy/plush/animatronic/foxy
	name = "Foxy plushie"
	desc = "It just wants a friend!"
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "foxy"

/obj/item/toy/plush/animatronic/bonnie
	name = "Bonnie plushie"
	desc = "A different purple guy."
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "bonnie"

/obj/item/toy/plush/animatronic/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] is stuffing themselves into the suit! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(loc, 'fulp_modules/features/toys/sound/jumpscare.ogg', 35, TRUE,)
	var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
	if(myhead)
		myhead.dismember()
	return(BRUTELOSS)

/obj/item/toy/plush/beefplushie
	name = "beef plushie"
	desc = "Made from real meat!"
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "beefman"
	squeak_override = list('sound/effects/meatslap.ogg'=1)

//Do your cooldown changes here.
#define BEEFPLUSHIE_COOLDOWN_TIME (1 MINUTES)

/obj/item/toy/plush/beefplushie/living
	desc = "It looks oddly alive. You feel like you should pet it."
	COOLDOWN_DECLARE(beefplushie_cooldown)

//When used in hand.
/obj/item/toy/plush/beefplushie/living/attack_self(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, beefplushie_cooldown))
		balloon_alert(user, "not ready yet!")
		return
	balloon_alert(user, "producing meat")
	if(!do_after(user, 2 SECONDS, target = src))
		return
	playsound(src, "sound/effects/splat.ogg", 50)
	user.put_in_hands(new /obj/item/food/meat/slab)
	COOLDOWN_START(src, beefplushie_cooldown, BEEFPLUSHIE_COOLDOWN_TIME)

#undef BEEFPLUSHIE_COOLDOWN_TIME

/obj/item/toy/plush/EightZeroEight
	name = "808"
	desc = "A Rockstars companion turned into a marketable plushie."
	icon = 'fulp_modules/features/halloween/2023/2023_icons.dmi'
	icon_state = "808"
	worn_icon = 'fulp_modules/features/halloween/2023/2023_icons_worn.dmi'
	worn_icon_state = "808"
	inhand_icon_state = "808"
	lefthand_file = 'fulp_modules/features/halloween/2023/2023_icons_left.dmi'
	righthand_file = 'fulp_modules/features/halloween/2023/2023_icons_right.dmi'
	attack_verb_continuous = list("bops","beats")
	attack_verb_simple = list("bop","beat")
	squeak_override = list(
		'sound/effects/meow1.ogg' = 1)


/obj/item/toy/plush/shrimp
	name = "shrimp plushie"
	desc = "You're telling me THIS GUY fried my rice?"
	icon = 'fulp_modules/features/toys/icons/toys.dmi'
	icon_state = "shrimp"
	attack_verb_continuous = list("shrimps", "skitters")
	attack_verb_simple = list("shrimp","skitter")
	squeak_override = list(
		'fulp_modules/sounds/sound/effects/kero.ogg' = 1
	)
	/// The rice the shrimp fried. The shrimp can only fry one rice
	var/obj/item/food/fried_rice
	/// Whether the shrimp has fried any rice
	var/has_fried = FALSE

/obj/item/toy/plush/shrimp/examine(mob/user)
	. = ..()
	if(has_fried)
		. += span_notice("[p_Theyre()] all tuckered out.")
