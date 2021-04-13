//--Joyce's Power Ranger costumes
/obj/item/clothing/head/power_ranger
	name = "ranger helmet"
	desc = "ranger helmet."
	icon = 'fulp_modules/halloween_event/costumes_2020/power_ranger_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/power_ranger_worn.dmi'
	icon_state = "red_helm"
	var/ranger

/obj/item/clothing/head/power_ranger/Initialize()
	. = ..()
	if(ranger)
		name = "[ranger] [name]"
		desc = "The '[ranger]' ranger helmet."
		icon_state = "[ranger]_helm"

/obj/item/clothing/head/power_ranger/black
	ranger = "black"

/obj/item/clothing/head/power_ranger/blue
	ranger = "blue"

/obj/item/clothing/head/power_ranger/green
	ranger = "green"

/obj/item/clothing/head/power_ranger/pink
	ranger = "pink"

/obj/item/clothing/head/power_ranger/red
	ranger = "red"

/obj/item/clothing/head/power_ranger/yellow
	ranger = "yellow"

//--Suits, hardsuits, jackets, bodyarmor and others
/obj/item/clothing/suit/power_ranger
	name = "ranger suit"
	desc = "ranger suit."
	icon = 'fulp_modules/halloween_event/costumes_2020/power_ranger_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/power_ranger_worn.dmi'
	icon_state = "red_ranger"
	var/ranger = "Red"
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

/obj/item/clothing/suit/power_ranger/Initialize()
	. = ..()
	if(ranger)
		name = "[ranger] [name]"
		desc = "The '[ranger]' ranger suit."
		icon_state = "[ranger]_ranger"

/obj/item/clothing/suit/power_ranger/black
	ranger = "black"

/obj/item/clothing/suit/power_ranger/blue
	ranger = "blue"

/obj/item/clothing/suit/power_ranger/green
	ranger = "green"

/obj/item/clothing/suit/power_ranger/pink
	ranger = "pink"

/obj/item/clothing/suit/power_ranger/red
	ranger = "red"

/obj/item/clothing/suit/power_ranger/yellow
	ranger = "yellow"

//--Shoes... ye
/obj/item/clothing/shoes/power_ranger
	name = "Ranger boots"
	desc = "Ranger suit."
	icon = 'fulp_modules/halloween_event/costumes_2020/power_ranger_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/power_ranger_worn.dmi'
	icon_state = "red_boots"
	var/ranger

/obj/item/clothing/shoes/power_ranger/Initialize()
	. = ..()
	if(ranger)
		name = "[ranger] [name]"
		desc = "The '[ranger]' ranger boots."
		icon_state = "[ranger]_boots"

/obj/item/clothing/shoes/power_ranger/black
	ranger = "black"

/obj/item/clothing/shoes/power_ranger/blue
	ranger = "blue"

/obj/item/clothing/shoes/power_ranger/green
	ranger = "green"

/obj/item/clothing/shoes/power_ranger/pink
	ranger = "pink"

/obj/item/clothing/shoes/power_ranger/red
	ranger = "red"

/obj/item/clothing/shoes/power_ranger/yellow
	ranger = "yellow"


//--Box that contains the costumes
/obj/item/storage/box/halloween/edition_20/power_ranger
	theme_name = "2020's Power Ranger -- Random"
	var/rangercolor

