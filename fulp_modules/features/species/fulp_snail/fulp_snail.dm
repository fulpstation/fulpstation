/datum/species/fulp_snail
	name = "\improper Snailperson"
	plural_form = "Snailpeople"
	id = SPECIES_FULPSNAIL
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_NO_UNDERWEAR,
		TRAIT_NO_SLIP_ALL,
	)

	coldmod = 0.5 //snails only come out when its cold and wet
	siemens_coeff = 2 //snails are mostly water
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP
	sexes = FALSE //snails are hermaphrodites

	mutanteyes = /obj/item/organ/internal/eyes/snail
	mutanttongue = /obj/item/organ/internal/tongue/snail
	exotic_blood = /datum/reagent/lube

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/snail,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/snail,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/snail,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/snail,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/snail,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/snail
	)

/datum/species/fulp_snail/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.features["mcolor"] = COLOR_BEIGE
	human.update_body(is_creating = TRUE)

/datum/species/fulp_snail/get_physical_attributes()
	return "Snailpeople emit a viscous, slippery ooze when crawling along the ground, which they are somewhat faster at than other species. \
		They are almost purely made of water, making them extremely susceptible to shocks, and salt will scour them heavily."

/datum/species/fulp_snail/get_species_description()
	return "Snailpeople are viscous, slimy beings with a shell on their back."

/datum/species/fulp_snail/get_species_lore()
	return list(
		"Normally, Snailpeople are a result of a genetic experiment gone wrong, but they have since become recognized species in their own right, \
		similar to the Felinid.",
	)

/datum/species/fulp_snail/create_pref_unique_perks()
	var/list/to_add = list()
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_RUNNING,
		SPECIES_PERK_NAME = "Turbo",
		SPECIES_PERK_DESC = "Snailpeople walk and run very slow, but crawl around very fast. While crawling, they leave a trail of slippery slime behind them.",
	))
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHRIMP,
		SPECIES_PERK_NAME = "Shelled",
		SPECIES_PERK_DESC = "The back of a Snailperson is covered in an armored shell, which is effectively an unremovable backpack. \
			Good for keeping your things from being stolen, but bad for needing to wear a MODsuit, or disguising.",
	))
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SKULL_CROSSBONES,
		SPECIES_PERK_NAME = "Salty",
		SPECIES_PERK_DESC = "Being evolved from Snails, Snailpeople are extremely susceptible to salt, which burns them.",
	))
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_HAND_FIST,
		SPECIES_PERK_NAME = "Squishy",
		SPECIES_PERK_DESC = "Snailpeople are squishy and slimy, making their punches and kicks far less effective than other species.",
	))
	return to_add

/datum/species/fulp_snail/handle_chemical(datum/reagent/chem, mob/living/carbon/human/affected, seconds_per_tick, times_fired)
	. = ..()
	if(. & COMSIG_MOB_STOP_REAGENT_CHECK)
		return
	if(istype(chem,/datum/reagent/consumable/salt))
		playsound(affected, SFX_SEAR, 30, TRUE)
		affected.adjustFireLoss(2 * REM * seconds_per_tick)
		affected.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * seconds_per_tick)
		return COMSIG_MOB_STOP_REAGENT_CHECK

/datum/species/fulp_snail/on_species_gain(mob/living/carbon/new_fulpsnailperson, datum/species/old_species, pref_load)
	. = ..()
	var/obj/item/storage/backpack/bag = new_fulpsnailperson.get_item_by_slot(ITEM_SLOT_BACK)
	if(!istype(bag, /obj/item/storage/backpack/snail))
		if(new_fulpsnailperson.dropItemToGround(bag)) //returns TRUE even if its null
			new_fulpsnailperson.equip_to_slot_or_del(new /obj/item/storage/backpack/snail(new_fulpsnailperson), ITEM_SLOT_BACK)
	new_fulpsnailperson.AddElement(/datum/element/snailcrawl)

/datum/species/fulp_snail/on_species_loss(mob/living/carbon/former_fulpsnailperson, datum/species/new_species, pref_load)
	. = ..()
	former_fulpsnailperson.RemoveElement(/datum/element/snailcrawl)
	var/obj/item/storage/backpack/bag = former_fulpsnailperson.get_item_by_slot(ITEM_SLOT_BACK)
	if(istype(bag, /obj/item/storage/backpack/snail))
		bag.emptyStorage()
		former_fulpsnailperson.temporarilyRemoveItemFromInventory(bag, TRUE)
		qdel(bag)

/obj/item/storage/backpack/snail
	name = "snail shell"
	desc = "Worn by snails as armor and storage compartment."
	icon_state = "snailshell"
	inhand_icon_state = null
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	armor_type = /datum/armor/backpack_snail
	max_integrity = 200
	resistance_flags = FIRE_PROOF | ACID_PROOF

/datum/armor/backpack_snail
	melee = 40
	bullet = 30
	laser = 30
	energy = 10
	bomb = 25
	acid = 50

/obj/item/storage/backpack/snail/dropped(mob/user, silent)
	. = ..()
	emptyStorage()
	if(!QDELETED(src))
		qdel(src)

/obj/item/storage/backpack/snail/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)
