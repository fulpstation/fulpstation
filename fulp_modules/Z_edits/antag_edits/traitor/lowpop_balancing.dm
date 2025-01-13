/* This file contains a lot of balance-related overrides for */
/* traitor secondary objectives on lowpop.                   */


//////// Proc(s) ////////

/// Returns TRUE if the number of "crewmember" minds is lower than 'lowpop_count' (defaults to 20).
/proc/at_lowpop(lowpop_count = 20 as num)
	var/crew_count = length(get_crewmember_minds())
	if(!crew_count)
		return TRUE

	if(crew_count <= lowpop_count)
		return TRUE
	return FALSE


//////// Outright lowpop removals ////////

/datum/traitor_objective/target_player/assassinate/calling_card/can_generate_objective(datum/mind/generating_for, list/possible_duplicates)
	. = ..()
	if(at_lowpop())
		return FALSE

/datum/traitor_objective/locate_weakpoint/can_generate_objective(datum/mind/generating_for, list/possible_duplicates)
	. = ..()
	if(at_lowpop(10))
		return FALSE

/datum/traitor_objective/target_player/eyesnatching/can_generate_objective(datum/mind/generating_for, list/possible_duplicates)
	. = ..()
	if(at_lowpop(10))
		return FALSE

/obj/machinery/telecomms/hub/add_as_sabotage_target()
	if(at_lowpop(10))
		return
	return add_sabotage_machine(src, /obj/machinery/telecomms/hub)


//////// Lowpop TC Reward Adjustments ////////

// Using 'New()' for all of this might not be optimal,
// but if 'generate_objective()' was used then a pretty fair amount of code might have to be
// repeated here. The same goes for a lot of other procs.

// This objective is currently just used for the blackbox.
/datum/traitor_objective/destroy_item/very_risky/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = rand(2, 3)

/datum/traitor_objective/hack_comm_console/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = rand(4, 6)

/datum/traitor_objective/locate_weakpoint/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = rand(2, 4)

//This further incentivizes keeping the kidnapping target alive.
/datum/traitor_objective/target_player/kidnapping/common/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 0

/datum/traitor_objective/target_player/kidnapping/uncommon/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 0

/datum/traitor_objective/target_player/kidnapping/rare/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 0

/datum/traitor_objective/target_player/kidnapping/captain/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 0

/datum/traitor_objective/target_player/assault/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 0

/datum/traitor_objective/destroy_heirloom/common/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 0

/datum/traitor_objective/destroy_heirloom/uncommon/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 1

/datum/traitor_objective/destroy_heirloom/rare/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 2

/datum/traitor_objective/destroy_heirloom/captain/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 3

/datum/traitor_objective/kill_pet/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 0

/datum/traitor_objective/kill_pet/high_risk/New(datum/uplink_handler/handler)
	. = ..()
	if(at_lowpop())
		telecrystal_reward = 1
