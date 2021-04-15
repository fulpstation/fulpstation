/obj/item/clothing/under/costume/nextadventure_uniform
	name = "next adventure dress"
	desc = "A dress perfectly designed to withstand oncoming magic projectile. Too bad the magic it can withstand is not the same as here."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "nextadventure_uniform"
	fitted = NO_FEMALE_UNIFORM
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/head/nextadventure_ears
	name = "next adventure bunny ears"
	desc = "A pair of bunny ears to fully attest how much you love bunnies (or perhaps that you are one?)."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "nextadventure_ears"

/obj/item/clothing/shoes/nextadventure_boots
	name = "next adventure boots"
	desc = "A pair of long boots that are quite to keep your feets and legs in good condition after dodging magical bullets all day."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "nextadventure_boots"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes

/*
/obj/item/storage/belt/nextadventure_belt
	name = "next adventure belt"
	desc = "A nice double belt with some pockets, mainly used to carry your bunnylicious meal."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "nextadventure_belt"

/obj/item/storage/belt/nextadventure_belt/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 4
	STR.set_holdable(list(
		/obj/item/reagent_containers/food/snacks/grown/carrot
		))

/obj/item/storage/belt/nextadventure_belt/full/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/grown/carrot(src)
	new /obj/item/reagent_containers/food/snacks/grown/carrot(src)
	new /obj/item/reagent_containers/food/snacks/grown/carrot(src)
	new /obj/item/reagent_containers/food/snacks/grown/carrot(src)

/obj/item/storage/backpack/nextadventure_fairy
	name = "Ribbon"
	desc = "A little fairy that can shoot ranged magic bolts. Too bad space is too far away from home, so she can only store items with magic."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	icon_state = "nextadventure_fairy"
*/

/obj/item/reagent_containers/spray/hairdye_purple
	name = "purple hair dye"
	desc = "A spray can that contain a small amount of Polypyrylium Oligomers, usually used to heal lungs and bruises, but it also double as a nice purple hair dye."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	icon_state = "hairdye_purple"
	inhand_icon_state = "hairdye_purple"
	volume = 3
	stream_range = 1
	amount_per_transfer_from_this = 1
	list_reagents = list(/datum/reagent/medicine/polypyr = 3)


/obj/item/storage/box/halloween/edition_19/nextadventure
	theme_name = "2019's Next adventure"

/obj/item/storage/box/halloween/edition_19/nextadventure/PopulateContents()
	new /obj/item/clothing/under/costume/nextadventure_uniform(src)
	new /obj/item/clothing/head/nextadventure_ears(src)
	new /obj/item/clothing/shoes/nextadventure_boots(src)
	new /obj/item/reagent_containers/spray/hairdye_purple(src)
