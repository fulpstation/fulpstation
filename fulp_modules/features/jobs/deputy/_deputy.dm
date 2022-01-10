/datum/job/fulp/deputy
	title = JOB_DEPUTY
	description = "Help Security enforce Space Law, \
		Capture criminals and deliver them to the Brig."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	supervisors = "the head of your assigned department"
	selection_color = "#ffeeee"
	minimal_player_age = 14
	exp_requirements = 300
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SECURITY
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/deputy
	plasmaman_outfit = /datum/outfit/plasmaman/deputy

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC
	departments_list = list(
		/datum/job_department/security,
	)

	mail_goodies = list(
		/obj/item/storage/fancy/cigarettes = 15,
		/obj/item/pizzabox = 10,
		/obj/effect/spawner/random/food_or_drink/donkpockets = 10,
		/obj/item/storage/box/handcuffs = 10,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/choice_beacon/music = 5,
		/obj/item/crowbar/large = 1,
		/obj/item/melee/baton/security/boomerang/loaded = 1,
		/obj/item/clothing/gloves/tackler/offbrand = 1,
	)
	rpg_title = "Independent Guardsman"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS
	fulp_spawn = /obj/effect/landmark/start/deputy

	///The Deputy's assigned department
	var/deputy_department = DEPARTMENT_SECURITY

/datum/job/fulp/deputy/config_check()
	if(deputy_department == DEPARTMENT_SECURITY)
		return CONFIG_GET(flag/allow_departmentless_deputy)
	if(deputy_department == DEPARTMENT_SERVICE)
		return CONFIG_GET(flag/allow_service_deputy)
	return TRUE

/// Engineering
/datum/job/fulp/deputy/engineering
	title = JOB_DEPUTY_ENG
	description = "Help Security enforce Space Law within the Engineering department, \
		Capture criminals in Engineering and deliver them to the Brig."
	department_head = list("Chief Engineer")
	selection_color = "#fff5cc"
	total_positions = 1
	spawn_positions = 1
	exp_required_type_department = EXP_TYPE_ENGINEERING
	exp_granted_type = EXP_TYPE_ENGINEERING
	outfit = /datum/outfit/job/deputy/engineering
	fulp_spawn = /obj/effect/landmark/start/deputy/engineering
	deputy_department = DEPARTMENT_ENGINEERING

	display_order = JOB_DISPLAY_ORDER_CHIEF_ENGINEER
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/engineering,
	)
	department_for_prefs = /datum/job_department/engineering

///Medical
/datum/job/fulp/deputy/medical
	title = JOB_DEPUTY_MED
	description = "Help Security enforce Space Law within the Medical department, \
		Capture criminals in Medical and deliver them to the Brig."
	department_head = list("Chief Medical Officer")
	selection_color = "#ffeef0"
	total_positions = 1
	spawn_positions = 1
	exp_required_type_department = EXP_TYPE_MEDICAL
	exp_granted_type = EXP_TYPE_MEDICAL
	outfit = /datum/outfit/job/deputy/medical
	fulp_spawn = /obj/effect/landmark/start/deputy/medical
	deputy_department = DEPARTMENT_MEDICAL

	display_order = JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/medical,
	)
	department_for_prefs = /datum/job_department/medical

///Science
/datum/job/fulp/deputy/science
	title = JOB_DEPUTY_SCI
	description = "Help Security enforce Space Law within the Science department, \
		Capture criminals in Science and deliver them to the Brig."
	department_head = list("Research Director")
	selection_color = "#ffeeff"
	total_positions = 1
	spawn_positions = 1
	exp_required_type_department = EXP_TYPE_SCIENCE
	exp_granted_type = EXP_TYPE_SCIENCE
	outfit = /datum/outfit/job/deputy/science
	fulp_spawn = /obj/effect/landmark/start/deputy/science
	deputy_department = DEPARTMENT_SCIENCE

	display_order = JOB_DISPLAY_ORDER_RESEARCH_DIRECTOR
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/science,
	)
	department_for_prefs = /datum/job_department/science

///Supply
/datum/job/fulp/deputy/supply
	title = JOB_DEPUTY_SUP
	description = "Help Security enforce Space Law within the Supply department, \
		Capture criminals  in Cargo and deliver them to the Brig."
	department_head = list("Head of Personnel")
	selection_color = "#dcba97"
	total_positions = 1
	spawn_positions = 1
	exp_required_type_department = EXP_TYPE_SUPPLY
	exp_granted_type = EXP_TYPE_SUPPLY
	outfit = /datum/outfit/job/deputy/supply
	fulp_spawn = /obj/effect/landmark/start/deputy/supply
	deputy_department = DEPARTMENT_CARGO

	display_order = JOB_DISPLAY_ORDER_QUARTERMASTER
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/cargo,
	)
	department_for_prefs = /datum/job_department/cargo

