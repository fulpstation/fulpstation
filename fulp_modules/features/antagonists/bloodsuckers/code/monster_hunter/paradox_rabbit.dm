/datum/action/cooldown/paradox
	name = "Paradox Rabbit"
	icon_icon = 'icons/mob/simple/rabbit.dmi'
	button_icon_state = "rabbit_white_dead"
	cooldown_time = 3 MINUTES
	///where we will be teleporting the rabbit too
	var/obj/effect/landmark/wonderchess_mark/chessmark
	///the rabbit in question if it exists
	var/mob/living/simple_animal/rabbit/rabbit

/datum/action/cooldown/paradox/Activate()
	StartCooldown(360 SECONDS, 360 SECONDS)
	if(!chessmark)
		return
	var/turf/theplace = get_turf(chessmark)
	var/mob/living/simple_animal/rabbit/bunny
	bunny = new /mob/living/simple_animal/rabbit(theplace)
	if(!bunny)
		return
	var/mob/living/master = owner
	owner.mind.transfer_to(bunny)
	playsound(bunny, 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/sounds/paradoxskip.ogg',100)
	addtimer(CALLBACK(src,.proc/return_to_station, master, bunny, theplace), 5 SECONDS)
	StartCooldown()

/datum/action/cooldown/paradox/proc/return_to_station(mob/user, mob/bunny,turf/mark)
	var/new_x = bunny.x - mark.x
	var/new_y = bunny.y - mark.y
	var/turf/new_location = locate((user.x + new_x) , (user.y + new_y) , user.z)
	user.forceMove(new_location)
	bunny.mind.transfer_to(user)
	playsound(user, 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/sounds/paradoxskip.ogg',100)
	rabbit = null
	qdel(bunny)

