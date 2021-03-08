// This is a code file for everything to do with wintercoats made by fulp. - Homingpenguins

/obj/item/clothing/suit/hooded/wintercoat/fulp //the baseline fulp wintercoat, so i dont have to repeat the same exact lines every 5 seconds.
	name = "fulp"
	desc = "fulp"
	icon = 'fulp_modules/wintercoats/icons/wintercoats_icons.dmi'
	worn_icon = 'fulp_modules/wintercoats/icons/wintercoats.dmi'
	lefthand_file = 'fulp_modules/wintercoats/icons/wintercoat_lefthand.dmi'
	righthand_file = 'fulp_modules/wintercoats/icons/wintercoat_righthand.dmi'
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	strip_delay = 80 // Anti-ERP Technology?
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp

/obj/item/clothing/head/hooded/winterhood/fulp
	worn_icon = 'fulp_modules/wintercoats/icons/wintercoats.dmi'
	icon = 'fulp_modules/wintercoats/icons/wintercoathoods.dmi'

/obj/item/clothing/suit/hooded/wintercoat/fulp/security/pris
	name = "\improper prisioner's winter coat"
	desc = "Made just for the times when the prison runs out of working space heaters."
	icon_state = "wintercoat_pris"
	inhand_icon_state = "wintercoat_pris"
	allowed = list(/obj/item/paper, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/security/pris

/obj/item/clothing/head/hooded/winterhood/fulp/security/pris
	icon_state = "winterhood_pris"