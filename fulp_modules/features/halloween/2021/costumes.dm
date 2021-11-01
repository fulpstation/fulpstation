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

/obj/item/clothing/head/hardhat/costume_2021/deadcells_hat
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
		/obj/item/clothing/head/hardhat/costume_2021/deadcells_hat,
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
	theme_name = "2021's dancing man"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/pucci_suit,
		/obj/item/clothing/suit/costume_2021/pucci_jacket,
		/obj/item/clothing/head/costume_2021/pucci_hat,
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
	theme_name = "2021's male witch"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/willard_suit,
		/obj/item/clothing/suit/costume_2021/willard_jacket,
		/obj/item/clothing/head/costume_2021/willard_hat,
		/obj/item/clothing/shoes/costume_2021/willard_shoes,
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
	theme_name = "2021's thirsty flower"
	costume_contents = list(
		/obj/item/clothing/under/color/thirsty_suit,
		/obj/item/clothing/head/costume_2021/thirsty_hat,
	)
