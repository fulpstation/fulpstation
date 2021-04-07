// Medical

/obj/item/clothing/head/helmet/space/hardsuit/ert/commandermed
	name = "medical emergency response team commander helmet"
	desc = "The integrated helmet of an ERT hardsuit, belonging to a Specialized Chief Medical Officer. It has a built-in Security hud."
	worn_icon = 'fulp_modules/departmental_ert/icons/hardsuit_worn.dmi'
	icon = 'fulp_modules/departmental_ert/icons/hardsuit.dmi'
	icon_state = "hardsuit0-medert_commander"
	hardsuit_type = "medert_commander"

/obj/item/clothing/head/helmet/space/hardsuit/ert/commandermed/equipped(mob/living/carbon/human/user, slot)
	..()
	to_chat(user, "Your helmet's visor activates its integrated HUD, revealing information around you.")
	ADD_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.add_hud_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/ert/commandermed/dropped(mob/living/carbon/human/user)
	..()
	to_chat(user, "You remove your helmet, disabling its integrated hud.")
	REMOVE_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.remove_hud_from(user)

/obj/item/clothing/suit/space/hardsuit/ert/commandermed
	name = "medical emergency response team commander hardsuit"
	desc = "The standard issue hardsuit of the ERT, belonging to a Specialized Chief Medical Officer. Offers superb protection against environmental hazards."
	worn_icon = 'fulp_modules/departmental_ert/icons/hardsuit_worn.dmi'
	icon = 'fulp_modules/departmental_ert/icons/hardsuit.dmi'
	inhand_icon_state = "ert_medical"
	icon_state = "medert_commander"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/commandermed

// Security

/obj/item/clothing/head/helmet/space/hardsuit/ert/commandersec
	name = "security emergency response team commander helmet"
	desc = "The integrated helmet of an ERT hardsuit, belonging to a Specialized Head of Security. It has a built-in Security hud."
	worn_icon = 'fulp_modules/departmental_ert/icons/hardsuit_worn.dmi'
	icon = 'fulp_modules/departmental_ert/icons/hardsuit.dmi'
	icon_state = "hardsuit-secert_commander"
	hardsuit_type = "secert_commander"
	actions_types = list()

/obj/item/clothing/head/helmet/space/hardsuit/ert/commandersec/equipped(mob/living/carbon/human/user, slot)
	..()
	to_chat(user, "Your helmet's visor activates its integrated HUD, revealing information around you.")
	ADD_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.add_hud_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/ert/commandersec/dropped(mob/living/carbon/human/user)
	..()
	to_chat(user, "You remove your helmet, disabling its integrated hud.")
	REMOVE_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.remove_hud_from(user)

/obj/item/clothing/suit/space/hardsuit/ert/commandersec
	name = "security emergency response team commander hardsuit"
	desc = "The standard issue hardsuit of the ERT, belonging to a Specialized Head of Security. Offers protection against enviromental hazards, along with protection to shoves."
	worn_icon = 'fulp_modules/departmental_ert/icons/hardsuit_worn.dmi'
	icon = 'fulp_modules/departmental_ert/icons/hardsuit.dmi'
	inhand_icon_state = "ert_security"
	icon_state = "secert_commander"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/commandersec
	clothing_flags = BLOCKS_SHOVE_KNOCKDOWN

// Engineering

/obj/item/clothing/head/helmet/space/hardsuit/ert/commandereng
	name = "engineering emergency response team commander helmet"
	desc = "The integrated helmet of an ERT hardsuit, belonging to a Specialized Chief Engineer. It has a built-in Security hud."
	worn_icon = 'fulp_modules/departmental_ert/icons/hardsuit_worn.dmi'
	icon = 'fulp_modules/departmental_ert/icons/hardsuit.dmi'
	icon_state = "hardsuit0-engert_commander"
	hardsuit_type = "engert_commander"

/obj/item/clothing/head/helmet/space/hardsuit/ert/commandereng/equipped(mob/living/carbon/human/user, slot)
	..()
	to_chat(user, "Your helmet's visor activates its integrated HUD, revealing information around you.")
	ADD_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.add_hud_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/ert/commandereng/dropped(mob/living/carbon/human/user)
	..()
	to_chat(user, "You remove your helmet, disabling its integrated hud.")
	REMOVE_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.remove_hud_from(user)

/obj/item/clothing/suit/space/hardsuit/ert/commandereng
	name = "engineering emergency response team commander hardsuit"
	desc = "The standard issue hardsuit of the ERT, belonging to a Specialized Chief Engineer. Offers superb protection against environmental hazards."
	worn_icon = 'fulp_modules/departmental_ert/icons/hardsuit_worn.dmi'
	icon = 'fulp_modules/departmental_ert/icons/hardsuit.dmi'
	inhand_icon_state = "ert_engineer"
	icon_state = "engert_commander"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/commandereng

// Clown

/obj/item/clothing/head/helmet/space/hardsuit/ert/clown/commander
	name = "clown emergency response team commander helmet"
	desc = "The integrated helmet of an ERT hardsuit, this one is colourful, with a green visor!"
	worn_icon = 'fulp_modules/departmental_ert/icons/hardsuit_worn.dmi'
	icon = 'fulp_modules/departmental_ert/icons/hardsuit.dmi'
	icon_state = "hardsuit0-clownert_commander"
	hardsuit_type = "clownert_commander"

/obj/item/clothing/suit/space/hardsuit/ert/clown/commander
	name = "clown emergency response team commander hardsuit"
	desc = "The non-standard issue hardsuit of the Honk Prime, this one is colourful! Offers superb protection against environmental hazards. Does not offer superb protection against a ravaging crew."
	worn_icon = 'fulp_modules/departmental_ert/icons/hardsuit_worn.dmi'
	icon = 'fulp_modules/departmental_ert/icons/hardsuit.dmi'
	icon_state = "clownert_commander"
	inhand_icon_state = "ert_clown"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/clown/commander
