/datum/martial_art/deputygrab
	name = "Deputy Grab"
	id = MARTIALART_DEPUTYGRAB
	var/old_grab_state = null
	var/in_department = TRUE
	var/list/valid_area = null

/datum/martial_art/deputygrab/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D) // From CQC.dm
	if(!can_use(A))
		return FALSE
	if(in_department)
		if(!is_type_in_list(get_area(A), valid_area))
			return FALSE
		old_grab_state = A.grab_state
		D.grabbedby(A, 1)
		if(old_grab_state == GRAB_PASSIVE)
			D.drop_all_held_items()
			A.setGrabState(GRAB_AGGRESSIVE)
			log_combat(A, D, "grabbed", addition="aggressively")
			D.visible_message("<span class='warning'>[A] violently grabs [D]!</span>", \
							"<span class='userdanger'>You're grabbed violently by [A]!</span>", "<span class='hear'>You hear sounds of aggressive fondling!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You violently grab [D]!</span>")
	else
		return FALSE
/*
/datum/martial_art/deputygrab/teach(mob/living/carbon/human/H, make_temporary = FALSE)
	. = ..()
	if(!.)
		return
	if(HAS_TRAIT(src, TRAIT_SUPPLYDEPUTY))
		valid_area = typesof(/area/quartermaster)
	if(HAS_TRAIT(src, TRAIT_ENGINEERINGDEPUTY))
		valid_area = typesof(/area/engine)
	if(HAS_TRAIT(src, TRAIT_MEDICALDEPUTY))
		valid_area = typesof(/area/medical)
	if(HAS_TRAIT(src, TRAIT_SCIENCEDEPUTY))
		valid_area = typesof(/area/science)
*/

// This is used to limit it to the Deputy's department.
/datum/martial_art/deputygrab/can_use(mob/living/carbon/human/H)
	if(HAS_TRAIT(src, TRAIT_SUPPLYDEPUTY))
		valid_area = typesof(/area/quartermaster)
	if(HAS_TRAIT(src, TRAIT_ENGINEERINGDEPUTY))
		valid_area = typesof(/area/engine)
	if(HAS_TRAIT(src, TRAIT_MEDICALDEPUTY))
		valid_area = typesof(/area/medical)
	if(HAS_TRAIT(src, TRAIT_SCIENCEDEPUTY))
		valid_area = typesof(/area/science)
	return ..()
