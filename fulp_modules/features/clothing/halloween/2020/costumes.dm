/**
 * Setting all costumes to use our .dmi file so we dont have to repeat each time
 * We're only setting the most commonly used items to use it.
 */
/obj/item/clothing/under/costume_2020
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/suit/costume_2020
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/head/costume_2020
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/neck/costume_2020
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/shoes/costume_2020
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'

/obj/item/clothing/gloves/costume_2020
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'

/**
 * 2020 Space Asshole costume
 * Made by: Papaporo Paprito
 */
/obj/item/clothing/under/costume_2020/asshole_jumpsuit
	name = "space asshole suit"
	desc = "A faint smell sulphur, mars dust and free space terrorism."
	icon_state = "asshole_jumpsuit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = FEMALE_UNIFORM_FULL
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

/obj/item/storage/box/halloween/edition_20/space_asshole/PopulateContents()
	new /obj/item/clothing/suit/costume_2020/asshole_coat(src)
	new /obj/item/clothing/under/costume_2020/asshole_jumpsuit(src)
	new /obj/item/clothing/shoes/costume_2020/asshole_boots(src)
	new /obj/item/clothing/neck/costume_2020/asshole_scarf(src)
	new /obj/item/clothing/gloves/color/black(src)

/**
 * Chaos Mage Costume
 */
/obj/item/clothing/under/costume_2020/chaosmage
	name = "chaos mage tabard"
	desc = "An old outfit which has lost its magical power. It is said that this belonged to a powerful mage."
	icon_state = "chaos_tabard"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/suit/hooded/wintercoat/chaosmage
	name = "chaos mage cloak"
	desc = "A fancy purplish cloak with golden finitions. It keeps a bit warm for cold travels."
	icon_state = "chaos_cloak"
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'
	hoodtype = /obj/item/clothing/head/hooded/winterhood/chaosmage

/obj/item/clothing/head/hooded/winterhood/chaosmage
	name = "chaos mage hood"
	desc = "A comfy purplish hood with golden trim. Wear it to be more mysterious."
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'
	icon_state = "chaos_hood"

/obj/item/clothing/shoes/costume_2020/chaosmage
	name = "chaos mage boots"
	desc = "A pair of warm boots made of synthetic wool. Sadly, dashes are not included."
	icon_state = "chaos_boots"

/obj/item/storage/box/halloween/edition_20/chaosmage
	theme_name = "2020's Chaos mage outfit"
	illustration = "mask"

/obj/item/storage/box/halloween/edition_20/chaosmage/PopulateContents()
	new /obj/item/clothing/under/costume_2020/chaosmage(src)
	new /obj/item/clothing/suit/hooded/wintercoat/chaosmage(src)
	new /obj/item/clothing/shoes/costume_2020/chaosmage(src)

/**
 * Columbia Costume
 */
/obj/item/clothing/under/costume_2020/columbia
	name = "Columbia's suit"
	desc = "With a bit of a mind flip..."
	icon_state = "columbia"
	body_parts_covered = CHEST|GROIN
	fitted = NO_FEMALE_UNIFORM
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

/obj/item/storage/box/halloween/edition_20/columbia/PopulateContents()
	new /obj/item/clothing/under/costume_2020/columbia(src)
	new /obj/item/clothing/head/costume_2020/columbia(src)
	new /obj/item/clothing/suit/costume_2020/columbia(src)
	new /obj/item/clothing/neck/costume_2020/columbia(src)
	new /obj/item/clothing/shoes/costume_2020/columbia(src)

/**
 * Daft Punk costume
 * Made by: Franklin
 */
///Golden punk helmet
/obj/item/clothing/head/hardhat/golden_punk
	name = "Guy-Manuel Helmet"
	desc = "Give life back to music!"
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'
	icon_state = "hardhat0_guy"
	on = FALSE
	hat_type = "guy"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, RAD = 0, FIRE = 0, ACID = 0, WOUND = 0)
	resistance_flags = null
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES

