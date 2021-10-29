/**
 * Jill Valentine
 * Chris Redfield
 * From: Resident Evil
 * Gyro Zeppeli
 * From: Steel Ball Run
 * Rakka
 * From: Haibane Renmei
 * Char
 * From:Gundam
 * IRA
 * From: IRL
 * Doll
 * Cainhurst Knight
 * From: Bloodborne
 * Patlabor Officer
 * From: Patlabor
 * Alucard
 * From: Castlevania
 * By: Saladlegs (Reina)
 */

// JILL VALENTINE


/obj/item/clothing/under/costume_2021/jill_valentine
	name = "S.T.A.R.S. Uniform"
	desc = "Hungry for a Jill sandwich?"
	icon_state = "jill_under"
	can_adjust = FALSE

/obj/item/clothing/head/costume_2021/jill_valentine
	name = "S.T.A.R.S. Hat"
	desc = "Itchy. Tasty."
	icon_state = "jill_hat"

/obj/item/storage/box/halloween/edition_21/jill_valentine
	theme_name = "2021's Jill Valentine"
	illustration = "storage_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/jill_valentine,
		/obj/item/clothing/head/costume_2021/jill_valentine,
		/obj/item/food/grown/ambrosia/vulgaris,
		/obj/item/clothing/shoes/jackboots,
		/obj/item/gun/ballistic/shotgun/toy,
	)

// GYRO ZEPPELLI

/obj/item/clothing/under/costume_2021/gyro_zeppeli
	name = "Spin Master's coat"
	desc = "GO! GO! ZEPPELI"
	icon_state = "gyro_under"
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/head/costume_2021/gyro_zeppeli
	name = "Spin Master's hat"
	desc = "For the hot American day."
	icon_state = "gyro_hat"

/obj/item/clothing/shoes/costume_2021/gyro_zeppeli
	name = "Spin Master's boots"
	desc = "Perfect for a cross-country trip!"
	icon_state = "gyro_shoes"

/obj/item/storage/box/halloween/edition_21/gyro_zeppeli
	theme_name = "2021's Gyro Zeppeli"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/gyro_zeppeli,
		/obj/item/clothing/head/costume_2021/gyro_zeppeli,
		/obj/item/clothing/shoes/costume_2021/gyro_zeppeli,
	)

/// Rakka

/obj/item/clothing/under/costume_2021/rakka
	name = "thrift store dress"
	desc = "Reminiscent of a schoolgirl uniform."
	icon_state = "rakka_under"
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/shoes/costume_2021/rakka
	name = "wooden sandals"
	desc = "Standard wooden sandals."
	icon_state = "rakka_shoes"

/obj/item/clothing/head/costume_2021/rakka
	name = "Old Home halo"
	desc = "Not related to any religion."
	icon_state = "rakka_hat"
	dynamic_hair_suffix = ""

/obj/item/clothing/suit/costume_2021/rakka
	name = "thrift store jacket"
	desc = "A warm jacket"
	icon_state = "rakka_suit"

/obj/item/storage/box/halloween/edition_21/rakka
	theme_name = "2021's Rakka"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/rakka,
		/obj/item/clothing/shoes/costume_2021/rakka,
		/obj/item/clothing/head/costume_2021/rakka,
		/obj/item/clothing/suit/costume_2021/rakka,
	)

/// Char

/obj/item/clothing/under/costume_2021/char
	name = "Red Comet's uniform"
	desc = "USE FOR ONE YEAR ONLY!"
	icon_state = "char_under"

/obj/item/clothing/shoes/costume_2021/char
	name = "Red Comet's boots"
	desc = "Is it common courtesty to take off your shoes before entering a mech?"
	icon_state = "char_boots"

/obj/item/clothing/head/costume_2021/char
	name = "Red Comet's helmet"
	desc = "Use to laugh at people."
	icon_state = "char_helmet"

/obj/item/clothing/gloves/costume_2021/char
	name = "Red Comet's gloves"
	desc = "For the hands of those who have never betrayed anyone in their life."
	icon_state = "char_gloves"

