/datum/job/fulp/brigdoc
	title = "Brig Physician"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security", "Chief Medical Officer")
	faction = "Station"
	total_positions = 2
	spawn_positions = 1
	supervisors = "the head of security and the chief medical officer"
	selection_color = "#ffeef0"
	minimal_player_age = 14
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_SECURITY
	id_icon = 'fulp_modules/jobs/cards.dmi'
	hud_icon = 'fulp_modules/jobs/huds.dmi'
	fulp_spawn = /obj/effect/landmark/start/brigdoc

	outfit = /datum/outfit/job/brigdoc
	plasmaman_outfit = /datum/outfit/plasmaman/brigdoc

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SEC
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)
	family_heirlooms = list(/obj/item/storage/firstaid/ancient/heirloom)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC

/datum/outfit/job/brigdoc
	name = "Brig Physician"
	jobtype = /datum/job/fulp/brigdoc

	belt = /obj/item/storage/belt/medical/surgeryfilled
	ears = /obj/item/radio/headset/headset_sec/alt/department/med
	uniform = /obj/item/clothing/under/rank/medical/brigdoc
	shoes = /obj/item/clothing/shoes/jackboots
	suit =  /obj/item/clothing/suit/toggle/labcoat/armored
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	head = /obj/item/clothing/head/beret/sec/medical
	l_hand = /obj/item/storage/firstaid/regular
	l_pocket = /obj/item/pda/medical
	r_pocket = /obj/item/flashlight/pen
	suit_store = /obj/item/melee/baton/loaded
	backpack_contents = list(/obj/item/storage/pill_bottle/paxpsych=1, /obj/item/reagent_containers/glass/bottle/formaldehyde=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/survival/medical

	implants = list(/obj/item/implant/mindshield)
	skillchips = list(/obj/item/skillchip/entrails_reader, /obj/item/skillchip/quickercarry)

	id_trim = /datum/id_trim/job/brig_physician

/datum/outfit/plasmaman/brigdoc
	name = "Plasmaman Brig Physician"

	head = /obj/item/clothing/head/helmet/space/plasmaman/brigdoc
	uniform = /obj/item/clothing/under/plasmaman/brigdoc
	gloves = /obj/item/clothing/gloves/color/plasmaman/white

/datum/id_trim/job/brig_physician
	assignment = "Brig Physician"
	trim_icon = 'fulp_modules/jobs/cards.dmi'
	trim_state = "trim_brigphysician"
	full_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_WEAPONS)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_WEAPONS)
	config_job = "brig_physician"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)
