/datum/job/atmospheric_technician
	title = "Atmospheric Technician"
	department_head = list("Chief Engineer")
	faction = FACTION_STATION
	total_positions = 3
	spawn_positions = 2
	supervisors = "the chief engineer"
	selection_color = "#fff5cc"
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/atmos
	plasmaman_outfit = /datum/outfit/plasmaman/atmospherics

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_ENG

	liver_traits = list(TRAIT_ENGINEER_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_ATMOSPHERIC_TECHNICIAN
	bounty_types = CIV_JOB_ENG
	departments_list = list(
		/datum/job_department/engineering,
		)

	family_heirlooms = list(/obj/item/lighter, /obj/item/lighter/greyscale, /obj/item/storage/box/matches)

	mail_goodies = list(
		/obj/item/rpd_upgrade/unwrench = 30,
		/obj/item/grenade/gas_crystal/crystal_foam = 10,
		/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 10,
		/obj/item/grenade/gas_crystal/healium_crystal = 10,
		/obj/item/grenade/gas_crystal/nitrous_oxide_crystal = 5,
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS
	rpg_title = "Aeromancer"

/datum/outfit/job/atmos
	name = "Atmospheric Technician"
	jobtype = /datum/job/atmospheric_technician

	id_trim = /datum/id_trim/job/atmospheric_technician
	uniform = /obj/item/clothing/under/rank/engineering/atmospheric_technician
	backpack_contents = list(
		/obj/item/modular_computer/tablet/preset/advanced/atmos = 1,
		)
	belt = /obj/item/storage/belt/utility/atmostech
	ears = /obj/item/radio/headset/headset_eng
	l_pocket = /obj/item/pda/atmos
	r_pocket = /obj/item/analyzer

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering

	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET

/datum/outfit/job/atmos/rig
	name = "Atmospheric Technician (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/atmos
	suit_store = /obj/item/tank/internals/oxygen
	mask = /obj/item/clothing/mask/gas/atmos
	internals_slot = ITEM_SLOT_SUITSTORE
