/*
 * Contains:
 * Lasertag
 * Costume
 * Misc
 */

/*
 * Lasertag
 */
/obj/item/clothing/suit/bluetag
	name = "blue laser tag armor"
	desc = "A piece of plastic armor. It has sensors that react to red light." //Lasers are concentrated light
	icon_state = "bluetag"
	inhand_icon_state = "bluetag"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	allowed = list (/obj/item/gun/energy/laser/bluetag)
	resistance_flags = NONE

/obj/item/clothing/suit/redtag
	name = "red laser tag armor"
	desc = "A piece of plastic armor. It has sensors that react to blue light."
	icon_state = "redtag"
	inhand_icon_state = "redtag"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	allowed = list (/obj/item/gun/energy/laser/redtag)
	resistance_flags = NONE

/*
 * Costume
 */
/obj/item/clothing/suit/hooded/flashsuit
	name = "flashy costume"
	desc = "What did you expect?"
	icon_state = "flashsuit"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN
	hoodtype = /obj/item/clothing/head/hooded/flashsuit

/obj/item/clothing/head/hooded/flashsuit
	name = "flash button"
	desc = "You will learn to fear the flash."
	icon_state = "flashsuit"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR|HIDEFACE|HIDEMASK|HIDESNOUT

/obj/item/clothing/suit/pirate
	name = "pirate coat"
	desc = "Yarr."
	icon_state = "pirate"
	inhand_icon_state = "pirate"
	allowed = list(/obj/item/melee/transforming/energy/sword/pirate, /obj/item/clothing/glasses/eyepatch, /obj/item/reagent_containers/food/drinks/bottle/rum)
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/pirate/armored
	armor = list(MELEE = 30, BULLET = 50, LASER = 30,ENERGY = 40, BOMB = 30, BIO = 30, RAD = 30, FIRE = 60, ACID = 75)
	strip_delay = 40
	equip_delay_other = 20

/obj/item/clothing/suit/pirate/captain
	name = "pirate captain coat"
	desc = "Yarr."
	icon_state = "hgpirate"
	inhand_icon_state = "hgpirate"

/obj/item/clothing/suit/pirate/captain/armored
	armor = list(MELEE = 30, BULLET = 50, LASER = 30,ENERGY = 40, BOMB = 30, BIO = 30, RAD = 30, FIRE = 60, ACID = 75)
	strip_delay = 40
	equip_delay_other = 20


/obj/item/clothing/suit/cyborg_suit
	name = "cyborg suit"
	desc = "Suit for a cyborg costume."
	icon_state = "death"
	inhand_icon_state = "death"
	flags_1 = CONDUCT_1
	fire_resist = T0C+5200
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/justice
	name = "justice suit"
	desc = "this pretty much looks ridiculous" //Needs no fixing
	icon_state = "justice"
	inhand_icon_state = "justice"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, RAD = 0, FIRE = 50, ACID = 50)


/obj/item/clothing/suit/judgerobe
	name = "judge's robe"
	desc = "This robe commands authority."
	icon_state = "judge"
	inhand_icon_state = "judge"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/storage/fancy/cigarettes, /obj/item/stack/spacecash)
	flags_inv = HIDEJUMPSUIT


/obj/item/clothing/suit/apron/overalls
	name = "coveralls"
	desc = "A set of denim overalls."
	icon_state = "overalls"
	inhand_icon_state = "overalls"
	body_parts_covered = CHEST|GROIN|LEGS
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/apron/purple_bartender
	name = "purple bartender apron"
	desc = "A fancy purple apron for a stylish person."
	icon_state = "purplebartenderapron"
	inhand_icon_state = "purplebartenderapron"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/syndicatefake
	name = "black and red space suit replica"
	icon_state = "syndicate-black-red"
	inhand_icon_state = "syndicate-black-red"
	desc = "A plastic replica of the Syndicate space suit. You'll look just like a real murderous Syndicate agent in this! This is a toy, it is not made for use in space!"
	w_class = WEIGHT_CLASS_NORMAL
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	resistance_flags = NONE

/obj/item/clothing/suit/hastur
	name = "\improper Hastur's robe"
	desc = "Robes not meant to be worn by man."
	icon_state = "hastur"
	inhand_icon_state = "hastur"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/imperium_monk
	name = "\improper Imperium monk suit"
	desc = "Have YOU killed a xeno today?"
	icon_state = "imperium_monk"
	inhand_icon_state = "imperium_monk"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen)


