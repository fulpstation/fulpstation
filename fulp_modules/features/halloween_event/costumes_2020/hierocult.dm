/obj/item/clothing/head/hierocult
	name = "Hierophant cultist helmet"
	desc = "A strange, flashing helmet worn by the Hierophant cultists... or just fans of it."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/hierocult_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/hierocult_worn.dmi'
	icon_state = "helmet"

/obj/item/clothing/suit/hierocult
	name = "Hierophant cultist robe"
	desc = "A strange metalic robe but flexible like fabric. Worn by the Hierophant cultists... or just fans of it."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/hierocult_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/hierocult_worn.dmi'
	icon_state = "robe"

/obj/item/storage/box/halloween/edition_20/hierocult
	theme_name = "2020's Hierophant's cultist"
	illustration = "mask"

/obj/item/storage/box/halloween/edition_20/hierocult/PopulateContents()
	new /obj/item/clothing/suit/hierocult(src)
	new /obj/item/clothing/head/hierocult(src)
