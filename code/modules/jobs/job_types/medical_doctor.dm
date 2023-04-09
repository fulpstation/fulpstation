/datum/job/doctor
	title = JOB_MEDICAL_DOCTOR
	description = "Save lives, run around the station looking for victims, \
		scan everyone in sight"
	department_head = list(JOB_CHIEF_MEDICAL_OFFICER)
	faction = FACTION_STATION
	total_positions = 5
	spawn_positions = 3
	supervisors = SUPERVISOR_CMO
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "MEDICAL_DOCTOR"

	outfit = /datum/outfit/job/doctor
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_MED

	liver_traits = list(TRAIT_MEDICAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_MEDICAL_DOCTOR
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/medical,
		)

	family_heirlooms = list(/obj/item/storage/medkit/ancient/heirloom, /obj/item/scalpel, /obj/item/hemostat, /obj/item/circular_saw, /obj/item/retractor, /obj/item/cautery)

	mail_goodies = list(
		/obj/item/healthanalyzer/advanced = 15,
		/obj/item/scalpel/advanced = 6,
		/obj/item/retractor/advanced = 6,
		/obj/item/cautery/advanced = 6,
		/obj/item/reagent_containers/cup/bottle/formaldehyde = 6,
		/obj/effect/spawner/random/medical/organs = 5,
		/obj/effect/spawner/random/medical/memeorgans = 1
	)
	rpg_title = "Cleric"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN


/datum/outfit/job/doctor
	name = "Medical Doctor"
	jobtype = /datum/job/doctor

	id_trim = /datum/id_trim/job/medical_doctor
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	suit = /obj/item/clothing/suit/toggle/labcoat
	suit_store = /obj/item/flashlight/pen
	belt = /obj/item/modular_computer/pda/medical
	ears = /obj/item/radio/headset/headset_med
	head = /obj/item/clothing/head/utility/surgerycap
	shoes = /obj/item/clothing/shoes/sneakers/white
	l_hand = /obj/item/storage/medkit/surgery

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med

	box = /obj/item/storage/box/survival/medical
	chameleon_extras = /obj/item/gun/syringe
	skillchips = list(/obj/item/skillchip/entrails_reader)

/datum/outfit/job/doctor/mod
	name = "Medical Doctor (MODsuit)"

	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/mod/control/pre_equipped/medical
	suit = null
	head = null
	uniform = /obj/item/clothing/under/rank/medical/doctor
	mask = /obj/item/clothing/mask/breath/medical
	r_pocket = /obj/item/flashlight/pen
	internals_slot = ITEM_SLOT_SUITSTORE
