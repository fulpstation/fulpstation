/datum/action/cooldown/paradox
	name = "Paradox Rabbit"
	icon_icon = 'icons/mob/simple/rabbit.dmi'
	button_icon_state = "rabbit_white_dead"
	cooldown_time = 3 MINUTES
	///where we will be teleporting the rabbit too
	var/obj/effect/landmark/wonderchess_mark/chessmark
	///where the user will be while this whole ordeal is happening
	var/obj/effect/landmark/wonderland_mark/landmark
	///the rabbit in question if it exists
	var/mob/living/simple_animal/rabbit/rabbit
	///where the user originally was
	var/turf/original_loc

/datum/action/cooldown/paradox/New(Target)
	..()
	chessmark = GLOB.wonderland_marks["Wonderchess landmark"]
	landmark =  GLOB.wonderland_marks["Wonderland landmark"]



/datum/action/cooldown/paradox/Activate()
	StartCooldown(360 SECONDS, 360 SECONDS)
	if(!chessmark)
		return
	var/turf/theplace = get_turf(chessmark)
	var/turf/land_mark = get_turf(landmark)
	var/mob/living/simple_animal/rabbit/bunny
	original_loc = get_turf(owner)
	bunny = new /mob/living/simple_animal/rabbit(theplace)
	if(!bunny)
		return
	owner.forceMove(land_mark) ///the user remains safe in the wonderland
	var/mob/living/master = owner
	owner.mind.transfer_to(bunny)
	playsound(bunny, 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/sounds/paradoxskip.ogg',100)
	addtimer(CALLBACK(src,.proc/return_to_station, master, bunny, theplace), 5 SECONDS)
	StartCooldown()

/datum/action/cooldown/paradox/proc/return_to_station(mob/user, mob/bunny,turf/mark)
	var/new_x = bunny.x - mark.x
	var/new_y = bunny.y - mark.y
	var/turf/new_location = locate((original_loc.x + new_x) , (original_loc.y + new_y) , original_loc.z)
	user.forceMove(new_location)
	bunny.mind.transfer_to(user)
	playsound(user, 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/sounds/paradoxskip.ogg',100)
	rabbit = null
	original_loc = null
	qdel(bunny)


/datum/action/cooldown/wonderland_drop
	name = "To Wonderland"
	icon_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	button_icon_state = "to_wonderland"
	cooldown_time = 3 MINUTES
	///where we will be teleporting the user too
	var/obj/effect/landmark/wonderland_mark/landmark
	///where the user originally was
	var/turf/original_loc

/datum/action/cooldown/wonderland_drop/New(Target)
	..()
	landmark =  GLOB.wonderland_marks["Wonderland landmark"]



/datum/action/cooldown/wonderland_drop/Activate()
	StartCooldown(360 SECONDS, 360 SECONDS)
	if(!landmark)
		return
	original_loc = get_turf(owner)
	var/turf/theplace = get_turf(landmark)
	owner.forceMove(theplace)
	to_chat(owner, span_warning("You wake up in the Wonderland"))
	addtimer(CALLBACK(src,.proc/return_to_station, owner), 30 SECONDS)
	StartCooldown()

/datum/action/cooldown/wonderland_drop/proc/return_to_station()
	if(!original_loc)
		return
	owner.forceMove(original_loc)
	to_chat(owner, span_warning("Was it all a dream?"))
	original_loc = null
