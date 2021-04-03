/datum/martial_art/deputygrab
	name = "Deputy Grab"
	id = MARTIALART_DEPUTYGRAB
	var/old_grab_state = null
	var/list/valid_area = list()

/// From CQC.dm
/datum/martial_art/deputygrab/grab_act(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(is_type_in_list(get_area(A), valid_area))
		old_grab_state = A.grab_state
		D.grabbedby(A, 1)
		if(old_grab_state == GRAB_PASSIVE)
			D.drop_all_held_items()
			A.setGrabState(GRAB_AGGRESSIVE)
			log_combat(A, D, "grabbed", addition="aggressively")
			D.visible_message("<span class='warning'>[A] violently grabs [D]!</span>", \
							"<span class='userdanger'>You're grabbed violently by [A]!</span>", "<span class='hear'>You hear sounds of aggressive fondling!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You violently grab [D]!</span>")
			return TRUE
	else
		return FALSE

// This is used to limit it to the Deputy's department.
/datum/martial_art/deputygrab/can_use(mob/living/H)
	if(HAS_TRAIT(H, TRAIT_SUPPLYDEPUTY))
		valid_area = typesof(/area/cargo)
		return TRUE
	if(HAS_TRAIT(H, TRAIT_ENGINEERINGDEPUTY))
		valid_area = typesof(/area/engineering)
		return TRUE
	if(HAS_TRAIT(H, TRAIT_MEDICALDEPUTY))
		valid_area = typesof(/area/medical)
		return TRUE
	if(HAS_TRAIT(H, TRAIT_SCIENCEDEPUTY))
		valid_area = typesof(/area/science)
		return TRUE
	else
		return ..()
