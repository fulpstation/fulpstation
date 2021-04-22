/obj/item/clothing/under/costume/zero_suit
	name = "plastic bounty hunter's plugsuit"
	desc = "A cheap plastic suit with zero practical use."
	icon_state = "zerosuit"
	icon = 'fulp_modules/halloween_event/costumes_2019/zerosuit_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/zerosuit_worn.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	fitted = NO_FEMALE_UNIFORM
	alternate_worn_layer = GLOVES_LAYER //copied blindly from mech jumpsuit lmao
	can_adjust = FALSE

/obj/item/clothing/suit/space/hardsuit/toy
	name = "toy hardsuit"
	desc = "Comes packaged with the 'My First Singularity Playset'"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)
	clothing_flags = NONE
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	cold_protection = null
	heat_protection = null
	slowdown = 0
	actions_types = list(/datum/action/item_action/toggle_helmet)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/toy

/obj/item/clothing/suit/space/hardsuit/toy/varia
	name = "plastic bounty hunter's hardsuit"
	desc = "It's variapparent that this is injection-moulded."
	icon_state = "varia_suit"
	icon = 'fulp_modules/halloween_event/costumes_2019/zerosuit_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/zerosuit_worn.dmi'
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/toy/varia


/obj/item/clothing/head/helmet/space/hardsuit/toy
	name = "toy hardsuit helmet"
	desc = "With working flashlight!"
	max_integrity = 300
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)
	clothing_flags = NONE
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	cold_protection = null
	heat_protection = null
	hardsuit_type = "engineering"

/obj/item/clothing/head/helmet/space/hardsuit/toy/varia
	name = "plastic bounty hunter's helmet"
	desc = "A cheap plastic helmet spring-loaded into the suit."
	icon_state = "hardsuit0-varia" //hardsuit helmet code is weird - has to follow this format: 'hardsuit0-[hardsuit_type]' and have 'hardsuit1-[hardsuit_type]'' as the icon for the light-on ver
	icon = 'fulp_modules/halloween_event/costumes_2019/zerosuit_icon.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2019/zerosuit_worn.dmi'
	hardsuit_type = "varia"

//--Cannon
/obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon
	name = "foam force arm cannon"
	desc = "The chozo manufacturing industry exports thousands of these things a year. Ages 8+"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy/arm_ball
	icon = 'fulp_modules/halloween_event/costumes_2019/zerosuit_icon.dmi'
	icon_state = "arm_cannon"
	inhand_icon_state = "arm_cannon"
	lefthand_file = 'fulp_modules/halloween_event/costumes_2019/zerosuit_lefthand.dmi'
	righthand_file = 'fulp_modules/halloween_event/costumes_2019/zerosuit_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	slot_flags = null

/obj/item/ammo_casing/caseless/foam_dart/arm_ball
	name = "small foam ball"
	desc = "Eat this, space pirates!"
	icon = 'fulp_modules/halloween_event/costumes_2019/zerosuit_icon.dmi'
	projectile_type = /obj/projectile/bullet/reusable/foam_dart/arm_ball
	icon_state = "ball"
	caliber = "arm_ball"

/obj/item/ammo_box/magazine/internal/shot/toy/arm_ball
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/arm_ball
	caliber = "arm_ball"

/obj/projectile/bullet/reusable/foam_dart/arm_ball
	name = "small foam ball"
	desc = "Eat this, space pirates!"
	icon = 'fulp_modules/halloween_event/costumes_2019/zerosuit_icon.dmi'
	icon_state = "ball"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/arm_ball

/obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon/shoot_live_shot(mob/living/user as mob|obj) //makes it automatic
	..()
	src.rack()

/obj/item/ammo_casing/caseless/foam_dart/arm_ball/attack_self() //prevents breaking via dart modding
	return

/obj/item/ammo_casing/caseless/foam_dart/arm_ball/attackby(obj/item/A) //prevents using a screwdriver on it
	if (A.tool_behaviour == TOOL_SCREWDRIVER)
		return
	..()

/// obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon/update_icon() //Prevents all the shitty overlays breaking the icon   // UPDATE 11/4/19 This proc throws errors now.
//	SEND_SIGNAL(src, COMSIG_OBJ_UPDATE_ICON)
//	return

/obj/item/storage/box/halloween/edition_19/zerosuit
	theme_name = "2019's Bounty Hunter"

/obj/item/storage/box/halloween/edition_19/zerosuit/PopulateContents()
	new /obj/item/clothing/under/costume/zero_suit(src)
	new /obj/item/clothing/suit/space/hardsuit/toy/varia(src)
	new /obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon(src)
