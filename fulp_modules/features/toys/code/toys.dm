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
	color = LIGHT_COLOR_YELLOW
	attack_verb_continuous = list("dust")
	attack_verb_simple = list("dust")
	squeak_override = list('sound/effects/supermatter.ogg'= 1)

/obj/item/clothing/gloves/rapid/toy
	name = "Gloves of the South Star"
	desc = "Just looking at these fills you with an urge to pretend to beat the shit out of people."
	var/datum/martial_art/northstar/style = new

/obj/item/clothing/gloves/rapid/toy/equipped(mob/user, slot)
	..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_GLOVES)
		var/mob/living/student = user
		student.mind.martial_art.allow_temp_override = TRUE
		style.teach(student, 1)

/obj/item/clothing/gloves/rapid/toy/dropped(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/owner = user
	style.remove(owner)
