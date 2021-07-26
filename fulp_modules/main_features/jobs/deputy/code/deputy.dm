/datum/job/fulp/deputy
	title = "Deputy"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	supervisors = "the head of your assigned department"
	selection_color = "#ffeeee"
	minimal_player_age = 14
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_SECURITY

	outfit = /datum/outfit/job/deputy
	plasmaman_outfit = /datum/outfit/plasmaman/deputy

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC
	departments = DEPARTMENT_SECURITY

	mail_goodies = list(
		/obj/item/storage/fancy/cigarettes = 15,
		/obj/item/pizzabox = 10,
		/obj/effect/spawner/lootdrop/donkpockets = 10,
		/obj/item/storage/box/handcuffs = 10,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/choice_beacon/music = 5,
		/obj/item/crowbar/large = 1,
		/obj/item/melee/baton/boomerang/loaded = 1,
	)

	fulp_spawn = /obj/effect/landmark/start/deputy

/// Engineering
/datum/job/fulp/deputy/engineering
	title = "Deputy (Engineering)"
	department_head = list("Chief Engineer")
	selection_color = "#fff5cc"
	total_positions = 1
	spawn_positions = 1
	outfit = /datum/outfit/job/deputy/engineering
	fulp_spawn = /obj/effect/landmark/start/deputy/engineering

	display_order = JOB_DISPLAY_ORDER_CHIEF_ENGINEER
	departments = DEPARTMENT_ENGINEERING
///Medical
/datum/job/fulp/deputy/medical
	title = "Deputy (Medical)"
	department_head = list("Chief Medical Officer")
	selection_color = "#ffeef0"
	total_positions = 1
	spawn_positions = 1
	outfit = /datum/outfit/job/deputy/medical
	fulp_spawn = /obj/effect/landmark/start/deputy/medical

	display_order = JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER
	departments = DEPARTMENT_MEDICAL
///Science
/datum/job/fulp/deputy/science
	title = "Deputy (Science)"
	department_head = list("Research Director")
	selection_color = "#ffeeff"
	total_positions = 1
	spawn_positions = 1
	outfit = /datum/outfit/job/deputy/science
	fulp_spawn = /obj/effect/landmark/start/deputy/science

	display_order = JOB_DISPLAY_ORDER_RESEARCH_DIRECTOR
	departments = DEPARTMENT_SCIENCE
///Supply
/datum/job/fulp/deputy/supply
	title = "Deputy (Supply)"
	department_head = list("Head of Personnel")
	selection_color = "#dcba97"
	total_positions = 1
	spawn_positions = 1
	outfit = /datum/outfit/job/deputy/supply
	fulp_spawn = /obj/effect/landmark/start/deputy/supply

	display_order = JOB_DISPLAY_ORDER_QUARTERMASTER
	departments = DEPARTMENT_CARGO
///Service
/*
/datum/job/fulp/deputy/service
	title = "Deputy (Service)"
	department_head = list("Head of Personnel")
	selection_color = "#bbe291"
	total_positions = 1
	spawn_positions = 1
	outfit = /datum/outfit/job/deputy/service

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL
	departments = DEPARTMENT_SERVICE
*/

/// Default Deputy trim, this should never be assigned roundstart.
/datum/id_trim/job/deputy
	assignment = "Deputy"
	trim_icon = 'fulp_modules/main_features/jobs/cards.dmi'
	trim_state = "trim_deputy"
	full_access = list(ACCESS_SEC_DOORS, ACCESS_SECURITY, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SEC_DOORS, ACCESS_SECURITY, ACCESS_BRIG, ACCESS_MINERAL_STOREROOM)
	config_job = "deputy"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)
	/// Used to give the Departmental access
	var/department_access = list()

/datum/id_trim/job/deputy/refresh_trim_access()
	if(!..())
		return
	access |= department_access

/datum/id_trim/job/deputy/engineering
	assignment = "Deputy (Engineering)"
	trim_state = "trim_deputyeng"
	department_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CONSTRUCTION, ACCESS_MECH_ENGINE, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CE, ACCESS_CHANGE_IDS)

/datum/id_trim/job/deputy/medical
	assignment = "Deputy (Medical)"
	trim_state = "trim_deputymed"
	department_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_MORGUE, ACCESS_VIROLOGY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_SURGERY, ACCESS_MECH_MEDICAL)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CMO, ACCESS_CHANGE_IDS)

/datum/id_trim/job/deputy/science
	assignment = "Deputy (Science)"
	trim_state = "trim_deputysci"
	department_access = list(ACCESS_RND, ACCESS_GENETICS, ACCESS_TOXINS, ACCESS_MECH_SCIENCE, ACCESS_RESEARCH, ACCESS_ROBOTICS, ACCESS_XENOBIOLOGY, ACCESS_MINERAL_STOREROOM, ACCESS_TOXINS_STORAGE)
	template_access = list(ACCESS_CAPTAIN, ACCESS_RD, ACCESS_CHANGE_IDS)

/datum/id_trim/job/deputy/supply
	assignment = "Deputy (Supply)"
	trim_state = "trim_deputysupply"
	department_access = list(ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE, ACCESS_QM)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)

/datum/id_trim/job/deputy/service
	assignment = "Deputy (Service)"
	trim_state = "trim_deputyservice"
	department_access = list(ACCESS_PSYCHOLOGY, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_HYDROPONICS, ACCESS_LAWYER, ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)

/datum/job/fulp/deputy/after_spawn(mob/living/carbon/human/H, mob/M, latejoin = FALSE)
	. = ..()

	var/assigned_department = SEC_DEPT_NONE
	var/channel

	if(!departments || departments == DEPARTMENT_SECURITY)
		to_chat(M, "<b>You have not been assigned to any department. Patrol the halls and help where needed.</b>")
		return
	switch(departments)
		if(DEPARTMENT_ENGINEERING)
			assigned_department = SEC_DEPT_ENGINEERING
			channel = RADIO_CHANNEL_ENGINEERING
		if(DEPARTMENT_MEDICAL)
			assigned_department = SEC_DEPT_MEDICAL
			channel = RADIO_CHANNEL_MEDICAL
		if(DEPARTMENT_SCIENCE)
			assigned_department = SEC_DEPT_SCIENCE
			channel = RADIO_CHANNEL_SCIENCE
		if(DEPARTMENT_CARGO)
			assigned_department = SEC_DEPT_SUPPLY
			channel = RADIO_CHANNEL_SUPPLY
		if(DEPARTMENT_SERVICE)
			assigned_department = SEC_DEPT_SERVICE
			channel = RADIO_CHANNEL_SERVICE
	announce_deputy(H, assigned_department, channel)
	to_chat(M, "<b>You have been assigned to [assigned_department]!</b>")

/datum/job/fulp/deputy/proc/announce_deputy(mob/deputy, department, channel)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_deputy(deputy, department, channel)

/obj/machinery/announcement_system/proc/announce_deputy(mob/deputy, department, channel)
	if(!is_operational)
		return
	broadcast("[deputy.real_name] is the [department] departmental Deputy.", list(channel))
