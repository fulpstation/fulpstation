//
// ERT Outfits
//

// MEDICAL ERT OUTFITS

/datum/outfit/centcom/ert/medic/specialized
	name = "ERT Medic - Specialized"

	belt = /obj/item/storage/belt/medical/advanced
	gloves = /obj/item/clothing/gloves/combat/nitrile

/datum/outfit/centcom/ert/commander/medical
	name = "ERT Commander - Medical"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/commandermed
	suit_store = /obj/item/gun/energy/e_gun
	back = /obj/item/storage/backpack/ert/medical
	backpack_contents = list(
		/obj/item/gun/medbeam=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/reagent_containers/hypospray/combat/nanites=1,
		/obj/item/storage/box/survival/engineer=1,
		)
	belt = /obj/item/storage/belt/medical/advanced
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	gloves = /obj/item/clothing/gloves/combat/nitrile

/datum/outfit/centcom/ert/medic/specialized/alien
	name = "ERT Medic - Alien"

	uniform = /obj/item/clothing/under/abductor
	backpack_contents = list(
		/obj/item/gun/energy/alien = 1,
		/obj/item/gun/medbeam=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/reagent_containers/hypospray/combat=1,
		/obj/item/storage/box/survival/engineer=1,
		)
	belt = /obj/item/storage/belt/medical/alien

/datum/outfit/centcom/ert/medic/specialized/oath
	name = "ERT Medic - Oath"

	backpack_contents = list(
		/obj/item/gun/medbeam=1,
		/obj/item/reagent_containers/hypospray/combat=1,
		/obj/item/storage/box/survival/engineer=1,
		/obj/item/storage/firstaid/regular=1,
		)
	l_hand = /obj/item/rod_of_asclepius

/datum/outfit/centcom/ert/commander/medical/alien
	name = "ERT Commander - Medical Alien"

	uniform = /obj/item/clothing/under/abductor
	suit_store = /obj/item/gun/energy/alien
	backpack_contents = list(
		/obj/item/gun/medbeam=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/reagent_containers/hypospray/combat/nanites=1,
		/obj/item/storage/box/survival/engineer=1,
		)
	belt = /obj/item/storage/belt/medical/alien

/datum/outfit/centcom/ert/commander/medical/oath
	name = "ERT Commander - Medical Oath"

	backpack_contents = list(
		/obj/item/gun/medbeam=1,
		/obj/item/reagent_containers/hypospray/combat/nanites=1,
		/obj/item/storage/box/survival/engineer=1,
		/obj/item/storage/firstaid/regular=1,
		)
	l_pocket = /obj/item/flashlight/pen/paramedic
	l_hand = /obj/item/rod_of_asclepius

// SECURITY ERT OUTFITS

/datum/outfit/centcom/ert/security/specialized
	name = "ERT Security - Specialized"

	belt = /obj/item/storage/belt/security/webbing/full
	mask = /obj/item/clothing/mask/gas/sechailer

/datum/outfit/centcom/ert/commander/security
	name = "ERT Commander - Security"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/commandersec
	suit_store = /obj/item/gun/energy/e_gun/stun
	back = /obj/item/storage/backpack/ert/security
	backpack_contents = list(
		/obj/item/melee/baton/loaded=1,
		/obj/item/storage/box/handcuffs=1,
		/obj/item/storage/box/survival/engineer=1,
		)
	belt = /obj/item/storage/belt/security/webbing/full
	glasses = /obj/item/clothing/glasses/thermal/eyepatch
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	mask = /obj/item/clothing/mask/gas/sechailer/swat

// ENGINEERING ERT OUTFITS

/datum/outfit/centcom/ert/engineer/specialized
	name = "ERT Engineer - Specialized"

	belt = /obj/item/storage/belt/utility/full/powertools
	mask = /obj/item/clothing/mask/gas
	suit_store = /obj/item/tank/internals/oxygen
	l_hand = /obj/item/analyzer

/datum/outfit/centcom/ert/commander/engineer
	name = "ERT Commander - Engineer"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/commandereng
	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/storage/backpack/ert/engineer
	backpack_contents = list(
		/obj/item/construction/rcd/combat=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/storage/box/survival/engineer=1,
		)
	belt = /obj/item/storage/belt/utility/full/powertools
	glasses =  /obj/item/clothing/glasses/meson/engine
	mask = /obj/item/clothing/mask/gas
	r_pocket = /obj/item/rcd_ammo/large
	r_hand = /obj/item/gun/energy/e_gun

// CLOWN ERT OUTFITS

/datum/outfit/centcom/ert/clown/honk
	name = "ERT Clown - Specialized"

	backpack_contents = list(
		/obj/item/melee/transforming/energy/sword/bananium=1,
		/obj/item/shield/energy/bananium=1,
		/obj/item/storage/box/hug/survival=1,
		)
	glasses = /obj/item/clothing/glasses/night

/datum/outfit/centcom/ert/clown/honk/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE) // Just to make sure
	..()
	if(visualsOnly)
		return
	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_service
	R.recalculateChannels()
	ADD_TRAIT(H, TRAIT_NAIVE, INNATE_TRAIT)
	H.dna.add_mutation(CLOWNMUT)
	for(var/datum/mutation/human/clumsy/M in H.dna.mutations)
		M.mutadone_proof = TRUE

/datum/outfit/centcom/ert/clown/commander
	name = "ERT Commander - Clown"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/clown/commander
	backpack_contents = list(
		/obj/item/melee/transforming/energy/sword/bananium=1,
		/obj/item/shield/energy/bananium=1,
		/obj/item/storage/box/hug/survival=1,
		/obj/item/storage/box/fireworks=2,
		)
	glasses = /obj/item/clothing/glasses/night
	shoes = /obj/item/clothing/shoes/clown_shoes/banana_shoes/combat
	l_hand = /obj/item/pneumatic_cannon/pie/selfcharge

/datum/outfit/centcom/ert/clown/commander/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE) // Same here
	..()
	if(visualsOnly)
		return
	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_service
	R.recalculateChannels()
	ADD_TRAIT(H, TRAIT_NAIVE, INNATE_TRAIT)
	H.dna.add_mutation(CLOWNMUT)
	for(var/datum/mutation/human/clumsy/M in H.dna.mutations)
		M.mutadone_proof = TRUE
