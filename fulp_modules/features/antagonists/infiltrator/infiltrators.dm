/datum/antagonist/traitor/infiltrator
	name = "Infiltrator"
	antagpanel_category = "Infiltrator"
	job_rank = ROLE_INFILTRATOR
	antag_hud_name = "traitor"
	hijack_speed = 1
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	antag_moodlet = /datum/mood_event/focused
	preview_outfit = /datum/outfit/infiltrator
	var/give_equipment = TRUE

/datum/job/infiltrator
	title = ROLE_INFILTRATOR

/datum/antagonist/traitor/infiltrator/proc/equip_infiltrator(mob/living/carbon/human/infiltrator = owner.current)
	return infiltrator.equipOutfit(/datum/outfit/infiltrator)

/datum/antagonist/traitor/infiltrator/on_gain()
	..()
	if(give_equipment)
		equip_infiltrator(owner.current)
	owner.current.mind.set_assigned_role(SSjob.GetJobType(/datum/job/infiltrator))
	owner.current.mind.special_role = ROLE_INFILTRATOR
	traitor_flavor = strings("infiltrator_flavor.json", "infiltrator", "fulp_modules/strings/infils")

/datum/outfit/infiltrator
	name = "Infiltrator"
	uniform = /obj/item/clothing/under/chameleon
	suit = /obj/item/clothing/suit/space/syndicate
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	head = /obj/item/clothing/head/helmet/space/syndicate
	ears = /obj/item/radio/headset
	back = /obj/item/storage/backpack/old
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/knife/combat/survival = 1,
	)
	r_hand = /obj/item/card/id/advanced/chameleon
	l_hand = /obj/item/tank/jetpack
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/combat
	r_pocket = /obj/item/tank/internals/emergency_oxygen
	internals_slot = ITEM_SLOT_RPOCKET
	belt = /obj/item/crowbar/power/syndicate
	implants = list(/obj/item/implant/explosive)

