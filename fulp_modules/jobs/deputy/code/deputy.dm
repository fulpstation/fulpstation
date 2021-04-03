/datum/job/fulp/deputy
	title = "Deputy"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the head of your assigned department, and the head of security when outside your post"
	selection_color = "#ffeeee"
	minimal_player_age = 14
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_SECURITY
	id_icon = 'fulp_modules/jobs/cards.dmi'
	hud_icon = 'fulp_modules/jobs/huds.dmi'
	fulp_spawn = /obj/effect/landmark/start/deputy

	plasmaman_outfit = /datum/outfit/plasmaman/deputy

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SEC
	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC

/// Default Deputy Clothes
/datum/outfit/job/deputy
	name = "Deputy"
	jobtype = /datum/job/fulp/deputy

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec
	uniform = /obj/item/clothing/under/rank/security/officer/mallcop
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/beret/sec
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/assembly/flash/handheld
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	backpack_contents = list(/obj/item/melee/baton/loaded=1, /obj/item/restraints/handcuffs/cable/zipties=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/deputy

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

/datum/id_trim/job/deputy/supply
	assignment = "Deputy (Cargo)"
	department_access = list(ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE)

/datum/id_trim/job/deputy/engineering
	assignment = "Deputy (Engineering)"
	department_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CONSTRUCTION, ACCESS_MECH_ENGINE, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)

/datum/id_trim/job/deputy/medical
	assignment = "Deputy (Medical)"
	department_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_MORGUE, ACCESS_VIROLOGY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_SURGERY, ACCESS_MECH_MEDICAL)

/datum/id_trim/job/deputy/science
	assignment = "Deputy (Science)"
	department_access = list(ACCESS_RND, ACCESS_GENETICS, ACCESS_TOXINS, ACCESS_MECH_SCIENCE, ACCESS_RESEARCH, ACCESS_ROBOTICS, ACCESS_XENOBIOLOGY, ACCESS_MINERAL_STOREROOM, ACCESS_TOXINS_STORAGE)

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

		if(latejoin)
			announce_latejoin(H, department)

	var/list/dep_trim = null
	switch(department)
		if(SEC_DEPT_SUPPLY)
			H.equipOutfit(/datum/outfit/job/deputy/supply)
			dep_trim = /datum/id_trim/job/deputy/supply
		if(SEC_DEPT_ENGINEERING)
			H.equipOutfit(/datum/outfit/job/deputy/engineering)
			dep_trim = /datum/id_trim/job/deputy/engineering
		if(SEC_DEPT_MEDICAL)
			H.equipOutfit(/datum/outfit/job/deputy/medical)
			dep_trim = /datum/id_trim/job/deputy/medical
		if(SEC_DEPT_SCIENCE)
			H.equipOutfit(/datum/outfit/job/deputy/science)
			dep_trim = /datum/id_trim/job/deputy/science
		else
			H.equipOutfit(/datum/outfit/job/deputy)

	if(dep_trim)
		var/obj/item/card/id/worn_id = H.wear_id
		SSid_access.apply_trim_to_card(worn_id, dep_trim)
		H.sec_hud_set_ID()

	if(department)
		to_chat(M, "<b>You have been assigned to [department]!</b>")
	else
		to_chat(M, "<b>You have not been assigned to any department. Patrol the halls and help where needed.</b>")

/datum/job/fulp/deputy/proc/announce_latejoin(mob/officer, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return

	announcement_system.announce_officer(officer, department)

	var/list/targets = list()

	if(!targets.len)
		return

	var/datum/signal/subspace/messaging/pda/signal = new(announcement_system, list(
		"name" = "Security Department Update",
		"job" = "Automated Announcement System",
		"message" = "[officer.real_name] arrived as the [department] departmental Deputy.",
		"targets" = targets,
		"automated" = TRUE,
	))

	signal.send_to_receivers()
