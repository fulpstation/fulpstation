/obj/item/adv_mulligan
	name = "advanced mulligan"
	desc = "Toxin that permanently changes your DNA into the one of last injected person. Use it on the victim to extract their DNA then inject it into yourself!"
	icon = 'icons/obj/syringe.dmi'
	icon_state = "dnainjector0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/used = FALSE ///determines wether the injector is used up or nah
	var/datum/weakref/store  ///the mob currently stored in the injector

/obj/item/adv_mulligan/afterattack(atom/movable/victim, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(user))
		return
	if(used)
		to_chat(user, span_warning("[src] has been already used, you can't activate it again!"))
		return
	if(ishuman(victim))
		var/mob/living/carbon/human/target = victim
		if(user.real_name != target.dna.real_name)
			store = WEAKREF(target)
			to_chat(user, span_notice("You stealthly stab [target.name] with [src]."))
			icon_state = "dnainjector"
		else
			if(store)
				mutate(user)
			else
				to_chat(user, span_notice("You can't stab yourself with [src]!"))

/obj/item/adv_mulligan/attack_self(mob/living/carbon/user)
	mutate(user)

/obj/item/adv_mulligan/proc/mutate(mob/living/carbon/user)
	if(used)
		to_chat(user, span_notice("[src] has been already used, you can't activate it again!"))
		return
	if(!store)
		to_chat(user, span_notice("[src] doesn't have any DNA loaded in it!"))
		return

	if(!do_after(user, 2 SECONDS))
		return

	var/mob/living/carbon/human/stored = store.resolve()

	user.visible_message(span_warning("[user.name] shivers in pain and soon transforms into [stored.dna.real_name]!"), \
		span_notice("You inject yourself with [src] and suddenly become a copy of [stored.dna.real_name]."))

	user.real_name = stored.real_name
	stored.dna.transfer_identity(user, transfer_SE=1)
	user.updateappearance(mutcolor_update=1)
	user.domutcheck()
	used = TRUE

	icon_state = "dnainjector0"
	store = null

/obj/item/adv_mulligan/examine(mob/user)
	. = ..()
	if (used)
		. += "This one is all used up."
