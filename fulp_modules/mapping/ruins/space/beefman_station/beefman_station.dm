/datum/map_template/ruin/space/fulp/beef_station
	name = "Govyadina Station"
	id = "beef station"
	description = "A station built for beefmen"
	suffix = "beef_station.dmm"

/obj/effect/mob_spawn/ghost_role/human/beefman/beef_station
	name = "Govyadina Station Inhabitant"
	desc = "A cryogenics pod, storing meat for future consumption."
	prompt_name = "a beefman"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/beefman
	you_are_text = "You are an inhabitant of Govyadina Station, a station made specificially for beefmen."
	flavour_text = "After undergoing many experiments at the hands of the Union of Soviet Socialist Planets researchers, \
	you and your fellow beefmen have been given freedom aboard Govyadina Station. \
	Work with your fellow beefmen to embrace your new community and home."
	important_text = "Try to avoid leaving the station and be careful with the Atmospherics equipment!"
	spawner_job_path = /datum/job/fulp_beefstation


/datum/job/fulp_beefstation
	title = ROLE_BEEFMAN_STATION

/area/ruin/space/has_grav/powered/beef
	name = "beef station"
	icon_state = "green"
	ambientsounds = list('fulp_modules/sounds/sound/ambience/beef_station.ogg')

/datum/map_template/ruin/space/fulp/beef_station
	name = "Govyadina Station"
	id = "beef station"
	description = "A station built for beefmen"
	suffix = "beef_station.dmm"

/obj/effect/spawner/random/beef_station
	name = "Beef Station spawner"
	loot = list(
		/obj/item/clothing/neck/bfeemam = 3,
		/obj/item/clothing/head/pirate/captain = 1,
		/obj/item/clothing/suit/armor/vest/russian_coat = 1,
		/obj/item/clothing/suit/security/officer/russian = 1,
		/obj/item/clothing/under/costume/russian_officer = 1,
		/obj/item/clothing/under/pants/track = 1,
		/obj/item/food/grown/icepepper = 1,
		/obj/item/food/meat/slab/meatwheat = 1,
		/obj/item/food/pie/baklava = 1,
		/obj/item/food/khachapuri = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka/badminka = 1,
		/obj/item/reagent_containers/glass/bottle/frostoil = 1,
		/obj/item/toy/plush/beefplushie = 3,
	)

