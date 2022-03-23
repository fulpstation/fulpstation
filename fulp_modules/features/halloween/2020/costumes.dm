/**
 * Setting all costumes to use our .dmi file so we dont have to repeat each time
 * We're only setting the most commonly used items to use it.
 */
/obj/item/clothing/under/costume_2020
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/suit/costume_2020
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/head/costume_2020
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/neck/costume_2020
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/shoes/costume_2020
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/gloves/costume_2020
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'

/**
 * 2020 Space Asshole costume
 * Made by: Papaporo Paprito
 */
/obj/item/clothing/under/costume_2020/asshole_jumpsuit
	name = "space asshole suit"
	desc = "A faint smell sulphur, mars dust and free space terrorism."
	icon_state = "asshole_jumpsuit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	female_sprite_flags = FEMALE_UNIFORM_FULL
	can_adjust = FALSE
	alt_covers_chest = FALSE

/obj/item/clothing/suit/costume_2020/asshole_coat
	name = "space asshole coat"
	desc = "Covered in dust and blood. Allows for easy sledgehammer storage."
	icon_state = "asshole_coat"

/obj/item/clothing/neck/costume_2020/asshole_scarf
	name = "space asshole scarf"
	desc = "Keep your neck warm on your martian guerrilla incursions."
	icon_state = "asshole_scarf"

/obj/item/clothing/shoes/costume_2020/asshole_boots
	name = "space asshole boots"
	desc = "Stylish boots for stylish assholes."
	icon_state = "asshole_boots"

/obj/item/storage/box/halloween/edition_20/space_asshole
	theme_name = "2020's Martian revolutionary"
	illustration = "moth"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/asshole_coat,
		/obj/item/clothing/under/costume_2020/asshole_jumpsuit,
		/obj/item/clothing/shoes/costume_2020/asshole_boots,
		/obj/item/clothing/neck/costume_2020/asshole_scarf,
		/obj/item/clothing/gloves/color/black,
	)

/**
 * Chaos Mage Costume
 */
/obj/item/clothing/under/costume_2020/chaosmage
	name = "chaos mage tabard"
	desc = "An old outfit which has lost its magical power. It is said that this belonged to a powerful mage."
	icon_state = "chaos_tabard"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/suit/hooded/wintercoat/chaosmage
	name = "chaos mage cloak"
	desc = "A fancy purplish cloak with golden finitions. It keeps a bit warm for cold travels."
	icon_state = "chaos_cloak"
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'
	hoodtype = /obj/item/clothing/head/hooded/winterhood/chaosmage

/obj/item/clothing/head/hooded/winterhood/chaosmage
	name = "chaos mage hood"
	desc = "A comfy purplish hood with golden trim. Wear it to be more mysterious."
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'
	icon_state = "chaos_hood"

/obj/item/clothing/shoes/costume_2020/chaosmage
	name = "chaos mage boots"
	desc = "A pair of warm boots made of synthetic wool. Sadly, dashes are not included."
	icon_state = "chaos_boots"

/obj/item/storage/box/halloween/edition_20/chaosmage
	theme_name = "2020's Chaos mage outfit"
	illustration = "mask"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/chaosmage,
		/obj/item/clothing/suit/hooded/wintercoat/chaosmage,
		/obj/item/clothing/shoes/costume_2020/chaosmage,
	)

/**
 * Columbia Costume
 */
/obj/item/clothing/under/costume_2020/columbia
	name = "Columbia's suit"
	desc = "With a bit of a mind flip..."
	icon_state = "columbia"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2020/columbia
	name = "Columbia's jacket"
	desc = "And nothing can ever be the same."
	icon_state = "columbia_jacket"

/obj/item/clothing/head/costume_2020/columbia
	name = "Columbia's hat"
	desc = "You're into a time slip..."
	icon_state = "columbia_hat"

/obj/item/clothing/neck/costume_2020/columbia
	name = "Columbia's bow"
	desc = "Let's do the time warp again!"
	icon_state = "columbia_bow"

/obj/item/clothing/shoes/costume_2020/columbia
	name = "Columbia's shoes"
	desc = "It's just a jump to the left..."
	icon_state = "columbia_shoes"

