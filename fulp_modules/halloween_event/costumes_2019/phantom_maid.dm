/obj/item/clothing/under/costume/phantommaid_uniform
	name = "phantom maid uniform"
	desc = "A maid uniform once worn by a maid seeking the anwsers to what happened to her home. Come supplied with stockings."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "phantommaid_uniform"
	fitted = NO_FEMALE_UNIFORM
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/head/phantommaid_headband
	name = "phantom maid headband"
	desc = "A headgear that clearly help establish the maid or how to assert your dominance as a maid."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "phantommaid_headband"


/obj/item/clothing/neck/scarf/phantommaid_scarfshoulder
	name = "phantom maid scarf and shoulder neckpiece"
	desc = "A badly designed piece of a maid uniform that the maid wore as part of her uniform. The red (blood ?) stained scarf and the shoulders are stuck together."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "phantommaid_scarfshoulder"

/obj/item/clothing/gloves/phantommaid_gloves
	name = "phantom maid gloves"
	desc = "A pair of silky white gloves to keep your hands free of the dirty work."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "phantommaid_gloves"

/obj/item/clothing/glasses/phantommaid_eyes
	name = "phantom maid eyes"
	desc = "Some red contact lens that mimic the looks of the maid eyes. Red eyes (or blood shot eyes, your pick) are cool and make you look powerful or out for blood."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "phantommaid_eyes"

/obj/item/clothing/suit/phantommaid_apron
	name = "phantom maid apron"
	desc = "An apron that helped the maid to protect herself."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "phantommaid_apron"

/obj/item/clothing/shoes/phantommaid_shoes
	name = "phantom maid stilettos"
	desc = "A pair of red stilettos that surely keeped the maid's feets clean. Too bad the pointy part is only for show and doesnt actually make you taller."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "phantommaid_shoes"

/obj/item/toy/phantommaid_knife
	name = "toy red knife"
	desc = "A red (bloodstained?) knife that as seen better days. Quite similar to the one the maid used to find what happened to her home."
	icon = 'fulp_modules/halloween_event/costumes_2019/costumes_icon.dmi'
	icon_state = "phantommaid_knife"
	inhand_icon_state = "phantommaid_knife"
	lefthand_file = 'fulp_modules/halloween_event/costumes_2019/phantomknife_l.dmi'
	righthand_file = 'fulp_modules/halloween_event/costumes_2019/phantomknife_r.dmi'
	w_class = WEIGHT_CLASS_SMALL


/obj/item/storage/box/halloween/edition_19/phantommaid
	theme_name = "2019's Phantom maid"

/obj/item/storage/box/halloween/edition_19/phantommaid/PopulateContents()
	new /obj/item/clothing/under/costume/phantommaid_uniform(src)
	new /obj/item/clothing/head/phantommaid_headband(src)
	new /obj/item/clothing/neck/scarf/phantommaid_scarfshoulder(src)
	new /obj/item/clothing/gloves/phantommaid_gloves(src)
	new /obj/item/clothing/glasses/phantommaid_eyes(src)
	new /obj/item/clothing/suit/phantommaid_apron(src)
	new /obj/item/clothing/shoes/phantommaid_shoes(src)
	new /obj/item/toy/phantommaid_knife(src)
