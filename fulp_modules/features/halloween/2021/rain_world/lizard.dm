/**
 * Lizard
 * From: Rain World
 * By: Sheets
 */

/obj/item/clothing/suit/hooded/costume_2021/lizard
	name = "slugcat lizard onesie"
	desc = "A snuggly animal oneise, made from a stretchy hide."
	icon_state = "lizard"
	greyscale_config = /datum/greyscale_config/lizard_onesie
	greyscale_config_worn = /datum/greyscale_config/lizard_onesie/worn
	greyscale_colors = "#FFFFFF"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	hoodtype = /obj/item/clothing/head/hooded/costume_2021/lizard_head
	var/static/list/lizard_onesie_colours = list(
		"#ffec3e",
		"#FFFFFF",
		"#ff4040",
		"#b72cee",
		"#2495e0",
		"#32bb2e",
		"#ff7e28",
	)

/obj/item/clothing/head/hooded/costume_2021/lizard_head
	name = "slugcat lizard hoodie"
	icon_state = "lizard_head"
	greyscale_config = /datum/greyscale_config/lizard_onesie_head
	greyscale_config_worn = /datum/greyscale_config/lizard_onesie_head/worn
	greyscale_colors = "#FFFFFF"
	body_parts_covered = HEAD
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEMASK

/obj/item/clothing/suit/hooded/costume_2021/lizard/Initialize(mapload)
	. = ..()
	var/lizard_onesie_colour = pick(lizard_onesie_colours)

	set_greyscale(lizard_onesie_colour)
	hood.set_greyscale(lizard_onesie_colour)

/obj/item/clothing/suit/hooded/costume_2021/lizard/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "lizard_emissive", alpha = src.alpha)

/obj/item/clothing/head/hooded/costume_2021/lizard_head/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "lizardhead_emissive", alpha = src.alpha)

/obj/item/storage/box/halloween/edition_21/lizard
	theme_name = "2021's Slugcat Lizard Onesie"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/costume_2021/lizard,
	)

