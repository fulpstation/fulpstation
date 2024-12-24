/obj/item/toy/plush/batong
	name = "batong"
	desc = "A cheaply made toy. It looks uncharged, maybe security can help you."

	icon = /obj/item/melee/baton/security::icon
	icon_state = /obj/item/melee/baton/security::icon_state
	worn_icon = /obj/item/melee/baton/security::worn_icon
	worn_icon_state = /obj/item/melee/baton/security::worn_icon_state
	inhand_icon_state = /obj/item/melee/baton/security::inhand_icon_state
	lefthand_file = /obj/item/melee/baton/security::lefthand_file
	righthand_file = /obj/item/melee/baton/security::righthand_file
	slot_flags = /obj/item/melee/baton/security::slot_flags

	attack_verb_continuous = list("Tries to recharge the batong in")
	attack_verb_simple = list("try to recharge the batong in")
	// "the monkey (958) Tries to recharge the batong in you in the chest with the batong" people wanted this.
	squeak_override = list('fulp_modules/sounds/effects/batong.ogg' = 1)

/obj/item/toy/plush/batong/Initialize(mapload)
	. = ..()
	add_filter("batong_outline", 1, list("type" = "outline", "color" = COLOR_RED, "size" = 1))

/obj/item/toy/plush/supermatter
	name = "Supermatter toy"
	desc = "A Supermatter plushie! you shouldn't pet the real one without the Chief Engineer's permission!"
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "supermatter"
	light_range = 3
	light_system = OVERLAY_LIGHT
	color = LIGHT_COLOR_DIM_YELLOW
	attack_verb_continuous = list("dust")
	attack_verb_simple = list("dust")
	squeak_override = list('sound/effects/supermatter.ogg'= 1)

/obj/item/toy/plush/pico
	name = "pico plushie"
	desc = "A plushie of an alarmed middle schooler with orange hair and a green shirt. Maybe something's happening at his school."
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "pico"
	attack_verb_continuous = list("flails at")
	attack_verb_simple = list("flail at")
	squeak_override = list('fulp_modules/sounds/effects/pico.ogg'= 1)
	custom_price = PAYCHECK_COMMAND

/obj/item/toy/plush/fly
	name = "fly plushie"
	desc = "A plushie depicting a despicable flyperson. It looks like a discontinued human plushie dropped in a teleporter."
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "fly"
	inhand_icon_state = null
	attack_verb_continuous = list("buzzes", "swats")
	attack_verb_simple = list("buzz", "swat")
	squeak_override = list( 'sound/effects/snap.ogg'=1)

/obj/item/toy/plush/animatronic
	name = "Freddy Fazbear plushie"
	desc = "Don't look inside of the suit."
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "freddy"
	inhand_icon_state = null
	attack_verb_continuous = list("jumpscares")
	attack_verb_simple = list("jumpscare")
	squeak_override = list('fulp_modules/sounds/effects/jumpscare.ogg'= 1)

/obj/item/toy/plush/animatronic/chica
	name = "Chica plushie"
	desc = "Despite saying let's eat on the bib, please do not attempt to feed the plush."
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "chica"

/obj/item/toy/plush/animatronic/foxy
	name = "Foxy plushie"
	desc = "It just wants a friend!"
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "foxy"

/obj/item/toy/plush/animatronic/bonnie
	name = "Bonnie plushie"
	desc = "A different purple guy."
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "bonnie"

/obj/item/toy/plush/animatronic/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] is stuffing themselves into the suit! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(loc, 'fulp_modules/sounds/effects/jumpscare.ogg', 35, TRUE,)
	var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
	if(myhead)
		myhead.dismember()
	return(BRUTELOSS)

/obj/item/toy/plush/beefplushie
	name = "beef plushie"
	desc = "Made from real meat!"
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "beefman"
	base_icon_state = "beefman"
	squeak_override = list('sound/effects/meatslap.ogg'=1)

	/// If true then the plushie will initialize with its holiday icon (which has a santa hat).
	/// Coded by referencing 'supermatter.dm'
	var/holiday_edition = FALSE

/obj/item/toy/plush/beefplushie/Initialize(mapload)
	. = ..()
	if(!isnull(check_holidays(FESTIVE_SEASON)))
		holiday_edition = TRUE
		update_appearance()

/obj/item/toy/plush/beefplushie/update_desc(mob/user)
	. = ..()
	if(holiday_edition)
		desc = initial(desc) + span_notice("\nIt's a holiday exclusive edition with a santa hat sewn on!")

/obj/item/toy/plush/beefplushie/update_icon_state()
	. = ..()
	if(holiday_edition)
		icon_state = "holiday_[base_icon_state]"

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
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	icon_state = "808"
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'
	worn_icon_state = "808"
	inhand_icon_state = "808"
	lefthand_file = 'fulp_modules/icons/halloween/2023_icons_left.dmi'
	righthand_file = 'fulp_modules/icons/halloween/2023_icons_right.dmi'
	attack_verb_continuous = list("bops","beats")
	attack_verb_simple = list("bop","beat")
	squeak_override = list(
		'sound/effects/meow1.ogg' = 1)


/obj/item/toy/plush/shrimp
	name = "shrimp plushie"
	desc = "You're telling me THIS GUY fried my rice?"
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "shrimp"
	attack_verb_continuous = list("shrimps", "skitters")
	attack_verb_simple = list("shrimp","skitter")
	squeak_override = list(
		'fulp_modules/sounds/effects/kero.ogg' = 1
	)
	/// The rice the shrimp fried. The shrimp can only fry one rice
	var/obj/item/food/fried_rice
	/// Whether the shrimp has fried any rice
	var/has_fried = FALSE

/obj/item/toy/plush/shrimp/examine(mob/user)
	. = ..()
	if(has_fried)
		. += span_notice("[p_Theyre()] all tuckered out.")


/obj/item/toy/plush/phos
	name = "phosphophyllite plushie"
	desc = "Has a hardness of roughly 3.5 on Mohs' scale."
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "phos"
	base_icon_state = "phos"
	attack_verb_continuous = list("taps", "clicks", "scrapes")
	attack_verb_simple = list("tap", "click", "scrape")
	resistance_flags = FLAMMABLE | ACID_PROOF //Most gemstones are acid-resistant... right?
	squeak_override = list(
		'sound/items/handling/beaker_place.ogg' = 3,
		'sound/items/handling/materials/glass_pick_up.ogg' = 2,
		'sound/effects/rock/rocktap2.ogg' = 1
	)
	max_integrity = 250
	grind_results = list(
		/datum/reagent/phosphorus = 5,
		/datum/reagent/carbon = 2,
		/datum/reagent/iron = 3,
		/datum/reagent/oxygen = 2,
		/datum/reagent/hydrogen = 4
	) //I'm not a geologist so this may or mayn't be accurate

	/// If true then the plushie will initialize with its holiday icon (which has a santa hat).
	/// Coded by referencing 'supermatter.dm'
	var/holiday_edition = FALSE

/obj/item/toy/plush/phos/Initialize(mapload)
	. = ..()
	if(!isnull(check_holidays(FESTIVE_SEASON)))
		holiday_edition = TRUE
		update_appearance()

/obj/item/toy/plush/phos/update_desc(mob/user)
	. = ..()
	if(holiday_edition)
		desc = initial(desc) + span_notice("\nIt's a holiday exclusive edition with a santa hat sewn on!")

/obj/item/toy/plush/phos/update_icon_state()
	. = ..()
	if(holiday_edition)
		icon_state = "holiday_[base_icon_state]"