/obj/item/storage/box/halloween/edition_20/columbia
	theme_name = "2020's Columbia"
	illustration = "columbia"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/columbia,
		/obj/item/clothing/head/costume_2020/columbia,
		/obj/item/clothing/suit/costume_2020/columbia,
		/obj/item/clothing/neck/costume_2020/columbia,
		/obj/item/clothing/shoes/costume_2020/columbia,
	)

/**
 * Daft Punk costume
 * Made by: Franklin
 */
///Golden punk helmet
/obj/item/clothing/head/hardhat/golden_punk
	name = "Guy-Manuel Helmet"
	desc = "Give life back to music!"
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'
	icon_state = "hardhat0_guy"
	on = FALSE
	hat_type = "guy"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, FIRE = 0, ACID = 0, WOUND = 0)
	resistance_flags = null
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES

///Silver punk helmet
/obj/item/clothing/head/hardhat/silver_punk
	name = "Thomas Helmet"
	desc = "Reminds you of touch..."
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'
	icon_state = "hardhat0_thomas"
	on = FALSE
	hat_type = "thomas"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, FIRE = 0, ACID = 0, WOUND = 0)
	resistance_flags = null
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/under/costume_2020/sparky
	name = "sparkling suit"
	desc = "Harder, Better, Faster, Stronger!"
	icon_state = "the_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	female_sprite_flags = FEMALE_UNIFORM_FULL
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/gloves/costume_2020/daft_golden
	name = "daft golden gloves"
	desc = "A pair of sparky golden gloves."
	icon_state = "golden_gloves"

/obj/item/clothing/gloves/costume_2020/daft_silver
	name = "daft silver gloves"
	desc = "A pair of sparky silver gloves."
	icon_state = "silver_gloves"

/obj/item/storage/box/halloween/edition_20/daft_box
	theme_name = "2020's Daft Punk Duo"
	illustration = "daft"
	costume_contents = list(
		/obj/item/clothing/head/hardhat/golden_punk,
		/obj/item/clothing/head/hardhat/silver_punk,
		/obj/item/clothing/gloves/costume_2020/daft_golden,
		/obj/item/clothing/gloves/costume_2020/daft_silver,
		/obj/item/instrument/eguitar,
		/obj/item/instrument/piano_synth,
		/obj/item/clothing/under/costume_2020/sparky,
		/obj/item/clothing/shoes/sneakers/cyborg,
	)

/obj/item/storage/box/halloween/edition_20/daft_box/golden
	theme_name = "2020's Daft Punk Golden"
	costume_contents = list(
		/obj/item/clothing/head/hardhat/golden_punk,
		/obj/item/clothing/gloves/costume_2020/daft_golden,
		/obj/item/instrument/eguitar,
		/obj/item/clothing/under/costume_2020/sparky,
		/obj/item/clothing/shoes/sneakers/cyborg,
	)

/obj/item/storage/box/halloween/edition_20/daft_box/silver
	theme_name = "2020's Daft Punk Silver"
	costume_contents = list(
		/obj/item/clothing/head/hardhat/silver_punk,
		/obj/item/clothing/gloves/costume_2020/daft_silver,
		/obj/item/instrument/piano_synth,
		/obj/item/clothing/under/costume_2020/sparky,
		/obj/item/clothing/shoes/sneakers/cyborg,
	)

/**
 * Devil fan costume (2020)
 */
/obj/item/clothing/under/costume_2020/devilfan
	name = "devil's body"
	desc = "This is just red paint all over your body. And somehow it sticks well even after washing!"
	icon_state = "devil_body"
	female_sprite_flags = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/head/costume_2020/devilfan
	name = "devil's mask"
	desc = "Are you finally revealing your true evil?"
	icon_state = "devil_mask"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR

/obj/item/clothing/shoes/costume_2020/devilfan
	name = "devil's hooves"
	desc = "It never skipped leg day! Look at those sturdy legs!"
	icon_state = "devil_hooves"

/obj/item/clothing/gloves/costume_2020/devilfan
	name = "devil's hands"
	desc = "Red paint to go with your hands. Why it isn't part of the suit is a mystery."
	icon_state = "devil_hands"

