/**
 * Princess costumes
 * Made by: Horatio/Joyce
 * Too many items to be worth moving into the main file.
 */

///Alice
/obj/item/clothing/suit/costume_2020/wonderland
	name = "wonderland dress"
	desc = "It's no use going back to yesterday, because I was a different person then."
	icon_state = "wonderland"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/shoes/costume_2020/wonderland
	name = "dainty shoes"
	desc = "How long is forever?"
	icon_state = "dainty_shoes"

///Belle
/obj/item/clothing/suit/costume_2020/beauty
	name = "beauty's dress"
	desc = "A golden dress of extreme beauty."
	icon_state = "beauty"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/head/costume_2020/beauty
	name = "beauty's wig"
	desc = "A brown wig with a golden hair band."
	icon_state = "beauty_wig"
	flags_inv = HIDEHAIR

/obj/item/clothing/gloves/costume_2020/beauty
	name = "beauty's gloves"
	desc = "A pair of golden elbow length gloves."
	icon_state = "beauty_gloves"

///Brave
/obj/item/clothing/suit/costume_2020/tenacious
	name = "tenacious scottish princess dress"
	desc = "A long dress that is light and confortable."
	icon_state = "tenacious"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/head/costume_2020/tenacious
	name = "tenacious scottish princess wig"
	desc = "The pretty colored wig."
	icon_state = "tenacious_wig"
	flags_inv = HIDEHAIR

///Cruella
/obj/item/clothing/under/costume_2020/cruel_devil
	name = "cruel devil's dress"
	desc = "A sharp black dress."
	icon_state = "cruel_devil_dress"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2020/cruel_devil
	name = "cruel devil's coat"
	desc = "Yes, it's fake fur..."
	icon_state = "cruel_devil_coat"

/obj/item/clothing/head/costume_2020/cruel_devil
	name = "cruel devil's wig"
	desc = "For when you want to be noticed."
	icon_state = "cruel_devil_wig"
	flags_inv = HIDEHAIR

/obj/item/clothing/gloves/costume_2020/cruel_devil
	name = "cruel devil's gloves"
	desc = "A pair of classy gloves."
	icon_state = "cruel_devil_gloves"

/obj/item/clothing/shoes/costume_2020/cruel_devil
	name = "cruel devil's shoes"
	desc = "A pair of classy shoes."
	icon_state = "cruel_devil_shoes"

///Jasmine
/obj/item/clothing/under/costume_2020/arabian
	name = "arabian princess dress"
	desc = "You will be the last drop of water in the desert with this."
	icon_state = "arabian"
	body_parts_covered = CHEST|GROIN|LEGS
	female_sprite_flags = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/head/costume_2020/arabian
	name = "arabian princess wig"
	desc = "It's a dazzling tiara on top of a wig."
	icon_state = "arabian_wig"
	flags_inv = HIDEHAIR

///Snow White
/obj/item/clothing/suit/costume_2020/sleeper
	name = "sleeper's dress"
	desc = "It actually doesn't look comfortable to sleep on."
	icon_state = "sleeper"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/head/costume_2020/sleeper
	name = "sleeper's wig"
	desc = "A wig with a red tiara on top of it."
	icon_state = "sleeper_wig"
	flags_inv = HIDEHAIR

///Skeletor
/obj/item/clothing/suit/costume_2020/skeletor
	name = "Skeletor"
	desc = "Spooky."
	icon_state = "skeletor"

/obj/item/clothing/head/costume_2020/skeletor
	name = "Skeletor"
	desc = "Scary."
	icon_state = "skeletor_hood"

///Octopus
/obj/item/clothing/suit/costume_2020/octopus
	name = "octopus"
	desc = "Not a princess suit."
	icon_state = "octopus"

/obj/item/clothing/head/costume_2020/octopus
	name = "octopus"
	desc = "Not a princess mask."
	icon_state = "octopus_head"

/obj/item/clothing/gloves/costume_2020/octopus
	name = "octopus gloves"
	desc = "Not a princess gloves."
	icon_state = "octopus_gloves"

/obj/item/storage/box/halloween/edition_20/princess
	theme_name = "2020's Princess -- Random"
	var/princess