/obj/item/clothing/suit/chickensuit
	name = "chicken suit"
	desc = "A suit made long ago by the ancient empire KFC."
	icon_state = "chickensuit"
	inhand_icon_state = "chickensuit"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET
	flags_inv = HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/monkeysuit
	name = "monkey suit"
	desc = "A suit that looks like a primate."
	icon_state = "monkeysuit"
	inhand_icon_state = "monkeysuit"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/toggle/owlwings
	name = "owl cloak"
	desc = "A soft brown cloak made of synthetic feathers. Soft to the touch, stylish, and a 2 meter wing span that will drive the ladies mad."
	icon_state = "owl_wings"
	inhand_icon_state = "owl_wings"
	togglename = "wings"
	body_parts_covered = ARMS|CHEST
	actions_types = list(/datum/action/item_action/toggle_wings)

/obj/item/clothing/suit/toggle/owlwings/Initialize()
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/owlwings/griffinwings
	name = "griffon cloak"
	desc = "A plush white cloak made of synthetic feathers. Soft to the touch, stylish, and a 2 meter wing span that will drive your captives mad."
	icon_state = "griffin_wings"
	inhand_icon_state = "griffin_wings"

/obj/item/clothing/suit/cardborg
	name = "cardborg suit"
	desc = "An ordinary cardboard box with holes cut in the sides."
	icon_state = "cardborg"
	inhand_icon_state = "cardborg"
	body_parts_covered = CHEST|GROIN
	flags_inv = HIDEJUMPSUIT
	dog_fashion = /datum/dog_fashion/back

/obj/item/clothing/suit/cardborg/equipped(mob/living/user, slot)
	..()
	if(slot == ITEM_SLOT_OCLOTHING)
		disguise(user)

/obj/item/clothing/suit/cardborg/dropped(mob/living/user)
	..()
	user.remove_alt_appearance("standard_borg_disguise")

/obj/item/clothing/suit/cardborg/proc/disguise(mob/living/carbon/human/H, obj/item/clothing/head/cardborg/borghead)
	if(istype(H))
		if(!borghead)
			borghead = H.head
		if(istype(borghead, /obj/item/clothing/head/cardborg)) //why is this done this way? because equipped() is called BEFORE THE ITEM IS IN THE SLOT WHYYYY
			var/image/I = image(icon = 'icons/mob/robots.dmi' , icon_state = "robot", loc = H)
			I.override = 1
			I.add_overlay(mutable_appearance('icons/mob/robots.dmi', "robot_e")) //gotta look realistic
			add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/silicons, "standard_borg_disguise", I) //you look like a robot to robots! (including yourself because you're totally a robot)


/obj/item/clothing/suit/snowman
	name = "snowman outfit"
	desc = "Two white spheres covered in white glitter. 'Tis the season."
	icon_state = "snowman"
	inhand_icon_state = "snowman"
	body_parts_covered = CHEST|GROIN
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/poncho
	name = "poncho"
	desc = "Your classic, non-racist poncho."
	icon_state = "classicponcho"
	inhand_icon_state = "classicponcho"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/poncho/green
	name = "green poncho"
	desc = "Your classic, non-racist poncho. This one is green."
	icon_state = "greenponcho"
	inhand_icon_state = "greenponcho"

/obj/item/clothing/suit/poncho/red
	name = "red poncho"
	desc = "Your classic, non-racist poncho. This one is red."
	icon_state = "redponcho"
	inhand_icon_state = "redponcho"

/obj/item/clothing/suit/poncho/ponchoshame
	name = "poncho of shame"
	desc = "Forced to live on your shameful acting as a fake Mexican, you and your poncho have grown inseparable. Literally."
	icon_state = "ponchoshame"
	inhand_icon_state = "ponchoshame"

/obj/item/clothing/suit/poncho/ponchoshame/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SHAMEBRERO_TRAIT)

/obj/item/clothing/suit/whitedress
	name = "white dress"
	desc = "A fancy white dress."
	icon_state = "white_dress"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	flags_inv = HIDEJUMPSUIT|HIDESHOES

/obj/item/clothing/suit/hooded/carp_costume
	name = "carp costume"
	desc = "A costume made from 'synthetic' carp scales, it smells."
	icon_state = "carp_casual"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT //Space carp like space, so you should too
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/gun/ballistic/rifle/boltaction/harpoon)
	hoodtype = /obj/item/clothing/head/hooded/carp_hood

/obj/item/clothing/head/hooded/carp_hood
	name = "carp hood"
	desc = "A hood attached to a carp costume."
	icon_state = "carp_casual"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/head/hooded/carp_hood/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		user.faction |= "carp"

/obj/item/clothing/head/hooded/carp_hood/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		user.faction -= "carp"

