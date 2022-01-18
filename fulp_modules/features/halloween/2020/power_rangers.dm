/**
 * Power ranger costumes
 * Made by: Horatio/Joyce
 * Too many items to be worth moving into the main file.
 */
/obj/item/clothing/head/costume_2020/power_ranger
	name = "ranger helmet"
	desc = "ranger helmet."
	icon_state = "red_helm"
	var/ranger

/obj/item/clothing/head/costume_2020/power_ranger/Initialize()
	. = ..()
	if(ranger)
		name = "[ranger] [name]"
		desc = "The '[ranger]' ranger helmet."
		icon_state = "[ranger]_helm"

/obj/item/clothing/head/costume_2020/power_ranger/black
	ranger = "black"

/obj/item/clothing/head/costume_2020/power_ranger/blue
	ranger = "blue"

/obj/item/clothing/head/costume_2020/power_ranger/green
	ranger = "green"

/obj/item/clothing/head/costume_2020/power_ranger/pink
	ranger = "pink"

/obj/item/clothing/head/costume_2020/power_ranger/red
	ranger = "red"

/obj/item/clothing/head/costume_2020/power_ranger/yellow
	ranger = "yellow"

/obj/item/clothing/suit/costume_2020/power_ranger
	name = "ranger suit"
	desc = "ranger suit."
	icon_state = "red_ranger"
	var/ranger = "Red"
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

/obj/item/clothing/suit/costume_2020/power_ranger/Initialize()
	. = ..()
	if(ranger)
		name = "[ranger] [name]"
		desc = "The '[ranger]' ranger suit."
		icon_state = "[ranger]_ranger"

/obj/item/clothing/suit/costume_2020/power_ranger/black
	ranger = "black"

/obj/item/clothing/suit/costume_2020/power_ranger/blue
	ranger = "blue"

/obj/item/clothing/suit/costume_2020/power_ranger/green
	ranger = "green"

/obj/item/clothing/suit/costume_2020/power_ranger/pink
	ranger = "pink"

/obj/item/clothing/suit/costume_2020/power_ranger/red
	ranger = "red"

/obj/item/clothing/suit/costume_2020/power_ranger/yellow
	ranger = "yellow"

/obj/item/clothing/shoes/costume_2020/power_ranger
	name = "Ranger boots"
	desc = "Ranger suit."
	icon_state = "red_boots"
	var/ranger

/obj/item/clothing/shoes/costume_2020/power_ranger/Initialize()
	. = ..()
	if(ranger)
		name = "[ranger] [name]"
		desc = "The '[ranger]' ranger boots."
		icon_state = "[ranger]_boots"

/obj/item/clothing/shoes/costume_2020/power_ranger/black
	ranger = "black"

/obj/item/clothing/shoes/costume_2020/power_ranger/blue
	ranger = "blue"

/obj/item/clothing/shoes/costume_2020/power_ranger/green
	ranger = "green"

/obj/item/clothing/shoes/costume_2020/power_ranger/pink
	ranger = "pink"

/obj/item/clothing/shoes/costume_2020/power_ranger/red
	ranger = "red"

/obj/item/clothing/shoes/costume_2020/power_ranger/yellow
	ranger = "yellow"


/obj/item/storage/box/halloween/edition_20/power_ranger
	theme_name = "2020's Power Ranger -- Random"
	var/rangercolor

