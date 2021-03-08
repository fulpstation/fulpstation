//This is a file for all the machine Initializations that one may need to change a tg file without actually changing it. its named vending till both this and lampless hardhat get merged.

// ------------------
//    LOCKERS START
// ------------------

/obj/structure/closet/secure_closet/brig/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/security/pris(src)
	. = ..()

// ----------------
//    LOCKERS END
// ----------------
