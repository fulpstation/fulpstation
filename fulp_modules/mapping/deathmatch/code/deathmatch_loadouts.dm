/datum/outfit/deathmatch_loadout/gladiator
	name = "Deathmatch: Gladiator"
	display_name = "Gladiator"
	desc = "Made for mayhem."
	head = /obj/item/clothing/head/helmet/gladiator
	uniform = /obj/item/clothing/under/costume/gladiator
	shoes = /obj/item/clothing/shoes/sandal
	r_hand = /obj/item/knife/combat
	l_hand = /obj/item/shield/buckler

/datum/outfit/deathmatch_loadout/dmhos
	name = "Deathmatch: Head of Security"
	display_name = "Head of Security"
	desc = "Finally, nobody to stop the power from going to your head."

	head = /obj/item/clothing/head/hats/hos/beret
	uniform = /obj/item/clothing/under/rank/security/head_of_security/alt
	shoes = /obj/item/clothing/shoes/jackboots/sec
	suit = /obj/item/clothing/suit/armor/hos/hos_formal
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat/compact
	neck = /obj/item/bedsheet/hos
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	gloves = /obj/item/clothing/gloves/tackler/combat
	belt = /obj/item/gun/energy/e_gun/hos
	r_hand = /obj/item/melee/baton/security/loaded
	l_hand = /obj/item/shield/riot/tele
	l_pocket = /obj/item/restraints/legcuffs/bola/energy
	r_pocket = /obj/item/restraints/legcuffs/bola/energy
	implants = list(/obj/item/implant/mindshield)

/datum/outfit/deathmatch_loadout/dmcap
	name = "Deathmatch: Captain"
	display_name = "Captain"
	desc = "Draw your sword and show the syndicate scum no quarter."

	head = /obj/item/clothing/head/hats/caphat/parade
	uniform = /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/captains_formal
	suit_store = /obj/item/gun/energy
	shoes = /obj/item/clothing/shoes/laceup
	neck = /obj/item/bedsheet/captain
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/captain
	belt = /obj/item/storage/belt/sabre
	l_hand = /obj/item/gun/energy/laser/captain
	r_pocket = /obj/item/assembly/flash
	l_pocket = /obj/item/melee/baton/telescopic

/datum/outfit/deathmatch_loadout/dmtot
	name = "Deathmatch: Traitor"
	display_name = "Traitor"
	desc = "The classic; energy sword & energy bow, donning a reflector trenchcoat (stolen)."

	head = /obj/item/clothing/head/chameleon
	uniform = /obj/item/clothing/under/chameleon
	mask = /obj/item/clothing/mask/chameleon
	suit = /obj/item/clothing/suit/hooded/ablative
	shoes = /obj/item/clothing/shoes/chameleon/noslip
	glasses = /obj/item/clothing/glasses/thermal/syndi
	gloves = /obj/item/clothing/gloves/combat
	suit_store = /obj/item/gun/energy/recharge/ebow
	l_hand = /obj/item/melee/energy/sword
	r_pocket = /obj/item/reagent_containers/hypospray/medipen/stimulants
	l_pocket = /obj/item/ammo_box/a357
	belt = /obj/item/gun/ballistic/revolver/syndicate

/datum/outfit/deathmatch_loadout/dmnukie
	name = "Deathmatch: Nuclear Operative"
	display_name = "Nuclear Operative"
	desc = "Gear afforded to Lone Operatives. Your mission is simple."

	uniform = /obj/item/clothing/under/syndicate/tacticool
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/mod/control/pre_equipped/nuclear
	r_hand = /obj/item/gun/ballistic/shotgun/bulldog/unrestricted
	belt = /obj/item/gun/ballistic/automatic/pistol/clandestine
	r_pocket = /obj/item/reagent_containers/hypospray/medipen/methamphetamine
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/atropine
	implants = list(/obj/item/implant/explosive)

	backpack_contents = list(
		/obj/item/ammo_box/c10mm,
		/obj/item/ammo_box/magazine/m12g = 2,
   	)

/datum/outfit/deathmatch_loadout/dmpete
	name = "Deathmatch: Cuban Pete"
	display_name = "Disciple of Pete"
	desc = "You took a lesson from Cuban Pete."

	head = /obj/item/clothing/head/collectable/petehat
	uniform = /obj/item/clothing/under/pants/camo
	suit = /obj/item/clothing/suit/costume/poncho
	belt = /obj/item/storage/belt/grenade/full
	shoes = /obj/item/clothing/shoes/workboots
	l_hand = /obj/item/reagent_containers/cup/glass/bottle/rum
	r_hand = /obj/item/sbeacondrop/bomb
	l_pocket = /obj/item/grenade/syndieminibomb
	r_pocket = /obj/item/grenade/syndieminibomb
	implants = list(/obj/item/implanter/explosive_macro)
