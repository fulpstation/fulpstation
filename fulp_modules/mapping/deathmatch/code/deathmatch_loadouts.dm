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

	spells_to_add = list(
		/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/two,
		)

/datum/outfit/deathmatch_loadout/worker
	name = "Deathmatch: Worker"
	display_name = "Worker"
	desc = "Just your average Joe."
	head = /obj/item/clothing/head/soft/yellow
	uniform = /obj/item/clothing/under/rank/cargo/tech
	gloves = /obj/item/clothing/gloves/fingerless
	shoes = /obj/item/clothing/shoes/sneakers/black
	r_hand = /obj/item/boxcutter

/datum/outfit/deathmatch_loadout/maintenance
	name = "Deathmatch: Maintenance"
	display_name = "Maintenance"
	desc = "Can fix just about anything."
	head = /obj/item/clothing/head/utility/hardhat/welding/orange
	uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	belt = /obj/item/storage/belt/utility/full/engi
	gloves = /obj/item/clothing/gloves/color/yellow
	shoes = /obj/item/clothing/shoes/workboots

/datum/outfit/deathmatch_loadout/guard
	name = "Deathmatch: Security Guard"
	display_name = "Security Guard"
	desc = "Addicted to donuts and watching TV."
	head = /obj/item/clothing/head/beret/sec/navyofficer
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	r_hand = /obj/item/gun/energy/disabler
	l_hand = /obj/item/food/donut/choco

/datum/outfit/deathmatch_loadout/supervisor
	name = "Deathmatch: Supervisor"
	display_name = "Supervisor"
	desc = "In charge of it all, right?"
	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/rank/cargo/qm
	shoes = /obj/item/clothing/shoes/sneakers/brown
	r_hand = /obj/item/clipboard
