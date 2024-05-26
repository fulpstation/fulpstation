/mob/living/carbon/human/werewolf
	// hud_possible = list(HEALTH_HUD)
	gender = NEUTER
	// dna = null
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

/mob/living/carbon/human/werewolf/Initialize(mapload)
	. = ..()
	qdel(GetComponent(/datum/component/personal_crafting))
	icon_state = "werewolf"
	hairstyle = "Bald"
	underwear = "Nude"
	underwear_color = "#000000"
	undershirt = "Nude"
	socks = "Nude"
	facial_hairstyle = "Shaved"

	eye_color_left = "#FF0000"
	eye_color_right = "#FF0000"


/obj/item/bodypart/head/werewolf
	icon = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_static = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_state = "alien_r_arm"
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_ORGANIC
	bodyshape = BODYSHAPE_HUMANOID
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500

/obj/item/bodypart/chest/werewolf
	icon = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_static = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_state = "alien_r_arm"
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_ORGANIC
	bodyshape = BODYSHAPE_HUMANOID
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500
	acceptable_bodytype = BODYTYPE_ORGANIC
	acceptable_bodyshape = BODYSHAPE_HUMANOID

/obj/item/bodypart/arm/left/werewolf
	icon = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_static = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_state = "alien_r_arm"
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_ORGANIC
	bodyshape = BODYSHAPE_HUMANOID
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500

/obj/item/bodypart/arm/right/werewolf
	icon = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_static = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_state = "alien_r_arm"
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_ORGANIC
	bodyshape = BODYSHAPE_HUMANOID
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500

/obj/item/bodypart/leg/left/werewolf
	icon = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_static = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_state = "alien_r_arm"
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_ORGANIC
	bodyshape = BODYSHAPE_HUMANOID
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_flags = BODYPART_UNREMOVABLE
	max_damage = 500

/obj/item/bodypart/leg/right/werewolf
	icon = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_static = 'icons/mob/human/species/alien/bodyparts.dmi'
	icon_state = "alien_r_arm"
	brute_modifier = WEREWOLF_LIMB_BRUTE_MODIFIER
	burn_modifier = WEREWOLF_LIMB_BURN_MODIFIER
	wound_resistance = WEREWOLF_LIMB_WOUND_RESIST
	limb_id = BODYPART_ID_WEREWOLF
	bodytype = BODYTYPE_ORGANIC
	bodyshape = BODYSHAPE_HUMANOID
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
