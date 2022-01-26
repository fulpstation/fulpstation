/**
 * Setting all costumes to use our .dmi file so we dont have to repeat each time
 * We're only setting the most commonly used items to use it.
 */
/obj/item/clothing/under/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'

/obj/item/clothing/suit/hooded/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'

/obj/item/clothing/head/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'

/obj/item/clothing/head/hooded/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'

/obj/item/clothing/neck/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'

/obj/item/clothing/shoes/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'

/obj/item/clothing/gloves/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'

/obj/item/clothing/mask/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'

/obj/item/clothing/glasses/costume_2021
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'


/**
 * Barok Van Zieks
 * From: Ace Attorney Chronicles
 * By: Pepsilawn
 */

/obj/item/clothing/neck/costume_2021/breaper_cape
	name = "baroque cape"
	desc = "Smells like spilled wine, hopes and tears."
	icon_state = "breaper_cape"

/obj/item/clothing/under/costume_2021/breaper_suit
	name = "baroque suit"
	desc = "A military suit that would be worn by veteran legal practitioners of old."
	icon_state = "breaper_under"

/obj/item/clothing/shoes/costume_2021/breaper_boots
	name = "baroque boots"
	desc = "Dark leather military boots designed for harsh winters, the clunking noise they make on the ice cold stone pavements of the old city produces fear in those that fear the reaper."
	icon_state = "breaper_feet"

/obj/item/clothing/gloves/costume_2021/breaper_gloves
	name = "baroque gauntlets"
	desc = "Originally designed to be worn during sabre practice for protection, now reduced to a fashion statement by officials in their military parade uniforms."
	icon_state = "breaper_hands"

/obj/item/storage/box/halloween/edition_21/breaper
	theme_name = "2021's Bailey Reaper"
	costume_contents = list(
		/obj/item/clothing/neck/costume_2021/breaper_cape,
		/obj/item/clothing/under/costume_2021/breaper_suit,
		/obj/item/clothing/shoes/costume_2021/breaper_boots,
		/obj/item/clothing/gloves/costume_2021/breaper_gloves,
	)


/**
 * CP 2077 costume
 * From: Cyberpunk 2077
 * By: BalkyGoat
 */

/obj/item/clothing/under/costume_2021/cp2077_rockerboy
	name = "rockerboy's suit"
	desc = "One last gig."
	icon_state = "cp2077jsh_suit"
	has_sensor = HAS_SENSORS

/obj/item/clothing/suit/costume_2021/cp2077_rockerjacket
	name = "samurai's jacket"
	desc = "Never fade away."
	icon_state = "cp2077jsh_jacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/costume_2021/cp2077_rockerjacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/glasses/costume_2021/cp2077_glasses
	name = "hackerman glasses"
	desc = "Oh! Shiny!"
	icon_state = "cp2077hacker_glasses"

/obj/item/storage/box/halloween/edition_21/cp2077_box
	theme_name = "2021's CP 2077 Relics"
	illustration = "cp2077"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/cp2077_rockerboy,
		/obj/item/clothing/suit/costume_2021/cp2077_rockerjacket,
		/obj/item/clothing/glasses/costume_2021/cp2077_glasses,
	)


/**
 * Chef knight
 * By: DaJanitor
 */

/obj/item/clothing/suit/hooded/costume_2021/chef_knight_body
	name = "chef knight's suit"
	desc = "A hulking suit of armour fit with gauntlets, a pair of boots and a pretty apron with a bow."
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn_64.dmi'
	icon_state = "chef_knight_body"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDENECK|HIDEFACIALHAIR
	hoodtype = /obj/item/clothing/head/hooded/costume_2021/chef_knight_hat

/obj/item/clothing/head/hooded/costume_2021/chef_knight_hat
	name = "chef knight's helmet"
	desc = "A steel helmet with a tall chef's hat ontop."
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn_64.dmi'
	icon_state = "chef_knight_head"
	body_parts_covered = HEAD
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

/obj/item/storage/box/halloween/edition_21/chef_knight
	theme_name = "2021's Chef Knight"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/costume_2021/chef_knight_body,
	)


