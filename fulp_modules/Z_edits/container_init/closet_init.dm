/obj/structure/closet/secure_closet/engineering_chief/Initialize()
	new /obj/item/clothing/shoes/workboots/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/research_director/Initialize()
	new /obj/item/clothing/shoes/laceup/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/chief_medical/Initialize()
	new /obj/item/clothing/shoes/brown/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/hop/Initialize()
	new /obj/item/clothing/shoes/brown/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/hos/Initialize()
	new /obj/item/clothing/shoes/jackboots/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/captains/Initialize()
	new /obj/item/clothing/shoes/brown/digitigrade(src)
	. = ..()

/// Security locker ID edits - Adds ACCESS_WEAPONS to Security lockers.
/obj/structure/closet/secure_closet/security
	req_access = list(ACCESS_WEAPONS, ACCESS_SECURITY)

/obj/structure/closet/secure_closet/security/Initialize()
	new /obj/item/clothing/shoes/jackboots/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/medical3/Initialize()
	new /obj/item/clothing/shoes/brown/digitigrade(src)
	. = ..()

/obj/structure/closet/wardrobe/miner/Initialize()
	new /obj/item/clothing/shoes/workboots/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/brig/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/security/pris(src)
	. = ..()
