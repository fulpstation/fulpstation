/datum/job/fulp/deputy
	title = "Deputy"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the head of your assigned department, and the head of security, but only on red alert"
	selection_color = "#ffeeee"
	minimal_player_age = 14
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_SECURITY
	id_icon = 'fulp_modules/jobs/cards.dmi'
	hud_icon = 'fulp_modules/jobs/huds.dmi'
	fulp_spawn = /obj/effect/landmark/start/deputy

	outfit = /datum/outfit/job/deputy
	plasmaman_outfit = /datum/outfit/plasmaman/deputy

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC
	departments = DEPARTMENT_SECURITY

/// Default Deputy trim, this should never be used in game.
/datum/id_trim/job/deputy
	assignment = "Deputy"
	trim_state = "trim_deputy"
	trim_icon = 'fulp_modules/jobs/cards.dmi'
	full_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_MINERAL_STOREROOM)
	config_job = "deputy"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)
	/// Used to give the Departmental access
	var/department_access = list()

/datum/id_trim/job/deputy/refresh_trim_access()
	. = ..()
	if(!.)
		return
	access |= department_access

/datum/id_trim/job/deputy/engineering
	assignment = "Deputy (Engineering)"
	department_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CONSTRUCTION, ACCESS_MECH_ENGINE, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)

/datum/id_trim/job/deputy/medical
	assignment = "Deputy (Medical)"
	department_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_MORGUE, ACCESS_VIROLOGY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_SURGERY, ACCESS_MECH_MEDICAL)

/datum/id_trim/job/deputy/science
	assignment = "Deputy (Science)"
	department_access = list(ACCESS_RND, ACCESS_GENETICS, ACCESS_TOXINS, ACCESS_MECH_SCIENCE, ACCESS_RESEARCH, ACCESS_ROBOTICS, ACCESS_XENOBIOLOGY, ACCESS_MINERAL_STOREROOM, ACCESS_TOXINS_STORAGE)

/datum/id_trim/job/deputy/supply
	assignment = "Deputy (Cargo)"
	department_access = list(ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE)

GLOBAL_LIST_INIT(available_deputy_depts, sortList(list(SEC_DEPT_ENGINEERING, SEC_DEPT_MEDICAL, SEC_DEPT_SCIENCE, SEC_DEPT_SUPPLY)))

/datum/job/fulp/deputy/after_spawn(mob/living/carbon/human/H, mob/M, latejoin = FALSE)
	. = ..()
	var/department

	if(M && M.client && M.client.prefs)
		department = M.client.prefs.prefered_security_department
		if(!LAZYLEN(GLOB.available_deputy_depts))
			return
		else if(department in GLOB.available_deputy_depts)
			LAZYREMOVE(GLOB.available_deputy_depts, department)
		else
			department = pick_n_take(GLOB.available_deputy_depts)
	var/ears = null
	switch(department)
		if(SEC_DEPT_ENGINEERING)
			H.equipOutfit(/datum/outfit/job/deputy/engineering)
			ears = /obj/item/radio/headset/headset_sec/alt/department/engi
			announce_engineering(H, department)
		if(SEC_DEPT_MEDICAL)
			H.equipOutfit(/datum/outfit/job/deputy/medical)
			ears = /obj/item/radio/headset/headset_sec/alt/department/med
			announce_medical(H, department)
		if(SEC_DEPT_SCIENCE)
			H.equipOutfit(/datum/outfit/job/deputy/science)
			ears = /obj/item/radio/headset/headset_sec/alt/department/sci
			announce_science(H, department)
		if(SEC_DEPT_SUPPLY)
			H.equipOutfit(/datum/outfit/job/deputy/supply)
			ears = /obj/item/radio/headset/headset_sec/alt/department/supply
			announce_supply(H, department)

	if(ears)
		if(H.ears)
			qdel(H.ears)
		H.equip_to_slot_or_del(new ears(H), ITEM_SLOT_EARS)

	if(department)
		to_chat(M, "<b>You have been assigned to [department]!</b>")
	else
		to_chat(M, "<b>You have not been assigned to any department. Patrol the halls and help where needed.</b>")

/// Engineering
/datum/job/fulp/deputy/proc/announce_engineering(mob/officer, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_engineering(officer, department)

/obj/machinery/announcement_system/proc/announce_engineering(mob/officer, department)
	if(!is_operational)
		return
	broadcast("[officer.real_name] is the [department] departmental Deputy.", list(RADIO_CHANNEL_ENGINEERING))

/// Medical
/datum/job/fulp/deputy/proc/announce_medical(mob/officer, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_medical(officer, department)

/obj/machinery/announcement_system/proc/announce_medical(mob/officer, department)
	if(!is_operational)
		return
	broadcast("[officer.real_name] is the [department] departmental Deputy.", list(RADIO_CHANNEL_MEDICAL))

/// Science
/datum/job/fulp/deputy/proc/announce_science(mob/officer, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_science(officer, department)

/obj/machinery/announcement_system/proc/announce_science(mob/officer, department)
	if(!is_operational)
		return
	broadcast("[officer.real_name] is the [department] departmental Deputy.", list(RADIO_CHANNEL_SCIENCE))

/// Supply
/datum/job/fulp/deputy/proc/announce_supply(mob/officer, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_supply(officer, department)

/obj/machinery/announcement_system/proc/announce_supply(mob/officer, department)
	if(!is_operational)
		return
	broadcast("[officer.real_name] is the [department] departmental Deputy.", list(RADIO_CHANNEL_SUPPLY))

/// Used for Science Deputies
/obj/item/reagent_containers/hypospray/medipen/mutadone
	name = "mutadone medipen"
	desc = "Hulked lings in the RD office? Space adapt traitors bombing the Armory? You know what to do! Comes with 2 uses."
	volume = 60
	amount_per_transfer_from_this = 30
	list_reagents = list(/datum/reagent/medicine/mutadone = 60)
