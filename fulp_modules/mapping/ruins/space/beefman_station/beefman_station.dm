/obj/effect/mob_spawn/human/beefman/beef_station
	death = FALSE
	roundstart = FALSE
	random = TRUE
	mob_name = "Govyadina Station Inhabitant"
	mob_species = /datum/species/beefman
	mob_type = /mob/living/carbon/human/species/beefman
	name = "Govyadina Station Inhabitant"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	short_desc = "You are an inhabitant of Govyadina Station, a station made specificially for beefmen."
	flavour_text = "After undergoing many experiments at the hands of the Union of Soviet Socialist Planets researchers, you and your fellow beefmen have been given freedom aboard Govyadina Station. Work with your fellow beefmen to embrace your new community and home."

/area/ruin/space/has_grav/powered/beef
	name = "beef station"
	icon_state = "green"

/datum/map_template/ruin/space/beef_station
	name = "Govyadina Station"
	id = "beef station"
	description = "A station built for beefmen"
	suffix = "beef_station.dmm"

/obj/item/toy/plush/beefplushie
	name = "beef plushie"
	desc = "Made from real meat!"
	icon = 'fulp_modules/mapping/ruins/space/beefman_station/beef_station_stuff.dmi'
	icon_state = "plushie_beef"
	squeak_override = list('sound/effects/meatslap.ogg'=1)

/obj/item/clothing/neck/bfeemam
	name = "heart-shaped locket"
	desc = "It has a picture of someone important to you."
	icon = 'fulp_modules/mapping/ruins/space/beefman_station/beef_station_stuff.dmi'
	icon_state = "beef_locket"

/obj/effect/spawner/lootdrop/beef_station
	name = "Beef Station spawner"
	loot = list(
		/obj/item/clothing/neck/bfeemam = 3,
		/obj/item/toy/plush/beefplushie = 3,
		/obj/item/food/meat/slab/meatwheat = 1,
		/obj/item/food/grown/icepepper = 1,
		/obj/item/clothing/under/costume/russian_officer = 1,
		/obj/item/clothing/suit/armor/vest/russian_coat = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka/badminka = 1,
		/obj/item/clothing/suit/security/officer/russian = 1,
		/obj/item/clothing/under/pants/track  = 1,
		/obj/item/clothing/head/pirate/captain  = 1,
		/obj/item/food/pie/baklava = 1,
		/obj/item/reagent_containers/glass/bottle/frostoil = 1,
		/obj/item/food/khachapuri = 1,
	)

