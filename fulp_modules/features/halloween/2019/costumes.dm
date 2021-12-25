/**
 * Setting all costumes to use our .dmi file so we dont have to repeat each time
 * We're only setting the most commonly used items to use it.
 */
/obj/item/clothing/suit/costume_2019
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2019/2019_icons_worn.dmi'

/obj/item/clothing/head/costume_2019
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2019/2019_icons_worn.dmi'

/obj/item/clothing/under/costume/costume_2019
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2019/2019_icons_worn.dmi'

/**
 * Centaur costume
 */

/obj/item/clothing/suit/costume_2019/centaur
	name = "centaur costume"
	desc = "The prototypes required two or more participants to pilot the suit, but this advanced version only requires one."
	icon_state = "centaur"

/obj/item/storage/box/halloween/edition_19/centaur
	theme_name = "2019's Centaur"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/centaur,
	)

/**
 * Hot Dog costume
 */
/obj/item/clothing/suit/costume_2019/hotdog
	name = "Hotdog"
	desc = "Hot Dawg."
	icon_state = "hotdog"

/obj/item/clothing/head/costume_2019/hot_head
	name = "Hotdog hood"
	desc = "Hot Dawg."
	icon_state = "hotdog_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/hotdog
	theme_name = "2019's Hotdog"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/hotdog,
		/obj/item/clothing/head/costume_2019/hot_head,
	)

/**
 * Ketchup & Mustard costumes
 */
/obj/item/clothing/suit/costume_2019/ketchup
	name = "Ketchup"
	desc = "A soft plush ketchup bottle."
	icon_state = "ketchup"

/obj/item/clothing/head/costume_2019/ketchup_head
	desc = "A soft plush ketchup bottle."
	icon_state = "ketchup_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/ketchup
	theme_name = "2019's Ketchup"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/ketchup,
		/obj/item/clothing/head/costume_2019/ketchup_head,
	)

/obj/item/clothing/suit/costume_2019/mustard
	name = "Mustard"
	desc = "A soft plush mustard bottle."
	icon_state = "mustard"

/obj/item/clothing/head/costume_2019/mustard_head
	desc = "A soft plush mustard bottle."
	icon_state = "mustard_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/mustard
	theme_name = "2019's Mustard"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/mustard,
		/obj/item/clothing/head/costume_2019/mustard_head,
	)

/**
 * Angel & Devil Costume
 */
/obj/item/clothing/suit/costume_2019/angel
	name = "angel"
	desc = "Heavenly Dress."
	icon_state = "angel"

/obj/item/clothing/head/costume_2019/angel_halo
	desc = "Heavenly Halo."
	icon_state = "angel_halo"

/obj/item/storage/box/halloween/edition_19/angel
	theme_name = "2019's Angel"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/angel,
		/obj/item/clothing/head/costume_2019/angel_halo,
	)

/obj/item/clothing/suit/costume_2019/devil
	name = "Devil"
	desc = "The one the only Devil."
	icon_state = "devil"

/obj/item/clothing/head/costume_2019/devil_horns
	desc = "The one the only Devil."
	icon_state = "devil_horns"
	dynamic_hair_suffix = ""

/obj/item/storage/box/halloween/edition_19/devil
	theme_name = "2019's Devil"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/devil,
		/obj/item/clothing/head/costume_2019/devil_horns,
	)

/**
 * Skeleton costume
 */
/obj/item/clothing/suit/costume_2019/skeleton
	name = "Skeleton"
	desc = "You are now Mr.Bones."
	icon_state = "skeleton"

/obj/item/clothing/head/costume_2019/skull
	name = "Skull"
	desc = "A skull on your face."
	icon_state = "skull"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR

/obj/item/storage/box/halloween/edition_19/skeleton
	theme_name = "2019's Skeleton"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/skeleton,
		/obj/item/clothing/head/costume_2019/skull,
	)

/**
 * Spider costume
 */
/obj/item/clothing/suit/costume_2019/spider
	name = "Spider"
	desc = "An unwieldy set of 8 limbs"
	icon_state = "spider"

/obj/item/storage/box/halloween/edition_19/spider
	theme_name = "2019's Spider"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/spider,
	)

/**
 * Witch costume
 */
/obj/item/clothing/suit/costume_2019/witch
	name = "witch"
	desc = "You've become the Wicked Witch of the West."
	icon_state = "witch"

/obj/item/clothing/head/costume_2019/witch_hat
	name = "Witch Head"
	desc = "A green face and a pointy hat."
	icon_state = "witch_hat"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR

/obj/item/storage/box/halloween/edition_19/witch
	theme_name = "2019's Witch"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/witch,
		/obj/item/clothing/head/costume_2019/witch_hat,
	)

/**
 * Joseph Joestar costume
 */
/obj/item/clothing/under/costume/costume_2019/tricksters_outfit
	name = "trickster's vest and jeans"
	desc = "Someone's ruined this vest by cutting slots in it."
	icon_state = "joseph_outfit"
	body_parts_covered = CHEST|GROIN|LEGS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/head/costume_2019/tricksters_headband
	name = "trickster's headband"
	desc = "Smells like expired ceasar dressing."
	icon_state = "joseph_headband"
	dynamic_hair_suffix = ""

/obj/item/clothing/neck/scarf/tricksters_scarf
	name = "trickster's scarf"
	desc = "The real trick is that it's held in place with a stiff wire."
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2019/2019_icons_worn.dmi'
	icon_state = "joseph_scarf"

/obj/item/clothing/shoes/tricksters_boots
	name = "trickster's boots"
	desc = "These help you Stand."
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2019/2019_icons_worn.dmi'
	icon_state = "joseph_boots"

