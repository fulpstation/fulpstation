/datum/map_template/ruin/icemoon/underground/fulp/cyto
	name = "Beefman Research Outpost"
	id = "beef cyto"
	description = "A remote research outpost."
	suffix = "beef_cytology.dmm"

/obj/effect/mob_spawn/ghost_role/human/beefman
	name = "Beefman Cytology Researcher"
	desc = "A cryogenics pod, storing meat for future consumption."
	prompt_name = "a beefman cytologist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/beefman
	you_are_text = "You are a cytological researcher in a remote scientific outpost."
	flavour_text = "You and your fellow researcher are studying cellular biology to better understand the origins of your species. \
	Sample the subjects provided and the surrounding area for testing."
	important_text = "This is meant as a way to learn how to play Cytology!"
	outfit = /datum/outfit/russian_beefman
	spawner_job_path = /datum/job/fulp_cytology

/obj/effect/mob_spawn/ghost_role/human/beefman/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.fully_replace_character_name(null, random_unique_beefman_name())

/datum/job/fulp_cytology
	title = ROLE_BEEFMAN_CYTOLOGY

/datum/outfit/russian_beefman
	name = "Russian Beefman"
	uniform = /obj/item/clothing/under/bodysash/russia
	shoes = /obj/item/clothing/shoes/winterboots
	back = /obj/item/storage/backpack
	box = /obj/item/storage/box/survival
