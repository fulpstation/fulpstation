
/datum/antagonist/ert/safety_moth/greet()

	to_chat(owner, "<B><font size=3 color=green>You are the [name].</font></B>")
	to_chat(owner, "You are being sent on a mission to [station_name()] by Nanotrasen's Operational Safety Department. Ensure the crew is following all proper safety protocols. Board the shuttle when your team is ready.")


/datum/antagonist/ert/safety_moth/proc/equip_official()
	var/mob/living/carbon/human/H = owner.current
	if(!istype(H))
		return
	H.set_species(/datum/species/moth)


/datum/outfit/centcom/ert/engineer/safety_moth
	name = "Safety Moth Engineer"
	suit = /obj/item/clothing/suit/space/eva/safety_moth
	suit_store = /obj/item/tank/internals/oxygen
	mask = /obj/item/clothing/mask/breath
	r_pocket = /obj/item/toy/plush/moth
	r_hand = /obj/item/clipboard
	head = /obj/item/clothing/head/helmet/space/eva/
	gloves = /obj/item/clothing/gloves/color/yellow
	shoes = /obj/item/clothing/shoes/magboots


	internals_slot = ITEM_SLOT_SUITSTORE

/obj/item/clothing/suit/space/eva/safety_moth
	name = "Safety Moth safety vest"
	desc = "The standard issue safety vest of the Safety Moth. Functions like a hardsuit and offers superb protection against environmental hazards."
	icon_state = "hazard"
	inhand_icon_state = "hazard"
	flags_inv = null
	armor = list(MELEE = 65, BULLET = 50, LASER = 50, ENERGY = 60, BOMB = 50, BIO = 100, RAD = 100, FIRE = 80, ACID = 80)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	slowdown = 0
	
