// This is a code file for everything to do with wintercoats made by fulp. - Homingpenguins

/obj/item/clothing/suit/hooded/wintercoat/security/pris
	name = "\improper prisioner's winter coat"
	desc = "Made just for the times when the prison runs out of working space heaters."
	icon = 'fulp_modules/fulp_clothing/wintercoats/icons/wintercoats_icons.dmi'
	worn_icon = 'fulp_modules/fulp_clothing/wintercoats/icons/wintercoats.dmi'
	lefthand_file = 'fulp_modules/fulp_clothing/wintercoats/icons/wintercoat_lefthand.dmi'
	righthand_file = 'fulp_modules/fulp_clothing/wintercoats/icons/wintercoat_righthand.dmi'
	icon_state = "wintercoat_pris"
	inhand_icon_state = "wintercoat_pris"
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/paper, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/security/pris

/obj/item/clothing/head/hooded/winterhood/fulp/security/pris
	worn_icon = 'fulp_modules/fulp_clothing/wintercoats/icons/wintercoats.dmi'
	icon = 'fulp_modules/fulp_clothing/wintercoats/icons/wintercoathoods.dmi'
	icon_state = "winterhood_pris"
