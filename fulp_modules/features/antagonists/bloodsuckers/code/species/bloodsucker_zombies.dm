//Hecata necromancy bloodsucker zombie. Kind of like a weakened Szlachta that can also wear clothes still
/datum/species/zombie/hecata
	name = "Sanguine Zombie"
	id = "hecatazombie"
	damage_modifier = -10
	stunmod = 0.5
	inherent_traits = list(
		TRAIT_NOGUNS,
		TRAIT_NOSOFTCRIT,
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | ERT_SPAWN

/datum/species/zombie/hecata/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	human_who_gained_species.add_faction(FACTION_BLOODHUNGRY)
	var/mob/living/carbon/our_zombie = human_who_gained_species

	var/obj/item/bodypart/zombie_left_hand = our_zombie.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/zombie_right_hand = our_zombie.get_bodypart(BODY_ZONE_R_ARM)
	zombie_left_hand.unarmed_damage_low += HECATA_ZOMBIE_ATTACK_BONUS
	zombie_right_hand.unarmed_damage_low += HECATA_ZOMBIE_ATTACK_BONUS
	zombie_left_hand.unarmed_damage_high += HECATA_ZOMBIE_ATTACK_BONUS
	zombie_right_hand.unarmed_damage_high += HECATA_ZOMBIE_ATTACK_BONUS

/datum/species/zombie/hecata/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	human.remove_faction(FACTION_BLOODHUNGRY)
	var/mob/living/carbon/our_zombie = human

	var/obj/item/bodypart/zombie_left_hand = our_zombie.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/zombie_right_hand = our_zombie.get_bodypart(BODY_ZONE_R_ARM)
	zombie_left_hand.unarmed_damage_low = initial(zombie_left_hand.unarmed_damage_low)
	zombie_right_hand.unarmed_damage_low = initial(zombie_right_hand.unarmed_damage_low)
	zombie_left_hand.unarmed_damage_high = initial(zombie_left_hand.unarmed_damage_high)
	zombie_right_hand.unarmed_damage_high = initial(zombie_right_hand.unarmed_damage_high)
