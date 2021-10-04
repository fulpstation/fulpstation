/**
 * Centaur costume
 */
/obj/item/clothing/suit/centaur
	name = "centaur costume"
	desc = "The prototypes required two or more participants to pilot the suit, but this advanced version only requires one."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "centaur"

/obj/item/storage/box/halloween/edition_19/centaur
	theme_name = "2019's Centaur"
	costume_contents = list(
		/obj/item/clothing/suit/centaur,
	)

/**
 * Hot Dog costume
 */
/obj/item/clothing/suit/hotdog
	name = "Hotdog"
	desc = "Hot Dawg."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "hotdog"

/obj/item/clothing/head/hot_head
	name = "Hotdog hood"
	desc = "Hot Dawg."
	icon_state = "hotdog_top"
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/hotdog
	theme_name = "2019's Hotdog"
	costume_contents = list(
		/obj/item/clothing/suit/hotdog,
		/obj/item/clothing/head/hot_head,
	)

/**
 * Ketchup & Mustard costumes
 */
/obj/item/clothing/suit/ketchup
	name = "Ketchup"
	desc = "A soft plush ketchup bottle."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "ketchup"

/obj/item/clothing/head/ketchup_head
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	desc = "A soft plush ketchup bottle."
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "ketchup_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/ketchup
	theme_name = "2019's Ketchup"

/obj/item/storage/box/halloween/edition_19/ketchup/PopulateContents()
	new /obj/item/clothing/suit/ketchup(src)
	new /obj/item/clothing/head/ketchup_head(src)

/obj/item/clothing/suit/mustard
	name = "Mustard"
	desc = "A soft plush mustard bottle."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "mustard"

/obj/item/clothing/head/mustard_head
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	desc = "A soft plush mustard bottle."
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "mustard_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/mustard
	theme_name = "2019's Mustard"

/obj/item/storage/box/halloween/edition_19/mustard/PopulateContents()
	new /obj/item/clothing/suit/mustard(src)
	new /obj/item/clothing/head/mustard_head(src)

/**
 * Angel & Devil Costume
 */
/obj/item/clothing/suit/angel
	name = "angel"
	desc = "Heavenly Dress."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "angel"

/obj/item/clothing/head/angel_halo
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	desc = "Heavenly Halo."
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "angel_halo"

/obj/item/storage/box/halloween/edition_19/angel
	theme_name = "2019's Angel"

/obj/item/storage/box/halloween/edition_19/angel/PopulateContents()
	new /obj/item/clothing/suit/angel(src)
	new /obj/item/clothing/head/angel_halo(src)

/obj/item/clothing/suit/devil
	name = "Devil"
	desc = "The one the only Devil."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "devil"

/obj/item/clothing/head/devil_horns
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	desc = "The one the only Devil."
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "devil_horns"
	dynamic_hair_suffix = ""

/obj/item/storage/box/halloween/edition_19/devil
	theme_name = "2019's Devil"

/obj/item/storage/box/halloween/edition_19/devil/PopulateContents()
	new /obj/item/clothing/suit/devil(src)
	new /obj/item/clothing/head/devil_horns(src)

/**
 * Cat costume (back when felinids werent a thing)
 */
/obj/item/clothing/suit/cat
	name = "Cat suit"
	desc = "You feel like you can slink everywhere now."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "cat"

/obj/item/clothing/head/cat_head
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	desc = "You feel like you can slink everywhere now."
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "cat_ears"

/obj/item/storage/box/halloween/edition_19/cat
	theme_name = "2019's Cat"

/obj/item/storage/box/halloween/edition_19/cat/PopulateContents()
	new /obj/item/clothing/suit/cat(src)
	new /obj/item/clothing/head/cat_head(src)

/**
 * Pumpkin costume
 */
/obj/item/clothing/suit/space/hardsuit/toy/pumpkin
	name = "Pumpkin"
	desc = "The insides of a pumpkin a awkwardly warm and slimy."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "pumpkin"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/toy/pumpkin_top

