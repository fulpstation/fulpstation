//Totally not stolen code that was given to me by Guil - Neri
/obj/item/clothing/mask/gas/mime/heister_mask
	name = "mastermind's clown mask"
	desc = "Guys, the nuclear disk, go get it!"
	icon = 'fulp_modules/halloween_event/costumes_2020/payday_masks_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/payday_masks_worn.dmi'
	icon_state = "dallas"
	inhand_icon_state = "mime"

/obj/item/clothing/mask/gas/mime/heister_mask/Initialize(mapload)
	.=..()
	mimemask_designs = list(
		"Dallas" = image(icon = src.icon, icon_state = "dallas"),
		"Wolf" = image(icon = src.icon, icon_state = "wolf"),
		"Hoxton" = image(icon = src.icon, icon_state = "hoxton"),
		"Chains" = image(icon = src.icon, icon_state = "chains")
		)

/obj/item/clothing/mask/gas/mime/heister_mask/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated())
		return

	var/list/options = list()
	options["Dallas"] = "dallas"
	options["Wolf"] = "wolf"
	options["Hoxton"] = "hoxton"
	options["Chains"] = "chains"

	var/choice = show_radial_menu(user,src, mimemask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated() && in_range(user,src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		to_chat(user, "<span class='notice'>Your Heister's Mask has now morphed into [choice]!</span>")
		return TRUE

/obj/item/storage/box/halloween/edition_20/heisters
	theme_name = "2020's Heisters"

/obj/item/storage/box/halloween/edition_20/heisters/PopulateContents()
	new /obj/item/clothing/mask/gas/mime/heister_mask(src)
	new /obj/item/toy/gun(src)
	new /obj/item/clothing/gloves/color/latex/nitrile(src)
	new /obj/item/clothing/shoes/laceup(src)

	var/randomsuit = pick(/obj/item/clothing/under/suit/tan,
							/obj/item/clothing/under/suit/black,
							/obj/item/clothing/under/suit/burgundy,
							/obj/item/clothing/under/suit/navy,
							/obj/item/clothing/under/suit/black/female)
	new randomsuit(src)