/obj/item/storage/box/halloween/edition_20/devilfan
	theme_name = "2020's Devilfan"
	illustration = "mask"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/devilfan,
		/obj/item/clothing/head/costume_2020/devilfan,
		/obj/item/clothing/shoes/costume_2020/devilfan,
		/obj/item/clothing/gloves/costume_2020/devilfan,
	)

/**
 * Woody/Forbidden costume
 * Made by: Horatio/Joyce
 */
/obj/item/clothing/under/costume_2020/forbidden_cowboy
	name = "forbidden cowboy suit"
	desc = "Just looking at this suit makes you hear a quiet bwoink at the back of you mind."
	icon_state = "forbiddencowboy_suit"
	female_sprite_flags = FEMALE_UNIFORM_FULL
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/head/costume_2020/forbidden_cowboy
	name = "forbidden cowboy hat"
	desc = "Just looking at this hat makes you hear a quiet bwoink at the back of you mind."
	icon_state = "forbiddencowboy_hat"

/obj/item/storage/box/halloween/edition_20/forbidden_cowboy
	theme_name = "2020's Forbidden Cowboy"
	costume_contents = list(
		/obj/item/clothing/head/costume_2020/forbidden_cowboy,
		/obj/item/clothing/under/costume_2020/forbidden_cowboy,
		/obj/item/clothing/shoes/cowboy,
		/obj/item/stack/sheet/mineral/wood,
	)

/**
 * Frog costume
 * Made by: Cecily
 */
/obj/item/clothing/under/costume_2020/frog_suit
	name = "frog onesie"
	desc = "A comfortable and snuggly animal onesie."
	icon_state = "frog_suit"
	female_sprite_flags = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/head/costume_2020/frog_head
	name = "frog hood"
	desc = "A comfortable and snuggly animal hoodie"
	icon_state = "frog_head"

/obj/item/clothing/gloves/costume_2020/frog_gloves
	name = "frog gloves"
	desc = "A tight yet comfortable pair of gloves."
	icon_state = "frog_gloves"

/obj/item/clothing/shoes/costume_2020/frog_shoes
	name = "frog shoes"
	desc = "A pair of comfortable shoes recolored green."
	icon_state = "frog_shoes"

/obj/item/storage/box/halloween/edition_20/frog
	theme_name = "2020's Frog"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/frog_suit,
		/obj/item/clothing/head/costume_2020/frog_head,
		/obj/item/clothing/gloves/costume_2020/frog_gloves,
		/obj/item/clothing/shoes/costume_2020/frog_shoes,
	)

/**
 * Gnome costume
 * Made by: Papaporo
 */
/obj/item/clothing/under/costume_2020/gnome
	name = "Gnome's jumpsuit"
	desc = "A gnome suit for gnoming."
	icon_state = "gnome_jumpsuit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	female_sprite_flags = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2020/gnome
	name = "Gnome's suit"
	desc = "I'm a gnome, and you will be gnomed."
	icon_state = "gnome_suit"
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

/obj/item/clothing/shoes/costume_2020/gnome
	name = "Gnome's shoes"
	desc = "These are gnot gnoblin boots."
	icon_state = "gnome_shoes"

/obj/item/clothing/head/costume_2020/gnome
	name = "Gnome's hat"
	desc = "This is gnot a gnelf hat."
	icon_state = "gnome_hat"
	var/armed = FALSE

/obj/item/clothing/head/costume_2020/gnome/proc/triggered(mob/target)
	if(!armed)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/victim = target
		victim.Knockdown(30)
		SEND_SIGNAL(target, COMSIG_ADD_MOOD_EVENT, "gnomed", /datum/mood_event/gnomed)
	playsound(src, 'fulp_modules/features/halloween/sounds/gnomed.ogg', 50, TRUE)
	armed = FALSE
	update_icon()

