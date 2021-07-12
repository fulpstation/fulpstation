/datum/species/beefman/spec_unarmedattacked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user)
	return ..()

/datum/species/beefman/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user)
	return ..()

/datum/species/beefman/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user)
	return ..()

/datum/species/beefman/disarm(mob/living/carbon/human/beefman, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Targeting Self? With "DISARM"
	if (beefman == target)
		var/target_zone = beefman.zone_selected
		var/list/allowedList = list ( BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG )
		var/obj/item/bodypart/selected_bodypart = beefman.get_bodypart(check_zone(target_zone)) //stabbing yourself always hits the right target

		if ((target_zone in allowedList) && selected_bodypart)

			if (beefman.handcuffed)
				to_chat(beefman, span_alert("You can't get a good enough grip with your hands bound."))
				return FALSE

			// Robot Arms Fail
			if (selected_bodypart.status != BODYPART_ORGANIC)
				to_chat(beefman, "That thing is on there good. It's not coming off with a gentle tug.")
				return FALSE

			// Pry it off...
			beefman.visible_message("[beefman] grabs onto [p_their()] own [selected_bodypart.name] and pulls.", span_notice("You grab hold of your [selected_bodypart.name] and yank hard."))
			if (!do_mob(beefman,target))
				return TRUE

			beefman.visible_message("[beefman]'s [selected_bodypart.name] comes right off in their hand.", span_notice("Your [selected_bodypart.name] pops right off."))
			playsound(get_turf(beefman), 'fulp_modules/main_features/species/beefman/sounds/beef_hit.ogg', 40, 1)

			// Destroy Limb, Drop Meat, Pick Up
			var/obj/item/meat = selected_bodypart.drop_limb()
			// selected_bodypart.drop_meat(beefman)
			if(istype(meat, /obj/item/food/meat/slab))
				beefman.put_in_hands(meat) // This has no way of failing because we just passed all earlier checks.

			return TRUE
	return ..()

/datum/species/beefman/spec_attacked_by(obj/item/item, mob/living/user, obj/item/bodypart/bodypart, mob/living/carbon/human/beefman, modifiers)
	signal_handler_because_fuck_you()

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	if(beefman.stat < DEAD && !bodypart && istype(item, /obj/item/food/meat/slab))
		var/target_zone = user.zone_selected
		var/list/limbs = list(BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG)

		// MEAT LIMBS: If our limb is missing, and we're using meat, stick it in!
		if(target_zone in limbs)
			if(user == beefman)
				user.visible_message("[user] begins mashing [item] into [beefman]'s torso.", span_notice("You begin mashing [item] into your torso."))
			else
				user.visible_message("[user] begins mashing [item] into [beefman]'s torso.", span_notice("You begin mashing [item] into [beefman]'s torso."))

		if(do_mob(user, beefman, 3 SECONDS))
			// Attach the part!
			var/obj/item/bodypart/newbodypart = beefman.newBodyPart(target_zone, FALSE)
			beefman.visible_message("The meat sprouts digits and becomes [beefman]'s new [newbodypart.name]!", "<span class='notice'>The meat sprouts digits and becomes your new [newbodypart.name]!</span>")
			newbodypart.attach_limb(beefman)
			newbodypart.give_meat(beefman, item)
			playsound(get_turf(beefman), 'fulp_modules/main_features/species/beefman/sounds/beef_grab.ogg', 50, 1)

			return TRUE
	return ..()

/datum/species/beefman/proc/signal_handler_because_fuck_you()
	SIGNAL_HANDLER