/obj/item/clothing/gloves/tricksters_gloves
	name = "trickster's gloves"
	desc = "Fingerless, to let you better pull tricks out of nowhere."
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2019/2019_icons_worn.dmi'
	icon_state = "joseph_gloves"

/obj/item/storage/box/halloween/edition_19/tricksters
	theme_name = "2019's Tricksters"
	costume_contents = list(
		/obj/item/clothing/under/costume/costume_2019/tricksters_outfit,
		/obj/item/clothing/head/costume_2019/tricksters_headband,
		/obj/item/clothing/neck/scarf/tricksters_scarf,
		/obj/item/clothing/shoes/tricksters_boots,
		/obj/item/clothing/gloves/tricksters_gloves,
	)

/**
 * Sans costume
 */
/obj/item/clothing/under/costume/costume_2019/sans
	name = "a skeleton\'s suit"
	desc = "A baggy, comfortable combination of a tee and shorts. You can tell if you wear this you're gonna have a good time."
	icon_state = "sans"
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/head/hardhat/sans
	name = "massive foam skull"
	desc = "What's this guy's name again? Sand? Sailsbury?"
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2019/2019_icons_worn.dmi'
	icon_state = "hardhat0_sans"
	on = FALSE
	hat_type = "sans"
	armor = list(MELEE = -10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0) //just dodge, duh
	resistance_flags = null
	flags_inv = HIDEHAIR|HIDEFACIALHAIR
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	dynamic_hair_suffix = ""

/obj/item/storage/box/halloween/edition_19/sans
	theme_name = "2019's Sans"
	costume_contents = list(
		/obj/item/clothing/under/costume/costume_2019/sans,
		/obj/item/clothing/head/hardhat/sans,
	)

/**
 * Samus suit costume (please dont copyright us)
 */
/obj/item/clothing/under/costume/costume_2019/zero_suit
	name = "plastic bounty hunter's plugsuit"
	desc = "A cheap plastic suit with zero practical use."
	icon_state = "zerosuit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	fitted = NO_FEMALE_UNIFORM
	alternate_worn_layer = GLOVES_LAYER //copied blindly from mech jumpsuit lmao
	can_adjust = FALSE

/obj/item/clothing/suit/space/varia // Hardsuits aren't subtypes of the regular suit
	name = "plastic bounty hunter's hardsuit"
	desc = "It's variapparent that this is injection-moulded."
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2019/2019_icons_worn.dmi'
	icon_state = "varia_suit"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	clothing_flags = NONE
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	cold_protection = null
	heat_protection = null
	slowdown = 0
	actions_types = list(/datum/action/item_action/toggle_helmet)
	helmettype = /obj/item/clothing/head/helmet/space/varia

/obj/item/clothing/head/helmet/space/varia
	name = "plastic bounty hunter's helmet"
	desc = "A cheap plastic helmet spring-loaded into the suit."
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2019/2019_icons_worn.dmi'
	icon_state = "hardsuit0-varia"
	max_integrity = 300
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	clothing_flags = NONE
	min_cold_protection_temperature = null
	max_heat_protection_temperature = null
	cold_protection = null
	heat_protection = nullnd 

///Toy arm cannon used in the Samus costume
/obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon
	name = "foam force arm cannon"
	desc = "The chozo manufacturing industry exports thousands of these things a year. Ages 8+"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy/arm_ball
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	icon_state = "arm_cannon"
	inhand_icon_state = "arm_cannon"
	lefthand_file = 'fulp_modules/features/halloween/2019/2019_icons_left.dmi'
	righthand_file = 'fulp_modules/features/halloween/2019/2019_icons_right.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	slot_flags = null

/obj/item/ammo_casing/caseless/foam_dart/arm_ball
	name = "small foam ball"
	desc = "Eat this, space pirates!"
	icon ='fulp_modules/features/halloween/2019/2019_icons.dmi'
	projectile_type = /obj/projectile/bullet/reusable/foam_dart/arm_ball
	icon_state = "ball"
	caliber = "arm_ball"

/obj/item/ammo_box/magazine/internal/shot/toy/arm_ball
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/arm_ball
	caliber = "arm_ball"

/obj/projectile/bullet/reusable/foam_dart/arm_ball
	name = "small foam ball"
	desc = "Eat this, space pirates!"
	icon = 'fulp_modules/features/halloween/2019/2019_icons.dmi'
	icon_state = "ball"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/arm_ball

///Makes the firing automatic
/obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon/shoot_live_shot(mob/living/user as mob|obj)
	..()
	src.rack()

///Prevents breaking via dart modding
/obj/item/ammo_casing/caseless/foam_dart/arm_ball/attack_self()
	return

///Prevents using a screwdriver on it
/obj/item/ammo_casing/caseless/foam_dart/arm_ball/attackby(obj/item/used_tool)
	if(used_tool.tool_behaviour == TOOL_SCREWDRIVER)
		return
	..()

/obj/item/storage/box/halloween/edition_19/zerosuit
	theme_name = "2019's Bounty Hunter"
	costume_contents = list(
		/obj/item/clothing/under/costume/costume_2019/zero_suit,
		/obj/item/clothing/suit/space/varia,
		/obj/item/clothing/head/helmet/space/varia,
		/obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon,
	)

/**
 * Zombie Rider costume
 */
/obj/item/clothing/suit/costume_2019/zombie_rider
	name = "Zombie Rider"
	desc = "Tired of walking? Have your friendly slave zombie waddle you around!"
	icon_state = "zombie_rider"
	lefthand_file = 'fulp_modules/features/halloween/2019/2019_icons_left.dmi'
	righthand_file = 'fulp_modules/features/halloween/2019/2019_icons_right.dmi'

/obj/item/storage/box/halloween/edition_19/zombie
	theme_name = "2019's Zombie"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2019/zombie_rider,
	)
