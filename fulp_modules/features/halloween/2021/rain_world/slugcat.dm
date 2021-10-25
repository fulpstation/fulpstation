/**
 * Slug cat
 * From: Rain World
 * By: Sheets
 */



/obj/item/clothing/suit/hooded/costume_2021/slugcat
	name = "slugcat onesie"
	desc = "A snuggly animal oneise, made from a stretchy hide."
	icon_state = "slugcat"
	greyscale_config = /datum/greyscale_config/slugcat
	greyscale_config_worn = /datum/greyscale_config/slugcat/worn
	greyscale_colors = "#FFFFFF"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	hoodtype = /obj/item/clothing/head/hooded/costume_2021/slugcat_head
	var/static/list/slugcat_onesie_colours = list(
		"#ffec3e",
		"#FFFFFF",
		"#ff4040",
		"#b72cee",
		"#2495e0",
		"#32bb2e",
		"#ff7e28",
	)

/obj/item/clothing/head/hooded/costume_2021/slugcat_head
	name = "slugcat hoodie"
	icon_state = "slugcat_head"
	greyscale_config = /datum/greyscale_config/slugcat_head
	greyscale_config_worn = /datum/greyscale_config/slugcat_head/worn
	greyscale_colors = "#FFFFFF"
	body_parts_covered = HEAD
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/suit/hooded/costume_2021/slugcat/Initialize(mapload)
	. = ..()
	var/slugcat_onesie_colour = pick(slugcat_onesie_colours)

	set_greyscale(slugcat_onesie_colour)
	hood.set_greyscale(slugcat_onesie_colour)

/obj/item/clothing/suit/hooded/costume_2021/slugcat/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "slugcat_emissive", alpha = src.alpha)

/obj/item/clothing/head/hooded/costume_2021/slugcat_head/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "slugcathead_emissive", alpha = src.alpha)

/obj/item/storage/box/halloween/edition_21/slugcat
	theme_name = "2021's Slugcat Onesie"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/costume_2021/slugcat,
	)