/obj/item/clothing/head/costume_2020/gnome/on_found(mob/finder)
	if(!armed)
		return FALSE
	if(finder)
		finder.visible_message(
			span_warning("[finder] gets gnomed by the [src]."),
			span_hypnophrase("You got gnomed by the [src]!"),
			span_hear("You hear a gnome."),
		)
		triggered(finder, (finder.active_hand_index % 2 == 0) ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_PRECISE_L_HAND)
		return TRUE	//end the search
	visible_message(span_warning("[src] snaps shut!"))
	triggered(loc)
	return FALSE

/obj/item/clothing/head/costume_2020/gnome/gnomed
	armed = TRUE

///Gnoming stuff
/datum/mood_event/gnomed
	description = "<span class='warning'>I can't believe I got gnomed!...</span>\n"
	mood_change = -2
	timeout = 5 MINUTES

/obj/item/storage/box/halloween/edition_20/gnome
	theme_name = "2020's Gnome"
	illustration = "moth"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/gnome,
		/obj/item/clothing/head/costume_2020/gnome,
		/obj/item/clothing/suit/costume_2020/gnome,
		/obj/item/clothing/shoes/costume_2020/gnome,
	)

///Unique halloween box that can't be bought by default, only from the halloween event
/obj/item/storage/box/halloween/special/gnomed
	illustration = "pumpkin"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/gnome,
		/obj/item/clothing/head/costume_2020/gnome,
		/obj/item/clothing/suit/costume_2020/gnome,
		/obj/item/clothing/shoes/costume_2020/gnome,
	)

/obj/item/storage/box/halloween/special/gnomed/Initialize()
	. = ..()
	year = pick("2019", "2020")
	switch(year)
		if("2019")
			theme_name = pick(
				"2019's Centaur", "2019's Hotdog", "2019's Ketchup", "2019's Mustard",
				"2019's Angel", "2019's Devil", "2019's Skeleton", "2019's Spider", "2019's Witch",
				"2019's Tricksters", "2019's Sans", "2019's Bounty Hunter", "2019's Zombie",
			)
		if("2020")
			theme_name = pick(
				"2020's Martial revolutionary", "2020's Chaos Mage outfit", "2020's Columbia", "2020's Daft Punk Duo",
				"2020's Daft Punk Golden", "2020's Daft Punk Silver", "2020's Devilfan", "2020's Forbidden Cowboy",
				"2020's Frog", "2020's Gnome", "2020's Hierophant cultist", "2020's Midsommer", "2020's Moffking",
				"2020's Bob Ross", "2020's Heisters", "2020's Skull mask", "2020's Burger", "2020's Pizza",
				"2020's Onesie - Beefman", "2020's Onesie - Ethereal", "2020's Onesie - Felinid", "2020's Onesie - Fly",
				"2020's Onesie - Lizard", "2020's Onesie - Moth", "2020's Onesie - Silicon", "2020's Power Ranger - Black",
				"2020's Power Ranger - Blue", "2020's Power Ranger - Green", "2020's Power Ranger - Pink", "2020's Power Ranger - Red",
				"2020's Power Ranger - Yellow", "2020's Princess - Wonderland", "2020's Princess - Beauty", "2020's Princess - Tenacious",
				"2020's Princess - Cruel devil", "2020's Princess - Arabian", "2020's Princess - Sleeper", "2020's Princess - Skeletor",
				"2020's Princess - Octopus",
			)

	if(theme_name)
		name = "[name] ([theme_name])"
		desc = "Costumes in a box. The box's theme is '[theme_name]'."
		inhand_icon_state = "syringe_kit"

/**
 * Hierophant cult costume
 */
/obj/item/clothing/suit/costume_2020/hierocult
	name = "Hierophant cultist robe"
	desc = "A strange metalic robe but flexible like fabric. Worn by the Hierophant cultists... or just fans of it."
	icon_state = "hiero_robe"

/obj/item/clothing/head/costume_2020/hierocult
	name = "Hierophant cultist helmet"
	desc = "A strange, flashing helmet worn by the Hierophant cultists... or just fans of it."
	icon_state = "hiero_helmet"


/obj/item/storage/box/halloween/edition_20/hierocult
	theme_name = "2020's Hierophant's cultist"
	illustration = "mask"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/hierocult,
		/obj/item/clothing/head/costume_2020/hierocult,
	)

