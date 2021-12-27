// Allows us to add fulp-exclusive modsuits without having to add the sprites to tg's mod dmi-s.

/obj/item/mod/control/pre_equipped/fulp
	var/icon_path
	var/worn_icon_path

/obj/item/mod/control/pre_equipped/fulp/Initialize(mapload, new_theme, new_skin)
	. = ..()
	if (icon_path && worn_icon_path)
		for(var/obj/item/clothing as anything in mod_parts)
			clothing.icon = icon_path
			clothing.worn_icon = worn_icon_path
