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
	fulp_spawn = /obj/effect/landmark/start/deputy

	outfit = /datum/outfit/job/deputy

	access = list(ACCESS_SECURITY, ACCESS_BRIG, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_WEAPONS)
	minimal_access = list(ACCESS_SECURITY, ACCESS_BRIG, ACCESS_SEC_DOORS)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SEC
	mind_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC

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
	var/ears = null
	var/head = null
	var/accessory = null
	var/list/dep_access = null
	var/destination = null
	var/spawn_point = null
	var/skillchips = null
	switch(department)
		if(SEC_DEPT_SUPPLY)
			ears = /obj/item/radio/headset/headset_sec/department/supply
			head = /obj/item/clothing/head/fulpberet/sec/supply
			dep_access = list(ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE)
			destination = /area/security/checkpoint/supply
			spawn_point = get_fulp_spawn(destination)
			accessory = /obj/item/clothing/accessory/armband/cargo
			skillchips = list(/obj/item/skillchip/job/supply_deputy)
		if(SEC_DEPT_ENGINEERING)
			ears = /obj/item/radio/headset/headset_sec/department/engi
			head = /obj/item/clothing/head/fulpberet/sec/engineering
			dep_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CONSTRUCTION, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
			destination = /area/security/checkpoint/engineering
			spawn_point = get_fulp_spawn(destination)
			accessory = /obj/item/clothing/accessory/armband/engine
			skillchips = list(/obj/item/skillchip/job/engineering_deputy)
		if(SEC_DEPT_MEDICAL)
			ears = /obj/item/radio/headset/headset_sec/department/med
			head = /obj/item/clothing/head/fulpberet/sec/medical
			dep_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_MORGUE, ACCESS_VIROLOGY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_SURGERY, ACCESS_MECH_MEDICAL)
			destination = /area/security/checkpoint/medical
			spawn_point = get_fulp_spawn(destination)
			accessory =  /obj/item/clothing/accessory/armband/medblue
			skillchips = list(/obj/item/skillchip/job/medical_deputy)
		if(SEC_DEPT_SCIENCE)
			ears = /obj/item/radio/headset/headset_sec/department/sci
			head = /obj/item/clothing/head/fulpberet/sec/science
			dep_access = list(ACCESS_RND, ACCESS_GENETICS, ACCESS_TOXINS, ACCESS_MECH_SCIENCE, ACCESS_RESEARCH, ACCESS_ROBOTICS, ACCESS_XENOBIOLOGY, ACCESS_MINERAL_STOREROOM, ACCESS_TOXINS_STORAGE)
			destination = /area/security/checkpoint/science
			spawn_point = get_fulp_spawn(destination)
			accessory = /obj/item/clothing/accessory/armband/science
			skillchips = list(/obj/item/skillchip/job/science_deputy)

	if(skillchips)
		var/obj/item/skillchip/skillchip_instance = new skillchip_path()
		var/implant_msg = H.implant_skillchip(skillchip_instance)
		if(implant_msg)
			stack_trace("Failed to implant [H] with [skillchip_instance], on job [src]. Failure message: [implant_msg]")
			qdel(skillchip_instance)
			return
		var/activate_msg = skillchip_instance.try_activate_skillchip(TRUE, TRUE)
		if(activate_msg)
			stack_trace("Failed to activate [H]'s [skillchip_instance], on job [src]. Failure message: [activate_msg]")
//	if(skillchips) // Backup from testing, just to see what works best
//		var/obj/item/skillchip/skillchip = new skillchip(user)
	if(accessory)
		var/obj/item/clothing/under/U = H.w_uniform
		U.attach_accessory(new accessory)
	if(ears)
		if(H.ears)
			qdel(H.ears)
		H.equip_to_slot_or_del(new ears(H),ITEM_SLOT_EARS, TRUE)
	if(head)
		if(H.head)
			qdel(H.head)
		H.equip_to_slot_or_del(new head(H),ITEM_SLOT_HEAD, TRUE)

	var/obj/item/card/id/W = H.wear_id
	W.access |= dep_access
	W.access |= dep_access
	W.update_icon()

	var/teleport = 0
	if(!CONFIG_GET(flag/sec_start_brig))
		if(destination || spawn_point)
			teleport = 1
	if(teleport)
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

/obj/item/radio/headset/headset_sec/department/Initialize()
	. = ..()
	wires = new/datum/wires/radio(src)
	secure_radio_connections = new
	recalculateChannels()

/datum/outfit/plasmaman/deputy
	name = "Plasmaman Deputy"

	head = /obj/item/clothing/head/helmet/space/plasmaman/security
	uniform = /obj/item/clothing/under/plasmaman/security
	gloves = /obj/item/clothing/gloves/color/plasmaman/black