/obj/item/clothing/suit/hooded/ian_costume //It's Ian, rub his bell- oh god what happened to his inside parts?
	name = "corgi costume"
	desc = "A costume that looks like someone made a human-like corgi, it won't guarantee belly rubs."
	icon_state = "ian"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	//cold_protection = CHEST|GROIN|ARMS
	//min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	allowed = list()
	hoodtype = /obj/item/clothing/head/hooded/ian_hood
	dog_fashion = /datum/dog_fashion/back

/obj/item/clothing/head/hooded/ian_hood
	name = "corgi hood"
	desc = "A hood that looks just like a corgi's head, it won't guarantee dog biscuits."
	icon_state = "ian"
	body_parts_covered = HEAD
	//cold_protection = HEAD
	//min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/hooded/bee_costume // It's Hip!
	name = "bee costume"
	desc = "Bee the true Queen!"
	icon_state = "bee"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	clothing_flags = THICKMATERIAL
	hoodtype = /obj/item/clothing/head/hooded/bee_hood

/obj/item/clothing/head/hooded/bee_hood
	name = "bee hood"
	desc = "A hood attached to a bee costume."
	icon_state = "bee"
	body_parts_covered = HEAD
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEHAIR|HIDEEARS
	dynamic_hair_suffix = ""

/obj/item/clothing/suit/hooded/bloated_human //OH MY GOD WHAT HAVE YOU DONE!?!?!?
	name = "bloated human suit"
	desc = "A horribly bloated suit made from human skins."
	icon_state = "lingspacesuit"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list()
	actions_types = list(/datum/action/item_action/toggle_human_head)
	hoodtype = /obj/item/clothing/head/hooded/human_head
	species_exception = list(/datum/species/golem) //Finally, flesh


/obj/item/clothing/head/hooded/human_head
	name = "bloated human head"
	desc = "A horribly bloated and mismatched human head."
	icon_state = "lingspacehelmet"
	body_parts_covered = HEAD
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/suit/security/officer/russian
	name = "\improper Russian officer's jacket"
	desc = "This jacket is for those special occasions when a russian officer isn't required to wear their armor."
	icon_state = "officertanjacket"
	inhand_icon_state = "officertanjacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/shrine_maiden
	name = "shrine maiden's outfit"
	desc = "Makes you want to exterminate some troublesome youkai."
	icon_state = "shrine_maiden"
	inhand_icon_state = "shrine_maiden"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT

/*
 * Misc
 */

/obj/item/clothing/suit/straight_jacket
	name = "straight jacket"
	desc = "A suit that completely restrains the wearer. Manufactured by Antyphun Corp." //Straight jacket is antifun
	icon_state = "straight_jacket"
	inhand_icon_state = "straight_jacket"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	clothing_flags = DANGEROUS_OBJECT
	equip_delay_self = 50
	strip_delay = 60
	breakouttime = 3000

/obj/item/clothing/suit/ianshirt
	name = "worn shirt"
	desc = "A worn out, curiously comfortable t-shirt with a picture of Ian. You wouldn't go so far as to say it feels like being hugged when you wear it, but it's pretty close. Good for sleeping in."
	icon_state = "ianshirt"
	inhand_icon_state = "ianshirt"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/nerdshirt
	name = "gamer shirt"
	desc = "A baggy shirt with vintage game character Phanic the Weasel. Why would anyone wear this?"
	icon_state = "nerdshirt"
	inhand_icon_state = "nerdshirt"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/vapeshirt //wearing this is asking to get beat.
	name = "Vape Naysh shirt"
	desc = "A cheap white T-shirt with a big tacky \"VN\" on the front, Why would you wear this unironically?"
	icon_state = "vapeshirt"
	inhand_icon_state = "vapeshirt"

/obj/item/clothing/suit/striped_sweater
	name = "striped sweater"
	desc = "Reminds you of someone, but you just can't put your finger on it..."
	icon_state = "waldo_shirt"
	inhand_icon_state = "waldo_shirt"

/obj/item/clothing/suit/jacket
	name = "bomber jacket"
	desc = "Aviators not included."
	icon_state = "bomberjacket"
	inhand_icon_state = "brownjsuit"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/radio)
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/jacket/leather
	name = "leather jacket"
	desc = "Pompadour not included."
	icon_state = "leatherjacket"
	inhand_icon_state = "hostrench"
	resistance_flags = NONE
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/gun/ballistic/automatic/pistol, /obj/item/gun/ballistic/revolver, /obj/item/gun/ballistic/revolver/detective, /obj/item/radio)
	species_exception = list(/datum/species/golem/bone) //bad to the bone

