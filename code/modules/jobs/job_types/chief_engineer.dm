/datum/job/chief_engineer
	title = "Chief Engineer"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("Captain")
	head_announce = list("Engineering")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ffeeaa"
	req_admin_notify = 1
	minimal_player_age = 7
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_ENGINEERING
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/ce
	plasmaman_outfit = /datum/outfit/plasmaman/chief_engineer
	departments_list = list(
		/datum/job_department/engineering,
		/datum/job_department/command,
		)

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_ENG

	liver_traits = list(TRAIT_ENGINEER_METABOLISM, TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_CHIEF_ENGINEER
	bounty_types = CIV_JOB_ENG

	family_heirlooms = list(/obj/item/clothing/head/hardhat/white, /obj/item/screwdriver, /obj/item/wrench, /obj/item/weldingtool, /obj/item/crowbar, /obj/item/wirecutters)

	mail_goodies = list(
		/obj/item/food/cracker = 25, //you know. for poly
		/obj/item/stack/sheet/mineral/diamond = 15,
		/obj/item/stack/sheet/mineral/uranium/five = 15,
		/obj/item/stack/sheet/mineral/plasma/five = 15,
		/obj/item/stack/sheet/mineral/gold = 15,
		/obj/effect/spawner/lootdrop/space/fancytool/engineonly = 3
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

	voice_of_god_power = 1.4 //Command staff has authority


/datum/job/chief_engineer/get_captaincy_announcement(mob/living/captain)
	return "Due to staffing shortages, newly promoted Acting Captain [captain.real_name] on deck!"


/datum/outfit/job/ce
	name = "Chief Engineer"
	jobtype = /datum/job/chief_engineer

	id = /obj/item/card/id/advanced/silver
	belt = /obj/item/storage/belt/utility/chief/full
	l_pocket = /obj/item/pda/heads/ce
	ears = /obj/item/radio/headset/heads/ce
	uniform = /obj/item/clothing/under/rank/engineering/chief_engineer
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hardhat/white
	gloves = /obj/item/clothing/gloves/color/black
	backpack_contents = list(/obj/item/melee/baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced/command/engineering=1)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	chameleon_extras = /obj/item/stamp/ce

	skillchips = list(/obj/item/skillchip/job/engineer)

	id_trim = /datum/id_trim/job/chief_engineer

/datum/outfit/job/ce/rig
	name = "Chief Engineer (Hardsuit)"

	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/hardsuit/engine/elite
	shoes = /obj/item/clothing/shoes/magboots/advance
	suit_store = /obj/item/tank/internals/oxygen
	glasses = /obj/item/clothing/glasses/meson/engine
	gloves = /obj/item/clothing/gloves/color/yellow
	head = null
	internals_slot = ITEM_SLOT_SUITSTORE
