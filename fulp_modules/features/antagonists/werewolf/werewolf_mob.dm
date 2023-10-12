/datum/species/werewolf
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/werewolf,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/werewolf,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/werewolf,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/werewolf,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/werewolf,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/werewolf,
	)

/mob/living/carbon/werewolf
	// hud_possible = list(HEALTH_HUD)
	gender = NEUTER
	dna = null
	mob_size = MOB_SIZE_HUGE
	icon = 'fulp_modules/features/antagonists/werewolf/icons/werwolf_mob.dmi'
	icon_state = "werewolf"

	bodyparts = list(
		/obj/item/bodypart/chest/werewolf,
		/obj/item/bodypart/head/werewolf,
		/obj/item/bodypart/arm/left/werewolf,
		/obj/item/bodypart/arm/right/werewolf,
		/obj/item/bodypart/leg/right/werewolf,
		/obj/item/bodypart/leg/left/werewolf,
	)


/mob/living/carbon/werewolf/Initialize(mapload)
	create_bodyparts() //initialize bodyparts
	create_internal_organs()
	return ..()


/mob/living/carbon/werewolf/create_internal_organs()
	organs += new /obj/item/organ/internal/brain
	organs += new /obj/item/organ/internal/heart
	organs += new /obj/item/organ/internal/lungs
	organs += new /obj/item/organ/internal/tongue
	organs += new /obj/item/organ/internal/eyes
	organs += new /obj/item/organ/internal/liver
	organs += new /obj/item/organ/internal/ears
	..()

/obj/item/bodypart/head/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500

/obj/item/bodypart/chest/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_HUMANOID  | BODYTYPE_ORGANIC
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500
	acceptable_bodytype = BODYTYPE_HUMANOID

/obj/item/bodypart/arm/left/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500

/obj/item/bodypart/arm/right/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500

/obj/item/bodypart/leg/left/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500

/obj/item/bodypart/leg/right/werewolf
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500

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
