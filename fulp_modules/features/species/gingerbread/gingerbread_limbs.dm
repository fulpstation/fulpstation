/*
Gingerbread Limb Code
*/

//HEAD//
/obj/item/bodypart/head/gingerbread
	icon = 'fulp_modules/icons/mobs/gingerbread.dmi'
	icon_state = "gingerbread_head"
	icon_static = 'fulp_modules/icons/mobs/gingerbread.dmi'
	limb_id = SPECIES_GINGERBREAD
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	brute_modifier = 1.4 //High brute damage 
	burn_modifier = 0.7 //Low burn damage 
	head_flags = HEAD_EYESPRITES
	bodypart_flags = BODYPART_UNHUSKABLE

/obj/item/bodypart/head/gingerbread/Initialize(mapload)
	. = ..()AddComponent(/datum/component/edible,
	initial_reagents = (/datum/reagent/consumable/nutriment = 30, /datum/reagent/consumable/nutriment/vitamin = 8, /datum/reagent/consumable/sugar = 7)
	foodtypes = GRAIN | SUGAR | DAIRY,
	volume = 50,
	eat_time = 3 SECONDS,
	list/tastes = ("gingerbread" = 5, "sugar" = 3, "hope" = 1)
	bite_consumption = 4,)

/obj/item/bodypart/chest/gingerbread
	icon = 'fulp_modules/icons/mobs/gingerbread.dmi'
	icon_state = "gingerbread_chest"
	icon_static = 'fulp_modules/icons/mobs/gingerbread.dmi'
	limb_id = SPECIES_GINGERBREAD
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	brute_modifier = 1.4 //High brute damage 
	burn_modifier = 0.7 //Low burn damage 
	bodypart_flags = BODYPART_UNHUSKABLE
	wing_types = NONE

/obj/item/bodypart/head/gingerbread/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/edible,
	initial_reagents = list(/datum/reagent/consumable/nutriment = 37, /datum/reagent/consumable/nutriment/vitamin = 10, /datum/reagent/consumable/sugar = 9)
	foodtypes = GRAIN | SUGAR | DAIRY,
	volume = 60,
	eat_time = 3 SECONDS,
	tastes = ("gingerbread" = 5, "sugar" = 3, "hope" = 1)
	eatverbs = list("bite", "chew", "gnaw", "chomp"),
	bite_consumption = 5,)

//BODY//
/obj/item/bodypart/arm/left/gingerbread
	icon = 'fulp_modules/icons/mobs/gingerbread.dmi'
	icon_state = "gingerbread_l_arm"
	icon_static = 'fulp_modules/icons/mobs/gingerbread.dmi'
	limb_id = SPECIES_GINGERBREAD
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	brute_modifier = 1.4 //High brute damage 
	burn_modifier = 0.7 //Low burn damage 
	bodypart_flags = BODYPART_UNHUSKABLE

/obj/item/bodypart/head/gingerbread/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/edible,
	initial_reagents = (/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/nutriment/vitamin = 7, /datum/reagent/consumable/sugar = 5)
	foodtypes = GRAIN | SUGAR | DAIRY,
	volume = 50,
	eat_time = 3 SECONDS,
	list/tastes = ("gingerbread" = 5, "sugar" = 3, "hope" = 1)
	list/eatverbs = list("bite", "chew", "gnaw", "chomp"),
	bite_consumption = 3,)

/obj/item/bodypart/arm/right/gingerbread
	icon = 'fulp_modules/icons/mobs/gingerbread.dmi'
	icon_state = "gingerbread_r_arm"
	icon_static = 'fulp_modules/icons/mobs/gingerbread.dmi'
	limb_id = SPECIES_GINGERBREAD
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	brute_modifier = 1.4 //High brute damage 
	burn_modifier = 0.7 //Low burn damage 
	bodypart_flags = BODYPART_UNHUSKABLE

/obj/item/bodypart/head/gingerbread/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/edible,
	initial_reagents = (/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/nutriment/vitamin = 7, /datum/reagent/consumable/sugar = 5)
	foodtypes = GRAIN | SUGAR | DAIRY,
	volume = 50,
	eat_time = 3 SECONDS,
	list/tastes = ("gingerbread" = 5, "sugar" = 3, "hope" = 1)
	list/eatverbs = list("bite", "chew", "gnaw", "chomp"),
	bite_consumption = 3,)
	
/obj/item/bodypart/leg/left/gingerbread
	icon = 'fulp_modules/icons/mobs/gingerbread.dmi'
	icon_state = "gingerbread_l_leg"
	icon_static = 'fulp_modules/icons/mobs/gingerbread.dmi'
	limb_id = SPECIES_GINGERBREAD
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	brute_modifier = 1.4 //High brute damage 
	burn_modifier = 0.7 //Low burn damage 
	bodypart_flags = BODYPART_UNHUSKABLE

/obj/item/bodypart/head/gingerbread/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/edible,
	initial_reagents = (/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/nutriment/vitamin = 7, /datum/reagent/consumable/sugar = 5)
	foodtypes = GRAIN | SUGAR | DAIRY,
	volume = 50,
	eat_time = 3 SECONDS,
	list/tastes = ("gingerbread" = 5, "sugar" = 3, "hope" = 1)
	list/eatverbs = list("bite", "chew", "gnaw", "chomp"),
	bite_consumption = 3,)

/obj/item/bodypart/leg/right/gingerbread
	icon = 'fulp_modules/icons/mobs/gingerbread.dmi'
	icon_state = "gingerbread_r_leg"
	icon_static = 'fulp_modules/icons/mobs/gingerbread.dmi'
	limb_id = SPECIES_GINGERBREAD
	should_draw_greyscale = FALSE
	dmg_overlay_type = null
	brute_modifier = 1.4 //High brute damage 
	burn_modifier = 0.7 //Low burn damage 
	bodypart_flags = BODYPART_UNHUSKABLE

/obj/item/bodypart/head/gingerbread/Initialize(mapload)
    . = ..()
	AddComponent(/datum/component/edible,
	initial_reagents = (/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/nutriment/vitamin = 7, /datum/reagent/consumable/sugar = 5)
	foodtypes = GRAIN | SUGAR | DAIRY,
	volume = 50,
	eat_time = 3 SECONDS,
	list/tastes = ("gingerbread" = 5, "sugar" = 3, "hope" = 1)
	list/eatverbs = list("bite", "chew", "gnaw", "chomp"),
	bite_consumption = 3,)