/**
 * The Beheaded
 * From: Dead Cells
 * By: Helianthus
 */

/obj/item/clothing/under/costume_2021/deadcells_suit
	name = "prisoner's carapace"
	desc = "An old set of armor with some dusty cloth wrapped around it. Smells of smoke and rot."
	icon_state = "deadcells_suit"

/obj/item/clothing/shoes/costume_2021/deadcells_shoes
	name = "blue sandals"
	desc = "A pair of dark blue sandals, fit with light socks. The leather is falling apart."
	icon_state = "deadcells_feet"

/obj/item/clothing/head/hardhat/deadcells_hat
	name = "homonculus mask"
	desc = "May possess you if you aren't careful."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "hardhat0_deadcells"
	on = FALSE
	hat_type = "deadcells"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT|HIDENECK

/obj/item/storage/box/halloween/edition_21/deadcells
	theme_name = "2021's The Beheaded"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/deadcells_suit,
		/obj/item/clothing/shoes/costume_2021/deadcells_shoes,
		/obj/item/clothing/head/hardhat/deadcells_hat,
	)

/**
 * Hart
 * From: Lisa: the Hopeful
 * By: Sheets
 */

/obj/item/clothing/under/costume_2021/hart_suit
	name = "Hart's suit"
	desc = "A well worn suit made from various animal furs and bones."
	icon_state = "hart_body"
	body_parts_covered = GROIN|LEGS|ARMS

/obj/item/clothing/head/costume_2021/hart_hat
	name = "Hart's hood"
	desc = "A hood made from tattered black cloth."
	icon_state = "hart_head"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

/obj/item/clothing/mask/costume_2021/lovely_mask
	name = "lovely mask"
	desc = "A porcelain disk with a crudely drawn on heart."
	icon_state = "lovely_mask"
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR

/obj/item/storage/box/halloween/edition_21/hart
	theme_name = "2021's Lovelies"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/hart_suit,
		/obj/item/clothing/head/costume_2021/hart_hat,
		/obj/item/clothing/mask/costume_2021/lovely_mask,
		/obj/item/clothing/mask/costume_2021/lovely_mask,
		/obj/item/clothing/mask/costume_2021/lovely_mask,
	)


/**
 * Infinity Suit
 * From: Lisa: The Pointless
 * By: BoltonsHead
 */

/obj/item/clothing/under/costume_2021/infinity_suit
	name = "infinity shorts"
	desc = "Though usually covered up by a jersey, these are it's on own level of threatening."
	icon_state = "infinity_shorts"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/costume_2021/infinity_jacket
	name = "infinity jersey"
	desc = "A jersey labelled '88', somehow leaving a threatening aura around it."
	icon_state = "infinity_jersey"

/obj/item/clothing/gloves/costume_2021/infinity_gloves
	name = "infinity wristbands"
	desc = "After being used in many, many fist fights, these bands somehow are still usable."
	icon_state = "infinity_wrist"

/obj/item/clothing/gloves/costume_2021/infinity_gloves/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_GLOVES)
		user.dna.species.punchdamagelow += 0.2
		user.dna.species.punchdamagehigh += 0.1

/obj/item/clothing/gloves/costume_2021/infinity_gloves/dropped(mob/living/carbon/user)
	. = ..()
	if(!ishuman(user))
		return
	if(user.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		user.dna.species.punchdamagelow -= 0.2
		user.dna.species.punchdamagehigh -= 0.1

/obj/item/clothing/gloves/costume_2021/infinity_gloves/examine_more(mob/user)
	. = list(span_notice("Wearing these will <i>very slightly</i> increase your punching damage."))

/obj/item/clothing/shoes/costume_2021/infinity_shoes
	name = "infinity shoes"
	desc = "Shoes made for walking over the blood of your enemies."
	icon_state = "infinity_shoes"

/obj/item/storage/box/halloween/edition_21/infinity
	theme_name = "2021's Infinity"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/infinity_suit,
		/obj/item/clothing/suit/costume_2021/infinity_jacket,
		/obj/item/clothing/gloves/costume_2021/infinity_gloves,
		/obj/item/clothing/shoes/costume_2021/infinity_shoes,
	)


