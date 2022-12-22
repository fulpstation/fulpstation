/obj/effect/client_image_holder/white_rabbit
	name = "white rabbit"
	desc = "FEED YOUR HEAD."
	image_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	image_state = "white_rabbit"
	image_layer = ABOVE_LIGHTING_PLANE
	image_layer = ABOVE_MOB_LAYER
	image_plane =  GAME_PLANE_UPPER
	///the rabbit's whisper
	var/description
	///has the rabbit already whispered?
	var/being_used = FALSE
	///trauma this rabbit is tied to
	var/datum/brain_trauma/special/rabbit_hole/illness
	///is this rabbit selected to drop the mask?
	var/drop_mask = FALSE
	///is this rabbit selected to drop the gun?
	var/drop_gun = FALSE

/obj/effect/client_image_holder/white_rabbit/Initialize(mapload)
	. = ..()
	RegisterSignal(src, RABBIT_FOUND, .proc/spotted)

/obj/effect/client_image_holder/white_rabbit/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!(user in who_sees_us))
		return
	if(being_used)
		return
	being_used = TRUE
	SEND_SIGNAL(src, RABBIT_FOUND,user)
	var/datum/antagonist/monsterhunter/hunta = user.mind.has_antag_datum(/datum/antagonist/monsterhunter)
	if(!hunta)
		return
	SEND_SIGNAL(hunta, GAIN_INSIGHT)
	image_state = "rabbit_hole"
	update_appearance()
	QDEL_IN(src, 8 SECONDS)


/obj/effect/client_image_holder/white_rabbit/proc/spotted(mob/user)
	SIGNAL_HANDLER

	new /obj/item/rabbit_eye(loc)
	if(drop_mask)
		new /obj/item/clothing/mask/cursed_rabbit(loc)
	if(drop_gun)
		new /obj/item/gun/ballistic/revolver/hunter_revolver(loc)
	if(illness)
		illness.white_rabbits -= src
	UnregisterSignal(src, RABBIT_FOUND)







/datum/brain_trauma/special/rabbit_hole
	name = "Rabbit Chaser"
	desc = "They believe in a wonderland they lie."
	scan_desc = "rabbit chaser"
	gain_text = "<span class='notice'>You see the white rabbits clearly, have they always been there?"
	lose_text = "<span class='warning'>The rabbits scurry off in a hurry, perhaps there's trouble in the wonderland."
	///the list of rabbit holes the owner can currently interact with
	var/list/white_rabbits = list()
	///the red card tied to this trauma if any
	var/obj/item/rabbit_locator/locator

/datum/brain_trauma/special/rabbit_hole/on_lose()
	for(var/obj/effect/client_image_holder/white_rabbit/rabbit as anything in white_rabbits)
		white_rabbits -= rabbit
		qdel(rabbit)
	var/datum/antagonist/monsterhunter/monst = owner.mind.has_antag_datum(/datum/antagonist/monsterhunter)
	monst.sickness = null
	if(locator)
		locator.mental = null
	locator = null
	. = ..()

/datum/brain_trauma/special/rabbit_hole/on_gain()
	..()
	for(var/i in 1 to 5 )
		var/turf/rabbit_hole = get_safe_random_station_turf()
		var/obj/effect/client_image_holder/white_rabbit/cretin =  new /obj/effect/client_image_holder/white_rabbit(rabbit_hole, owner)
		cretin.illness = src
		white_rabbits += cretin
	var/obj/effect/client_image_holder/white_rabbit/mask_holder = pick(white_rabbits)
	var/obj/effect/client_image_holder/white_rabbit/gun_holder = pick(white_rabbits)
	mask_holder.drop_mask = TRUE
	gun_holder.drop_gun = TRUE



