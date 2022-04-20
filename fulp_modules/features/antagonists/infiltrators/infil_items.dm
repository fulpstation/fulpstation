/obj/item/adv_mulligan
	name = "advanced mulligan"
	desc = "Toxin that permanently changes your DNA into the one of last injected person."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "dnainjector0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/used = FALSE
	var/mob/living/carbon/human/stored

/obj/item/adv_mulligan/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	return

/obj/item/adv_mulligan/afterattack(atom/movable/AM, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(user))
		return
	if(used)
		to_chat(user, "<span class='warning'>[src] has been already used, you can't activate it again!</span>")
		return
	if(ishuman(AM))
		var/mob/living/carbon/human/target = AM
		if(user.real_name != target.dna.real_name)
			stored = target
			to_chat(user, "<span class='notice'>You stealthly stab [target.name] with [src].</span>")
			desc = "Toxin that permanently changes your DNA into the one of last injected person. It has DNA of <span class='blue'>[stored.dna.real_name]</span> inside."
			icon_state = "dnainjector"
		else
			if(stored)
				mutate(user)
			else
				to_chat(user, "<span class='warning'>You can't stab yourself with [src]!</span>")

/obj/item/adv_mulligan/attack_self(mob/living/carbon/user)
	mutate(user)

/obj/item/adv_mulligan/proc/mutate(mob/living/carbon/user)
	if(used)
		to_chat(user, "<span class='warning'>[src] has been already used, you can't activate it again!</span>")
		return
	if(!stored)
		to_chat(user, "<span class='warning'>[src] doesn't have any DNA loaded in it!</span>")
		return

	user.visible_message("<span class='warning'>[user.name] shivers in pain and soon transform into [stored.dna.real_name]!</span>", \
	"<span class='notice'>You inject yourself with [src] and suddenly become a copy of [stored.dna.real_name].</span>")

	user.real_name = stored.real_name
	stored.dna.transfer_identity(user, transfer_SE=1)
	user.updateappearance(mutcolor_update=1)
	user.domutcheck()
	used = TRUE

	icon_state = "dnainjector0"
	desc = "Toxin that permanently changes your DNA into the one of last injected person. This one is used up."