/**
 * Breather boys
 * From: Lisa: The Vegaful
 * By: Derpiestbruh
 */

/obj/item/clothing/mask/costume_2021/breather_mask
	name = "breather mask"
	desc = "A tight green balaclava with breathing apparatus strapped to the front."
	icon_state = "breather_mask"
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	clothing_flags = MASKINTERNALS

/obj/item/storage/box/halloween/edition_21/breather_mask
	theme_name = "2021's Breather Boys"
	costume_contents = list(
		/obj/item/clothing/mask/costume_2021/breather_mask,
		/obj/item/clothing/mask/costume_2021/breather_mask,
		/obj/item/clothing/mask/costume_2021/breather_mask,
	)


/**
 * Old hunter
 * From: Bloodborne
 * By: Spacedragon00 (Beatrice)
 */

/obj/item/clothing/suit/costume_2021/oldhunter_suit
	name = "old hunter's garb"
	desc = "A fanciful victorian suit with bafflingly irremovable shoes."
	icon_state = "lady_maria_suit"

/obj/item/clothing/head/costume_2021/oldhunter_hat
	name = "old hunter's cap"
	desc = "Under no circumstances does this remind you of any copyrighted characters."
	icon_state = "lady_maria_hat"

/obj/item/storage/box/halloween/edition_21/oldhunter
	theme_name = "2021's Old Hunter"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2021/oldhunter_suit,
		/obj/item/clothing/head/costume_2021/oldhunter_hat,
	)


/**
* Randolf
* By: Twox
*/

/obj/item/clothing/suit/costume_2021/randolf_suit
	name = "randolf's suit"
	desc = "All in one suit, tail not included."
	icon_state = "randolf_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT|HIDEGLOVES

/obj/item/clothing/head/costume_2021/randolf_hat
	name = "randolf's hat"
	desc = "Comfy and can fit two."
	icon_state = "randolf_hat"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDEFACE|HIDEEYES|HIDEMASK|HIDEEARS
	worn_y_offset = 6

/obj/item/clothing/shoes/costume_2021/randolf_shoes
	name = "randolf's shoes"
	desc = "There is more than one way to skin a dog."
	icon_state = "randolf_shoes"
	body_parts_covered = FEET

/obj/item/storage/box/halloween/edition_21/randolf
	theme_name = "2021's Randolf the Fox"
	illustration = "randolf_box"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2021/randolf_suit,
		/obj/item/clothing/head/costume_2021/randolf_hat,
		/obj/item/clothing/shoes/costume_2021/randolf_shoes,
	)


/**
 * Propeller Knight
 * From: Shovel knight
 * By: Sheets
 */

/obj/item/clothing/suit/hooded/costume_2021/propeller_suit
	name = "propeller knight's suit"
	desc = "A tight, yet comfortable green suit."
	icon_state = "propeller_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	hoodtype = /obj/item/clothing/head/hooded/costume_2021/propeller_hat

/obj/item/clothing/head/hooded/costume_2021/propeller_hat
	name = "propeller knight's helmet"
	desc = "A reflective gold helmet with a makeshift propeller device fastened ontop."
	icon_state = "propeller_head"
	body_parts_covered = HEAD
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

/obj/item/clothing/gloves/tackler/propeller_gloves
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	name = "propeller gloves"
	desc = "A tight yet comfortable pair of gloves, can be used for very, very bad tackles."
	icon_state = "propeller_gloves"
	tackle_stam_cost = 35
	base_knockdown = 1.75 SECONDS
	min_distance = 2
	skill_mod = -1.2

/obj/item/storage/box/halloween/edition_21/propeller_knight
	theme_name = "2021's Propeller Knight"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/costume_2021/propeller_suit,
		/obj/item/clothing/gloves/tackler/propeller_gloves,
	)


/**
 * Spectre Knight
 * From: Shovel knight
 * By: Sheets
 */

