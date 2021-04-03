/obj/effect/mob_spawn/human/beefman/cytology
	death = FALSE
	roundstart = FALSE
	random = TRUE
	mob_name = "Beefman Cytology Researcher"
	mob_species = /datum/species/beefman
	mob_type = /mob/living/carbon/human/species/beefman
	name = "Beefman Cytology Researcher"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	short_desc = "You are a cytological researcher in a remote scientific outpost."
	flavour_text = "You and your fellow researcher are studying cellular biology to better understand the origins of your species. Sample the subjects provided and the surrounding area for testing."
	assignedrole = "Cytological Researcher"
	outfit = /datum/outfit/russian_beefman

/area/ruin/powered/beefcyto
	name = "Research Outpost"
	icon_state = "dk_yellow"

/datum/map_template/ruin/icemoon/underground/fulp/cyto
	name = "Beefman Research Outpost"
	id = "beef cyto"
	description = "A remote research outpost."
	suffix = "fulp_icemoon_surface_cyto_nospace.dmm"



/datum/outfit/russian_beefman
	name = "Russian Beefman"
	uniform = /obj/item/clothing/under/bodysash/russia
	shoes = /obj/item/clothing/shoes/winterboots
	back = /obj/item/storage/backpack
	box = /obj/item/storage/box/survival
