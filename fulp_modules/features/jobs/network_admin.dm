/datum/job/signal_technician
	title = JOB_NETWORK_ADMIN
	description = "Maintain and repair Telecommunications and run scripts in your offtime."
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_CE
	minimal_player_age = 7
	exp_requirements = 600 // Same as the CE hours, 10. This is because telecomms are unironically harder than most head roles and very important.
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_ENGINEERING
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "SIGNAL_TECH"

	outfit = /datum/outfit/job/signal_tech
	plasmaman_outfit = /datum/outfit/plasmaman/signal_tech

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_ENG

	liver_traits = list(TRAIT_ENGINEER_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_CHIEF_ENGINEER + 0.5 //go under the CE directly
	bounty_types = CIV_JOB_ENG

	departments_list = list(
		/datum/job_department/engineering,
	)

	family_heirlooms = list(
		/obj/item/clothing/head/utility/hardhat,
		/obj/item/screwdriver,
		/obj/item/wrench,
		/obj/item/weldingtool,
		/obj/item/crowbar,
		/obj/item/wirecutters,
	)

	mail_goodies = list(
		/obj/item/storage/box/lights/mixed = 20,
		/obj/item/lightreplacer = 10,
		/obj/item/holosign_creator/engineering = 8,
		/obj/item/wrench/bolter = 8,
		/obj/item/clothing/head/utility/hardhat/red/upgraded = 1
	)
	rpg_title = "Telecommunications Goblin"
	job_flags = STATION_JOB_FLAGS

/obj/effect/landmark/start/network_admin
	name = JOB_NETWORK_ADMIN
	icon_state = JOB_NETWORK_ADMIN
	icon = 'fulp_modules/icons/jobs/landmarks.dmi'

/datum/outfit/job/signal_tech
	name = JOB_NETWORK_ADMIN
	jobtype = /datum/job/signal_technician

	id_trim = /datum/id_trim/job/signal_technician

	uniform = /obj/item/clothing/under/rank/engineering/signal_tech
	suit = /obj/item/clothing/suit/hooded/wintercoat/engineering/signal_tech
	belt = /obj/item/storage/belt/utility/full/engi
	ears = /obj/item/radio/headset/headset_network
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/workboots

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering

	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	//If PDA_PAINTING_REGIONS don't exist no more then add modular /obj/item/modular_computer/pda/signal :thumbsup:
	l_pocket = /obj/item/modular_computer/pda/engineering

	skillchips = list(/obj/item/skillchip/job/engineer)

/datum/outfit/plasmaman/signal_tech
	name = JOB_NETWORK_ADMIN + " Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/engineering/signal_tech
	gloves = /obj/item/clothing/gloves/color/plasmaman/engineer
	head = /obj/item/clothing/head/helmet/space/plasmaman/engineering/signal_tech

/datum/id_trim/job/signal_technician
	assignment = JOB_NETWORK_ADMIN
	intern_alt_name = "Junior Network Admin"
	trim_icon = 'fulp_modules/icons/jobs/cards.dmi'
	trim_state = "trim_signaltech"
	department_color = COLOR_ENGINEERING_ORANGE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_SIGNAL_TECHNICAN
	minimal_access = list(
		ACCESS_AUX_BASE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_ENGINE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINISAT,
		ACCESS_NETWORK,
		ACCESS_TCOMMS,
		ACCESS_TCOMMS_ADMIN,
		ACCESS_TECH_STORAGE,
		ACCESS_RC_ANNOUNCE,
	)
	extra_access = list(
		ACCESS_ATMOSPHERICS,
	)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_CE,
	)
	job = /datum/job/signal_technician
