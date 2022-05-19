/datum/martial_art/deputyblock
	name = "Deputy Block"
	id = MARTIALART_DEPUTYBLOCK
	block_chance = 95
	var/list/valid_area = list()

/datum/martial_art/deputyblock/teach(mob/living/holder_living, make_temporary = TRUE)
	. = ..()
	addtimer(CALLBACK(src, .proc/assign_department, holder_living), 1 SECONDS, TIMER_CLIENT_TIME)

/datum/martial_art/deputyblock/proc/assign_department(mob/holder_living)
	if(HAS_TRAIT(holder_living, TRAIT_SUPPLYDEPUTY))
		valid_area = typesof(/area/station/cargo) + list(
		/area/station/security/checkpoint/supply,
		)
	if(HAS_TRAIT(holder_living, TRAIT_ENGINEERINGDEPUTY))
		valid_area = typesof(/area/station/engineering) + list(
		/area/station/security/checkpoint/engineering,
		/area/station/command/heads_quarters/ce,
		)
	if(HAS_TRAIT(holder_living, TRAIT_MEDICALDEPUTY))
		valid_area = typesof(/area/station/medical) + list(
		/area/station/security/checkpoint/medical,
		/area/station/command/heads_quarters/cmo,
		)
	if(HAS_TRAIT(holder_living, TRAIT_SCIENCEDEPUTY))
		valid_area = typesof(/area/station/science) + list(
		/area/station/security/checkpoint/science/research,
		/area/station/command/heads_quarters/rd,
		)
	if(HAS_TRAIT(holder_living, TRAIT_SERVICEDEPUTY))
		valid_area = typesof(/area/station/service) + list(
		/area/station/command/heads_quarters/hop,
		)

/datum/martial_art/deputyblock/can_use(mob/living/owner)
	if(is_type_in_list(get_area(owner), valid_area))
		return TRUE
