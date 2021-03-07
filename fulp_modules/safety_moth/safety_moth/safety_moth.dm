/datum/ert/safety_moth
	mobtype = /mob/living/carbon/human/species/moth
	leader_role = /datum/antagonist/ert/safety_moth
	enforce_human = FALSE
	roles = /datum/antagonist/ert/safety_moth
	mission = "Ensure that proper safety protocols are being followed by the crew."
	teamsize = 1
	polldesc = "an experienced Nanotrasen engineering expert"
	opendoors = FALSE


/datum/antagonist/ert/safety_moth
	name = "Safety Moth"
	outfit = /datum/outfit/centcom/ert/engineer/safety_moth
	role = "Safety Moth"

/datum/antagonist/ert/safety_moth/on_gain()
	forge_objectives()
	. = ..()

	equip_official()
	ADD_TRAIT(owner.current, TRAIT_PACIFISM, JOB_TRAIT)

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
	head = /obj/item/clothing/head/helmet/space/eva/safety_moth
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

/obj/item/clothing/head/helmet/space/eva/safety_moth
	name = "Safety Moth safety hardhat"
	desc = "The standard issue safety hardhat of the Safety Moth. Functions like a hardsuit helmet and offers superb protection against environmental hazards."
	icon_state = "hardhat0_yellow"
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 65, BULLET = 50, LASER = 50, ENERGY = 60, BOMB = 50, BIO = 100, RAD = 100, FIRE = 80, ACID = 80)
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/magboots/safety_moth
	desc = "Magnetic boots, often used during extravehicular activity to ensure the user remains safely attached to the vehicle."
	name = "magboots"
	slowdown_active = 1


/obj/item/clothing/head/helmet/space/eva/safety_moth/equipped(mob/M, slot)
	. = ..()
	if (slot == ITEM_SLOT_HEAD)
		RegisterSignal(M, COMSIG_MOB_SAY, .proc/handle_speech)
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)


/obj/item/clothing/head/helmet/space/eva/safety_moth/proc/handle_speech(datum/source, mob/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = " [message]"
		var/list/clean = strings("clean_replacement.json", "clean")

		for(var/key in clean)
			var/value = clean[key]
			if(islist(value))
				value = pick(value)

			message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
			message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
			message = replacetextEx(message, " [key]", " [value]")

	speech_args[SPEECH_MESSAGE] = trim(message)