/obj/item/clothing/suit/jacket/leather/overcoat
	name = "leather overcoat"
	desc = "That's a damn fine coat."
	icon_state = "leathercoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/jacket/puffer
	name = "puffer jacket"
	desc = "A thick jacket with a rubbery, water-resistant shell."
	icon_state = "pufferjacket"
	inhand_icon_state = "hostrench"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 50, RAD = 0, FIRE = 0, ACID = 0)
	species_exception = list(/datum/species/golem/bone)

/obj/item/clothing/suit/jacket/puffer/vest
	name = "puffer vest"
	desc = "A thick vest with a rubbery, water-resistant shell."
	icon_state = "puffervest"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 30, RAD = 0, FIRE = 0, ACID = 0)

/obj/item/clothing/suit/jacket/miljacket
	name = "military jacket"
	desc = "A canvas jacket styled after classical American military garb. Feels sturdy, yet comfortable."
	icon_state = "militaryjacket"
	inhand_icon_state = "militaryjacket"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/gun/ballistic/automatic/pistol, /obj/item/gun/ballistic/revolver, /obj/item/radio)

/obj/item/clothing/suit/jacket/letterman
	name = "letterman jacket"
	desc = "A classic brown letterman jacket. Looks pretty hot and heavy."
	icon_state = "letterman"
	inhand_icon_state = "letterman"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/jacket/letterman_red
	name = "red letterman jacket"
	desc = "A letterman jacket in a sick red color. Radical."
	icon_state = "letterman_red"
	inhand_icon_state = "letterman_red"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/jacket/letterman_syndie
	name = "blood-red letterman jacket"
	desc = "Oddly, this jacket seems to have a large S on the back..."
	icon_state = "letterman_s"
	inhand_icon_state = "letterman_s"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/jacket/letterman_nanotrasen
	name = "blue letterman jacket"
	desc = "A blue letterman jacket with a proud Nanotrasen N on the back. The tag says that it was made in Space China."
	icon_state = "letterman_n"
	inhand_icon_state = "letterman_n"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/dracula
	name = "dracula coat"
	desc = "Looks like this belongs in a very old movie set."
	icon_state = "draculacoat"
	inhand_icon_state = "draculacoat"

/obj/item/clothing/suit/drfreeze_coat
	name = "doctor freeze's labcoat"
	desc = "A labcoat imbued with the power of features and freezes."
	icon_state = "drfreeze_coat"
	inhand_icon_state = "drfreeze_coat"

/obj/item/clothing/suit/gothcoat
	name = "gothic coat"
	desc = "Perfect for those who want to stalk around a corner of a bar."
	icon_state = "gothcoat"
	inhand_icon_state = "gothcoat"

/obj/item/clothing/suit/xenos
	name = "xenos suit"
	desc = "A suit made out of chitinous alien hide."
	icon_state = "xenos"
	inhand_icon_state = "xenos_helm"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	allowed = list(/obj/item/clothing/mask/facehugger/toy)