/obj/item/clothing/suit/costume_2021/spectre_suit
	name = "spectre knight's robes"
	desc = "A darkened blood red robe with little armour."
	icon_state = "spectre_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/head/costume_2021/spectre_hat
	name = "spectre knight's helmet"
	desc = "A blood red hood, obscuring reflective golden helmet."
	icon_state = "spectre_head"
	body_parts_covered = HEAD
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

/obj/item/storage/box/halloween/edition_21/spectre_knight
	theme_name = "2021's Spectre Knight"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2021/spectre_suit,
		/obj/item/clothing/head/costume_2021/spectre_hat,
	)


/**
 * Toolbox Medal
 * By: Horatio22
 */

/obj/item/clothing/accessory/toolbox_medal
	name = "Toolbox Tournamet silver medal"
	desc = "A silver medal for the second place finalists of the Toolbox Tournament. This one is for the year 2561."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	icon_state = "tt_medal"
	resistance_flags = FIRE_PROOF

/**
 * Dancing Man
 * From: Jojo
 * By: Horatio22
 */

/obj/item/clothing/under/costume_2021/pucci_suit
	name = "dancing man suit"
	desc = "A suit worn by a man who loves to dance."
	icon_state = "pucci"

/obj/item/clothing/suit/costume_2021/pucci_jacket
	name = "dancing man overcoat"
	desc = "An overcoat worn by a man who loves to dance."
	icon_state = "pucci_suit"

/obj/item/clothing/head/costume_2021/pucci_hat
	name = "dancing man wig"
	desc = "A wig designed to resemble the hair of a man who loves to dance."
	icon_state = "pucci_wig"

/obj/item/storage/box/halloween/edition_21/pucci
	theme_name = "2021's Dancing Man"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/pucci_suit,
		/obj/item/clothing/suit/costume_2021/pucci_jacket,
		/obj/item/clothing/head/costume_2021/pucci_hat,
		/obj/item/clothing/accessory/toolbox_medal,
	)


/**
 * John Willard
 * From: Town of Salem
 * By: Horatio22
 */

/obj/item/clothing/under/costume_2021/willard_suit
	name = "male witch's suit"
	desc = "A suit worn by a male witch."
	icon_state = "male_witch"

/obj/item/clothing/suit/costume_2021/willard_jacket
	name = "male witch's overcoat"
	desc = "An overcoat worn by a male witch."
	icon_state = "male_witch_suit"

/obj/item/clothing/head/costume_2021/willard_hat
	name = "male witch's hat"
	desc = "A hat worn by a male witch."
	icon_state = "male_witch_hat"

/obj/item/clothing/shoes/costume_2021/willard_shoes
	name = "male witch's shoes"
	desc = "Shoes worn by a male witch."
	icon_state = "buckleshoe"

/obj/item/storage/box/halloween/edition_21/willard
	theme_name = "2021's Male Witch"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/willard_suit,
		/obj/item/clothing/suit/costume_2021/willard_jacket,
		/obj/item/clothing/head/costume_2021/willard_hat,
		/obj/item/clothing/shoes/costume_2021/willard_shoes,
		/obj/item/clothing/accessory/toolbox_medal,
	)


/**
 * Flower
 * By: Horatio22
 */

/obj/item/clothing/under/color/thirsty_suit
	name = "thirsy flower jumpsuit"
	desc = "A dark green jumpsuit that represents a thirty flower's stem."
	greyscale_colors = "#128512"

/obj/item/clothing/head/costume_2021/thirsty_hat
	name = "thirst flower hat"
	desc = "A hat for a thirsty little flower."
	icon_state = "thirsty"

/obj/item/storage/box/halloween/edition_21/thirsty
	theme_name = "2021's Thirsty Flower"
	costume_contents = list(
		/obj/item/clothing/under/color/thirsty_suit,
		/obj/item/clothing/head/costume_2021/thirsty_hat,
	)

/**
 * Jill Valentine
 * From: Resident Evil
 * By: Saladlegs
 */

/obj/item/clothing/under/costume_2021/valentine_suit
	name = "S.T.A.R.S. Uniform"
	desc = "Hungry for a Jill sandwich?"
	icon_state = "jill_under"
	can_adjust = FALSE

