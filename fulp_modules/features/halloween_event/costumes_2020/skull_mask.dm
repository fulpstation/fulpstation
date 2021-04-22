//--Skull mime mask
/obj/item/clothing/mask/gas/mime/skull_mask
	name = "Skull mask"
	desc = "A unique mime's mask. It has an eerie facial posture."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/skullmasks_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/skullmasks_worn.dmi'
	icon_state = "rose"

/obj/item/clothing/mask/gas/mime/skull_mask/Initialize(mapload)
	.=..()
	mimemask_designs = list(
		"Bleu" = image(icon = src.icon, icon_state = "bleu"),
		"Rose" = image(icon = src.icon, icon_state = "rose"),
		"Rouge" = image(icon = src.icon, icon_state = "rouge"),
		"Vert" = image(icon = src.icon, icon_state = "vert"),
		)

/obj/item/clothing/mask/gas/mime/skull_mask/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated())
		return

	var/list/options = list()
	options["Bleu"] = "bleu"
	options["Rose"] = "rose"
	options["Rouge"] = "rouge"
	options["Vert"] = "vert"

	var/choice = show_radial_menu(user,src, mimemask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated() && in_range(user,src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		to_chat(user, "<span class='notice'>Your Skull Mime Mask has now morphed into [choice]!</span>")
		return TRUE

/obj/item/clothing/under/dress/blacktango/skull_mask
	name = "Skull mask's dress"
	desc = "A black dress adorned with harebells ."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/skullmasks_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/skullmasks_worn.dmi'
	icon_state = "skull_dress"

//--Head are hats, simple
/obj/item/clothing/head/wizard/fake/skull_mask
	name = "Skull mask's hat"
	desc = "A black hat adorned with harebells."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/skullmasks_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/skullmasks_worn.dmi'
	icon_state = "skull_hat"

/obj/item/storage/box/halloween/edition_20/skull_mask
	theme_name = "2020's Skull Mask"

/obj/item/storage/box/halloween/edition_20/skull_mask/PopulateContents()
	new /obj/item/clothing/head/wizard/fake/skull_mask(src)
	new /obj/item/clothing/mask/gas/mime/skull_mask(src)
	new /obj/item/clothing/under/dress/blacktango/skull_mask(src)
	for(var/i in 1 to 3)
		new /obj/item/food/grown/harebell(src)
