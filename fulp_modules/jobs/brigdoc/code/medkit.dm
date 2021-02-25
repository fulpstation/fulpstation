/obj/item/storage/firstaid/medical/brigdoc
	name = "medical aid kit"
	icon = 'fulp_modules/jobs/brigdoc/icons/medkit.dmi'
	lefthand_file = 'fulp_modules/jobs/brigdoc/icons/medkit_lefthand.dmi'
	righthand_file = 'fulp_modules/jobs/brigdoc/icons/medkit_righthand.dmi'
	icon_state = "brigdoc_medkit"
	inhand_icon_state = "brigdoc_medkit"
	desc = "A high capacity aid kit for brig physicians, full of medical supplies and basic equipment to aid them in their duties."

/obj/item/storage/firstaid/medical/brigdoc/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze/twelve = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/reagent_containers/glass/bottle/formaldehyde= 1,
		/obj/item/sensor_device = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/scalpel = 1,
		/obj/item/hemostat = 1,
		/obj/item/cautery = 1)
	generate_items_inside(items_inside,src)