/obj/item/storage/box/halloween/edition_20/power_ranger/PopulateContents()
	if(costume_contents.len)
		return ..()
	rangercolor = pick("black", "blue", "green", "pink", "red", "yellow")
	switch(rangercolor)
		if("black")
			costume_contents = list(
				/obj/item/clothing/head/costume_2020/power_ranger/black,
				/obj/item/clothing/suit/costume_2020/power_ranger/black,
				/obj/item/clothing/shoes/costume_2020/power_ranger/black,
				/obj/item/clothing/gloves/color/latex,
			)

		if("blue")
			costume_contents = list(
				/obj/item/clothing/head/costume_2020/power_ranger/blue,
				/obj/item/clothing/suit/costume_2020/power_ranger/blue,
				/obj/item/clothing/shoes/costume_2020/power_ranger/blue,
				/obj/item/clothing/gloves/color/latex,
			)

		if("green")
			/obj/item/clothing/head/costume_2020/power_ranger/green
			/obj/item/clothing/suit/costume_2020/power_ranger/green
			/obj/item/clothing/shoes/costume_2020/power_ranger/green
			/obj/item/clothing/gloves/color/latex

		if("pink")
			costume_contents = list(
				/obj/item/clothing/head/costume_2020/power_ranger/pink,
				/obj/item/clothing/suit/costume_2020/power_ranger/pink,
				/obj/item/clothing/shoes/costume_2020/power_ranger/pink,
				/obj/item/clothing/gloves/color/latex,
			)

		if("red")
			costume_contents = list(
				/obj/item/clothing/head/costume_2020/power_ranger/red,
				/obj/item/clothing/suit/costume_2020/power_ranger/red,
				/obj/item/clothing/shoes/costume_2020/power_ranger/red,
				/obj/item/clothing/gloves/color/latex,
			)

		if("yellow")
			costume_contents = list(
				/obj/item/clothing/head/costume_2020/power_ranger/yellow,
				/obj/item/clothing/suit/costume_2020/power_ranger/yellow,
				/obj/item/clothing/shoes/costume_2020/power_ranger/yellow,
				/obj/item/clothing/gloves/color/latex,
			)

	// Call parent to deal with the rest
	. = ..()

/obj/item/storage/box/halloween/edition_20/power_ranger/black
	theme_name = "2020's Power Ranger - Black"
	costume_contents = list(
		/obj/item/clothing/head/costume_2020/power_ranger/black,
		/obj/item/clothing/suit/costume_2020/power_ranger/black,
		/obj/item/clothing/shoes/costume_2020/power_ranger/black,
		/obj/item/clothing/gloves/color/latex,
	)

/obj/item/storage/box/halloween/edition_20/power_ranger/blue
	theme_name = "2020's Power Ranger - Blue"
	costume_contents = list(
		/obj/item/clothing/head/costume_2020/power_ranger/blue,
		/obj/item/clothing/suit/costume_2020/power_ranger/blue,
		/obj/item/clothing/shoes/costume_2020/power_ranger/blue,
		/obj/item/clothing/gloves/color/latex,
	)

/obj/item/storage/box/halloween/edition_20/power_ranger/green
	theme_name = "2020's Power Ranger - Green"
	costume_contents = list(
		/obj/item/clothing/head/costume_2020/power_ranger/green,
		/obj/item/clothing/suit/costume_2020/power_ranger/green,
		/obj/item/clothing/shoes/costume_2020/power_ranger/green,
		/obj/item/clothing/gloves/color/latex,
	)

/obj/item/storage/box/halloween/edition_20/power_ranger/pink
	theme_name = "2020's Power Ranger - Pink"
	costume_contents = list(
		/obj/item/clothing/head/costume_2020/power_ranger/pink,
		/obj/item/clothing/suit/costume_2020/power_ranger/pink,
		/obj/item/clothing/shoes/costume_2020/power_ranger/pink,
		/obj/item/clothing/gloves/color/latex,
	)

/obj/item/storage/box/halloween/edition_20/power_ranger/red
	theme_name = "2020's Power Ranger - Red"
	costume_contents = list(
		/obj/item/clothing/head/costume_2020/power_ranger/red,
		/obj/item/clothing/suit/costume_2020/power_ranger/red,
		/obj/item/clothing/shoes/costume_2020/power_ranger/red,
		/obj/item/clothing/gloves/color/latex,
	)

/obj/item/storage/box/halloween/edition_20/power_ranger/yellow
	theme_name = "2020's Power Ranger - Yellow"
	costume_contents = list(
		/obj/item/clothing/head/costume_2020/power_ranger/yellow,
		/obj/item/clothing/suit/costume_2020/power_ranger/yellow,
		/obj/item/clothing/shoes/costume_2020/power_ranger/yellow,
		/obj/item/clothing/gloves/color/latex,
	)
