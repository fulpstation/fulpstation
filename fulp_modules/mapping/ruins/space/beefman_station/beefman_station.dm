/// Beefstation map template
/datum/map_template/ruin/space/fulp/beef_station
	name = "Govyadina Station"
	id = "beef station"
	description = "A station built for beefmen"
	suffix = "beef_station.dmm"

/// Beefstation ghost role spawner
/obj/effect/mob_spawn/ghost_role/human/beefman/beef_station
	name = "Govyadina Station Inhabitant"
	desc = "A cryogenics pod, storing meat for future consumption."
	prompt_name = "a beefman"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/beefman
	you_are_text = "You are an inhabitant of Govyadina Station, a station made specificially for beefmen."
	flavour_text = "After undergoing many experiments at the hands of the Union of Soviet Socialist Planets, \
	you and your fellow beefmen have been given freedom aboard Govyadina Station. \
	Work with your fellow beefmen to embrace your new community and home."
	important_text = "Try to avoid leaving the station and be careful with the Atmospherics equipment!"
	spawner_job_path = /datum/job/fulp_beefstation


/// Beefstation job
/datum/job/fulp_beefstation
	title = ROLE_BEEFMAN_STATION

/// Beefstation item spawner
/obj/effect/spawner/random/beef_station
	name = "Beef Station spawner"
	loot = list(
		/obj/item/clothing/neck/beefman = 3,
		/obj/item/clothing/head/costume/pirate = 1,
		/obj/item/clothing/suit/armor/vest/russian_coat = 1,
		/obj/item/clothing/suit/jacket/officer/tan = 1,
		/obj/item/clothing/under/costume/russian_officer = 1,
		/obj/item/clothing/under/pants/track = 1,
		/obj/item/food/grown/icepepper = 1,
		/obj/item/food/meat/slab/meatwheat = 1,
		/obj/item/food/pie/baklava = 1,
		/obj/item/food/khachapuri = 1,
		/obj/item/reagent_containers/cup/glass/bottle/vodka/badminka = 1,
		/obj/item/reagent_containers/cup/bottle/frostoil = 1,
		/obj/item/toy/plush/beefplushie = 3,
	)

/// Mostly just a copy of '/secure_closet/atmospherics' but with the access requirement and
/// engineering headset removed.
/obj/structure/closet/secure_closet/beef_atmospherics
	name = "atmospheric locker"
	icon_state = "atmos"

/obj/structure/closet/secure_closet/beef_atmospherics/PopulateContents()
	..()

	new /obj/item/storage/toolbox/mechanical(src)
	new /obj/item/tank/internals/emergency_oxygen/engi(src)
	new /obj/item/holosign_creator/atmos(src)
	new /obj/item/watertank/atmos(src)
	new /obj/item/clothing/suit/utility/fire/atmos(src)
	new /obj/item/clothing/gloves/atmos(src)
	new /obj/item/clothing/mask/gas/atmos(src)
	new /obj/item/clothing/head/utility/hardhat/welding/atmos(src)
	new /obj/item/clothing/glasses/meson/engine/tray(src)
	new /obj/item/extinguisher/advanced(src)

/obj/structure/closet/secure_closet/beef_atmospherics/populate_contents_immediate()
	. = ..()

	new /obj/item/pipe_dispenser(src)

/// Beefstation atmos chamber
/obj/machinery/air_sensor/beef_mix_tank
	name = "Govyadina Station mix tank gas sensor"
	chamber_id = ATMOS_GAS_MONITOR_BEEF_MIX

/obj/item/circuitboard/computer/atmos_control/beef_mix_tank
	name = "Govyadina Mix Supply Control"
	build_path = /obj/machinery/computer/atmos_control/beef_mix_tank

/obj/machinery/computer/atmos_control/beef_mix_tank
	name = "Govyadina Mix Chamber Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/beef_mix_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_BEEF_MIX = "Govyadina Mix Chamber")

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/beef_mix_input
	name = "Govyadina mix tank input injector"