///Silver punk helmet
/obj/item/clothing/head/hardhat/silver_punk
	name = "Thomas Helmet"
	desc = "Reminds you of touch..."
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'
	icon_state = "hardhat0_thomas"
	on = FALSE
	hat_type = "thomas"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, RAD = 0, FIRE = 0, ACID = 0, WOUND = 0)
	resistance_flags = null
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/under/costume_2020/sparky
	name = "sparkling suit"
	desc = "Harder, Better, Faster, Stronger!"
	icon_state = "the_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = FEMALE_UNIFORM_FULL
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

/obj/item/storage/box/halloween/edition_20/daft_box/PopulateContents()
	new /obj/item/clothing/head/hardhat/golden_punk(src)
	new /obj/item/clothing/head/hardhat/silver_punk(src)
	new /obj/item/clothing/gloves/costume_2020/daft_golden(src)
	new /obj/item/clothing/gloves/costume_2020/daft_silver(src)
	new /obj/item/instrument/eguitar(src)
	new /obj/item/instrument/piano_synth(src)

	for(var/i in 1 to 2)
		new /obj/item/clothing/under/costume_2020/sparky(src)
		new /obj/item/clothing/shoes/sneakers/cyborg(src)

/obj/item/storage/box/halloween/edition_20/daft_box/golden
	theme_name = "2020's Daft Punk Golden"

/obj/item/storage/box/halloween/edition_20/daft_box/golden/PopulateContents()
	new /obj/item/clothing/head/hardhat/golden_punk(src)
	new /obj/item/clothing/gloves/costume_2020/daft_golden(src)
	new /obj/item/instrument/eguitar(src)
	new /obj/item/clothing/under/costume_2020/sparky(src)
	new /obj/item/clothing/shoes/sneakers/cyborg(src)

/obj/item/storage/box/halloween/edition_20/daft_box/silver
	theme_name = "2020's Daft Punk Silver"

/obj/item/storage/box/halloween/edition_20/daft_box/silver/PopulateContents()
	new /obj/item/clothing/head/hardhat/silver_punk(src)
	new /obj/item/clothing/gloves/costume_2020/daft_silver(src)
	new /obj/item/instrument/piano_synth(src)
	new /obj/item/clothing/under/costume_2020/sparky(src)
	new /obj/item/clothing/shoes/sneakers/cyborg(src)

/**
 * Devil fan costume (2020)
 */
/obj/item/clothing/under/costume_2020/devilfan
	name = "devil's body"
	desc = "This is just red paint all over your body. And somehow it sticks well even after washing!"
	icon_state = "devil_body"
	fitted = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/head/costume_2020/devilfan
	name = "devil's mask"
	desc = "Are you finally revealing your true evil?"
	icon_state = "devil_mask"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR
	dynamic_hair_suffix = "+generic"

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

/obj/item/storage/box/halloween/edition_20/devilfan/PopulateContents()
	new /obj/item/clothing/under/costume_2020/devilfan(src)
	new /obj/item/clothing/head/costume_2020/devilfan(src)
	new /obj/item/clothing/shoes/costume_2020/devilfan(src)
	new /obj/item/clothing/gloves/costume_2020/devilfan(src)

/**
 * Woody/Forbidden costume
 * Made by: Horatio/Joyce
 */
/obj/item/clothing/under/costume_2020/forbidden_cowboy
	name = "forbidden cowboy suit"
	desc = "Just looking at this suit makes you hear a quiet bwoink at the back of you mind."
	icon_state = "forbiddencowboy_suit"
	fitted = FEMALE_UNIFORM_FULL
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/head/costume_2020/forbidden_cowboy
	name = "forbidden cowboy hat"
	desc = "Just looking at this hat makes you hear a quiet bwoink at the back of you mind."
	icon_state = "forbiddencowboy_hat"

