/// ERT Datum - Default is Engineering
/datum/ert/safety_moth
	mobtype = /mob/living/carbon/human/species/moth
	leader_role = /datum/antagonist/ert/safety_moth
	enforce_human = FALSE
	roles = list(/datum/antagonist/ert/safety_moth)
	mission = "Ensure that proper safety protocols are being followed by the crew."
	teamsize = 1
	polldesc = "an experienced Engineering Safety team"
	opendoors = FALSE

/datum/ert/safety_moth/medical
	leader_role = /datum/antagonist/ert/safety_moth/medical
	roles = list(/datum/antagonist/ert/safety_moth/medical)
	polldesc = "an experienced Medical Safety team"

/datum/ert/safety_moth/security
	leader_role = /datum/antagonist/ert/safety_moth/security
	roles = list(/datum/antagonist/ert/safety_moth/security)
	polldesc = "an experienced Security Safety team"

/// Antagonist status
/datum/antagonist/ert/safety_moth
	name = "Engineering Safety Moth"
	role = "Engineering Safety Moth"
	outfit = /datum/outfit/centcom/ert/safety_moth

/datum/antagonist/ert/safety_moth/medical
	name = "Medical Safety Moth"
	role = "Medical Safety Moth"
	outfit = /datum/outfit/centcom/ert/safety_moth/medical

/datum/antagonist/ert/safety_moth/security
	name = "Security Safety Moth"
	role = "Security Safety Moth"
	outfit = /datum/outfit/centcom/ert/safety_moth/security

/datum/antagonist/ert/safety_moth/on_gain()
	forge_objectives()
	. = ..()
	owner.current.set_species(/datum/species/moth)
	ADD_TRAIT(owner.current, TRAIT_PACIFISM, JOB_TRAIT)

/datum/antagonist/ert/safety_moth/greet()
	to_chat(owner, "<B><font size=3 color=green>You are the [role].</font></B>")
	to_chat(owner, "You are being sent on a mission to [station_name()] by Nanotrasen's Operational Safety Department. Ensure the crew is following all proper safety protocols.")

/// Outfits
// Eng
/datum/outfit/centcom/ert/safety_moth
	name = "Safety Moth Engineer"

	head = /obj/item/clothing/head/helmet/space/safety_moth
	glasses = /obj/item/clothing/glasses/meson/engine
	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/safety_moth
	suit_store = /obj/item/tank/internals/oxygen
	gloves = /obj/item/clothing/gloves/color/chief_engineer
	shoes = /obj/item/clothing/shoes/magboots/safety_moth
	belt = /obj/item/storage/belt/utility/full/powertools
	back = /obj/item/storage/backpack/ert/engineer
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/construction/rcd/loaded/upgraded = 1,
		/obj/item/pipe_dispenser = 1,
		/obj/item/modular_computer/tablet/preset/advanced/engineering = 1,
		/obj/item/storage/box/survival/engineer = 1,
	)
	r_hand = /obj/item/clipboard
	r_pocket = /obj/item/toy/plush/moth
	l_pocket = /obj/item/rcd_ammo/large

	id = /obj/item/card/id/advanced/centcom/ert/safety_moth
	skillchips = list(/obj/item/skillchip/job/engineer)

// Med
/datum/outfit/centcom/ert/safety_moth/medical
	name = "Safety Moth Medic"

	head = /obj/item/clothing/head/helmet/space/safety_moth/med
	glasses = /obj/item/clothing/glasses/hud/health
	suit = /obj/item/clothing/suit/space/safety_moth/med
	suit_store = /obj/item/tank/internals/oxygen
	gloves = /obj/item/clothing/gloves/combat/nitrile
	shoes = /obj/item/clothing/shoes/sneakers/blue
	belt = /obj/item/storage/belt/medical/advanced
	back = /obj/item/storage/backpack/ert/medical
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/gun/medbeam = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/hug/plushes = 1,
		/obj/item/storage/box/survival/engineer = 1,
	)
	l_pocket = /obj/item/storage/pill_bottle/strange_reagent

	skillchips = list(/obj/item/skillchip/entrails_reader)

