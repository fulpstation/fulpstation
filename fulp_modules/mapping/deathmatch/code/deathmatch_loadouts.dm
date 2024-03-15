/datum/outfit/deathmatch_loadout/gladiator
	name = "Deathmatch: Gladiator"
	display_name = "Gladiator"
	desc = "Made for mayhem."
	head = /obj/item/clothing/head/helmet/gladiator
	uniform = /obj/item/clothing/under/costume/gladiator
	shoes = /obj/item/clothing/shoes/sandal
	r_hand = /obj/item/knife/combat
	l_hand = /obj/item/shield/buckler

/datum/outfit/deathmatch_loadout/beeftide
	name = "Deathmatch: Beeftide"
	display_name = "Beeftide"
	desc = "Nice to meat you."
	uniform = /obj/item/clothing/under/bodysash
	suit = /obj/item/clothing/suit/hooded/onesie/beefman
	r_hand = /obj/item/gun/magic/hook
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/methamphetamine

/datum/outfit/deathmatch_loadout/masquerader
	name = "Deathmatch: Masquerader"
	display_name = "Masquerader"
	desc = "Worth the stakes."
	uniform = /obj/item/clothing/under/costume/draculass
	suit = /obj/item/clothing/suit/costume_2021/alucard_suit
	head = /obj/item/clothing/head/costume/powdered_wig
	r_hand = /obj/item/melee/sabre
	
	granted_spells = list(
		/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/two,
		)
