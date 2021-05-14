/datum/job/fulp/deputy
	title = "Deputy"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security") /// Sadly.
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the head of your assigned department, and the head of security, but only on red alert"
	selection_color = "#ffeeee"
	minimal_player_age = 14
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_SECURITY

	outfit = /datum/outfit/job/deputy
	plasmaman_outfit = /datum/outfit/plasmaman/deputy

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_MED
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

/// Default Deputy trim, this should never be used in game.
/datum/id_trim/job/deputy
	assignment = "Deputy"
	trim_icon = 'fulp_modules/main_features/jobs/cards.dmi'
	trim_state = "trim_deputy"
	full_access = list(ACCESS_FORENSICS_LOCKERS, ACCESS_SEC_DOORS, ACCESS_SECURITY, ACCESS_BRIG, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_FORENSICS_LOCKERS, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_MINERAL_STOREROOM)
	config_job = "deputy"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS) // I don't like giving the HoS this, but it makes sense to "deputize" people.
	/// Used to give the Departmental access
	var/department_access = list()

/datum/id_trim/job/deputy/refresh_trim_access()
	. = ..()
	if(!.)
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
	assignment = "Deputy (Cargo)"
	trim_state = "trim_deputysupply"
	department_access = list(ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE, ACCESS_QM)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)

/datum/id_trim/job/deputy/service
	assignment = "Deputy (Service)"
	trim_state = "trim_deputyservice"
	department_access = list(ACCESS_PSYCHOLOGY, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_HYDROPONICS, ACCESS_LAWYER, ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)

GLOBAL_LIST_INIT(available_deputy_depts, sortList(list(SEC_DEPT_ENGINEERING, SEC_DEPT_MEDICAL, SEC_DEPT_SCIENCE, SEC_DEPT_SUPPLY, SEC_DEPT_SERVICE)))

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
	var/destination = null
	var/spawn_point = pick(LAZYACCESS(GLOB.department_security_spawns, department))
	switch(department)
		if(SEC_DEPT_ENGINEERING)
			H.equipOutfit(/datum/outfit/job/deputy/engineering)
			ears = /obj/item/radio/headset/headset_dep
			destination = /area/security/checkpoint/engineering
			announce_engineering(H, department)
		if(SEC_DEPT_MEDICAL)
			H.equipOutfit(/datum/outfit/job/deputy/medical)
			ears = /obj/item/radio/headset/headset_dep/med
			destination = /area/security/checkpoint/medical
			announce_medical(H, department)
		if(SEC_DEPT_SCIENCE)
			H.equipOutfit(/datum/outfit/job/deputy/science)
			ears = /obj/item/radio/headset/headset_dep/sci
			destination = /area/security/checkpoint/science
			announce_science(H, department)
		if(SEC_DEPT_SUPPLY)
			H.equipOutfit(/datum/outfit/job/deputy/supply)
			ears = /obj/item/radio/headset/headset_dep/supply
			destination = /area/security/checkpoint/supply
			announce_supply(H, department)
		if(SEC_DEPT_SERVICE)
			H.equipOutfit(/datum/outfit/job/deputy/service)
			ears = /obj/item/radio/headset/headset_dep/service
			destination = null
			announce_service(H, department)
	if(ears)
		if(H.ears)
			qdel(H.ears)
		H.equip_to_slot_or_del(new ears(H), ITEM_SLOT_EARS)
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
		to_chat(M, "<b>You have not been assigned to any department. Patrol the halls and help where needed.</b>")

/// Engineering
/datum/job/fulp/deputy/proc/announce_engineering(mob/deputy, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_engineering(deputy, department)

/obj/machinery/announcement_system/proc/announce_engineering(mob/deputy, department)
	if(!is_operational)
		return
	broadcast("[deputy.real_name] is the [department] departmental Deputy.", list(RADIO_CHANNEL_ENGINEERING))

/// Medical
/datum/job/fulp/deputy/proc/announce_medical(mob/deputy, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_medical(deputy, department)

/obj/machinery/announcement_system/proc/announce_medical(mob/deputy, department)
	if(!is_operational)
		return
	broadcast("[deputy.real_name] is the [department] departmental Deputy.", list(RADIO_CHANNEL_MEDICAL))

/// Science
/datum/job/fulp/deputy/proc/announce_science(mob/deputy, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_science(deputy, department)

/obj/machinery/announcement_system/proc/announce_science(mob/deputy, department)
	if(!is_operational)
		return
	broadcast("[deputy.real_name] is the [department] departmental Deputy.", list(RADIO_CHANNEL_SCIENCE))

/// Supply
/datum/job/fulp/deputy/proc/announce_supply(mob/deputy, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_supply(deputy, department)

/obj/machinery/announcement_system/proc/announce_supply(mob/deputy, department)
	if(!is_operational)
		return
	broadcast("[deputy.real_name] is the [department] departmental Deputy.", list(RADIO_CHANNEL_SUPPLY))

/// Service
/datum/job/fulp/deputy/proc/announce_service(mob/deputy, department)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if(isnull(announcement_system))
		return
	announcement_system.announce_service(deputy, department)

/obj/machinery/announcement_system/proc/announce_service(mob/deputy, department)
	if(!is_operational)
		return
	broadcast("[deputy.real_name] is the [department] departmental Deputy.", list(RADIO_CHANNEL_SERVICE))

/// Used for Science Deputies and Brig doctor's Chemical kit.
/obj/item/reagent_containers/hypospray/medipen/mutadone
	name = "mutadone medipen"
	desc = "Contains a chemical that will remove all of an injected target's mutations."
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	volume = 10
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/medicine/mutadone = 10)
