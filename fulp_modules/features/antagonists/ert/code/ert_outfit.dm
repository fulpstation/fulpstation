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

	back = /obj/item/mod/control/pre_equipped/fulp/ert/commander/medical
	backpack_contents = list(
		/obj/item/gun/medbeam = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/reagent_containers/hypospray/combat/nanites = 1,
		/obj/item/storage/box/survival/engineer = 1,
	)
	belt = /obj/item/storage/belt/medical/advanced
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	gloves = /obj/item/clothing/gloves/combat/nitrile

/datum/outfit/centcom/ert/medic/specialized/alien
	name = "ERT Medic - Alien"

	uniform = /obj/item/clothing/under/abductor
	backpack_contents = list(
		/obj/item/gun/energy/alien = 1,
		/obj/item/gun/medbeam = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/storage/box/survival/engineer = 1,
	)
	belt = /obj/item/storage/belt/medical/alien

/datum/outfit/centcom/ert/medic/specialized/oath
	name = "ERT Medic - Oath"

	backpack_contents = list(
		/obj/item/gun/medbeam = 1,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/storage/medkit/regular = 1,
	)
	l_hand = /obj/item/rod_of_asclepius

/datum/outfit/centcom/ert/commander/medical/alien
	name = "ERT Commander - Medical Alien"

	uniform = /obj/item/clothing/under/abductor
	backpack_contents = list(
		/obj/item/gun/medbeam=1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/reagent_containers/hypospray/combat/nanites = 1,
		/obj/item/storage/box/survival/engineer = 1,
	)
	belt = /obj/item/storage/belt/medical/alien

/datum/outfit/centcom/ert/commander/medical/oath
	name = "ERT Commander - Medical Oath"

	backpack_contents = list(
		/obj/item/gun/medbeam = 1,
		/obj/item/reagent_containers/hypospray/combat/nanites = 1,
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/storage/medkit/regular = 1,
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

	back = /obj/item/mod/control/pre_equipped/fulp/ert/commander/security
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/storage/box/survival/engineer = 1,
	)
	belt = /obj/item/storage/belt/security/webbing/full
	glasses = /obj/item/clothing/glasses/thermal/eyepatch
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	l_hand = /obj/item/gun/energy/e_gun

// ENGINEERING ERT OUTFITS

/datum/outfit/centcom/ert/engineer/specialized
	name = "ERT Engineer - Specialized"

	belt = /obj/item/storage/belt/utility/full/powertools
	mask = /obj/item/clothing/mask/gas
	suit_store = /obj/item/tank/internals/oxygen
	l_hand = /obj/item/analyzer

/datum/outfit/centcom/ert/commander/engineer
	name = "ERT Commander - Engineer"

	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/mod/control/pre_equipped/fulp/ert/commander/engineering
	backpack_contents = list(
		/obj/item/construction/rcd/combat = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/survival/engineer = 1,
	)
	belt = /obj/item/storage/belt/utility/full/powertools
	glasses = /obj/item/clothing/glasses/meson/engine
	mask = /obj/item/clothing/mask/gas
	r_pocket = /obj/item/rcd_ammo/large
	l_hand = /obj/item/gun/energy/e_gun

// CLOWN ERT OUTFITS

/datum/outfit/centcom/ert/clown/honk
	name = "ERT Clown - Specialized"

	backpack_contents = list(
		/obj/item/melee/energy/sword/bananium = 1,
		/obj/item/shield/energy/bananium = 1,
		/obj/item/storage/box/survival/hug = 1,
	)
	glasses = /obj/item/clothing/glasses/night

/datum/outfit/centcom/ert/clown/honk/post_equip(mob/living/carbon/human/user, visualsOnly = FALSE) // Just to make sure
	. = ..()
	if(visualsOnly)
		return
	var/obj/item/radio/equipped_radio = user.ears
	equipped_radio.keyslot = new /obj/item/encryptionkey/headset_service
	equipped_radio.recalculateChannels()
	ADD_TRAIT(user, TRAIT_NAIVE, INNATE_TRAIT)
	user.dna.add_mutation(/datum/mutation/human/clumsy)
	for(var/datum/mutation/human/clumsy/clumsy_mutation in user.dna.mutations)
		clumsy_mutation.mutadone_proof = TRUE

/datum/outfit/centcom/ert/clown/commander
	name = "ERT Commander - Clown"

	back = /obj/item/mod/control/pre_equipped/fulp/ert/commander/clown
	backpack_contents = list(
		/obj/item/melee/energy/sword/bananium = 1,
		/obj/item/shield/energy/bananium = 1,
		/obj/item/storage/box/survival/hug = 1,
		/obj/item/storage/box/fireworks = 2,
	)
	glasses = /obj/item/clothing/glasses/night
	shoes = /obj/item/clothing/shoes/clown_shoes/banana_shoes/combat
	l_hand = /obj/item/pneumatic_cannon/pie/selfcharge

/datum/outfit/centcom/ert/clown/commander/post_equip(mob/living/carbon/human/user, visualsOnly = FALSE) // Same here
	. = ..()
	if(visualsOnly)
		return
	var/obj/item/radio/equipped_radio = user.ears
	equipped_radio.keyslot = new /obj/item/encryptionkey/headset_service
	equipped_radio.recalculateChannels()
	ADD_TRAIT(user, TRAIT_NAIVE, INNATE_TRAIT)
	user.dna.add_mutation(/datum/mutation/human/clumsy)
	for(var/datum/mutation/human/clumsy/clumsy_mutation in user.dna.mutations)
		clumsy_mutation.mutadone_proof = TRUE