/obj/item/storage/box/halloween/edition_20/forbidden_cowboy
	theme_name = "2020's Forbidden Cowboy"

/obj/item/storage/box/halloween/edition_20/forbidden_cowboy/PopulateContents()
	new /obj/item/clothing/head/costume_2020/forbidden_cowboy(src)
	new /obj/item/clothing/under/costume_2020/forbidden_cowboy(src)
	new /obj/item/clothing/shoes/cowboy(src)
	new /obj/item/stack/sheet/mineral/wood(src)

/**
 * Frog costume
 * Made by: Cecily
 */
/obj/item/clothing/under/costume_2020/frog_suit
	name = "frog onesie"
	desc = "A comfortable and snuggly animal onesie."
	icon_state = "frog_suit"
	fitted = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/head/costume_2020/frog_head
	name = "frog hood"
	desc = "A comfortable and snuggly animal hoodie"
	icon_state = "frog_head"

/obj/item/clothing/gloves/costume_2020/frog_gloves
	name = "frog gloves"
	desc = "A tight yet comfortable pair of gloves."
	icon_state = "frog_gloves"

/obj/item/clothing/shoes/costume_2020/frog_shoe
	name = "frog shoes"
	desc = "A pair of comfortable shoes recolored green."
	icon_state = "frog_shoes"

/obj/item/storage/box/halloween/edition_20/frog
	theme_name = "2020's Frog"

/obj/item/storage/box/halloween/edition_20/frog/PopulateContents()
	new /obj/item/clothing/under/costume_2020/frog_suit(src)
	new /obj/item/clothing/head/costume_2020/frog_head(src)
	new /obj/item/clothing/gloves/costume_2020/frog_gloves(src)
	new /obj/item/clothing/shoes/costume_2020/frog_shoe(src)

/**
 * Gnome costume
 * Made by: Papaporo
 */
/obj/item/clothing/under/costume_2020/gnome
	name = "Gnome's jumpsuit"
	desc = "A gnome suit for gnoming."
	icon_state = "gnome_jumpsuit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = FEMALE_UNIFORM_FULL
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
		var/mob/living/carbon/human/H = target
		H.Knockdown(30)
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "gnomed", /datum/mood_event/gnomed)
	playsound(src, 'fulp_modules/features/clothing/halloween/sounds/gnomed.ogg', 50, TRUE)
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

/obj/item/storage/box/halloween/edition_20/gnome/PopulateContents()
	new /obj/item/clothing/under/costume_2020/gnome(src)
	new /obj/item/clothing/head/costume_2020/gnome(src)
	new /obj/item/clothing/suit/costume_2020/gnome(src)
	new /obj/item/clothing/shoes/costume_2020/gnome(src)

///Unique halloween box that can't be bought by default, only from the halloween event
/obj/item/storage/box/halloween/special/gnomed
	illustration = "pumpkin"

/obj/item/storage/box/halloween/special/gnomed/Initialize()
	. = ..()
	year = pick("2019", "2020")
	switch(year)
		if("2019")
			theme_name = pick("2019's Centaur", "2019's Hotdog", "2019's Ketchup", "2019's Mustard",
			"2019's Angel", "2019's Devil", "2019's Cat", "2019's Pumpkin", "2019's Skeleton",
			"2019's Spider", "2019's Witch", "2019's Sailor Moon", "2019's Tuxedo Mask",
			"2019's Tricksters", "2019's Next Adventure", "2019's Phantom maid", "2019's Sans",
			"2019's Solid Snake", "2019's Starship Trooper", "2019's Bounty Hunter", "2019's Zombie")
		if("2020")
			theme_name = pick("2020's Frog", "2020's Skull mask", "2020's Heisters")

	if(theme_name)
		name = "[name] ([theme_name])"
		desc = "Costumes in a box. The box's theme is '[theme_name]'."
		inhand_icon_state = "syringe_kit"

