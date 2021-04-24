///////////////////
//DRONES AS ITEMS//
///////////////////
//Drone shells

/** Drone Shell: Ghost role item for drones
 *
 * A simple mob spawner item that transforms into a maintenance drone
 * Resepcts drone minimum age
 */

/obj/effect/mob_spawn/drone
	name = "drone shell"
	desc = "A shell of a maintenance drone, an expendable robot built to perform station repairs."
	icon = 'icons/mob/drone.dmi'
	icon_state = "drone_maint_hat" //yes reuse the _hat state.
	layer = BELOW_MOB_LAYER
	density = FALSE
	death = FALSE
	roundstart = FALSE
	mob_name = "drone"
	///Type of drone that will be spawned
	mob_type = /mob/living/simple_animal/drone
	banType = ROLE_DRONE
	show_flavour = FALSE
	short_desc = "You are a Maintenance Drone."
	flavour_text = "Born out of science, your purpose is to maintain Space Station 13. Maintenance Drones can become the backbone of a healthy station."
	important_info = "You MUST read and follow your laws carefully."

/obj/effect/mob_spawn/drone/Initialize()
	. = ..()
	var/area/A = get_area(src)
	if(A)
		notify_ghosts("A drone shell has been created in \the [A.name].", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_DRONE, notify_suiciders = FALSE)
	AddElement(/datum/element/point_of_interest)

/obj/effect/mob_spawn/drone/allow_spawn(mob/user)
	var/client/user_client = user.client
	var/mob/living/simple_animal/drone/drone_type = mob_type
	if(!initial(drone_type.shy) || isnull(user_client) || !CONFIG_GET(flag/use_exp_restrictions_other))
		return ..()
	var/required_role = CONFIG_GET(string/drone_required_role)
	var/required_playtime = CONFIG_GET(number/drone_role_playtime) * 60
	if(required_playtime <= 0)
		return ..()
	var/current_playtime = user_client?.calc_exp_type(required_role)
	if (current_playtime < required_playtime)
		var/minutes_left = required_playtime - current_playtime
		var/playtime_left = DisplayTimeText(minutes_left * (1 MINUTES))
		to_chat(user, "<span class='danger'>You need to play [playtime_left] more as [required_role] to spawn as a Maintenance Drone!</span>")
		return FALSE
	return ..()