/**
 * Midsommer & Midsommer Queen costumes
 */
///Default Midsommer costume
/obj/item/clothing/under/costume_2020/midsommer
	name = "midsommer dress"
	desc = "A cute embroidered dress."
	icon_state = "midsommar_dress"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/head/costume_2020/midsommer
	name = "flower crown"
	desc = "A festive headpiece made of flowers."
	icon_state = "flower_crown"

///Midsommer Queen costume
/obj/item/clothing/suit/costume_2020/midsommer_queen
	name = "May Queen"
	desc = "A heavy-looking gown made almost entirely of flowers."
	icon_state = "may_queen"
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

/obj/item/clothing/head/costume_2020/midsommer_queen
	name = "May Queen crown"
	desc = "Heavy is the head that wears the crown."
	icon_state = "flower_crown_tall"
	worn_x_dimension = 64
	worn_y_dimension = 64
	clothing_flags = LARGE_WORN_ICON

/obj/item/storage/box/halloween/edition_20/midsommer
	theme_name = "2020's Midsommer"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/midsommer,
		/obj/item/clothing/head/costume_2020/midsommer,
		/obj/item/clothing/head/costume_2020/midsommer_queen,
		/obj/item/clothing/suit/costume_2020/midsommer_queen,
		/obj/item/food/grown/mushroom/libertycap,
	)

/**
 * Moffking costume
 */
/obj/item/clothing/suit/costume_2020/moffking
	name = "moffking chainmail"
	desc = "A cold chainmail from a frozen moon. The chains are made of plastic altough."
	icon_state = "chainmail_suit"

/obj/item/clothing/head/costume_2020/moffking
	name = "moffking helmet"
	desc = "A sturdy helmet with a frontal, gold trimmed, mask. It's in plastic tough, it won't protect anything."
	icon_state = "chainmail_helmet"

/obj/item/clothing/neck/costume_2020/moffking
	name = "moffking shoulderpads"
	desc = "It even comes with a cape!"
	icon_state = "shoulders_white"
	var/cloakcolor

/obj/item/clothing/neck/costume_2020/moffking/Initialize()
	. = ..()
	if(cloakcolor)
		name = "moffking [cloakcolor] shoulderpads"
		desc = "It even comes with a [cloakcolor] cape!."
		icon_state = "shoulders_[cloakcolor]"

/obj/item/clothing/neck/costume_2020/moffking/black
	cloakcolor = "black"

/obj/item/clothing/neck/costume_2020/moffking/blue
	cloakcolor = "blue"

/obj/item/clothing/neck/costume_2020/moffking/green
	cloakcolor = "green"

/obj/item/clothing/neck/costume_2020/moffking/purple
	cloakcolor = "purple"

/obj/item/clothing/neck/costume_2020/moffking/red
	cloakcolor = "red"

/obj/item/clothing/neck/costume_2020/moffking/orange
	cloakcolor = "orange"

/obj/item/clothing/neck/costume_2020/moffking/white
	cloakcolor = "white"

/obj/item/clothing/neck/costume_2020/moffking/yellow
	cloakcolor = "yellow"

/obj/item/storage/box/halloween/edition_20/moffking
	theme_name = "2020's Moffking"
	illustration = "mask"
	var/cloakcolor

/obj/item/storage/box/halloween/edition_20/moffking/PopulateContents()
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/moffking,
		/obj/item/clothing/head/costume_2020/moffking,
		/obj/item/shield/riot/buckler,
	)

	cloakcolor = pick("black","blue","green","purple","red","orange","white","yellow")
	switch(cloakcolor)
		if("black")
			costume_contents += list(/obj/item/clothing/neck/costume_2020/moffking/black)
		if("blue")
			costume_contents += list(/obj/item/clothing/neck/costume_2020/moffking/blue)
		if("green")
			costume_contents += list(/obj/item/clothing/neck/costume_2020/moffking/green)
		if("purple")
			costume_contents += list(/obj/item/clothing/neck/costume_2020/moffking/purple)
		if("red")
			costume_contents += list(/obj/item/clothing/neck/costume_2020/moffking/red)
		if("orange")
			costume_contents += list(/obj/item/clothing/neck/costume_2020/moffking/orange)
		if("white")
			costume_contents += list(/obj/item/clothing/neck/costume_2020/moffking/white)
		if("yellow")
			costume_contents += list(/obj/item/clothing/neck/costume_2020/moffking/yellow)
	// Call parent to deal with the rest
	. = ..()