/obj/item/storage/box/halloween/edition_21/char
	theme_name = "2021's Red Comet"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/char,
		/obj/item/clothing/shoes/costume_2021/char,
		/obj/item/clothing/head/costume_2021/char,
		/obj/item/clothing/gloves/costume_2021/char,
	)

/// Chris Redfield

/obj/item/clothing/under/costume_2021/chris
	name = "S.T.A.R.S Uniform"
	desc = "Do not punch boulders with this."
	icon_state = "chris_under"

/obj/item/storage/box/halloween/edition_21/chris
	theme_name = "2021's Chris Redfield"
	illustration = "storage_box"
	costume_contents = list(
	 	/obj/item/clothing/under/costume_2021/chris,
	 	/obj/item/clothing/shoes/jackboots,
		/obj/item/gun/ballistic/automatic/pistol/toy,
		/obj/item/kitchen/knife/plastic,
	)

/// IRA

/obj/item/clothing/under/costume_2021/ira
	name = "commando jumper "
	desc = "Perfect for cold space... months?"
	icon_state = "ira_under"

/obj/item/clothing/head/costume_2021/ira
	name = "balaclava and beret"
	desc = "Not indicative of rank"
	icon_state = "ira_head"
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/suit/costume_2021/ira
	name = "DPM field jacket"
	desc = "Not to be mistaken for the enemy"
	icon_state = "ira_suit"

/obj/item/storage/box/halloween/edition_21/ira
	theme_name = "2021's Irish Republican Army"
	illustration = "reina_box"
	costume_contents = list(
	 	/obj/item/clothing/under/costume_2021/ira,
		/obj/item/clothing/suit/costume_2021/ira,
	 	/obj/item/clothing/head/costume_2021/ira,
		/obj/item/clothing/gloves/color/black,
	 	/obj/item/clothing/shoes/sneakers/black,
	 	/obj/item/gun/ballistic/automatic/pistol/toy,
	)

/// Doll

/obj/item/clothing/under/costume_2021/doll
	name = "Doll's cloak"
	desc = "Discarded doll clothing, likely a spare for dress-up."
	icon_state = "doll_under"

/obj/item/clothing/head/costume_2021/doll
	name = "Doll's bonnet"
	desc = "A deep love for the doll can be sumised by the fine craftsmanship of this article, and the care with which it was kept."
	icon_state = "doll_hat"

/obj/item/clothing/shoes/costume_2021/doll
	name = "Doll's boots"
	desc = "It borderlines on mania, and exudes a slight warmth."
	icon_state = "doll_boots"

/obj/item/storage/box/halloween/edition_21/doll
	theme_name = "2021's Doll"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/doll,
		/obj/item/clothing/head/costume_2021/doll,
		/obj/item/clothing/shoes/costume_2021/doll,
	)

/// Cainhurst Knight

/obj/item/clothing/suit/costume_2021/vileblood
	name = "Cainhurst knight's garb"
	desc = "Adornment prized by the knights of Cainhurst."
	icon_state = "vileblood_suit"

/obj/item/storage/box/halloween/edition_21/vileblood
	theme_name = "2021's Cainhurst Knight"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2021/vileblood,
		/obj/item/clothing/shoes/laceup,
	)

/// Patlabor

/obj/item/clothing/under/costume_2021/patlabor
	name = "SV2 Uniform"
	desc = "For dealing with combat crimes, terrorism and accidents involving Labors."
	icon_state = "patlabor_under"

/obj/item/storage/box/halloween/edition_21/patlabor
	theme_name = "2021's Patlabor Officer"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/patlabor,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/gloves/color/white,
	)

/// Alucard

/obj/item/clothing/suit/costume_2021/alucard
	name = "vampiric cloak"
	desc = "What is Dracula backwards?"
	icon_state = "alucard_suit"


/obj/item/clothing/shoes/costume_2021/alucard
	name = "vampiric boots"
	desc = "For double jumping."
	icon_state = "alucard_boots"


/obj/item/storage/box/halloween/edition_21/alucard
	theme_name = "2021's Alucard"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2021/alucard,
		/obj/item/clothing/shoes/costume_2021/alucard,
	)