/obj/item/storage/box/halloween/special/gnomed/PopulateContents()
	new /obj/item/clothing/under/costume_2020/gnome(src)
	new /obj/item/clothing/head/costume_2020/gnome/gnomed(src)
	new /obj/item/clothing/suit/costume_2020/gnome(src)
	new /obj/item/clothing/shoes/costume_2020/gnome(src)

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

/obj/item/storage/box/halloween/edition_20/hierocult/PopulateContents()
	new /obj/item/clothing/suit/costume_2020/hierocult(src)
	new /obj/item/clothing/head/costume_2020/hierocult(src)

/**
 * Midsommer & Midsommer Queen costumes
 */
///Default Midsommer costume
/obj/item/clothing/under/costume_2020/midsommer
	name = "midsommer dress"
	desc = "Write something here to show up when examined."
	icon_state = "midsommar_dress"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/head/costume_2020/midsommer
	name = "flower crown"
	desc = "Write something here to show up when examined."
	icon_state = "flower_crown"

///Midsommer Queen costume
/obj/item/clothing/suit/costume_2020/midsommer_queen
	name = "May Queen"
	desc = "Write something here to show up when examined."
	icon_state = "may_queen"
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

/obj/item/clothing/head/costume_2020/midsommer_queen
	name = "May Queen crown"
	desc = "Write something here to show up when examined."
	icon_state = "flower_crown_tall"
	worn_x_dimension = 64
	worn_y_dimension = 64
	clothing_flags = LARGE_WORN_ICON

/obj/item/storage/box/halloween/edition_20/midsommer
	theme_name = "2020's Midsommer"

/obj/item/storage/box/halloween/edition_20/midsommer/PopulateContents()
	new /obj/item/clothing/under/costume_2020/midsommer(src)
	new /obj/item/clothing/head/costume_2020/midsommer(src)
	new /obj/item/clothing/head/costume_2020/midsommer_queen(src)
	new /obj/item/clothing/suit/costume_2020/midsommer_queen(src)
	new /obj/item/food/grown/mushroom/libertycap(src)

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
	new /obj/item/clothing/suit/costume_2020/moffking(src)
	new /obj/item/clothing/head/costume_2020/moffking(src)
	new /obj/item/shield/riot/buckler(src)

	cloakcolor = pick("black", "blue", "green", "purple", "red", "orange", "white", "yellow")
	switch(cloakcolor)
		if("black")
			new /obj/item/clothing/neck/costume_2020/moffking/black(src)
		if("blue")
			new /obj/item/clothing/neck/costume_2020/moffking/blue(src)
		if("green")
			new /obj/item/clothing/neck/costume_2020/moffking/green(src)
		if("purple")
			new /obj/item/clothing/neck/costume_2020/moffking/purple(src)
		if("red")
			new /obj/item/clothing/neck/costume_2020/moffking/red(src)
		if("orange")
			new /obj/item/clothing/neck/costume_2020/moffking/orange(src)
		if("white")
			new /obj/item/clothing/neck/costume_2020/moffking/white(src)
		if("yellow")
			new /obj/item/clothing/neck/costume_2020/moffking/yellow(src)

/**
 * Papa Ross costume
 * Made by: Papaporo
 */
/obj/item/clothing/under/costume_2020/papa_ross
	name = "Bob Ross jumpsuit"
	desc = "We dont make mistakes. We just have happy accidents."
	icon_state = "papa_ross_jumpsuit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = FEMALE_UNIFORM_FULL
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
	dynamic_hair_suffix = "+generic"

/obj/item/clothing/neck/costume_2020/papa_ross_squirrel
	name = "Peapod the squirrel"
	desc = "This here is my little friend. His name is Peapod and he lives in my garden."
	lefthand_file = 'fulp_modules/features/clothing/halloween/2020/2020_icons_left.dmi'
	righthand_file = 'fulp_modules/features/clothing/halloween/2020/2020_icons_right.dmi'
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

