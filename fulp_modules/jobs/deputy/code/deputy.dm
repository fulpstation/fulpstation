/datum/job/fulp/deputy
	title = "Deputy"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 4 //Kept in for posterity
	spawn_positions = 4 //ditto
	supervisors = "the head of security, and the head of your assigned department"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_SECURITY
	id_icon = 'fulp_modules/jobs/cards.dmi'
	hud_icon = 'fulp_modules/jobs/huds.dmi'
//	fulp_spawn = /obj/effect/landmark/start/deputy

	outfit = /datum/outfit/job/deputy

	access = list(ACCESS_SECURITY, ACCESS_BRIG, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_WEAPONS)
	minimal_access = list(ACCESS_SECURITY, ACCESS_BRIG, ACCESS_SEC_DOORS)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SEC
	mind_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC

//Default Deputy Clothes
/datum/outfit/job/deputy
	name = "Deputy"
	jobtype = /datum/job/fulp/deputy

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/mallcop
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/beret/sec
	suit = /obj/item/clothing/suit/armor/vest/alt
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/restraints/handcuffs/cable/zipties
	r_pocket = /obj/item/assembly/flash/handheld
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	backpack_contents = list(/obj/item/melee/baton/loaded=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

//Supply Deputy
/datum/outfit/job/deputy/supply
	name = "Supply Deputy"
	jobtype = /datum/job/fulp/deputy

	ears = /obj/item/radio/headset/headset_sec/department/supply
	head = /obj/item/clothing/head/fulpberet/sec/supply

	accessory = /obj/item/clothing/accessory/armband/cargo
	skillchips = list(/obj/item/skillchip/job/supply_deputy)

//Engineering Deputy
/datum/outfit/job/deputy/engineering
	name = "Engineering Deputy"
	jobtype = /datum/job/fulp/deputy

	ears = /obj/item/radio/headset/headset_sec/department/engi
	head = /obj/item/clothing/head/fulpberet/sec/engineering

	accessory = /obj/item/clothing/accessory/armband/engine
	skillchips = list(/obj/item/skillchip/job/engineering_deputy)

//Medical Deputy
/datum/outfit/job/deputy/medical
	name = "Medical Deputy"
	jobtype = /datum/job/fulp/deputy

	ears = /obj/item/radio/headset/headset_sec/department/med
	head = /obj/item/clothing/head/fulpberet/sec/medical

	accessory = /obj/item/clothing/accessory/armband/medblue
	skillchips = list(/obj/item/skillchip/job/medical_deputy)

//Science Deputy
/datum/outfit/job/deputy/science
	name = "Science Deputy"
	jobtype = /datum/job/fulp/deputy

	ears = /obj/item/radio/headset/headset_sec/department/sci
	head = /obj/item/clothing/head/fulpberet/sec/science

	accessory = /obj/item/clothing/accessory/armband/science
	skillchips = list(/obj/item/skillchip/job/science_deputy)

/datum/job/deputy/get_access()
	var/list/L = list()
	L |= ..()
	return L

GLOBAL_LIST_INIT(available_deputy_depts, sortList(list(SEC_DEPT_ENGINEERING, SEC_DEPT_MEDICAL, SEC_DEPT_SCIENCE, SEC_DEPT_SUPPLY)))

/datum/job/fulp/deputy/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	// Assign department
	var/department
	if(M && M.client && M.client.prefs)
		department = M.client.prefs.prefered_security_department
		if(!LAZYLEN(GLOB.available_deputy_depts))
			return
		else if(department in GLOB.available_deputy_depts)
			LAZYREMOVE(GLOB.available_deputy_depts, department)
		else
			department = pick_n_take(GLOB.available_deputy_depts)
	var/list/dep_access = null
	var/destination = null
	var/outfit = null
	var/spawn_point = null
	switch(department)
		if(SEC_DEPT_SUPPLY)
			dep_access = list(ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE)
			destination = /area/security/checkpoint/supply
			outfit = /datum/outfit/job/deputy/supply
			spawn_point = get_fulp_spawn(destination)
		if(SEC_DEPT_ENGINEERING)
			dep_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CONSTRUCTION, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
			destination = /area/security/checkpoint/engineering
			outfit = /datum/outfit/job/deputy/engineering
			spawn_point = get_fulp_spawn(destination)
		if(SEC_DEPT_MEDICAL)
			dep_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_MORGUE, ACCESS_VIROLOGY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_SURGERY, ACCESS_MECH_MEDICAL)
			destination = /area/security/checkpoint/medical
			outfit = /datum/outfit/job/deputy/medical
			spawn_point = get_fulp_spawn(destination)
		if(SEC_DEPT_SCIENCE)
			dep_access = list(ACCESS_RND, ACCESS_GENETICS, ACCESS_TOXINS, ACCESS_MECH_SCIENCE, ACCESS_RESEARCH, ACCESS_ROBOTICS, ACCESS_XENOBIOLOGY, ACCESS_MINERAL_STOREROOM, ACCESS_TOXINS_STORAGE)
			destination = /area/security/checkpoint/science
			outfit = /datum/outfit/job/deputy/science
			spawn_point = get_fulp_spawn(destination)

	if(outfit)
		if("/datum/outfit/job/deputy/supply")
			S.equipOutfit(outfit)
		if("/datum/outfit/job/deputy/engineering")
			S.equipOutfit(outfit)
		if("/datum/outfit/job/deputy/medical")
			S.equipOutfit(outfit)
		if("/datum/outfit/job/deputy/science")
			S.equipOutfit(outfit)
	if(destination)
		var/turf/T
		if(spawn_point)
			T = get_turf(spawn_point)
			H.Move(T)
		else
			var/list/possible_turfs = get_area_turfs(destination)
			while (length(possible_turfs))
				var/I = rand(1, possible_turfs.len)
				var/turf/target = possible_turfs[I]
				if (H.Move(target))
					break
				possible_turfs.Cut(I,I+1)
	if(department)
		to_chat(M, "<b>You have been assigned to [department]!</b>")
	else
		to_chat(M, "<b>You have not been assigned to any department. Please report this to a coder.</b>")

	var/obj/item/card/id/W = H.wear_id
	W.access |= dep_access
	W.access |= dep_access
	W.update_icon()
