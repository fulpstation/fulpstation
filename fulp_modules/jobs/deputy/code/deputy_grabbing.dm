/datum/martial_art/deputygrab
	name = "Deputy Grab"
	id = MARTIALART_DEPUTYGRAB

/datum/martial_art/deputygrab/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D) // From CQC.dm
	if(A!=D && can_use(A))
		if(HAS_TRAIT(owner, (TRAIT_SUPPLYDEPUTY)) // Supply Deputies
			var/list/valid_areas = list(typesof(/area/quartermaster))
			if(is_type_in_list(get_area(user), valid_areas))
				D.drop_all_held_items()
				A.setGrabState(GRAB_AGGRESSIVE)
				log_combat(A, D, "grabbed", addition="aggressively")
				D.visible_message("<span class='warning'>[A] violently grabs [D]!</span>", \
							"<span class='userdanger'>You're grabbed violently by [A]!</span>", "<span class='hear'>You hear sounds of aggressive fondling!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You violently grab [D]!</span>")
		return
		if(HAS_TRAIT(owner, (TRAIT_ENGINEERINGDEPUTY)) // Engineering Deputies
			var/list/valid_areas = list(typesof(/area/engine))
			if(is_type_in_list(get_area(user), valid_areas))
				D.drop_all_held_items()
				A.setGrabState(GRAB_AGGRESSIVE)
				log_combat(A, D, "grabbed", addition="aggressively")
				D.visible_message("<span class='warning'>[A] violently grabs [D]!</span>", \
							"<span class='userdanger'>You're grabbed violently by [A]!</span>", "<span class='hear'>You hear sounds of aggressive fondling!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You violently grab [D]!</span>")
		return
		if(HAS_TRAIT(owner, (TRAIT_MEDICALDEPUTY)) // Medical Deputies
			var/list/valid_areas = list(typesof(/area/medical))
			if(is_type_in_list(get_area(user), valid_areas))
				D.drop_all_held_items()
				A.setGrabState(GRAB_AGGRESSIVE)
				log_combat(A, D, "grabbed", addition="aggressively")
				D.visible_message("<span class='warning'>[A] violently grabs [D]!</span>", \
							"<span class='userdanger'>You're grabbed violently by [A]!</span>", "<span class='hear'>You hear sounds of aggressive fondling!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You violently grab [D]!</span>")
		return
		if(HAS_TRAIT(owner, (TRAIT_SCIENCEDEPUTY)) // Science Deputies
			var/list/valid_areas = list(typesof(/area/science))
			if(is_type_in_list(get_area(user), valid_areas))
				D.drop_all_held_items()
				A.setGrabState(GRAB_AGGRESSIVE)
				log_combat(A, D, "grabbed", addition="aggressively")
				D.visible_message("<span class='warning'>[A] violently grabs [D]!</span>", \
							"<span class='userdanger'>You're grabbed violently by [A]!</span>", "<span class='hear'>You hear sounds of aggressive fondling!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You violently grab [D]!</span>")
		return
	else
		return
