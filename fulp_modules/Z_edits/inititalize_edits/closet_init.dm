/// Security locker ID edits - Adds ACCESS_WEAPONS to Security lockers.
/obj/structure/closet/secure_closet/security
	req_access = list(ACCESS_WEAPONS, ACCESS_SECURITY)

/obj/structure/closet/secure_closet/brig/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/security/pris(src)
	return ..()
