/datum/outfit/deathmatch_loadout/gladiator
	name = "Deathmatch: Gladiator"
	display_name = "Gladiator"
	desc = "Made for mayhem."
	head = /obj/item/clothing/head/helmet/gladiator
	uniform = /obj/item/clothing/under/costume/gladiator
	shoes = /obj/item/clothing/shoes/sandal
	r_hand = /obj/item/knife/combat
	l_hand = /obj/item/shield/buckler


/datum/outfit/deathmatch_loadout/redmage
	name = "Deathmatch: Fire Wizard"
	display_name = "Fire Wizard"
	desc = "Too hot to handle."
	head = /obj/item/clothing/head/wizard/red
	suit = /obj/item/clothing/suit/wizrobe/red
	shoes = /obj/item/clothing/shoes/sandal/magic
	r_hand = /obj/item/staff/broom

	granted_spells = list(
		/datum/action/cooldown/spell/aoe/sacred_flame,
		/datum/action/cooldown/spell/pointed/projectile/fireball,
		)

/datum/outfit/deathmatch_loadout/bluemage
	name = "Deathmatch: Arcane Wizard"
	display_name = "Arcane Wizard"
	desc = "Magic missile."
	head = /obj/item/clothing/head/wizard
	suit = /obj/item/clothing/suit/wizrobe
	shoes = /obj/item/clothing/shoes/sandal/magic
	r_hand = /obj/item/staff/broom

	granted_spells = list(
		/datum/action/cooldown/spell/aoe/magic_missile,
		/datum/action/cooldown/spell/aoe/repulse/wizard,
		)

/datum/outfit/deathmatch_loadout/yellowmage
	name = "Deathmatch: Lightning Wizard"
	display_name = "Lightning Wizard"
	desc = "Unlimited power!"
	head = /obj/item/clothing/head/wizard/yellow
	suit = /obj/item/clothing/suit/wizrobe/yellow
	shoes = /obj/item/clothing/shoes/sandal/magic
	r_hand = /obj/item/staff/broom

	granted_spells = list(
		/datum/action/cooldown/spell/charged/beam/tesla,
		/datum/action/cooldown/spell/pointed/projectile/lightningbolt,
		)

/datum/outfit/deathmatch_loadout/whitemage
	name = "Deathmatch: Holy Wizard"
	display_name = "Holy Wizard"
	desc = "Outheal the competition."
	head = /obj/item/clothing/head/cowboy/white
	suit = /obj/item/clothing/suit/chaplainsuit/whiterobe
	shoes = /obj/item/clothing/shoes/sandal/magic
	r_hand = /obj/item/gun/magic/wand/resurrection

	granted_spells = list(
		/datum/action/cooldown/spell/charge,
		/datum/action/cooldown/spell/forcewall,
		)

/datum/outfit/deathmatch_loadout/blackmage
	name = "Deathmatch: Chaos Wizard"
	display_name = "Chaos Wizard"
	desc = "The touch of death."
	head = /obj/item/clothing/head/wizard/black	
	suit = /obj/item/clothing/suit/wizrobe/black
	shoes = /obj/item/clothing/shoes/sandal/magic
	r_hand = /obj/item/gun/magic/staff/chaos

	granted_spells = list(
		/datum/action/cooldown/spell/tap,
		/datum/action/cooldown/spell/touch/smite,
		)

/datum/outfit/deathmatch_loadout/beemage
	name = "Deathmatch: Bee Wizard"
	display_name = "Bee Wizard"
	desc = "OH NO, NOT THE BEES!"
	suit = /obj/item/clothing/suit/wizrobe/yellow
	shoes = /obj/item/clothing/shoes/sandal/magic
	head = /obj/item/clothing/head/wizard/yellow
	mask = /obj/item/clothing/mask/animal/small/bee/cursed
	r_hand = /obj/item/bee_smoker

	granted_spells = list(
		/datum/action/cooldown/spell/conjure/bee,
		)

/datum/outfit/deathmatch_loadout/monkeymage
	name = "Deathmatch: Monkey Wizard"
	display_name = "Monkey Wizard"
	desc = "Chee ook."
	head = /obj/item/clothing/head/wizard
	shoes = null
	r_hand = /obj/item/gun/magic/staff/honk
	l_hand = /obj/item/food/grown/banana
	species_override = /datum/species/monkey

	granted_spells = list(
		/datum/action/cooldown/spell/conjure/simian,
		)

/datum/outfit/deathmatch_loadout/discowizard
	name = "Deathmatch: Disco Wizard"
	display_name = "Disco Wizard"
	desc = "The wizard with the most swag."
	head = /obj/item/clothing/head/wizard
	uniform = /obj/item/clothing/under/suit/navy
	shoes = /obj/item/clothing/shoes/sandal/magic
	r_hand = /obj/item/staff/broom
	glasses = /obj/item/clothing/glasses/sunglasses

	granted_spells = list(
		/datum/action/cooldown/spell/smoke,
		/datum/action/cooldown/spell/summon_dancefloor,
		)
		
/datum/outfit/deathmatch_loadout/thechaplain
	name = "Deathmatch: The Chaplain"
	display_name = "The Chaplain"
	desc = "WIZARDS! FACE ME, COWARDS!"
	head = /obj/item/clothing/head/hooded/chaplain_hood
	suit = /obj/item/clothing/suit/hooded/chaplain_hoodie
	shoes = /obj/item/clothing/shoes/sandal
	l_hand = /obj/item/book/bible
	r_hand = /obj/item/nullrod
