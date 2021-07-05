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

/datum/species/beefman/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Targeting Self? With "DISARM"
	if (user == target)
		var/target_zone = user.zone_selected
		var/list/allowedList = list ( BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG )
		var/obj/item/bodypart/selected_bodypart = user.get_bodypart(check_zone(user.zone_selected)) //stabbing yourself always hits the right target

		if ((target_zone in allowedList) && selected_bodypart)

			if (user.handcuffed)
				to_chat(user, "<span class='alert'>You can't get a good enough grip with your hands bound.</span>")
				return FALSE

			// Robot Arms Fail
			if (selected_bodypart.status != BODYPART_ORGANIC)
				to_chat(user, "That thing is on there good. It's not coming off with a gentle tug.")
				return FALSE

			// Pry it off...
			user.visible_message("[user] grabs onto [p_their()] own [selected_bodypart.name] and pulls.", "<span class='notice'>You grab hold of your [selected_bodypart.name] and yank hard.</span>")
			if (!do_mob(user,target))
				return TRUE

			user.visible_message("[user]'s [selected_bodypart.name] comes right off in their hand.", "<span class='notice'>Your [selected_bodypart.name] pops right off.</span>")
			playsound(get_turf(user), 'fulp_modules/main_features/species/beefman/sounds/beef_hit.ogg', 40, 1)

			// Destroy Limb, Drop Meat, Pick Up
			var/obj/item/item = selected_bodypart.drop_limb() //  <--- This will return a meat vis drop_meat(), even if only Beefman limbs return anything. If this was another species' limb, it just comes off.
			if (istype(item, /obj/item/food/meat/slab))
				user.put_in_hands(item)

			return TRUE
	return ..()

/datum/species/beefman/spec_attacked_by(obj/item/item, mob/living/user, obj/item/bodypart/bodypart, mob/living/carbon/human/beefman, modifiers)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	if(beefman.stat < DEAD && !bodypart && istype(item, /obj/item/food/meat/slab))
		handle_limb_mashing(user, beefman, item)
		return TRUE
	return ..()

/datum/species/beefman/proc/handle_limb_mashing(mob/living/meat_masher, mob/living/carbon/human/beefman, /obj/item/meat)
	SIGNAL_HANDLER

	var/target_zone = meat_masher.zone_selected
	var/list/limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

	// MEAT LIMBS: If our limb is missing, and we're using meat, stick it in!
	if(target_zone in limbs)
		if(meat_masher == beefman)
			meat_masher.visible_message("[meat_masher] begins mashing [meat] into [beefman]'s torso.", span_notice("You begin mashing [meat] into your torso."))
		else
			meat_masher.visible_message("[meat_masher] begins mashing [meat] into [beefman]'s torso.", span_notice("You begin mashing [meat] into [beefman]'s torso."))

		spawn(1)
			if(do_mob(meat_masher, beefman))
				// Attach the part!
				var/obj/item/bodypart/newbodypart = beefman.newBodyPart(target_zone, FALSE)
				beefman.visible_message("The meat sprouts digits and becomes [beefman]'s new [newbodypart.name]!", "<span class='notice'>The meat sprouts digits and becomes your new [newbodypart.name]!</span>")
				newbodypart.attach_limb(beefman)
				newbodypart.give_meat(beefman, meat)
				playsound(get_turf(beefman), 'fulp_modules/main_features/species/beefman/sounds/beef_grab.ogg', 50, 1)