// Sec
/datum/outfit/centcom/ert/safety_moth/security
	name = "Safety Moth Officer"

	head = /obj/item/clothing/head/helmet/space/safety_moth/sec
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	mask = /obj/item/clothing/mask/gas/sechailer
	suit = /obj/item/clothing/suit/space/safety_moth/sec
	suit_store = /obj/item/gun/energy/e_gun/stun
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	shoes = /obj/item/clothing/shoes/combat/swat
	belt = /obj/item/storage/belt/security/full
	back = /obj/item/storage/backpack/ert/security
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/storage/box/survival/engineer = 1,
	)
	l_pocket = /obj/item/tank/internals/emergency_oxygen/double

	skillchips = null

/// Clothing
// ID
/obj/item/card/id/advanced/centcom/ert/safety_moth
	registered_name = "Safety Moth"
	trim = /datum/id_trim/centcom/ert/commander

// Headset
/datum/outfit/centcom/ert/safety_moth/post_equip(mob/living/carbon/human/user, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	var/obj/item/radio/equipped_radio = user.ears
	equipped_radio.keyslot = new /obj/item/encryptionkey/heads/captain
	equipped_radio.recalculateChannels()

//Eng
/obj/item/clothing/suit/space/safety_moth
	name = "Safety Moth safety vest"
	desc = "The standard issue safety vest belonging to Safety Moth themselves. Functions like a hardsuit and offers superb protection against environmental hazards."
	icon_state = "hazard"
	inhand_icon_state = "hazard"
	flags_inv = null
	armor = list(MELEE = 50, BULLET = 40, LASER = 40, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 100, ACID = 80)
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/tank/internals, /obj/item/toy/plush/moth)
	resistance_flags = FIRE_PROOF
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	slowdown = 0
/obj/item/clothing/head/helmet/space/safety_moth
	name = "Safety Moth safety hardhat"
	desc = "The standard issue safety hardhat belonging to Safety Moth themselves. Functions like a hardsuit helmet and offers superb protection against environmental hazards."
	icon_state = "hardhat0_yellow"
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 50, BULLET = 40, LASER = 40, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 100, ACID = 80)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
/obj/item/clothing/shoes/magboots/safety_moth
	desc = "A special pair of Magnetic boots which doesn't weight you down." // Do they even need this? They're a moth...
	name = "safety magboots"
	slowdown_active = SHOES_SLOWDOWN

//Med
/obj/item/clothing/suit/space/safety_moth/med
	name = "Safety Moth medical jacket"
	desc = "The standard issue safety jacket belonging to Safety Moth themselves. Functions like a hardsuit and offers superb protection against environmental hazards."
	icon_state = "labcoat_paramedic"
	inhand_icon_state = "labcoat_paramedic"
/obj/item/clothing/head/helmet/space/safety_moth/med
	name = "Safety Moth medical cap"
	desc = "The standard issue safety cap belonging to Safety Moth themselves. Functions like a hardsuit helmet and offers superb protection against environmental hazards."
	icon_state = "paramedicsoft"

//Sec
/obj/item/clothing/suit/space/safety_moth/sec
	name = "Safety Moth riot suit"
	desc = "The standard issue riot suit belonging to Safety Moth themselves. Functions like a hardsuit, resists shoves, and offers superb protection against environmental hazards."
	icon_state = "riot"
	inhand_icon_state = "riot"
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | BLOCKS_SHOVE_KNOCKDOWN
/obj/item/clothing/head/helmet/space/safety_moth/sec
	name = "Safety Moth riot helmet"
	desc = "The standard issue riot helmet belonging to Safety Moth themselves. Functions like a hardsuit helmet and offers superb protection against environmental hazards."
	icon_state = "riot"


/obj/item/clothing/suit/space/safety_moth/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/radiation_protected_clothing)

/obj/item/clothing/head/helmet/space/safety_moth/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/radiation_protected_clothing)