/obj/item/clothing/suit/nemes
	name = "pharoah tunic"
	desc = "Lavish space tomb not included."
	icon_state = "pharoah"
	inhand_icon_state = "pharoah"
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/caution
	name = "wet floor sign"
	desc = "Caution! Wet Floor!"
	icon_state = "caution"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN
	attack_verb_continuous = list("warns", "cautions", "smashes")
	attack_verb_simple = list("warn", "caution", "smash")
	armor = list(MELEE = 5, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/changshan_red
	name = "red changshan"
	desc = "A gorgeously embroidered silk shirt."
	icon_state = "changshan_red"
	inhand_icon_state = "changshan_red"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/changshan_blue
	name = "blue changshan"
	desc = "A gorgeously embroidered silk shirt."
	icon_state = "changshan_blue"
	inhand_icon_state = "changshan_blue"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/cheongsam_red
	name = "red cheongsam"
	desc = "A gorgeously embroidered silk dress."
	icon_state = "cheongsam_red"
	inhand_icon_state = "cheongsam_red"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/cheongsam_blue
	name = "blue cheongsam"
	desc = "A gorgeously embroidered silk dress."
	icon_state = "cheongsam_blue"
	inhand_icon_state = "cheongsam_blue"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/head/hooded/ablative
	name = "ablative hood"
	desc = "Hood hopefully belonging to an ablative trenchcoat. Includes a visor for cool-o-vision."
	icon_state = "ablativehood"
	armor = list(MELEE = 10, BULLET = 10, LASER = 60, ENERGY = 60, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	strip_delay = 30
	var/hit_reflect_chance = 50

/obj/item/clothing/head/hooded/ablative/equipped(mob/living/carbon/human/user, slot)
	..()
	to_chat(user, "As you put on the hood, a visor shifts into place and starts analyzing the people around you. Neat!")
	ADD_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.add_hud_to(user)

/obj/item/clothing/head/hooded/ablative/dropped(mob/living/carbon/human/user)
	..()
	to_chat(user, "You take off the hood, removing the visor in the process and disabling its integrated hud.")
	REMOVE_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.remove_hud_from(user)

/obj/item/clothing/head/hooded/ablative/IsReflect(def_zone)
	if(def_zone != BODY_ZONE_HEAD) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/suit/hooded/ablative
	name = "ablative trenchcoat"
	desc = "Experimental trenchcoat specially crafted to reflect and absorb laser and disabler shots. Don't expect it to do all that much against an axe or a shotgun, however."
	icon_state = "ablativecoat"
	inhand_icon_state = "ablativecoat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list(MELEE = 10, BULLET = 10, LASER = 60, ENERGY = 60, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	hoodtype = /obj/item/clothing/head/hooded/ablative
	strip_delay = 30
	equip_delay_other = 40
	var/hit_reflect_chance = 50

/obj/item/clothing/suit/hooded/ablative/Initialize()
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/hooded/ablative/IsReflect(def_zone)
	if(!(def_zone in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/suit/bronze
	name = "bronze suit"
	desc = "A big and clanky suit made of bronze that offers no protection and looks very unfashionable. Nice."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_cuirass_old"
	armor = list(MELEE = 5, BULLET = 0, LASER = -5, ENERGY = -15, BOMB = 10, BIO = 0, RAD = 0, FIRE = 20, ACID = 20)

/obj/item/clothing/suit/ghost_sheet
	name = "ghost sheet"
	desc = "The hands float by themselves, so it's extra spooky."
	icon_state = "ghost_sheet"
	inhand_icon_state = "ghost_sheet"
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEGLOVES|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	alternate_worn_layer = UNDER_HEAD_LAYER
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/ghost_sheet/spooky
	name = "spooky ghost"
	desc = "This is obviously just a bedsheet, but maybe try it on?"
	user_vars_to_edit = list("name" = "Spooky Ghost", "real_name" = "Spooky Ghost" , "incorporeal_move" = INCORPOREAL_MOVE_BASIC, "appearance_flags" = KEEP_TOGETHER|TILE_BOUND, "alpha" = 150)
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //so the bedsheet goes over everything but fire

/obj/item/clothing/suit/toggle/suspenders/blue
	name = "blue suspenders"
	desc = "The symbol of hard labor and dirty jobs."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "suspenders_blue"

/obj/item/clothing/suit/toggle/suspenders/gray
	name = "gray suspenders"
	desc = "The symbol of hard labor and dirty jobs."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "suspenders_gray"

/obj/item/clothing/suit/hooded/mysticrobe
	name = "mystic's robe"
	desc = "Wearing this makes you feel more attuned with the nature of the universe... as well as a bit more irresponsible. "
	icon_state = "mysticrobe"
	inhand_icon_state = "mysticrobe"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/spellbook, /obj/item/storage/book/bible)
	flags_inv = HIDEJUMPSUIT
	hoodtype = /obj/item/clothing/head/hooded/mysticrobe

/obj/item/clothing/head/hooded/mysticrobe
	name = "mystic's hood"
	desc = "The balance of reality tips towards order."
	icon_state = "mystichood"
	inhand_icon_state = "mystichood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR|HIDEFACE|HIDEMASK

/obj/item/clothing/suit/coordinator
	name = "coordinator jacket"
	desc = "A jacket for a party ooordinator, stylish!."
	icon_state = "capformal"
	inhand_icon_state = "capspacesuit"
	armor = list(MELEE = 25, BULLET = 15, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 0, RAD = 0, FIRE = 50, ACID = 50)

/obj/item/clothing/suit/hawaiian
	name = "hawaiian overshirt"
	desc = "A cool shirt for chilling on the beach."
	icon_state = "hawaiian_blue"
	inhand_icon_state = "hawaiian_blue"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/yakuza
	name = "tojo clan jacket"
	desc = "The jacket of a mad dog."
	icon_state = "MajimaJacket"
	inhand_icon_state = "MajimaJacket"
	body_parts_covered = ARMS

/obj/item/clothing/suit/dutch
	name = "dutch's jacket"
	desc = "For those long nights on the beach in Tahiti."
	icon_state = "DutchJacket"
	inhand_icon_state = "DutchJacket"
	body_parts_covered = ARMS

