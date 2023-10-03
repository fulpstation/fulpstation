/mob/living/carbon/human/werewolf
	hud_possible = list(HEALTH_HUD)
	gender = NEUTER
	mob_size = MOB_SIZE_HUGE

/obj/item/bodypart/head/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST

/obj/item/bodypart/chest/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST

/obj/item/bodypart/arm/left/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST

/obj/item/bodypart/arm/right/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST

/obj/item/bodypart/leg/left/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST

/obj/item/bodypart/leg/right/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST

/datum/species/werewolf
	name = "Werewolf"
	no_equip_flags = ITEM_SLOT_MASK | ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_ICLOTHING | ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT | ITEM_SLOT_EARS | ITEM_SLOT_HEAD
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/werewolf,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/werewolf,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/werewolf,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/werewolf,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/werewolf,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/werewolf,
	)


/datum/movespeed_modifier/werewolf_base
	multiplicative_slowdown = -0.30
