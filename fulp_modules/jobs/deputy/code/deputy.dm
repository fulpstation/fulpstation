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

	outfit = /datum/outfit/job/brigdoc
	plasmaman_outfit = /datum/outfit/plasmaman/deputy

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SEC
	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC

//Default Deputy Clothes
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
			announce_latejoin(H, department, GLOB.security_officer_distribution)

	switch(department)
		if(SEC_DEPT_SUPPLY)
			if(isplasmaman(H))
				H.equipOutfit(/datum/outfit/plasmaman/deputy)
			if(isbeefman(H))
				H.equipOutfit(/datum/outfit/job/deputy/beefman)
			H.equipOutfit(/datum/outfit/job/deputy/supply)
		if(SEC_DEPT_ENGINEERING)
			if(isplasmaman(H))
				H.equipOutfit(/datum/outfit/plasmaman/deputy)
			if(isbeefman(H))
				H.equipOutfit(/datum/outfit/job/deputy/beefman)
			H.equipOutfit(/datum/outfit/job/deputy/engineering)
		if(SEC_DEPT_MEDICAL)
			if(isplasmaman(H))
				H.equipOutfit(/datum/outfit/plasmaman/deputy)
			if(isbeefman(H))
				H.equipOutfit(/datum/outfit/job/deputy/beefman)
			H.equipOutfit(/datum/outfit/job/deputy/medical)
		if(SEC_DEPT_SCIENCE)
			if(isplasmaman(H))
				H.equipOutfit(/datum/outfit/plasmaman/deputy)
			if(isbeefman(H))
				H.equipOutfit(/datum/outfit/job/deputy/beefman)
			H.equipOutfit(/datum/outfit/job/deputy/science)

	if(department)
		to_chat(M, "<b>You have been assigned to [department]!</b>")
	else
		to_chat(M, "<b>You have not been assigned to any department. Patrol the halls and help where needed.</b>")

/datum/job/fulp/deputy/proc/announce_latejoin(mob/officer, department, distribution)
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
		"message" = "Officer [officer.real_name] has been assigned to your department, [department].",
		"targets" = targets,
		"automated" = TRUE,
	))

	signal.send_to_receivers()
