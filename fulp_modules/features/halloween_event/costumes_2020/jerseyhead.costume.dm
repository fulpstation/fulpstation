/obj/item/clothing/under/infinity_shorts
    name = "infinity shorts"
    desc = "Kung Company quality. Prone to tearing."
    body_parts_covered = GROIN|LEGS
    fitted = NO_FEMALE_UNIFORM
    can_adjust = FALSE
    icon_state = "infinity_shorts"
    icon = 'fulp_modules/features/halloween_event/costumes_2020/jerseyhead_item.dmi'
    worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/jerseyhead_costume.dmi'

/obj/item/clothing/suit/infinity_jersey
    name = "infinity jersey"
    desc = "A knockoff jersey made infamous being worn by anyone wanting to seem hard through association."
    icon = 'fulp_modules/features/halloween_event/costumes_2020/jerseyhead_item.dmi'
    worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/jerseyhead_costume.dmi'
    icon_state = "infinity_jersey"

/obj/item/clothing/shoes/infinity_shoes
    name = "infinity shoes"
    desc = "Unoriginal shoes from an unoriginal brand."
    icon = 'fulp_modules/features/halloween_event/costumes_2020/jerseyhead_item.dmi'
    worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/jerseyhead_costume.dmi'
    icon_state = "infinity_shoes"

/obj/item/clothing/gloves/infinity_wristbands
    name = "infinity wristbands"
    desc = "Infinitely Stylish."
    icon = 'fulp_modules/features/halloween_event/costumes_2020/jerseyhead_item.dmi'
    worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/jerseyhead_costume.dmi'
    icon_state = "infinity_wristbands"

/obj/item/storage/box/halloween/edition_20/jerseyhead_costume
	theme_name = "2020's Jerseyhead"
	illustration = "moth"

/obj/item/storage/box/halloween/edition_20/jerseyhead_costume/PopulateContents()
	new /obj/item/clothing/suit/infinity_jersey(src)
	new /obj/item/clothing/under/infinity_shorts(src)
	new /obj/item/clothing/shoes/infinity_shoes(src)
	new /obj/item/clothing/gloves/infinity_wristbands(src)