///Service
/datum/job/fulp/deputy/service
	title = JOB_DEPUTY_SRV
	description = "Help Security enforce Space Law within the Service department, \
		Capture criminals... wherever Service is... and deliver them to the Brig."
	department_head = list("Head of Personnel")
	selection_color = "#bbe291"
	total_positions = 1
	spawn_positions = 1
	exp_required_type_department = EXP_TYPE_SERVICE
	exp_granted_type = EXP_TYPE_SERVICE
	outfit = /datum/outfit/job/deputy/service
	deputy_department = DEPARTMENT_SERVICE

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/service,
	)
	department_for_prefs = /datum/job_department/service


/**
 * TRIMS
 */

/datum/id_trim/job/deputy
	assignment = "Deputy"
	trim_icon = 'fulp_modules/features/jobs/icons/cards.dmi'
	trim_state = "trim_deputy"
	extra_access = list(ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_SEC_DOORS, ACCESS_SECURITY, ACCESS_BRIG, ACCESS_MINERAL_STOREROOM)
	config_job = "deputy"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)
	job = /datum/job/fulp/deputy
	/// Used to give the Departmental access
	var/department_access = list()

/datum/id_trim/job/deputy/refresh_trim_access()
	. = ..()
	if(!.)
		return
	access |= department_access

/datum/id_trim/job/deputy/engineering
	assignment = "Engineering Deputy"
	trim_state = "trim_deputyeng"
	department_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CONSTRUCTION, ACCESS_MECH_ENGINE, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CE, ACCESS_CHANGE_IDS)
	job = /datum/job/fulp/deputy/engineering

/datum/id_trim/job/deputy/medical
	assignment = "Medical Deputy"
	trim_state = "trim_deputymed"
	department_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_MORGUE, ACCESS_VIROLOGY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_SURGERY, ACCESS_MECH_MEDICAL)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CMO, ACCESS_CHANGE_IDS)
	job = /datum/job/fulp/deputy/medical

/datum/id_trim/job/deputy/science
	assignment = "Science Deputy"
	trim_state = "trim_deputysci"
	department_access = list(ACCESS_RND, ACCESS_GENETICS, ACCESS_ORDNANCE, ACCESS_MECH_SCIENCE, ACCESS_RESEARCH, ACCESS_ROBOTICS, ACCESS_XENOBIOLOGY, ACCESS_MINERAL_STOREROOM, ACCESS_ORDNANCE_STORAGE)
	template_access = list(ACCESS_CAPTAIN, ACCESS_RD, ACCESS_CHANGE_IDS)
	job = /datum/job/fulp/deputy/science

/datum/id_trim/job/deputy/supply
	assignment = "Supply Deputy"
	trim_state = "trim_deputysupply"
	department_access = list(ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE, ACCESS_QM)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/fulp/deputy/supply

/datum/id_trim/job/deputy/service
	assignment = "Service Deputy"
	trim_state = "trim_deputyservice"
	department_access = list(
		ACCESS_BAR, ACCESS_KITCHEN, ACCESS_HYDROPONICS, ACCESS_SERVICE,
		ACCESS_THEATRE, ACCESS_JANITOR, ACCESS_LAWYER, ACCESS_CHAPEL_OFFICE, ACCESS_CREMATORIUM, ACCESS_LIBRARY,
		ACCESS_MEDICAL, ACCESS_PSYCHOLOGY,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/fulp/deputy/service

/**
 * DEPUTY SPAWNING
 */

/datum/job/fulp/deputy/after_spawn(mob/living/carbon/human/user, mob/player, latejoin = FALSE)
	. = ..()

	var/assigned_department = SEC_DEPT_NONE // Might be worth merging this into deputy_department soon.
	var/channel

	if(!deputy_department || deputy_department == DEPARTMENT_SECURITY)
		to_chat(user, "<b>You have not been assigned to any department. Patrol the halls and help where needed.</b>")
		return
	switch(deputy_department)
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
	announce_deputy(user, assigned_department, channel)
	to_chat(player, "<b>You have been assigned to [assigned_department]!</b>")

/datum/job/fulp/deputy/proc/announce_deputy(mob/deputy, department, channel)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_deputy(deputy, department, channel)

/obj/machinery/announcement_system/proc/announce_deputy(mob/deputy, department, channel)
	if(!is_operational)
		return
	broadcast("[deputy.real_name] is the [department] departmental Deputy.", list(channel))
