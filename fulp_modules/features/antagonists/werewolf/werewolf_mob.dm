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
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/werewolf,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/werewolf,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/werewolf,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/werewolf,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/werewolf,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/werewolf,
	)
