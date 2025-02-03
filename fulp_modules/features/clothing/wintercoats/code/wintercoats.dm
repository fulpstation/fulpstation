// This is a code file for everything to do with wintercoats made by fulp. - Homingpenguins

/obj/item/clothing/suit/hooded/wintercoat/security/pris
	name = "\improper prisoner's winter coat"
	desc = "Made just for the times when the prison runs out of working space heaters."
	icon = 'fulp_modules/icons/clothing/wintercoats_icons.dmi'
	worn_icon = 'fulp_modules/icons/clothing/wintercoats.dmi'
	lefthand_file = 'fulp_modules/icons/clothing/wintercoat_lefthand.dmi'
	righthand_file = 'fulp_modules/icons/clothing/wintercoat_righthand.dmi'
	icon_state = "wintercoat_pris"
	inhand_icon_state = "wintercoat_pris"
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/paper, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor_type = /datum/armor/wintercoat_miner
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/security/pris

/obj/item/clothing/head/hooded/winterhood/fulp/security/pris
	worn_icon = 'fulp_modules/icons/clothing/wintercoats.dmi'
	icon = 'fulp_modules/icons/clothing/wintercoathoods.dmi'
	icon_state = "winterhood_pris"
