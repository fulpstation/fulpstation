/datum/outfit/vr
	name = "Basic VR"

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/vr
	uniform = /obj/item/clothing/under/color/random
	ears = /obj/item/radio/headset
	shoes = /obj/item/clothing/shoes/sneakers/black

/datum/outfit/vr/pre_equip(mob/living/carbon/human/H)
	H.dna.species.before_equip_job(null, H)

/datum/outfit/vr/syndicate
	name = "Syndicate VR Operative - Basic"

	id = /obj/item/card/id/advanced/chameleon/black
	id_trim = /datum/id_trim/vr/operative
	uniform = /obj/item/clothing/under/syndicate
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/kitchen/knife/combat/survival = 1,
)
	belt = /obj/item/gun/ballistic/automatic/pistol
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/paper/fluff/vr/fluke_ops

/datum/outfit/vr/syndicate/post_equip(mob/living/carbon/human/H)
	. = ..()
	var/obj/item/uplink/U = new /obj/item/uplink/nuclear_restricted(H, H.key, 80)
	H.equip_to_slot_or_del(U, ITEM_SLOT_BACKPACK)
	var/obj/item/implant/weapons_auth/W = new/obj/item/implant/weapons_auth(H)
	W.implant(H)
	var/obj/item/implant/explosive/E = new/obj/item/implant/explosive(H)
	E.implant(H)
	H.faction |= ROLE_SYNDICATE
	H.update_icons()

/obj/item/paper/fluff/vr/fluke_ops
	name = "Where is my uplink?"
	info = "Use the radio in your backpack."