/obj/item/storage/box/halloween/edition_20/princess/PopulateContents()
	if(costume_contents.len)
		return ..()
	princess = pick("wonderland", "beauty", "tenacious", "cruel devil", "arabian", "sleeper", "skeletor", "octopus")
	switch(princess)
		if("wonderland")
			costume_contents = list(
				/obj/item/clothing/suit/costume_2020/wonderland,
				/obj/item/clothing/shoes/costume_2020/wonderland,
			)

		if("beauty")
			costume_contents = list(
				/obj/item/clothing/suit/costume_2020/beauty,
				/obj/item/clothing/head/costume_2020/beauty,
				/obj/item/clothing/gloves/costume_2020/beauty,
			)

		if("tenacious")
			costume_contents = list(
				/obj/item/clothing/suit/costume_2020/tenacious,
				/obj/item/clothing/head/costume_2020/tenacious,
			)

		if("cruel devil")
			costume_contents = list(
				/obj/item/clothing/under/costume_2020/cruel_devil,
				/obj/item/clothing/suit/costume_2020/cruel_devil,
				/obj/item/clothing/head/costume_2020/cruel_devil,
				/obj/item/clothing/gloves/costume_2020/cruel_devil,
				/obj/item/clothing/shoes/costume_2020/cruel_devil,
			)

		if("arabian")
			costume_contents = list(
				/obj/item/clothing/under/costume_2020/arabian,
				/obj/item/clothing/head/costume_2020/arabian,
//				/obj/item/clothing/neck/costume_2020/arabian,
			)

		if("sleeper")
			costume_contents = list(
				/obj/item/clothing/suit/costume_2020/sleeper,
				/obj/item/clothing/head/costume_2020/sleeper,
			)

		if("skeletor")
			costume_contents = list(
				/obj/item/clothing/suit/costume_2020/skeletor,
				/obj/item/clothing/head/costume_2020/skeletor,
			)

		if("octopus")
			costume_contents = list(
				/obj/item/clothing/suit/costume_2020/octopus,
				/obj/item/clothing/head/costume_2020/octopus,
				/obj/item/clothing/gloves/costume_2020/octopus,
			)

	// Call parent to deal with the rest
	. = ..()

/obj/item/storage/box/halloween/edition_20/princess/wonderland
	theme_name = "2020's Princess - Wonderland"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/wonderland,
		/obj/item/clothing/shoes/costume_2020/wonderland,
	)

/obj/item/storage/box/halloween/edition_20/princess/beauty
	theme_name = "2020's Princess - Beauty"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/beauty,
		/obj/item/clothing/head/costume_2020/beauty,
		/obj/item/clothing/gloves/costume_2020/beauty,
	)

/obj/item/storage/box/halloween/edition_20/princess/tenacious
	theme_name = "2020's Princess - Tenacious"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/tenacious,
		/obj/item/clothing/head/costume_2020/tenacious,
	)

/obj/item/storage/box/halloween/edition_20/princess/cruel_devil
	theme_name = "2020's Princess - Cruel devil"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/cruel_devil,
		/obj/item/clothing/suit/costume_2020/cruel_devil,
		/obj/item/clothing/head/costume_2020/cruel_devil,
		/obj/item/clothing/gloves/costume_2020/cruel_devil,
		/obj/item/clothing/shoes/costume_2020/cruel_devil,
	)

/obj/item/storage/box/halloween/edition_20/princess/arabian
	theme_name = "2020's Princess - Arabian"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/arabian,
		/obj/item/clothing/head/costume_2020/arabian,
//		/obj/item/clothing/neck/costume_2020/arabian,
	)

/obj/item/storage/box/halloween/edition_20/princess/sleeper
	theme_name = "2020's Princess - Sleeper"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/sleeper,
		/obj/item/clothing/head/costume_2020/sleeper,
	)

/obj/item/storage/box/halloween/edition_20/princess/skeletor
	theme_name = "2020's Princess - Skeletor"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/skeletor,
		/obj/item/clothing/head/costume_2020/skeletor,
	)

/obj/item/storage/box/halloween/edition_20/princess/octopus
	theme_name = "2020's Princess - Octopus"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/octopus,
		/obj/item/clothing/head/costume_2020/octopus,
		/obj/item/clothing/gloves/costume_2020/octopus,
	)
