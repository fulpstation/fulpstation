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

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SEC
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_MED

/datum/outfit/job/brigdoc
	name = "Brig Physician"
	jobtype = /datum/job/fulp/brigdoc

	belt = /obj/item/defibrillator/compact/loaded
	ears = /obj/item/radio/headset/headset_sec/alt/department/med
	uniform = /obj/item/clothing/under/rank/medical/brigdoc
	shoes = /obj/item/clothing/shoes/jackboots
	suit =  /obj/item/clothing/suit/toggle/labcoat/armored
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	head = /obj/item/clothing/head/beret/sec/medical
	l_hand = /obj/item/storage/firstaid/medical/brigdoc
	l_pocket = /obj/item/pda/medical
	r_pocket = /obj/item/assembly/flash
	suit_store = /obj/item/flashlight/pen

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/survival/medical

	backpack_contents = list(/obj/item/storage/pill_bottle/paxpsych = 1)

	implants = list(/obj/item/implant/mindshield)
	skillchips = list(/obj/item/skillchip/entrails_reader)

/datum/outfit/plasmaman/brigdoc
	name = "Brig Physician Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/brigdoc
	uniform = /obj/item/clothing/under/plasmaman/brigdoc
	gloves = /obj/item/clothing/gloves/color/plasmaman/white
