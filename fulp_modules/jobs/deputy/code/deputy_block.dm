/datum/martial_art/deputyblock
	name = "Deputy Block"
	id = MARTIALART_DEPUTYBLOCK
	block_chance = 80
	var/old_grab_state = null
	var/list/valid_area = list()

/datum/martial_art/deputyblock/teach(mob/living/holder_living, make_temporary = TRUE)
	. = ..()
	addtimer(CALLBACK(src, .proc/assign_department, holder_living), 1 SECONDS, TIMER_CLIENT_TIME)

/datum/martial_art/deputyblock/proc/assign_department(mob/holder_living)
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

/datum/martial_art/deputyblock/can_use(mob/living/owner)
	if(is_type_in_list(get_area(owner), valid_area))
		return TRUE

/// This is required or else the block chance just wont work
/datum/martial_art/deputyblock/disarm_act(mob/living/A, mob/living/D)
	..()

/datum/martial_art/deputyblock/grab_act(mob/living/A, mob/living/D)
	..()

/datum/martial_art/deputyblock/harm_act(mob/living/A, mob/living/D)
	..()