/**
 * Papa Ross costume
 * Made by: Papaporo
 */
/obj/item/clothing/under/costume_2020/papa_ross
	name = "Bob Ross jumpsuit"
	desc = "We dont make mistakes. We just have happy accidents."
	icon_state = "papa_ross_jumpsuit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	female_sprite_flags = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2020/papa_ross
	name = "Bob Ross apron"
	desc = "This is the fun part. We take our brush, and beat the devil out of it."
	icon_state = "papa_ross_apron"

/obj/item/clothing/head/costume_2020/papa_ross
	name = "Bob Ross wig"
	desc = "Thats a crooked tree. Well send him to Washington."
	icon_state = "papa_ross_wig"
	flags_inv = HIDEHAIR

/obj/item/clothing/neck/costume_2020/papa_ross_squirrel
	name = "Peapod the squirrel"
	desc = "This here is my little friend. His name is Peapod and he lives in my garden."
	lefthand_file = 'fulp_modules/features/halloween/2020/2020_icons_left.dmi'
	righthand_file = 'fulp_modules/features/halloween/2020/2020_icons_right.dmi'
	icon_state = "ross_squirrel_left"
	inhand_icon_state = "ross_squirrel"
	var/flipped = FALSE

/obj/item/clothing/neck/costume_2020/papa_ross_squirrel/dropped()
	icon_state = "ross_squirrel_left"
	flipped = FALSE
	..()

/obj/item/clothing/neck/costume_2020/papa_ross_squirrel/verb/flipcap()
	set category = "Object"
	set name = "Flip Peapod"
	flip(usr)

/obj/item/clothing/neck/costume_2020/papa_ross_squirrel/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	flip(user)

/obj/item/clothing/neck/costume_2020/papa_ross_squirrel/proc/flip(mob/user)
	if(user.incapacitated())
		return
	flipped = !flipped
	if(flipped)
		icon_state = "ross_squirrel_right"
		to_chat(user, span_notice("You moved Peapod to your right shoulder."))
	else
		icon_state = "ross_squirrel_left"
		to_chat(user, span_notice("You moved Peapod to your left shoulder."))
	usr.update_inv_neck()

/obj/item/clothing/neck/costume_2020/papa_ross_squirrel/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click the hat to flip it [flipped ? "left" : "right"].")

/obj/item/storage/box/halloween/edition_20/papa_ross
	theme_name = "2020's Bob Ross"
	illustration = "moth"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/papa_ross,
		/obj/item/clothing/head/costume_2020/papa_ross,
		/obj/item/clothing/suit/costume_2020/papa_ross,
		/obj/item/clothing/neck/costume_2020/papa_ross_squirrel,
		/obj/item/clothing/shoes/laceup,
		/obj/item/canvas/nineteen_nineteen,
	)


/**
 * Payday masks
 * Made by: Neri Ventado
 */
/obj/item/clothing/mask/gas/mime/heister_mask
	name = "mastermind's clown mask"
	desc = "Guys, the nuclear disk, go get it!"
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'
	icon_state = "dallas"
	inhand_icon_state = "mime"

/obj/item/clothing/mask/gas/mime/heister_mask/Initialize(mapload)
	. = ..()
	mimemask_designs = list(
		"Dallas" = image(icon = src.icon, icon_state = "dallas"),
		"Wolf" = image(icon = src.icon, icon_state = "wolf"),
		"Hoxton" = image(icon = src.icon, icon_state = "hoxton"),
		"Chains" = image(icon = src.icon, icon_state = "chains"),
		)