/obj/item/clothing/head/costume_2021/valentine_hat
	name = "S.T.A.R.S. Hat"
	desc = "Itchy. Tasty."
	icon_state = "jill_hat"

/obj/item/storage/box/halloween/edition_21/jill_valentine
	theme_name = "2021's Jill Valentine"
	illustration = "storage_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/valentine_suit,
		/obj/item/clothing/head/costume_2021/valentine_hat,
		/obj/item/food/grown/ambrosia/vulgaris,
		/obj/item/gun/ballistic/shotgun/toy,
	)


/**
 * Chris Redfield
 * From: Resident Evil
 * By: Saladlegs
 */

/obj/item/clothing/under/costume_2021/chris_uniform
	name = "S.T.A.R.S Uniform"
	desc = "Do not punch boulders with this."
	icon_state = "chris_under"

/obj/item/storage/box/halloween/edition_21/chris
	theme_name = "2021's Chris Redfield"
	illustration = "storage_box"
	costume_contents = list(
	 	/obj/item/clothing/under/costume_2021/chris_uniform,
		/obj/item/gun/ballistic/automatic/pistol/toy,
		/obj/item/knife/plastic,
	)


/**
 * Gyro Zeppeli
 * From: Jojo - Steel Ball Run
 * By: Saladlegs
 */

/obj/item/clothing/under/costume_2021/zeppeli_suit
	name = "Spin Master's coat"
	desc = "GO! GO! ZEPPELI"
	icon_state = "gyro_under"
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/head/costume_2021/zeppeli_hat
	name = "Spin Master's hat"
	desc = "For the hot American day."
	icon_state = "gyro_hat"

/obj/item/clothing/shoes/costume_2021/zeppeli_shoes
	name = "Spin Master's boots"
	desc = "Perfect for a cross-country trip!"
	icon_state = "gyro_shoes"

/obj/item/storage/box/halloween/edition_21/gyro_zeppeli
	theme_name = "2021's Gyro Zeppeli"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/zeppeli_suit,
		/obj/item/clothing/head/costume_2021/zeppeli_hat,
		/obj/item/clothing/shoes/costume_2021/zeppeli_shoes,
	)


/**
 * Rakka
 * From: Haibane Renmei
 * By: Saladlegs
 */

/obj/item/clothing/under/costume_2021/rakka_uniform
	name = "thrift store dress"
	desc = "Reminiscent of a schoolgirl uniform."
	icon_state = "rakka_under"
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/shoes/costume_2021/rakka_shoes
	name = "wooden sandals"
	desc = "Standard wooden sandals."
	icon_state = "rakka_shoes"

/obj/item/clothing/head/costume_2021/rakka_hat
	name = "Old Home halo"
	desc = "Not related to any religion."
	icon_state = "rakka_hat"
	dynamic_hair_suffix = ""

/obj/item/clothing/suit/costume_2021/rakka_jacket
	name = "thrift store jacket"
	desc = "A warm jacket"
	icon_state = "rakka_suit"

/obj/item/storage/box/halloween/edition_21/rakka
	theme_name = "2021's Rakka"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/rakka_uniform,
		/obj/item/clothing/suit/costume_2021/rakka_jacket,
		/obj/item/clothing/head/costume_2021/rakka_hat,
		/obj/item/clothing/shoes/costume_2021/rakka_shoes,
	)


/**
 * Char
 * From: Gundam
 * By: Saladlegs
 */

/obj/item/clothing/under/costume_2021/char_suit
	name = "Red Comet's uniform"
	desc = "USE FOR ONE YEAR ONLY!"
	icon_state = "char_under"

/obj/item/clothing/shoes/costume_2021/char_shoes
	name = "Red Comet's boots"
	desc = "Is it common courtesty to take off your shoes before entering a mech?"
	icon_state = "char_boots"

/obj/item/clothing/head/costume_2021/char_hat
	name = "Red Comet's helmet"
	desc = "Use to laugh at people."
	icon_state = "char_helmet"

/obj/item/clothing/gloves/costume_2021/char_gloves
	name = "Red Comet's gloves"
	desc = "For the hands of those who have never betrayed anyone in their life."
	icon_state = "char_gloves"

