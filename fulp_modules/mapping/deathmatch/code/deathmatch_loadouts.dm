/datum/outfit/deathmatch_loadout/gladiator
	name = "Deathmatch: Gladiator"
	display_name = "Gladiator"
	desc = "Made for mayhem."
	head = /obj/item/clothing/head/helmet/gladiator
	uniform = /obj/item/clothing/under/costume/gladiator
	shoes = /obj/item/clothing/shoes/sandal
	r_hand = /obj/item/knife/combat
	l_hand = /obj/item/shield/buckler

/datum/outfit/deathmatch_loadout/monkey
	name = "Deathmatch: Monkey"
	display_name = "Monkey"
	desc = "Chee ook."
	shoes = null
	l_hand = /obj/item/food/grown/banana
	species_override = /datum/species/monkey

	granted_spells = list(
		/datum/action/cooldown/spell/conjure/simian,
		)

