/obj/structure/closet/secure_closet/deputy
	name = "\proper deputy locker"
	req_access = list(ACCESS_SECURITY)
	icon = 'fulp_modules/features/jobs/icons/deputy_lockers.dmi'
	icon_state = "deputy"

/obj/structure/closet/secure_closet/deputy/PopulateContents()
	..()
	new /obj/item/clothing/gloves/fingerless(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/storage/belt/security/deputy(src)
	new /obj/item/crowbar/red(src)

/**
 * # ENGINEERING
 */
/obj/structure/closet/secure_closet/deputy/engineering
	name = "\proper engineering deputy locker"
	req_access = list(ACCESS_SECURITY, ACCESS_ENGINE_EQUIP)
	icon_state = "deputy_eng"

/obj/structure/closet/secure_closet/deputy/engineering/PopulateContents()
	..()
	new /obj/item/clothing/head/fulpberet/engineering(src)

/**
 * # MEDICAL
 */
/obj/structure/closet/secure_closet/deputy/medical
	name = "\proper medical deputy locker"
	req_access = list(ACCESS_SECURITY, ACCESS_VIROLOGY)
	icon_state = "deputy_med"

/obj/structure/closet/secure_closet/deputy/medical/PopulateContents()
	..()
	new /obj/item/clothing/head/fulpberet/medical(src)

/**
 * # SCIENCE
 */
/obj/structure/closet/secure_closet/deputy/science
	name = "\proper science deputy locker"
	req_access = list(ACCESS_SECURITY, ACCESS_ROBOTICS)
	icon_state = "deputy_sci"

/obj/structure/closet/secure_closet/deputy/science/PopulateContents()
	..()
	new /obj/item/clothing/head/fulpberet/science(src)
	new /obj/item/reagent_containers/hypospray/medipen/mutadone(src)
	new /obj/item/reagent_containers/hypospray/medipen/mutadone(src)
	new /obj/item/reagent_containers/hypospray/medipen/mutadone(src)

/**
 * # SUPPLY
 */
/obj/structure/closet/secure_closet/deputy/supply
	name = "\proper supply deputy locker"
	req_access = list(ACCESS_SECURITY, ACCESS_QM)
	icon_state = "deputy_sup"

/obj/structure/closet/secure_closet/deputy/supply/PopulateContents()
	..()
	new /obj/item/clothing/head/fulpberet/supply(src)
	new /obj/item/export_scanner(src)

/**
 * # SERVICE
 */
/obj/structure/closet/secure_closet/deputy/service
	name = "\proper service deputy locker"
	req_access = list(ACCESS_SECURITY, ACCESS_KITCHEN)
	icon_state = "deputy_srv"

/obj/structure/closet/secure_closet/deputy/service/PopulateContents()
	..()
	new /obj/item/clothing/head/fulpberet/service(src)
