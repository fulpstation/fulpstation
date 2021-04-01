/obj/effect/fun_balloon
	name = "fun balloon"
	desc = "This is going to be a laugh riot."
	icon = 'icons/obj/balloons.dmi'
	icon_state = "syndballoon"
	anchored = TRUE
	var/popped = FALSE

/obj/effect/fun_balloon/Initialize()
	. = ..()
	SSobj.processing |= src

/obj/effect/fun_balloon/Destroy()
	SSobj.processing -= src
	. = ..()

/obj/effect/fun_balloon/process()
	if(!popped && check() && !QDELETED(src))
		popped = TRUE
		effect()
		pop()

/obj/effect/fun_balloon/proc/check()
	return FALSE

/obj/effect/fun_balloon/proc/effect()
	return

/obj/effect/fun_balloon/proc/pop()
	visible_message("<span class='notice'>[src] pops!</span>")
	playsound(get_turf(src), 'sound/items/party_horn.ogg', 50, TRUE, -1)
	qdel(src)

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/effect/fun_balloon/attack_ghost(mob/user)
	if(!user.client || !user.client.holder || popped)
		return
	var/confirmation = alert("Pop [src]?","Fun Balloon","Yes","No")
	if(confirmation == "Yes" && !popped)
		popped = TRUE
		effect()
		pop()

/obj/effect/fun_balloon/sentience
	name = "sentience fun balloon"
	desc = "When this pops, things are gonna get more aware around here."
	var/effect_range = 3
	var/group_name = "a bunch of giant spiders"

/obj/effect/fun_balloon/sentience/effect()
	var/list/bodies = list()
	for(var/mob/living/possessable in range(effect_range, get_turf(src)))
		if (!possessable.ckey && possessable.stat == CONSCIOUS) // Only assign ghosts to living, non-occupied mobs!
			bodies += possessable

	var/question = "Would you like to be [group_name]?"
	var/list/candidates = pollCandidatesForMobs(question, ROLE_PAI, null, FALSE, 100, bodies)
	while(LAZYLEN(candidates) && LAZYLEN(bodies))
		var/mob/dead/observer/C = pick_n_take(candidates)
		var/mob/living/body = pick_n_take(bodies)

		message_admins("[key_name_admin(C)] has taken control of ([key_name_admin(body)])")
		body.ghostize(FALSE)
		body.key = C.key
		new /obj/effect/temp_visual/gravpush(get_turf(body))

/obj/effect/fun_balloon/sentience/emergency_shuttle
	name = "shuttle sentience fun balloon"
	var/trigger_time = 60

/obj/effect/fun_balloon/sentience/emergency_shuttle/check()
	. = FALSE
	if(SSshuttle.emergency && (SSshuttle.emergency.timeLeft() <= trigger_time) && (SSshuttle.emergency.mode == SHUTTLE_CALL))
		. = TRUE

/obj/effect/fun_balloon/scatter
	name = "scatter fun balloon"
	desc = "When this pops, you're not going to be around here anymore."
	var/effect_range = 5

/obj/effect/fun_balloon/scatter/effect()
	for(var/mob/living/M in range(effect_range, get_turf(src)))
		var/turf/T = find_safe_turf()
		new /obj/effect/temp_visual/gravpush(get_turf(M))
		M.forceMove(T)
		to_chat(M, "<span class='notice'>Pop!</span>", confidential = TRUE)

/obj/effect/station_crash
	name = "station crash"
	desc = "With no survivors!"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "syndballoon"
	anchored = TRUE
	var/min_crash_strength = 3
	var/max_crash_strength = 15

/obj/effect/station_crash/Initialize()
	..()
	shuttle_crash()
	return INITIALIZE_HINT_QDEL

/obj/effect/station_crash/proc/shuttle_crash()
	var/crash_strength = rand(min_crash_strength,max_crash_strength)
	for (var/S in SSshuttle.stationary)
		var/obj/docking_port/stationary/SM = S
		if (SM.id == "emergency_home")
			var/new_dir = turn(SM.dir, 180)
			SM.forceMove(get_ranged_target_turf(SM, new_dir, crash_strength))
			break

/obj/effect/station_crash/devastating
	name = "devastating station crash"
	desc = "Absolute Destruction. Will crash the shuttle far into the station."
	min_crash_strength = 15
	max_crash_strength = 25


//Arena

/obj/effect/forcefield/arena_shuttle
	name = "portal"
	timeleft = 0
	var/list/warp_points = list()

/obj/effect/forcefield/arena_shuttle/Initialize()
	. = ..()
	for(var/obj/effect/landmark/shuttle_arena_safe/exit in GLOB.landmarks_list)
		warp_points += exit

/obj/effect/forcefield/arena_shuttle/Bumped(atom/movable/AM)
	if(!isliving(AM))
		return

	var/mob/living/L = AM
	if(L.pulling && istype(L.pulling, /obj/item/bodypart/head))
		to_chat(L, "<span class='notice'>Your offering is accepted. You may pass.</span>", confidential = TRUE)
		qdel(L.pulling)
		var/turf/LA = get_turf(pick(warp_points))
		L.forceMove(LA)
		L.hallucination = 0
		to_chat(L, "<span class='reallybig redtext'>The battle is won. Your bloodlust subsides.</span>", confidential = TRUE)
		for(var/obj/item/chainsaw/doomslayer/chainsaw in L)
			qdel(chainsaw)
		var/obj/item/skeleton_key/key = new(L)
		L.put_in_hands(key)
	else
		to_chat(L, "<span class='warning'>You are not yet worthy of passing. Drag a severed head to the barrier to be allowed entry to the hall of champions.</span>", confidential = TRUE)

/obj/effect/landmark/shuttle_arena_safe
	name = "hall of champions"
	desc = "For the winners."

/obj/effect/landmark/shuttle_arena_entrance
	name = "\proper the arena"
	desc = "A lava filled battlefield."


/obj/effect/forcefield/arena_shuttle_entrance
	name = "portal"
	timeleft = 0
	var/list/warp_points = list()

/obj/effect/forcefield/arena_shuttle_entrance/Bumped(atom/movable/AM)
	if(!isliving(AM))
		return

	if(!warp_points.len)
		for(var/obj/effect/landmark/shuttle_arena_entrance/S in GLOB.landmarks_list)
			warp_points |= S

	var/obj/effect/landmark/LA = pick(warp_points)
	var/mob/living/M = AM
	M.forceMove(get_turf(LA))
	to_chat(M, "<span class='reallybig redtext'>You're trapped in a deadly arena! To escape, you'll need to drag a severed head to the escape portals.</span>", confidential = TRUE)
	M.apply_status_effect(STATUS_EFFECT_MAYHEM)

/area/shuttle_arena
	name = "arena"
	has_gravity = STANDARD_GRAVITY
	requires_power = FALSE