/obj/item/storage/box/halloween/edition_20/papa_ross/PopulateContents()
	new /obj/item/clothing/under/costume_2020/papa_ross(src)
	new /obj/item/clothing/head/costume_2020/papa_ross(src)
	new /obj/item/clothing/suit/costume_2020/papa_ross(src)
	new /obj/item/clothing/neck/costume_2020/papa_ross_squirrel(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/canvas/nineteen_nineteen(src)

/**
 * Payday masks
 * Made by: Neri Ventado
 */
/obj/item/clothing/mask/gas/mime/heister_mask
	name = "mastermind's clown mask"
	desc = "Guys, the nuclear disk, go get it!"
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'
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

	if(src && choice && !user.incapacitated() && in_range(user,src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		to_chat(user, span_notice("Your Heister's Mask has now morphed into [choice]!"))
		return TRUE

/obj/item/storage/box/halloween/edition_20/heisters
	theme_name = "2020's Heisters"

/obj/item/storage/box/halloween/edition_20/heisters/PopulateContents()
	new /obj/item/clothing/mask/gas/mime/heister_mask(src)
	new /obj/item/toy/gun(src)
	new /obj/item/clothing/gloves/color/latex/nitrile(src)
	new /obj/item/clothing/shoes/laceup(src)

	var/randomsuit = pick(
		/obj/item/clothing/under/suit/tan,
		/obj/item/clothing/under/suit/black,
		/obj/item/clothing/under/suit/burgundy,
		/obj/item/clothing/under/suit/navy,
		/obj/item/clothing/under/suit/black/female,
	)
	new randomsuit(src)

/**
 * Skull masks costumes
 */
/obj/item/clothing/mask/gas/mime/skull_mask_mime
	name = "Skull mask"
	desc = "A unique mime's mask. It has an eerie facial posture."
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'
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
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		to_chat(user, span_notice("Your Skull Mime Mask has now morphed into [choice]!"))
		return TRUE

/obj/item/clothing/under/dress/blacktango/skull_dress
	name = "Skull mask's dress"
	desc = "A black dress adorned with harebells ."
	icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/2020/2020_icons_worn.dmi'
	icon_state = "skull_dress"

/obj/item/clothing/head/costume_2020/skull_mask
	name = "Skull mask's hat"
	desc = "A black hat adorned with harebells."
	icon_state = "skull_hat"

/obj/item/storage/box/halloween/edition_20/skull_mask
	theme_name = "2020's Skull Mask"

/obj/item/storage/box/halloween/edition_20/skull_mask/PopulateContents()
	new /obj/item/clothing/head/costume_2020/skull_mask(src)
	new /obj/item/clothing/mask/gas/mime/skull_mask_mime(src)
	new /obj/item/clothing/under/dress/blacktango/skull_dress(src)
	for(var/i in 1 to 3)
		new /obj/item/food/grown/harebell(src)

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

/obj/item/storage/box/halloween/edition_20/princess/burger/PopulateContents()
	new /obj/item/clothing/suit/costume_2020/burger(src)
	new /obj/item/food/breadslice/plain(src)

/obj/item/clothing/under/costume_2020/pizza
	name = "pizza leotard"
	desc = "Pizza."
	icon_state = "pizza_leotard"
	body_parts_covered = CHEST|GROIN
	fitted = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2020/pizza
	name = "pizza"
	desc = "Time."
	icon_state = "pizza"
	body_parts_covered = CHEST|GROIN

/obj/item/storage/box/halloween/edition_20/pizza
	theme_name = "2020's Pizza"

/obj/item/storage/box/halloween/edition_20/princess/pizza/PopulateContents()
	new /obj/item/clothing/under/costume_2020/pizza(src)
	new /obj/item/clothing/suit/costume_2020/pizza(src)
