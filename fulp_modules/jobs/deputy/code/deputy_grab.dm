/datum/martial_art/deputygrab
	name = "Deputy Grab"
	id = MARTIALART_DEPUTYGRAB
	var/old_grab_state = null
	var/list/valid_area = list()

/datum/martial_art/deputygrab/teach(mob/living/holder_living, make_temporary = TRUE)
	. = ..()
	addtimer(CALLBACK(src, .proc/assign_department, holder_living), 1 SECONDS, TIMER_CLIENT_TIME)

/datum/martial_art/deputygrab/proc/assign_department(mob/holder_living)
	if(HAS_TRAIT(holder_living, TRAIT_SUPPLYDEPUTY))
		valid_area = typesof(/area/cargo) + list(
		/area/security/checkpoint/supply,
		)
	if(HAS_TRAIT(holder_living, TRAIT_ENGINEERINGDEPUTY))
		valid_area = typesof(/area/engineering) + list(
		/area/security/checkpoint/engineering,
		/area/command/heads_quarters/ce,
		)
	if(HAS_TRAIT(holder_living, TRAIT_MEDICALDEPUTY))
		valid_area = typesof(/area/medical) + list(
		/area/security/checkpoint/medical,
		/area/command/heads_quarters/cmo,
		)
	if(HAS_TRAIT(holder_living, TRAIT_SCIENCEDEPUTY))
		valid_area = typesof(/area/science) + list(
		/area/security/checkpoint/science/research,
		/area/command/heads_quarters/rd,
		)

/datum/martial_art/deputygrab/can_use(mob/living/owner)
	if(is_type_in_list(get_area(owner), valid_area))
		return TRUE

/datum/martial_art/deputygrab/grab_act(mob/living/A, mob/living/D)
	if(!can_use(A))
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
		return TRUE
