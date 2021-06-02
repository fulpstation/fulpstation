/datum/outfit/syndicate/clownop
	name = "Clown Operative - Basic"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/clown_shoes/combat
	mask = /obj/item/clothing/mask/gas/clown_hat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/clown
	ears = /obj/item/radio/headset/syndicate/alt
	l_pocket = /obj/item/pinpointer/nuke/syndicate
	r_pocket = /obj/item/bikehorn
	id = /obj/item/card/id/advanced/chameleon
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,
		/obj/item/dnainjector/clumsymut, //in case you want to be clumsy for the memes
		/obj/item/storage/box/syndie_kit/clownpins, //for any guns that you get your grubby little clown op mitts on
		/obj/item/reagent_containers/spray/waterflower/lube)
	implants = list(/obj/item/implant/sad_trombone)

	uplink_type = /obj/item/uplink/clownop

	id_trim = /datum/id_trim/chameleon/operative/clown

/datum/outfit/syndicate/clownop/no_crystals
	tc = 0

/datum/outfit/syndicate/clownop/leader
	name = "Clown Operative Leader - Basic"
	gloves = /obj/item/clothing/gloves/krav_maga/combatglovesplus
	command_radio = TRUE

	id_trim = /datum/id_trim/chameleon/operative/clown_leader
