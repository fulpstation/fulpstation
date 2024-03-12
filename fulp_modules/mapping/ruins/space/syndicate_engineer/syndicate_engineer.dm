/datum/map_template/ruin/space/fulp/prototype
	name = "Prototype Station"
	id = "prototype"
	description = "Apparently one of the first stations built by Nanotrasen. Slated for reclaimation by the Syndicate."
	suffix = "syndicate_engineer.dmm"

/obj/effect/mob_spawn/ghost_role/human/syndicate_engineer
	name = "Syndicate Engineer Corps"
	desc = "A cryogenics pod, storing someone to be awakened later. Best to leave it alone."
	prompt_name = "Syndicate engineer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	you_are_text = "You are a Syndicate Engineer, tasked by your superiors to repair a derelict station."
	flavour_text = "You must ensure that the station can support human life. You're pretty sure nobody will disturb you here, yet you can't shake the feeling this job will be like no other."
	important_text = "Leaving the station is forbidden."
	spawner_job_path = /datum/job/syndicate_engineer
	outfit = /datum/outfit/syndicate_engineer

/obj/effect/mob_spawn/ghost_role/human/syndicate_engineer/special(mob/living/new_spawn)
	. = ..()
	to_chat(new_spawn, "<b>You have been implanted with a bomb that will detonate if you stray too far from the station. Glory to the Syndicate.</b>")
	new_spawn.AddComponent(/datum/component/stationstuck, PUNISHMENT_GIB, "You have left the vicinity of the Prototype Station. Your bomb implant has been triggered.")

/obj/effect/mob_spawn/ghost_role/human/syndicate_engineer/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	return ..()

/datum/job/syndicate_engineer
	title = ROLE_SYNDICATE_ENGINEER

/datum/outfit/syndicate_engineer
	name = "Syndicate Engineer"
	head = /obj/item/clothing/head/helmet/space/syndicate/black/engie
	mask = /obj/item/clothing/mask/breath
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/syndicate/black/engie
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/utility/chief/full
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	internals_slot = ITEM_SLOT_DEX_STORAGE // SLOT_R_STORE
	id = /obj/item/card/id/advanced/chameleon
	implants = list(/obj/item/implant/weapons_auth)
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/tank/jetpack/oxygen/harness=1,\
		/obj/item/gun/ballistic/automatic/pistol)

/datum/outfit/syndicate_engineer/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE

// We're giving them a special solar panel crate because the budget one doesn't have enough panels-- and I don't want to place 20 crates.

/obj/structure/closet/crate/solarpanel_medium
	name = "solar panel crate"
	icon_state = "engi_e_crate"
	base_icon_state = "engi_e_crate"

/obj/structure/closet/crate/solarpanel_medium/PopulateContents()
	..()
	for(var/i in 1 to 26)
		new /obj/item/solar_assembly(src)
	new /obj/item/electronics/tracker(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/circuitboard/computer/solar_control(src)
	new /obj/item/paper/guides/jobs/engi/solars(src)