/obj/item/clothing/head/helmet/space/hardsuit/toy/pumpkin_top
	name = "Pumpkin top"
	desc = "The top of a pumpkin on the top of your head."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "pumpkin_top"

/obj/item/storage/box/halloween/edition_19/pumpkin
	theme_name = "2019's Pumpkin"

/obj/item/storage/box/halloween/edition_19/pumpkin/PopulateContents()
	new /obj/item/clothing/suit/space/hardsuit/toy/pumpkin(src)

/**
 * Skeleton costume
 */
/obj/item/clothing/suit/skeleton
	name = "Skeleton"
	desc = "You are now Mr.Bones."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "skeleton"

/obj/item/clothing/head/skull
	name = "Skull"
	desc = "A skull on your face."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "skull"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR

/obj/item/storage/box/halloween/edition_19/skeleton
	theme_name = "2019's Skeleton"


/obj/item/storage/box/halloween/edition_19/skeleton/PopulateContents()
	new /obj/item/clothing/suit/skeleton(src)
	new /obj/item/clothing/head/skull(src)

/**
 * Spider costume
 */
/obj/item/clothing/suit/spider
	name = "Spider"
	desc = "An unwieldy set of 8 limbs"
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "spider"

/obj/item/storage/box/halloween/edition_19/spider
	theme_name = "2019's Spider"


/obj/item/storage/box/halloween/edition_19/spider/PopulateContents()
	new /obj/item/clothing/suit/spider(src)

/**
 * Witch costume
 */
/obj/item/clothing/suit/witch
	name = "witch"
	desc = "You've become the Wicked Witch of the West."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "witch"

/obj/item/clothing/head/witch_hat
	name = "Witch Head"
	desc = "A green face and a pointy hat."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "witch_hat"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR

/obj/item/storage/box/halloween/edition_19/witch
	theme_name = "2019's Witch"


/obj/item/storage/box/halloween/edition_19/witch/PopulateContents()
	new /obj/item/clothing/suit/witch(src)
	new /obj/item/clothing/head/witch_hat(src)

/**
 * Joseph Joestar costume
 */
/obj/item/clothing/under/costume/tricksters_outfit
	name = "trickster's vest and jeans"
	desc = "Someone's ruined this vest by cutting slots in it."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "joseph_outfit"
	body_parts_covered = CHEST|GROIN|LEGS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/head/tricksters_headband
	name = "trickster's headband"
	desc = "Smells like expired ceasar dressing."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "joseph_headband"
	dynamic_hair_suffix = ""

/obj/item/clothing/neck/scarf/tricksters_scarf
	name = "trickster's scarf"
	desc = "The real trick is that it's held in place with a stiff wire."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "joseph_scarf"

/obj/item/clothing/shoes/tricksters_boots
	name = "trickster's boots"
	desc = "These help you Stand."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "joseph_boots"

/obj/item/clothing/gloves/tricksters_gloves
	name = "trickster's gloves"
	desc = "Fingerless, to let you better pull tricks out of nowhere."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "joseph_gloves"

/obj/item/storage/box/halloween/edition_19/tricksters
	theme_name = "2019's Tricksters"

/obj/item/storage/box/halloween/edition_19/tricksters/PopulateContents()
	new /obj/item/clothing/under/costume/tricksters_outfit(src)
	new /obj/item/clothing/head/tricksters_headband(src)
	new /obj/item/clothing/neck/scarf/tricksters_scarf(src)
	new /obj/item/clothing/shoes/tricksters_boots(src)
	new /obj/item/clothing/gloves/tricksters_gloves(src)

/**
 * Sans costume
 */
/obj/item/clothing/under/costume/sans
	name = "a skeleton\'s hoodie"
	desc = "A baggy, comfortable combination of a hoodie, tee and shorts. You can tell if you wear this you're gonna have a good time."
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "sans"
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/head/hardhat/sans
	name = "massive foam skull"
	desc = "What's this guy's name again? Sand? Sailsbury?"
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	icon_state = "hardhat0_sans"
	on = FALSE
	hat_type = "sans"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0) //just dodge, duh
	resistance_flags = null
	flags_inv = HIDEHAIR|HIDEFACIALHAIR
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	dynamic_hair_suffix = ""

