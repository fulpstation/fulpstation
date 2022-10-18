/obj/effect/client_image_holder/white_rabbit
	name = "white rabbit"
	desc = "FEED YOUR HEAD."
	image_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	image_state = "white_rabbit"
	// Place this above shadows so it always glows.
	image_layer = ABOVE_LIGHTING_PLANE
	image_layer = ABOVE_MOB_LAYER
	image_plane = GAME_PLANE_UPPER
	var/description
	var/being_used = FALSE


/obj/effect/client_image_holder/white_rabbit/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(!(user in who_sees_us))
		return
	if(being_used)
		return
	being_used = TRUE
	var/datum/antagonist/monsterhunter/hunta = user.mind.has_antag_datum(/datum/antagonist/monsterhunter)
	if(!hunta)
		return
	var/datum/objective/assassinate/obj = pick(hunta.objectives)
	description = "TARGET [obj.target.current.real_name], ABILITIES "
	for(var/datum/action/ability in obj.target.current.actions)
		if(!ability)
			continue
		if(!istype(ability, /datum/action/changeling) && !istype(ability, /datum/action/bloodsucker))
			continue
		description += "[ability.name], "
	image_icon = "rabbit_hole"
	to_chat(user,span_notice("[description]"))
	new /obj/item/rabbit_eye(get_turf(user))
	QDEL_IN(src, 8 SECONDS)






/datum/brain_trauma/special/rabbit_hole
	name = "Rabbit Chaser"
	desc = "They believe in a wonderland they lie."
	scan_desc = "rabbit chaser"
	gain_text = "<span class='notice'>You see the white rabbits clearly, have they always been there?"
	lose_text = "<span class='warning'>The rabbits scurry off in a hurry, perhaps there's trouble in the wonderland."

	var/list/white_rabbits = list()

/datum/brain_trauma/special/rabbit_hole/on_lose(silent)
	for(var/obj/effect/client_image_holder/white_rabbit/rabbit as anything in white_rabbits)
		qdel(rabbit)

/datum/brain_trauma/special/rabbit_hole/on_gain()
	..()
	for(var/i in 1 to 5 )
		var/turf/rabbit_hole = get_safe_random_station_turf()
		new /obj/effect/client_image_holder/white_rabbit(rabbit_hole, owner)
