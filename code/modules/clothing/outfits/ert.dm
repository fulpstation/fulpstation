/datum/outfit/centcom/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/implant/mindshield/L = new/obj/item/implant/mindshield(H)//hmm lets have centcom officials become revs
	L.implant(H, null, 1)

/datum/outfit/centcom/ert
	name = "ERT Common"

	uniform = /obj/item/clothing/under/rank/centcom/officer
	ears = /obj/item/radio/headset/headset_cent/alt
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/clothing/mask/gas/sechailer
	shoes = /obj/item/clothing/shoes/combat/swat
	toggle_helmet = FALSE

/datum/outfit/centcom/ert/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_CENTCOM)
	R.freqlock = TRUE

	var/obj/item/card/id/W = H.wear_id
	if(W)
		W.registered_name = H.real_name
		W.update_label()
		W.update_icon()
	return ..()

/datum/outfit/centcom/ert/commander
	name = "ERT Commander"

	id = /obj/item/card/id/advanced/centcom/ert
	suit = /obj/item/clothing/suit/space/hardsuit/ert
	suit_store = /obj/item/gun/energy/e_gun
	back = /obj/item/storage/backpack/ert
	backpack_contents = list(
		/obj/item/melee/baton/loaded = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/security/full
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	l_pocket = /obj/item/switchblade

/datum/outfit/centcom/ert/commander/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return
	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/heads/captain
	R.recalculateChannels()

/datum/outfit/centcom/ert/commander/alert
	name = "ERT Commander - High Alert"

	backpack_contents = list(
		/obj/item/gun/energy/pulse/pistol/loyalpin = 1,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	glasses = /obj/item/clothing/glasses/thermal/eyepatch
	l_pocket = /obj/item/melee/transforming/energy/sword/saber

/datum/outfit/centcom/ert/security
	name = "ERT Security"

	id = /obj/item/card/id/advanced/centcom/ert/security
	suit = /obj/item/clothing/suit/space/hardsuit/ert/sec
	suit_store = /obj/item/gun/energy/e_gun/stun
	back = /obj/item/storage/backpack/ert/security
	backpack_contents = list(
		/obj/item/melee/baton/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/security/full
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated

/datum/outfit/centcom/ert/security/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/heads/hos
	R.recalculateChannels()

/datum/outfit/centcom/ert/security/alert
	name = "ERT Security - High Alert"

	belt = /obj/item/gun/energy/pulse/carbine/loyalpin
	backpack_contents = list(
		/obj/item/melee/baton/loaded = 1,
		/obj/item/storage/belt/security/full = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/storage/box/survival/engineer = 1,
)

/datum/outfit/centcom/ert/medic
	name = "ERT Medic"

	id = /obj/item/card/id/advanced/centcom/ert/medical
	suit = /obj/item/clothing/suit/space/hardsuit/ert/med
	suit_store = /obj/item/gun/energy/e_gun
	back = /obj/item/storage/backpack/ert/medical
	backpack_contents = list(
		/obj/item/gun/medbeam = 1,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/storage/box/hug/plushes = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/medical
	glasses = /obj/item/clothing/glasses/hud/health
	l_hand = /obj/item/storage/firstaid/regular

/datum/outfit/centcom/ert/medic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/heads/cmo
	R.recalculateChannels()

/datum/outfit/centcom/ert/medic/alert
	name = "ERT Medic - High Alert"

	backpack_contents = list(
		/obj/item/gun/energy/pulse/pistol/loyalpin = 1,
		/obj/item/gun/medbeam = 1,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/reagent_containers/hypospray/combat/nanites = 1,
		/obj/item/storage/box/hug/plushes = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	mask = /obj/item/clothing/mask/gas/sechailer/swat

/datum/outfit/centcom/ert/engineer
	name = "ERT Engineer"

	id = /obj/item/card/id/advanced/centcom/ert/engineer
	suit = /obj/item/clothing/suit/space/hardsuit/ert/engi
	suit_store = /obj/item/gun/energy/e_gun
	back = /obj/item/storage/backpack/ert/engineer
	backpack_contents = list(
		/obj/item/construction/rcd/loaded/upgraded = 1,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/pipe_dispenser = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/utility/full/powertools
	glasses =  /obj/item/clothing/glasses/meson/engine
	l_pocket = /obj/item/rcd_ammo/large

/datum/outfit/centcom/ert/engineer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/heads/ce
	R.recalculateChannels()

/datum/outfit/centcom/ert/engineer/alert
	name = "ERT Engineer - High Alert"

	backpack_contents = list(
		/obj/item/construction/rcd/combat = 1,
		/obj/item/gun/energy/pulse/pistol/loyalpin = 1,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/pipe_dispenser = 1,
		/obj/item/storage/box/survival/engineer = 1,
)

/datum/outfit/centcom/centcom_official
	name = "CentCom Official"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/official
	uniform = /obj/item/clothing/under/rank/centcom/officer
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/stamp/centcom = 1,
		/obj/item/storage/box/survival = 1,
)
	belt = /obj/item/gun/energy/e_gun
	ears = /obj/item/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/sneakers/black
	l_pocket = /obj/item/pen
	r_pocket = /obj/item/pda/heads
	l_hand = /obj/item/clipboard

/datum/outfit/centcom/centcom_official/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/pda/heads/pda = H.r_store
	pda.owner = H.real_name
	pda.ownjob = "CentCom Official"
	pda.update_label()

	var/obj/item/card/id/W = H.wear_id
	W.registered_name = H.real_name
	W.update_label()
	W.update_icon()
	return ..()

/datum/outfit/centcom/ert/commander/inquisitor
	name = "Inquisition Commander"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/paranormal
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
)
	l_hand = /obj/item/nullrod/scythe/talking/chainsword

/datum/outfit/centcom/ert/security/inquisitor
	name = "Inquisition Security"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor
	suit_store = /obj/item/gun/energy/e_gun/stun
	backpack_contents = list(
		/obj/item/construction/rcd/loaded = 1,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/storage/box/survival/engineer = 1,
)

/datum/outfit/centcom/ert/medic/inquisitor
	name = "Inquisition Medic"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor
	backpack_contents = list(
		/obj/item/gun/medbeam = 1,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/reagent_containers/hypospray/combat/heresypurge = 1,
)

/datum/outfit/centcom/ert/chaplain
	name = "ERT Chaplain"

	id = /obj/item/card/id/advanced/centcom/ert/chaplain
	suit = /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor // Chap role always gets this suit
	suit_store = /obj/item/gun/energy/e_gun
	back = /obj/item/storage/backpack/cultpack
	backpack_contents = list(
		/obj/item/nullrod = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/soulstone
	glasses = /obj/item/clothing/glasses/hud/health

/datum/outfit/centcom/ert/chaplain/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/heads/hop
	R.recalculateChannels()

/datum/outfit/centcom/ert/chaplain/inquisitor
	name = "Inquisition Chaplain"

	backpack_contents = list(
		/obj/item/grenade/chem_grenade/holy = 1,
		/obj/item/nullrod = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/soulstone/full/chappy

/datum/outfit/centcom/ert/janitor
	name = "ERT Janitor"

	id = /obj/item/card/id/advanced/centcom/ert/janitor
	suit = /obj/item/clothing/suit/space/hardsuit/ert/jani
	back = /obj/item/storage/backpack/ert/janitor
	backpack_contents = list(
		/obj/item/grenade/clusterbuster/cleaner = 1,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/mop/advanced = 1,
		/obj/item/reagent_containers/glass/bucket = 1,
		/obj/item/storage/box/lights/mixed = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/janitor/full
	glasses = /obj/item/clothing/glasses/night
	l_pocket = /obj/item/grenade/chem_grenade/cleaner
	r_pocket = /obj/item/grenade/chem_grenade/cleaner
	l_hand = /obj/item/storage/bag/trash/bluespace

/datum/outfit/centcom/ert/janitor/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_service
	R.recalculateChannels()

/datum/outfit/centcom/ert/janitor/heavy
	name = "ERT Janitor - Heavy Duty"

	backpack_contents = list(
		/obj/item/grenade/clusterbuster/cleaner = 3,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/storage/box/lights/mixed = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	l_hand = /obj/item/reagent_containers/spray/chemsprayer/janitor

/datum/outfit/centcom/ert/clown
	name = "ERT Clown"

	id = /obj/item/card/id/advanced/centcom/ert/clown
	suit = /obj/item/clothing/suit/space/hardsuit/ert/clown
	back = /obj/item/storage/backpack/ert/clown
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/reverse = 1,
		/obj/item/melee/transforming/energy/sword/bananium = 1,
		/obj/item/shield/energy/bananium = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/champion
	glasses = /obj/item/clothing/glasses/godeye
	mask = /obj/item/clothing/mask/gas/clown_hat
	shoes = /obj/item/clothing/shoes/clown_shoes/combat
	l_pocket = /obj/item/food/grown/banana
	r_pocket = /obj/item/bikehorn/golden

/datum/outfit/centcom/ert/clown/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
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

/datum/outfit/centcom/centcom_intern
	name = "CentCom Intern"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/intern
	uniform = /obj/item/clothing/under/rank/centcom/intern
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
)
	belt = /obj/item/melee/classic_baton
	ears = /obj/item/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/sneakers/black
	l_pocket = /obj/item/ammo_box/a762
	r_pocket = /obj/item/ammo_box/a762
	l_hand = /obj/item/gun/ballistic/rifle/boltaction/brand_new

/datum/outfit/centcom/centcom_intern/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	W.registered_name = H.real_name
	W.update_label()
	W.update_icon()
	return ..()

/datum/outfit/centcom/centcom_intern/unarmed
	name = "CentCom Intern (Unarmed)"

	belt = null
	l_pocket = null
	r_pocket = null
	l_hand = null

/datum/outfit/centcom/centcom_intern/leader
	name = "CentCom Head Intern"

	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/rifle/boltaction/brand_new
	belt = /obj/item/melee/baton/loaded
	head = /obj/item/clothing/head/intern
	l_hand = /obj/item/megaphone

/datum/outfit/centcom/centcom_intern/leader/unarmed // i'll be nice and let the leader keep their baton and vest
	name = "CentCom Head Intern (Unarmed)"

	suit_store = null
	l_pocket = null
	r_pocket = null

/datum/outfit/centcom/ert/janitor/party
	name = "ERP Cleaning Service"

	uniform = /obj/item/clothing/under/misc/overalls
	suit = /obj/item/clothing/suit/apron
	suit_store = null
	backpack_contents = list(
		/obj/item/mop/advanced = 1,
		/obj/item/reagent_containers/glass/bucket = 1,
		/obj/item/storage/box/lights/mixed = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/janitor/full
	glasses = /obj/item/clothing/glasses/meson
	mask = /obj/item/clothing/mask/bandana/blue
	l_pocket = /obj/item/grenade/chem_grenade/cleaner
	r_pocket = /obj/item/grenade/chem_grenade/cleaner
	l_hand = /obj/item/storage/bag/trash

/datum/outfit/centcom/ert/security/party
	name = "ERP Bouncer"

	uniform = /obj/item/clothing/under/misc/bouncer
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = null
	backpack_contents = list(
		/obj/item/clothing/head/helmet/police = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/melee/classic_baton/telescopic
	l_pocket = /obj/item/assembly/flash
	r_pocket = /obj/item/storage/wallet

/datum/outfit/centcom/ert/engineer/party
	name = "ERP Constructor"

	uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	suit = /obj/item/clothing/suit/hazardvest
	suit_store = null
	backpack_contents = list(
		/obj/item/construction/rcd/loaded = 1,
		/obj/item/etherealballdeployer = 1,
		/obj/item/stack/light_w = 30,
		/obj/item/stack/sheet/glass/fifty = 1,
		/obj/item/stack/sheet/iron/fifty = 1,
		/obj/item/stack/sheet/plasteel/twenty = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	head = /obj/item/clothing/head/hardhat/weldhat
	mask = /obj/item/clothing/mask/gas/atmos
	l_hand = /obj/item/areaeditor/blueprints

/datum/outfit/centcom/ert/clown/party
	name = "ERP Comedian"

	uniform = /obj/item/clothing/under/rank/civilian/clown
	suit = /obj/item/clothing/suit/chameleon
	suit_store = null
	backpack_contents = list(
		/obj/item/instrument/piano_synth = 1,
		/obj/item/shield/energy/bananium = 1,
		/obj/item/storage/box/survival/engineer = 1,
)
	glasses = /obj/item/clothing/glasses/chameleon
	head = /obj/item/clothing/head/chameleon

/datum/outfit/centcom/ert/commander/party
	name = "ERP Coordinator"

	uniform = /obj/item/clothing/under/misc/coordinator
	suit = /obj/item/clothing/suit/coordinator
	suit_store = null
	backpack_contents = list(
		/obj/item/food/cake/birthday = 1,
		/obj/item/storage/box/fireworks = 3,
		/obj/item/storage/box/survival/engineer = 1,
)
	belt = /obj/item/storage/belt/sabre
	head = /obj/item/clothing/head/coordinator
	l_pocket = /obj/item/kitchen/knife
	l_hand = /obj/item/toy/balloon

/datum/outfit/centcom/death_commando
	name = "Death Commando"

	id = /obj/item/card/id/advanced/black/deathsquad
	id_trim = /datum/id_trim/centcom/deathsquad
	uniform = /obj/item/clothing/under/rank/centcom/commander
	suit = /obj/item/clothing/suit/space/hardsuit/deathsquad
	suit_store = /obj/item/tank/internals/emergency_oxygen/double
	back = /obj/item/storage/backpack/security
	backpack_contents = list(
		/obj/item/ammo_box/a357 = 1,
		/obj/item/flashlight = 1,
		/obj/item/grenade/c4/x4 = 1,
		/obj/item/storage/box/flashbangs = 1,
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/storage/firstaid/regular = 1,
)
	belt = /obj/item/gun/ballistic/revolver/mateba
	ears = /obj/item/radio/headset/headset_cent/alt
	glasses = /obj/item/clothing/glasses/hud/toggle/thermal
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	shoes = /obj/item/clothing/shoes/combat/swat
	l_pocket = /obj/item/melee/transforming/energy/sword/saber
	r_pocket = /obj/item/shield/energy
	l_hand = /obj/item/gun/energy/pulse/loyalpin

	skillchips = list(
		/obj/item/skillchip/disk_verifier,
)

/datum/outfit/centcom/death_commando/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_CENTCOM)
	R.freqlock = TRUE
	var/obj/item/card/id/W = H.wear_id
	W.registered_name = H.real_name
	W.update_label()
	W.update_icon()
	..()

/datum/outfit/centcom/death_commando/officer
	name = "Death Commando Officer"

	head = /obj/item/clothing/head/helmet/space/beret