/obj/item/storage/box/halloween/edition_19/sans
	theme_name = "2019's Sans"

/obj/item/storage/box/halloween/edition_19/sans/PopulateContents()
	new /obj/item/clothing/under/costume/sans(src)
	new /obj/item/clothing/head/hardhat/sans(src)

/**
 * Samus suit costume (please dont copyright us)
 */
/obj/item/clothing/under/costume/zero_suit
	name = "plastic bounty hunter's plugsuit"
	desc = "A cheap plastic suit with zero practical use."
	icon_state = "zerosuit"
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
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
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
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
	//hardsuit helmet code is weird - has to follow this format: 'hardsuit0-[hardsuit_type]' and have 'hardsuit1-[hardsuit_type]'' as the icon for the light-on ver
	icon_state = "hardsuit0-varia"
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	hardsuit_type = "varia"

//--Cannon
/obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon
	name = "foam force arm cannon"
	desc = "The chozo manufacturing industry exports thousands of these things a year. Ages 8+"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy/arm_ball
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	icon_state = "arm_cannon"
	inhand_icon_state = "arm_cannon"
	lefthand_file = 'fulp_modules/features/clothing/halloween/2019/2019_icons_left.dmi'
	righthand_file = 'fulp_modules/features/clothing/halloween/2019/2019_icons_right.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	slot_flags = null

/obj/item/ammo_casing/caseless/foam_dart/arm_ball
	name = "small foam ball"
	desc = "Eat this, space pirates!"
	icon ='fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	projectile_type = /obj/projectile/bullet/reusable/foam_dart/arm_ball
	icon_state = "ball"
	caliber = "arm_ball"

/obj/item/ammo_box/magazine/internal/shot/toy/arm_ball
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/arm_ball
	caliber = "arm_ball"

/obj/projectile/bullet/reusable/foam_dart/arm_ball
	name = "small foam ball"
	desc = "Eat this, space pirates!"
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	icon_state = "ball"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/arm_ball

/obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon/shoot_live_shot(mob/living/user as mob|obj) //makes it automatic
	..()
	src.rack()

/obj/item/ammo_casing/caseless/foam_dart/arm_ball/attack_self() //prevents breaking via dart modding
	return

/obj/item/ammo_casing/caseless/foam_dart/arm_ball/attackby(obj/item/A) //prevents using a screwdriver on it
	if(A.tool_behaviour == TOOL_SCREWDRIVER)
		return
	..()

/obj/item/storage/box/halloween/edition_19/zerosuit
	theme_name = "2019's Bounty Hunter"

/obj/item/storage/box/halloween/edition_19/zerosuit/PopulateContents()
	new /obj/item/clothing/under/costume/zero_suit(src)
	new /obj/item/clothing/suit/space/hardsuit/toy/varia(src)
	new /obj/item/gun/ballistic/shotgun/toy/toy_arm_cannon(src)

/**
 * Zombie Rider costume
 */
/obj/item/clothing/suit/zombie_rider
	name = "Zombie Rider"
	desc = "Tired of walking? Have your friendly slave zombie waddle you around!"
	icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons.dmi'
	icon_state = "zombie_rider"
	worn_icon = 'fulp_modules/features/clothing/halloween/2019/2019_icons_worn.dmi'
	lefthand_file = 'fulp_modules/features/clothing/halloween/2019/2019_icons_left.dmi'
	righthand_file = 'fulp_modules/features/clothing/halloween/2019/2019_icons_right.dmi'

/obj/item/storage/box/halloween/edition_19/zombie
	theme_name = "2019's Zombie"

/obj/item/storage/box/halloween/edition_19/zombie/PopulateContents()
	new /obj/item/clothing/suit/zombie_rider(src)