/obj/item/storage/box/halloween/edition_21/char
	theme_name = "2021's Red Comet"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/char_suit,
		/obj/item/clothing/shoes/costume_2021/char_shoes,
		/obj/item/clothing/head/costume_2021/char_hat,
		/obj/item/clothing/gloves/costume_2021/char_gloves,
	)


/**
 * IRA
 * From: Irish Republican Army (Anime)
 * By: Saladlegs
 */

/obj/item/clothing/under/costume_2021/ira_suit
	name = "commando jumper"
	desc = "Perfect for cold space... months?"
	icon_state = "ira_under"

/obj/item/clothing/head/costume_2021/ira_hat
	name = "balaclava and beret"
	desc = "Not indicative of rank"
	icon_state = "ira_head"
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/suit/costume_2021/ira_jacket
	name = "DPM field jacket"
	desc = "Not to be mistaken for the enemy"
	icon_state = "ira_suit"

/obj/item/storage/box/halloween/edition_21/ira
	theme_name = "2021's Irish Republican Army"
	illustration = "reina_box"
	costume_contents = list(
	 	/obj/item/clothing/under/costume_2021/ira_suit,
		/obj/item/clothing/head/costume_2021/ira_hat,
	 	/obj/item/clothing/suit/costume_2021/ira_jacket,
		/obj/item/clothing/gloves/color/black,
	 	/obj/item/clothing/shoes/sneakers/black,
	 	/obj/item/gun/ballistic/automatic/pistol/toy,
	)


/**
 * Doll
 * From: Bloodborne
 * By: Saladlegs
 */

/obj/item/clothing/under/costume_2021/doll_suit
	name = "Doll's cloak"
	desc = "Discarded doll clothing, likely a spare for dress-up."
	icon_state = "doll_under"

/obj/item/clothing/head/costume_2021/doll_hat
	name = "Doll's bonnet"
	desc = "A deep love for the doll can be sumised by the fine craftsmanship of this article, and the care with which it was kept."
	icon_state = "doll_hat"

/obj/item/clothing/shoes/costume_2021/doll_shoes
	name = "Doll's boots"
	desc = "It borderlines on mania, and exudes a slight warmth."
	icon_state = "doll_boots"

/obj/item/storage/box/halloween/edition_21/doll
	theme_name = "2021's Doll"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/doll_suit,
		/obj/item/clothing/head/costume_2021/doll_hat,
		/obj/item/clothing/shoes/costume_2021/doll_shoes,
	)


/**
 * Cainhurst Knight
 * From: Bloodborne
 * By: Saladlegs
 */

/obj/item/clothing/suit/costume_2021/vileblood_suit
	name = "Cainhurst knight's garb"
	desc = "Adornment prized by the knights of Cainhurst."
	icon_state = "vileblood_suit"

/obj/item/storage/box/halloween/edition_21/vileblood
	theme_name = "2021's Cainhurst Knight"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2021/vileblood_suit,
		/obj/item/clothing/shoes/laceup,
	)


/**
 * Patlabor
 * From: Patlabor
 * By: Saladlegs
 */

/obj/item/clothing/under/costume_2021/patlabor_suit
	name = "SV2 Uniform"
	desc = "For dealing with combat crimes, terrorism and accidents involving Labors."
	icon_state = "patlabor_under"

/obj/item/storage/box/halloween/edition_21/patlabor
	theme_name = "2021's Patlabor Officer"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/patlabor_suit,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/gloves/color/white,
	)


/**
 * Alucard
 * From: Castlevania
 * By: Saladlegs
 */

/obj/item/clothing/suit/costume_2021/alucard_suit
	name = "vampiric cloak"
	desc = "What is Dracula backwards?"
	icon_state = "alucard_suit"


/obj/item/clothing/shoes/costume_2021/alucard_shoes
	name = "vampiric boots"
	desc = "For double jumping."
	icon_state = "alucard_boots"


/obj/item/storage/box/halloween/edition_21/alucard
	theme_name = "2021's Alucard"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2021/alucard_suit,
		/obj/item/clothing/shoes/costume_2021/alucard_shoes,
	)
