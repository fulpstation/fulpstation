/obj/machinery/door/window/tram/heliotram2
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	associated_lift = HELIO_TRAM2
	icon_state = "windoor"
	base_state = "windoor"

/obj/effect/landmark/lift_id/heliotram1
	specific_lift_id = HELIO_TRAM1

/obj/effect/landmark/tram/left_part/heliotram1
	specific_lift_id = HELIO_TRAM1
	destination_id = "left_part_helio"
	tgui_icons = list("Arrivals" = "plane-arrival", "Botany" = "leaf")

/obj/effect/landmark/tram/middle_part/heliotram1
	specific_lift_id = HELIO_TRAM1
	destination_id = "middle_part_helio"
	tgui_icons = list("Transfer" = "briefcase", "Service" = "cocktail", "Dormitories" = "bed")

/obj/effect/landmark/tram/right_part/heliotram1
	specific_lift_id = HELIO_TRAM1
	destination_id = "right_part_helio"
	tgui_icons = list("Departures" = "plane-departure", "Medical" = "plus", "Science" = "flask")

/obj/effect/landmark/lift_id/heliotram2
	specific_lift_id = HELIO_TRAM2

/obj/effect/landmark/tram/left_part/heliotram2
	specific_lift_id = HELIO_TRAM2
	destination_id = "upper_part_helio"
	tgui_icons = list("Command" = "bullhorn", "Security" = "gavel")

/obj/effect/landmark/tram/middle_part/heliotram2
	specific_lift_id = HELIO_TRAM2
	destination_id = "center_part_helio"
	tgui_icons = list("Transfer" = "briefcase", "Service" = "cocktail", "Dormitories" = "bed")

/obj/effect/landmark/tram/right_part/heliotram2
	specific_lift_id = HELIO_TRAM2
	destination_id = "lower_part_helio"
	tgui_icons = list("Engineering" = "wrench", "Cargo" = "box")

/obj/effect/mob_spawn/ghost_role/human/tramconductor
	name = "new cryogenics pod"
	prompt_name = "a tram conductor"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You are a tram conductor working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You are tasked to work as a tram conductor in tram central station located in Heliostation. \
	You must charge anyone who wants to transfer from vertical line to horizontal line, no matter who they are. \
	Try your best to stop ticket evader, do not use any lethal method unless really necessary."
	important_text = "Regardless of the circumstances, DO NOT abandon your workplace, the tram central station."
	outfit = /datum/outfit/tramconductor
	spawner_job_path = /datum/job/ancient_crew

/obj/effect/mob_spawn/ghost_role/human/tramconductor/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/datum/outfit/tramconductor
	name = "Tram Conductor"
	id = /obj/item/card/id/away/old/sec
	uniform = /obj/item/clothing/under/rank/centcom/official
	head = /obj/item/clothing/head/hats/centcom_cap
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/gun/energy/e_gun/mini
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	internals_slot = ITEM_SLOT_RPOCKET
	belt = /obj/item/melee/baton/telescopic
