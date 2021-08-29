/datum/job/botanist
	title = "Botanist"
	department_head = list("Head of Personnel")
	faction = FACTION_STATION
	total_positions = 3
	spawn_positions = 2
	supervisors = "the head of personnel"
	selection_color = "#bbe291"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/botanist
	plasmaman_outfit = /datum/outfit/plasmaman/botany

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_BOTANIST
	bounty_types = CIV_JOB_GROW
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/cultivator, /obj/item/reagent_containers/glass/bucket, /obj/item/toy/plush/beeplushie)

	mail_goodies = list(
		/obj/item/reagent_containers/glass/bottle/mutagen = 20,
		/obj/item/reagent_containers/glass/bottle/saltpetre = 20,
		/obj/item/reagent_containers/glass/bottle/diethylamine = 20,
		/obj/item/gun/energy/floragun = 10,
		/obj/effect/spawner/lootdrop/space/rareseed = 5,// These are strong, rare seeds, so use sparingly.
		/obj/item/food/monkeycube/bee = 2
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS


/datum/outfit/job/botanist
	name = "Botanist"
	jobtype = /datum/job/botanist

	belt = /obj/item/pda/botanist
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/hydroponics
	suit = /obj/item/clothing/suit/apron
	gloves  =/obj/item/clothing/gloves/botanic_leather
	suit_store = /obj/item/plant_analyzer

	backpack = /obj/item/storage/backpack/botany
	satchel = /obj/item/storage/backpack/satchel/hyd
	duffelbag = /obj/item/storage/backpack/duffelbag/hydroponics

	id_trim = /datum/id_trim/job/botanist
