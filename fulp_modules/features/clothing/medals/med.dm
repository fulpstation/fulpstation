/obj/item/storage/lockbox/medal/med
	name = "medical medal box"
	desc = "A locked box used to store medals to be given to members of the medical department."
	req_access = list(ACCESS_CMO)

/obj/item/storage/lockbox/medal/med/PopulateContents()
	new /obj/item/clothing/accessory/medal/med_ribbon(src)
	new /obj/item/clothing/accessory/medal/med_exemp(src)
	new /obj/item/clothing/accessory/medal/med_excell(src)

/obj/item/clothing/accessory/medal/med_ribbon
	name = "distinguished conduct ribbon"
	desc = "An award given to those who have performed above the expectations set for them. The most basic award."
	icon_state = "med_ribbon"
	icon = 'fulp_modules/features/clothing/medals/med_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/medals/med_worn.dmi'
	above_suit = TRUE

/obj/item/clothing/accessory/medal/med_exemp
	name = "exemplary performance medal"
	desc = "A medal awarded to those who have shown distinguished conduct, performance, and initiative within the medical department."
	icon_state = "med_exemp"
	icon = 'fulp_modules/features/clothing/medals/med_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/medals/med_worn.dmi'
	above_suit = TRUE

/obj/item/clothing/accessory/medal/med_excell
	name = "excellence in medicine medal"
	desc = "A medal awarded to those who have shown legendary performance, competence, and initiative beyond all expectations within the medical department. It looks just like the Chief Medical Officer's cape."
	icon_state = "med_excell"
	icon = 'fulp_modules/features/clothing/medals/med_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/medals/med_worn.dmi'
	above_suit = TRUE