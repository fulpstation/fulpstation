//a container for all the machine Initializations that one may need to change a tg file without actually changing it. ment for machines, but named vending till both this and lampless hardhat get merged.

/obj/structure/closet/secure_closet/hos/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/security/head(src)
	. = ..()

/obj/structure/closet/secure_closet/chief_medical/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/medical/head(src)
	. = ..()

/obj/structure/closet/secure_closet/research_director/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/science/head(src)
	. = ..()

/obj/structure/closet/secure_closet/engineering_chief/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/engineering/head(src)
	. = ..()

/obj/structure/closet/secure_closet/hop/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/captain/hop(src)
	. = ..()

/obj/structure/closet/secure_closet/quartermaster/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/cargo/head(src)
	. = ..()

/obj/machinery/vending/wardrobe/law_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/security/lawyer = 2)
	. = ..()

/obj/machinery/vending/wardrobe/bar_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/service/bartender = 2)
	. = ..()

/obj/machinery/vending/wardrobe/chem_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/chem = 3)
	. = ..()

/obj/machinery/vending/wardrobe/gene_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/gen = 3)
	. = ..()

/obj/structure/closet/secure_closet/brig/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/security/pris(src)
	. = ..()

/obj/machinery/vending/wardrobe/medi_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/para = 3)
	. = ..()

/obj/machinery/vending/wardrobe/chap_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/service/chap = 2)
	. = ..()

//the future mechanic wintercoat goes here.

/*
/obj/machinery/vending/wardrobe/mech_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/engineering/mech = 2)
	. = ..()
*/

/obj/structure/closet/secure_closet/psychology/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/medical/psych(src)
	. = ..()

/obj/machinery/vending/autodrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/service/mime = 2, /obj/item/clothing/suit/hooded/wintercoat/fulp/service/clown = 2)
	. = ..()

/obj/machinery/vending/wardrobe/chef_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/service/chef = 2)
	. = ..()
