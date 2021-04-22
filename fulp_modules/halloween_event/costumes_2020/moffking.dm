/obj/item/clothing/suit/moffking
	name = "moffking chainmail"
	desc = "A cold chainmail from a frozen moon. The chains are made of plastic altough."
	icon = 'fulp_modules/halloween_event/costumes_2020/moffking_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/moffking_worn.dmi'
	icon_state = "chainmail"

/obj/item/clothing/head/moffking
	name = "moffking helmet"
	desc = "A sturdy helmet with a frontal, gold trimmed, mask. It's in plastic tough, it won't protect anything."
	icon = 'fulp_modules/halloween_event/costumes_2020/moffking_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/moffking_worn.dmi'
	icon_state = "helmet"

/obj/item/clothing/neck/moffking
	name = "moffking shoulderpads"
	desc = "It even comes with a cape!"
	icon = 'fulp_modules/halloween_event/costumes_2020/moffking_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/moffking_worn.dmi'
	icon_state = "shoulders_white"
	var/cloakcolor

/obj/item/clothing/neck/moffking/Initialize()
	. = ..()
	if(cloakcolor)
		name = "moffking [cloakcolor] shoulderpads"
		desc = "It even comes with a [cloakcolor] cape!."
		icon_state = "shoulders_[cloakcolor]"

/obj/item/clothing/neck/moffking/black
	cloakcolor = "black"

/obj/item/clothing/neck/moffking/blue
	cloakcolor = "blue"

/obj/item/clothing/neck/moffking/green
	cloakcolor = "green"

/obj/item/clothing/neck/moffking/purple
	cloakcolor = "purple"

/obj/item/clothing/neck/moffking/red
	cloakcolor = "red"

/obj/item/clothing/neck/moffking/orange
	cloakcolor = "orange"

/obj/item/clothing/neck/moffking/white
	cloakcolor = "white"

/obj/item/clothing/neck/moffking/yellow
	cloakcolor = "yellow"

/obj/item/storage/box/halloween/edition_20/moffking
	theme_name = "2020's Moffking"
	illustration = "mask"
	var/cloakcolor

/obj/item/storage/box/halloween/edition_20/moffking/PopulateContents()
	new /obj/item/clothing/suit/moffking(src)
	new /obj/item/clothing/head/moffking(src)
	new /obj/item/shield/riot/buckler(src)

	cloakcolor = pick("black", "blue", "green", "purple", "red", "orange", "white", "yellow")
	switch(cloakcolor)
		if("black")
			new /obj/item/clothing/neck/moffking/black(src)

		if("blue")
			new /obj/item/clothing/neck/moffking/blue(src)

		if("green")
			new /obj/item/clothing/neck/moffking/green(src)

		if("purple")
			new /obj/item/clothing/neck/moffking/purple(src)

		if("red")
			new /obj/item/clothing/neck/moffking/red(src)

		if("orange")
			new /obj/item/clothing/neck/moffking/orange(src)

		if("white")
			new /obj/item/clothing/neck/moffking/white(src)

		if("yellow")
			new /obj/item/clothing/neck/moffking/yellow(src)
