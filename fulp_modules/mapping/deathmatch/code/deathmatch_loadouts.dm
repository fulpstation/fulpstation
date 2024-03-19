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

/datum/outfit/deathmatch_loadout/dmhos
	name = "Deathmatch: Head of Security"
	display_name = "Head of Security"
	desc = "Finally, nobody to stop the power from going to your head."

	head = /obj/item/clothing/head/hats/hos/beret
	ears = 	/obj/item/radio/headset/heads/hos/alt
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
	l_pocket = /obj/item/grenade/flashbang
	r_pocket = /obj/item/restraints/legcuffs/bola/energy
	implants = list(/obj/item/implant/mindshield)

/datum/outfit/deathmatch_loadout/dmcap
	name = "Deathmatch: Captain"
	display_name = "Captain"
	desc = "Draw your sword and show the syndicate scum no quarter."

	head = /obj/item/clothing/head/hats/caphat/parade
	ears = /obj/item/radio/headset/heads/captain/alt
	uniform = /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/captains_formal
	suit_store = /obj/item/gun/energy/e_gun
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
	l_pocket = /obj/item/soap/syndie
	belt = /obj/item/gun/ballistic/revolver/syndicate

/datum/outfit/deathmatch_loadout/dmnukie
	name = "Deathmatch: Nuclear Operative"
	display_name = "Nuclear Operative"
	desc = "Gear afforded to Lone Operatives. Your mission is simple."

	uniform = /obj/item/clothing/under/syndicate/tacticool
	gloves = /obj/item/clothing/gloves/krav_maga/combatglovesplus
	back = /obj/item/mod/control/pre_equipped/nuclear
	r_hand = /obj/item/gun/ballistic/automatic/c20r/unrestricted
	belt = /obj/item/gun/ballistic/automatic/pistol/clandestine
	r_pocket = /obj/item/reagent_containers/hypospray/medipen/stimulants
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/atropine
	implants = list(/obj/item/implant/explosive)

	backpack_contents = list(
		/obj/item/ammo_box/c10mm,
		/obj/item/ammo_box/magazine/smgm45 = 2,
		/obj/item/pen/edagger,
   	)

/datum/outfit/deathmatch_loadout/dmpete
	name = "Deathmatch: Cuban Pete"
	display_name = "Disciple of Pete"
	desc = "You took a lesson from Cuban Pete."

	back = /obj/item/storage/backpack/santabag
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
	backpack_contents = list(
		/obj/item/assembly/signaler = 10,
   	)

/datum/outfit/deathmatch_loadout/dmtider
	name = "Deathmatch: Tider"
	display_name = "Tider"
	desc = "A very high power level Assistant."

	back = /obj/item/melee/baton/security/cattleprod
	r_hand = /obj/item/fireaxe
	uniform = /obj/item/clothing/under/color/grey/ancient
	mask = /obj/item/clothing/mask/gas
	shoes = /obj/item/clothing/shoes/sneakers/black
	gloves = /obj/item/clothing/gloves/cut
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/methamphetamine
	r_pocket = /obj/item/stock_parts/cell/high
	belt = /obj/item/storage/belt/utility/full

/datum/outfit/deathmatch_loadout/dmabductor
	name = "Deathmatch: Abductor"
	display_name = "Abductor"
	desc = "We come in peace."
	
	species_override = /datum/species/abductor
	uniform = /obj/item/clothing/under/abductor
	head = /obj/item/clothing/head/helmet/abductor
	suit = /obj/item/clothing/suit/armor/abductor/vest
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/atropine
	r_pocket = /obj/item/grenade/gluon
	l_hand = /obj/item/gun/energy/alien
	r_hand = /obj/item/gun/energy/alien
	belt = /obj/item/gun/energy/shrink_ray

/datum/outfit/deathmatch_loadout/dmclown
	name = "Deathmatch: Clown"
	display_name = "Clown"
	desc = "They were bound to show up sooner or later."

	uniform = /datum/outfit/job/clown::uniform
	belt = /datum/outfit/job/clown::belt
	shoes = /obj/item/clothing/shoes/clown_shoes/combat
	mask = /datum/outfit/job/clown::mask
	r_hand = /obj/item/pneumatic_cannon/pie/selfcharge
	l_hand = /obj/item/bikehorn/golden
	back = /datum/outfit/job/clown::backpack
	box = /obj/item/storage/box/hug/reverse_revolver
	implants = list(/obj/item/implant/sad_trombone)
	l_pocket = /obj/item/melee/energy/sword/bananium
	r_pocket = /obj/item/shield/energy/bananium
	gloves = /obj/item/clothing/gloves/tackler/rocket

	backpack_contents = list(
		/obj/item/paperplane/syndicate = 1,
		/obj/item/restraints/legcuffs/bola/tactical = 1,
		/obj/item/restraints/legcuffs/beartrap = 1,
		/obj/item/food/grown/banana = 1,
		/obj/item/food/pie/cream = 1,
		/obj/item/dnainjector/clumsymut,
		/obj/item/sbeacondrop/clownbomb,
		)

/datum/outfit/deathmatch_loadout/dmmime
	name = "Deathmatch: Mime"
	display_name = "Mime"
	desc = "..."

	uniform = /datum/outfit/job/mime::uniform
	belt = /obj/item/food/baguette/combat
	head = /datum/outfit/job/mime::head
	shoes = /datum/outfit/job/mime::shoes
	mask = /datum/outfit/job/mime::mask
	back = /datum/outfit/job/mime::backpack
	l_pocket = /obj/item/toy/crayon/spraycan/mimecan
	r_pocket = /obj/item/food/grown/banana/mime
	neck = /datum/outfit/job/mime::neck
	gloves = /datum/outfit/job/mime::gloves

	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/suppressor,
		/obj/item/ammo_box/c9mm,
		)

	granted_spells = list(
		/datum/action/cooldown/spell/vow_of_silence,
		/datum/action/cooldown/spell/conjure_item/invisible_box,
		/datum/action/cooldown/spell/conjure/invisible_chair,
		/datum/action/cooldown/spell/conjure/invisible_wall,
		/datum/action/cooldown/spell/forcewall/mime,
		/datum/action/cooldown/spell/pointed/projectile/finger_guns,
		)

/datum/outfit/deathmatch_loadout/dmchef
	name = "Deathmatch: Chef"
	display_name = "Chef"
	desc = "Let him cook."

	belt = /obj/item/gun/magic/hook
	uniform = /obj/item/clothing/under/costume/buttondown/slacks/service
	suit = /obj/item/clothing/suit/toggle/chef
	suit_store = /obj/item/knife/kitchen
	head = /obj/item/clothing/head/utility/chefhat
	mask = /obj/item/clothing/mask/fakemoustache/italian
	r_hand = /obj/item/clothing/gloves/the_sleeping_carp
	back = /obj/item/storage/backpack

	backpack_contents = list(
		/obj/item/pizzabox/bomb/armed = 3,
		/obj/item/knife/butcher,
		/obj/item/sharpener,
	)
