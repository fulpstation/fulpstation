
/datum/dimension_theme/wonderland
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white"
	replace_floors = list(/turf/open/misc/grass/jungle/wonderland = 1)
	replace_walls = /turf/closed/wall/mineral/wood
	replace_objs = list(\
		/obj/structure/chair = list(/obj/structure/chair/wood = 1), \
		/obj/machinery/door/airlock = list(/obj/machinery/door/airlock/wood = 1, /obj/machinery/door/airlock/wood/glass = 1), \
		/obj/structure/table = list(/obj/structure/table/wood = 1),)


/turf/open/misc/grass/jungle/wonderland
	underfloor_accessibility = UNDERFLOOR_HIDDEN

/datum/round_event_control/wonderlandapocalypse
	name = "Apocalypse"
	typepath = /datum/round_event/wonderlandapocalypse
	max_occurrences = 0
	weight = 0
	alert_observers = FALSE
	category = EVENT_CATEGORY_SPACE

/datum/round_event/wonderlandapocalypse/announce(fake)

	priority_announce("Multiple missiles detected en route to the station. Seek shelter", "Missile Detection System", 'fulp_modules/features/antagonists/infiltrators/sounds/missile_alert.ogg')

/datum/round_event/wonderlandapocalypse/start()
	for(var/i = 1, i < 10, i++)
		var/turf/targetloc = get_safe_random_station_turf()
		var/datum/dimension_theme/wonderland/greenery = new()
		new /obj/effect/anomaly/dimensional/wonderland(targetloc, null, FALSE, greenery)



/obj/effect/anomaly/dimensional/wonderland
	range = 5
	immortal = TRUE
	drops_core = FALSE

/obj/effect/anomaly/dimensional/wonderland/Initialize(mapload, new_lifespan, drops_core, datum/dimension_theme/grasslands)
	. = ..()
	overlays += mutable_appearance('icons/effects/effects.dmi', "dimensional_overlay")

	animate(src, transform = matrix()*0.85, time = 3, loop = -1)
	animate(transform = matrix(), time = 3, loop = -1)
	theme = grasslands


/obj/effect/anomaly/dimensional/wonderland/prepare_area()
	apply_theme_icon()
	target_turfs = new()
	var/list/turfs = spiral_range_turfs(range, src)
	for (var/turf/turf in turfs)
		if (theme.can_convert(turf))
			target_turfs.Add(turf)

/obj/effect/anomaly/dimensional/wonderland/relocate()
	var/datum/anomaly_placer/placer = new()
	var/area/new_area = placer.findValidArea()
	var/turf/new_turf = placer.findValidTurf(new_area)
	src.forceMove(new_turf)
	prepare_area()
