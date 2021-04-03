/obj/structure/closet/secure_closet/research_director
	name = "\proper research director's locker"
	req_access = list(ACCESS_RD)
	icon_state = "rd"

/obj/structure/closet/secure_closet/research_director/PopulateContents()
	..()
	new /obj/item/clothing/neck/cloak/rd(src)
	new /obj/item/clothing/suit/bio_suit/scientist(src)
	new /obj/item/clothing/head/bio_hood/scientist(src)
	new /obj/item/clothing/suit/toggle/labcoat(src)
	new /obj/item/clothing/under/rank/rnd/research_director(src)
	new /obj/item/clothing/under/rank/rnd/research_director/skirt(src)
	new /obj/item/clothing/under/rank/rnd/research_director/alt(src)
	new /obj/item/clothing/under/rank/rnd/research_director/alt/skirt(src)
	new /obj/item/clothing/under/rank/rnd/research_director/turtleneck(src)
	new /obj/item/clothing/under/rank/rnd/research_director/turtleneck/skirt(src)
	new /obj/item/clothing/head/beret/science(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/cartridge/rd(src)
	new /obj/item/radio/headset/heads/rd(src)
	new /obj/item/megaphone/command(src)
	new /obj/item/storage/lockbox/medal/sci(src)
	new /obj/item/clothing/suit/armor/reactive/teleport(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/laser_pointer(src)
	new /obj/item/door_remote/research_director(src)
	new /obj/item/circuitboard/machine/techfab/department/science(src)
	new /obj/item/storage/photo_album/rd(src)
	new /obj/item/storage/box/skillchips/science(src)
	new /obj/item/clothing/suit/hooded/wintercoat/science/rd(src)


/obj/structure/closet/secure_closet/cytology
	name = "cytology equipment locker"
	icon_state = "science"
	req_access = list(ACCESS_RESEARCH)

/obj/structure/closet/secure_closet/cytology/PopulateContents()
	. = ..()
	new /obj/item/pushbroom(src)
	new /obj/item/plunger(src)
	new /obj/item/storage/bag/bio(src)
	new /obj/item/storage/box/petridish(src)
	new /obj/item/stack/ducts/fifty(src)
	for(var/i in 1 to 2)
		new /obj/item/biopsy_tool(src)
		new /obj/item/storage/box/swab(src)
	new /obj/item/construction/plumbing/research(src)