/obj/item/clothing/mask/gas/mime/heister_mask/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated())
		return

	var/list/options = list()
	options["Dallas"] = "dallas"
	options["Wolf"] = "wolf"
	options["Hoxton"] = "hoxton"
	options["Chains"] = "chains"

	var/choice = show_radial_menu(user,src, mimemask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated() && in_range(user, src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/all_selections in actions)
			var/datum/action/mask_options = all_selections
			mask_options.UpdateButtonIcon()
		to_chat(user, span_notice("Your Heister's Mask has now morphed into [choice]!"))
		return TRUE

/obj/item/storage/box/halloween/edition_20/heisters
	theme_name = "2020's Heisters"
	costume_contents = list(
		/obj/item/clothing/mask/gas/mime/heister_mask,
		/obj/item/toy/gun,
		/obj/item/clothing/gloves/color/latex/nitrile,
		/obj/item/clothing/shoes/laceup,
	)

/obj/item/storage/box/halloween/edition_20/heisters/PopulateContents()
	costume_contents += pick(
		/obj/item/clothing/under/suit/tan,
		/obj/item/clothing/under/suit/black,
		/obj/item/clothing/under/suit/burgundy,
		/obj/item/clothing/under/suit/navy,
		/obj/item/clothing/under/suit/black/skirt,
	)
	. = ..()

/**
 * Skull masks costumes
 */
/obj/item/clothing/mask/gas/mime/skull_mask_mime
	name = "Skull mask"
	desc = "A unique mime's mask. It has an eerie facial posture."
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'
	icon_state = "rose"

/obj/item/clothing/mask/gas/mime/skull_mask_mime/Initialize(mapload)
	. = ..()
	mimemask_designs = list(
		"Bleu" = image(icon = src.icon, icon_state = "bleu"),
		"Rose" = image(icon = src.icon, icon_state = "rose"),
		"Rouge" = image(icon = src.icon, icon_state = "rouge"),
		"Vert" = image(icon = src.icon, icon_state = "vert"),
	)

/obj/item/clothing/mask/gas/mime/skull_mask_mime/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated())
		return

	var/list/options = list()
	options["Bleu"] = "bleu"
	options["Rose"] = "rose"
	options["Rouge"] = "rouge"
	options["Vert"] = "vert"

	var/choice = show_radial_menu(user, src, mimemask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated() && in_range(user,src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/all_selections in actions)
			var/datum/action/mask_options = all_selections
			mask_options.UpdateButtonIcon()
		to_chat(user, span_notice("Your Skull Mime Mask has now morphed into [choice]!"))
		return TRUE

/obj/item/clothing/under/dress/blacktango/skull_dress
	name = "Skull mask's dress"
	desc = "A black dress adorned with harebells ."
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'
	icon_state = "skull_dress"

/obj/item/clothing/head/costume_2020/skull_mask
	name = "Skull mask's hat"
	desc = "A black hat adorned with harebells."
	icon_state = "skull_hat"

/obj/item/storage/box/halloween/edition_20/skull_mask
	theme_name = "2020's Skull Mask"
	costume_contents = list(
		/obj/item/clothing/head/costume_2020/skull_mask,
		/obj/item/clothing/mask/gas/mime/skull_mask_mime,
		/obj/item/clothing/under/dress/blacktango/skull_dress,
		/obj/item/food/grown/harebell,
		/obj/item/food/grown/harebell,
	)

/**
 * Burger & Pizza costumes
 * Made by: Horatio/Joyce
 */
/obj/item/clothing/suit/costume_2020/burger
	name = "burger"
	desc = "BORGER."
	icon_state = "burger"
	body_parts_covered = CHEST|GROIN

/obj/item/storage/box/halloween/edition_20/burger
	theme_name = "2020's Burger"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2020/burger,
		/obj/item/food/breadslice/plain,
	)

/obj/item/clothing/under/costume_2020/pizza
	name = "pizza leotard"
	desc = "Pizza."
	icon_state = "pizza_leotard"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2020/pizza
	name = "pizza"
	desc = "Time."
	icon_state = "pizza"
	body_parts_covered = CHEST|GROIN

/obj/item/storage/box/halloween/edition_20/pizza
	theme_name = "2020's Pizza"
	costume_contents = list(
		/obj/item/clothing/under/costume_2020/pizza,
		/obj/item/clothing/suit/costume_2020/pizza,
	)