/obj/item/storage/box/halloween/edition_20/power_ranger/PopulateContents()
	rangercolor = pick("black", "blue", "green", "pink", "red", "yellow")
	switch(rangercolor)
		if("black")
			new /obj/item/clothing/head/power_ranger/black(src)
			new /obj/item/clothing/suit/power_ranger/black(src)
			new	/obj/item/clothing/shoes/power_ranger/black(src)
			new /obj/item/clothing/gloves/color/latex(src)

		if("blue")
			new /obj/item/clothing/head/power_ranger/blue(src)
			new /obj/item/clothing/suit/power_ranger/blue(src)
			new	/obj/item/clothing/shoes/power_ranger/blue(src)
			new /obj/item/clothing/gloves/color/latex(src)

		if("green")
			new /obj/item/clothing/head/power_ranger/green(src)
			new /obj/item/clothing/suit/power_ranger/green(src)
			new	/obj/item/clothing/shoes/power_ranger/green(src)
			new /obj/item/clothing/gloves/color/latex(src)

		if("pink")
			new /obj/item/clothing/head/power_ranger/pink(src)
			new /obj/item/clothing/suit/power_ranger/pink(src)
			new	/obj/item/clothing/shoes/power_ranger/pink(src)
			new /obj/item/clothing/gloves/color/latex(src)

		if("red")
			new /obj/item/clothing/head/power_ranger/red(src)
			new /obj/item/clothing/suit/power_ranger/red(src)
			new	/obj/item/clothing/shoes/power_ranger/red(src)
			new /obj/item/clothing/gloves/color/latex(src)

		if("yellow")
			new /obj/item/clothing/head/power_ranger/yellow(src)
			new /obj/item/clothing/suit/power_ranger/yellow(src)
			new	/obj/item/clothing/shoes/power_ranger/yellow(src)
			new /obj/item/clothing/gloves/color/latex(src)

/obj/item/storage/box/halloween/edition_20/power_ranger/black
	theme_name = "2020's Power Ranger - Black"

/obj/item/storage/box/halloween/edition_20/power_ranger/black/PopulateContents()
	new /obj/item/clothing/head/power_ranger/black(src)
	new /obj/item/clothing/suit/power_ranger/black(src)
	new	/obj/item/clothing/shoes/power_ranger/black(src)
	new /obj/item/clothing/gloves/color/latex(src)

/obj/item/storage/box/halloween/edition_20/power_ranger/blue
	theme_name = "2020's Power Ranger - Blue"

/obj/item/storage/box/halloween/edition_20/power_ranger/blue/PopulateContents()
	new /obj/item/clothing/head/power_ranger/blue(src)
	new /obj/item/clothing/suit/power_ranger/blue(src)
	new	/obj/item/clothing/shoes/power_ranger/blue(src)
	new /obj/item/clothing/gloves/color/latex(src)

/obj/item/storage/box/halloween/edition_20/power_ranger/green
	theme_name = "2020's Power Ranger - Green"

/obj/item/storage/box/halloween/edition_20/power_ranger/green/PopulateContents()
	new /obj/item/clothing/head/power_ranger/green(src)
	new /obj/item/clothing/suit/power_ranger/green(src)
	new	/obj/item/clothing/shoes/power_ranger/green(src)
	new /obj/item/clothing/gloves/color/latex(src)

/obj/item/storage/box/halloween/edition_20/power_ranger/pink
	theme_name = "2020's Power Ranger - Pink"

/obj/item/storage/box/halloween/edition_20/power_ranger/pink/PopulateContents()
	new /obj/item/clothing/head/power_ranger/pink(src)
	new /obj/item/clothing/suit/power_ranger/pink(src)
	new	/obj/item/clothing/shoes/power_ranger/pink(src)
	new /obj/item/clothing/gloves/color/latex(src)

/obj/item/storage/box/halloween/edition_20/power_ranger/red
	theme_name = "2020's Power Ranger - Red"

/obj/item/storage/box/halloween/edition_20/power_ranger/red/PopulateContents()
	new /obj/item/clothing/head/power_ranger/red(src)
	new /obj/item/clothing/suit/power_ranger/red(src)
	new	/obj/item/clothing/shoes/power_ranger/red(src)
	new /obj/item/clothing/gloves/color/latex(src)

/obj/item/storage/box/halloween/edition_20/power_ranger/yellow
	theme_name = "2020's Power Ranger - Yellow"

/obj/item/storage/box/halloween/edition_20/power_ranger/yellow/PopulateContents()
	new /obj/item/clothing/head/power_ranger/yellow(src)
	new /obj/item/clothing/suit/power_ranger/yellow(src)
	new	/obj/item/clothing/shoes/power_ranger/yellow(src)
	new /obj/item/clothing/gloves/color/latex(src)
