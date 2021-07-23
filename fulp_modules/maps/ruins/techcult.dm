/***************** Spawners *****************/

/// Regular Tech cultists
/obj/effect/mob_spawn/human/techcult
	name = "Adept of the Machine Cult"
	roundstart = FALSE
	random = TRUE
	death = FALSE
	show_flavour = TRUE
	mob_name = "tech priest"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	short_desc = "You are a member of the machine cult on Lavaland."
	flavour_text = "The flesh is weak and humans are fragile. You exist only to research the universe and enchance your abilities with the power of science."
	important_info = "Listen to your leader, help those in need and protect your religion."
	outfit = /datum/outfit/techcult
	assignedrole = "Tech Priest"

/obj/effect/mob_spawn/human/techcult/special(mob/living/new_spawn)
	var/obj/item/organ/tongue/T = new_spawn.getorgan(/obj/item/organ/tongue)
	T.languages_possible[/datum/language/machine] = 1

	new_spawn.grant_language(/datum/language/machine, TRUE, TRUE, LANGUAGE_MIND)
	new_spawn.faction |= TECH_CULT_FACTION

/datum/outfit/techcult
	name = "Tech Priest"

	uniform = /obj/item/clothing/under/color/black
	suit = /obj/item/clothing/suit/hooded/techpriest/armor/plate
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/color/black
	glasses = /obj/item/clothing/glasses/hud/diagnostic
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/kitchen/knife/combat/survival
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	id = /obj/item/card/id/away/techcult

/// Tech Cult Leader
/obj/effect/mob_spawn/human/techcult/leader
	name = "Leader of the Machine Cult"
	roundstart = FALSE
	random = TRUE
	death = FALSE
	show_flavour = TRUE
	mob_name = "the leader of a tech cult"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	short_desc = "You are the leader of the machine cult on Lavaland."
	flavour_text = "You are the one who started the expedition on Lavaland. Your goals are to research life, ruins and anything else you can find here. You must encourage your followers to abandon the weak flesh and help them to do so."
	important_info = "Lead your cult to the perfection, protect your religion."
	outfit = /datum/outfit/techcult/lead
	assignedrole = "Tech Cult Leader"

/obj/effect/mob_spawn/human/techcult/leader/special(mob/living/new_spawn)
	new_spawn.mind.holy_role = HOLY_ROLE_PRIEST
	new_spawn.faction |= TECH_CULT_FACTION
	new_spawn.grant_all_languages(TRUE, TRUE, TRUE, LANGUAGE_CURATOR) //Leader knows all languages so he can speak with ashwalkers, for example.
	new_spawn.equip_to_slot_or_del(new /obj/item/clothing/suit/hooded/techpriest/armor/lead(new_spawn), ITEM_SLOT_OCLOTHING, TRUE)

/datum/outfit/techcult/lead
	name = "Tech Cult Leader"
	uniform = /obj/item/clothing/under/rank/civilian/chaplain
	suit = null
	gloves = /obj/item/clothing/gloves/combat
	glasses = /obj/item/clothing/glasses/hud/diagnostic/night
	r_hand = /obj/item/gun/energy/sniper/pin
	back = /obj/item/storage/backpack/cultpack
	backpack_contents = list(
		/obj/item/storage/book/bible/omnissiah,
		/obj/item/book/granter/spell/omnissiah,
		/obj/item/organ/heart/cybernetic/tier4,
	)

/***************** Areas *****************/

/area/ruin/powered/mechanicus
	name = "Mechanicum Chapel"
	icon_state = "chapel"
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>Being in the chapel brings me peace.</span>\n"
	mood_trait = TRAIT_SPIRITUAL
	ambience_index = AMBIENCE_HOLY

//Ruin datum
/datum/map_template/ruin/lavaland/techcult
	name = "Adeptus Mechanicus"
	id = "techcult"
	description = "An old base, filled with religious fanatics praising the entity they call 'Machine God'."
	cost = 20
	suffix = "fulp_lavaland_techcult.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/underground/techcult
	name = "Adeptus Mechanicus Icebox"
	id = "techcult"
	description = "An old base, filled with religious fanatics praising the entity they call 'Machine God'."
	suffix = "fulp_icemoon_techcult.dmm"
	allow_duplicates = FALSE

/***************** Closets *****************/

/obj/structure/closet/secure_closet/mechanicus
	name = "tech storage"
	req_access = list(ACCESS_ROBOTICS)

/obj/structure/closet/secure_closet/mechanicus/implants
	name = "implants storage"

/obj/structure/closet/secure_closet/mechanicus/implants/PopulateContents()
	. = ..()
	var/static/items_inside = list(
		/obj/item/organ/cyberimp/arm/toolset = 1,
		/obj/item/organ/cyberimp/arm/surgery = 1,
		/obj/item/organ/cyberimp/chest/reviver = 3,
		/obj/item/organ/cyberimp/chest/nutriment/plus = 3,
		/obj/item/organ/tongue/robot = 3,
		/obj/item/organ/lungs/cybernetic/tier3 = 3,
		/obj/item/organ/heart/cybernetic/tier3 = 3,
	)
	generate_items_inside(items_inside, src)

/obj/structure/closet/secure_closet/mechanicus/augs
	name = "augmentation storage"

/obj/structure/closet/secure_closet/mechanicus/augs/PopulateContents()
	. = ..()
	var/static/items_inside = list(
		/obj/item/bodypart/chest/robot = 3,
		/obj/item/bodypart/head/robot = 3,
		/obj/item/bodypart/l_arm/robot = 3,
		/obj/item/bodypart/r_arm/robot = 3,
		/obj/item/bodypart/l_leg/robot = 3,
		/obj/item/bodypart/r_leg/robot = 3)
	generate_items_inside(items_inside, src)

/***************** ID *****************/

/obj/item/card/id/away/techcult
	name = "tech cult identification card"
	desc = "An ID card used by religious group praising misterious machine god."
	trim = /datum/id_trim/tech_cultist

/datum/id_trim/tech_cultist
	assignment = "Syndicate Battlecruiser Crew"
	trim_icon = 'fulp_modules/main_features/jobs/cards.dmi'
	trim_state = "trim_deputy" // Placeholder
	access = list(ACCESS_SYNDICATE)
