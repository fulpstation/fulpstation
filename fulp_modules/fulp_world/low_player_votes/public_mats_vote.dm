//----------------------------------------------------------------------------------//
// This code was written with significant reference to 'public_restart_vote.dm' and //
//          '/datum/supply_pack/custom/minerals/fill()' from '_packs.dm'.           //
//----------------------------------------------------------------------------------//

#define CHOICE_DROP "Accept mineral supply drop."
#define CHOICE_NO_DROP "Decline complimentary resources."

/datum/vote/public_mats_vote
	name = "Materials Supply Drop"
	default_choices = list(
		CHOICE_DROP,
		CHOICE_NO_DROP,
	)
	default_message = "Vote to have the station receive a small supply drop \
		containing materials only otherwise obtainable through significant effort."

	/// If the vote ties then this becomes TRUE and we change our final 'priority_announce()' call.
	var/unique_tie_message = FALSE

	/// A list of materials (formatted by typepath and associated quantity) to send if the vote succeeds.
	var/list/payload_mats = list(
		/obj/item/stack/sheet/plastic = 10,
		/obj/item/stack/sheet/mineral/plasma = 10,
		/obj/item/stack/sheet/mineral/silver = 5,
		/obj/item/stack/sheet/mineral/gold = 5,
		/obj/item/stack/sheet/mineral/uranium = 5,
		/obj/item/stack/sheet/mineral/titanium = 5
	)

/datum/vote/public_mats_vote/New()
	. = ..()
	addtimer(CALLBACK(SSvote, PROC_REF(initiate_vote), /datum/vote/public_mats_vote, "the server", null, TRUE), \
		CONFIG_GET(number/public_mats_vote) MINUTES, TIMER_UNIQUE)

/datum/vote/public_mats_vote/toggle_votable()
	var/datum/config_entry/CE = /datum/config_entry/number/public_mats_vote
	if(CONFIG_GET(number/public_mats_vote) == -1)
		var/time_requirement = input(usr, "How many minutes should the round last before the vote is automatically called?", "Enabling material supply drop vote", initial(CE.default)) as num
		CONFIG_SET(number/public_mats_vote, time_requirement)
	else
		CONFIG_SET(number/public_mats_vote, -1)

/datum/vote/public_mats_vote/is_config_enabled()
	return  CONFIG_GET(number/public_mats_vote) != -1

/datum/vote/public_mats_vote/create_vote()
	. = ..()
	var/list/crewmember_minds = get_crewmember_minds()
	if(length(crewmember_minds) > 20)
		return FALSE

	for(var/datum/mind/crew_mind in crewmember_minds)
		if(crew_mind.assigned_role.title == (JOB_SHAFT_MINER || JOB_BITRUNNER))
			return FALSE

/datum/vote/public_mats_vote/initiate_vote(initiator, duration)
	. = ..()
	priority_announce("Attention [station_name()], our automated manifest processing system indicates \
		that you are qualified to receive a small mineral supply package in exchange for slightly \
		increased profit quotas at the end of this quarter. Transcendental thought pattern analysis \
		will now begin so as to quickly determine your crew's opinion on this offer.", \
		"[command_name()] Department of Understaffed Station Logistics", 'sound/announcer/announcement/announce_dig.ogg', \
		has_important_message = TRUE)

/datum/vote/public_mats_vote/get_vote_result()
	. = ..()

/datum/vote/public_mats_vote/can_be_initiated(forced)
	. = ..()
	if(!is_config_enabled())
		return

	if(!forced)
		return "This vote will call itself automatically on low population rounds if there are no \
			shaft miners or bitrunners."

/**
 * Called if the vote passes or ties; sends a supply pod containing the material sheets set in
 * 'var/list/payload_mats' to a random, safe "commons" area. Returns the area the pod was sent to.
 */
/datum/vote/public_mats_vote/proc/send_supply_drop()
	var/obj/structure/closet/crate/drop_crate = new /obj/structure/closet/crate/large
	drop_crate.name = "Materials Supply Drop for [station_name()]"
	for(var/obj/item/stack/sheet/material as anything in payload_mats)
		new material(drop_crate, payload_mats[material])

	var/turf/target_commons_turf = get_safe_random_station_turf(typesof(/area/station/commons))
	// If we have no safe commons turfs (maybe someone plasmaflooded five minutes into the round...)
	// then just go for a random commons area.
	if(!target_commons_turf)
		var/area/random_commons_area = pick(get_areas(/area/station/commons))
		send_supply_pod_to_area(drop_crate, random_commons_area, /obj/structure/closet/supplypod/centcompod)
		return random_commons_area

	// If we do have a safe commons turf then we have to convert it into an area for 'send_supply_pod_to_area'
	var/area/commons_turf_area = get_area(target_commons_turf)
	send_supply_pod_to_area(drop_crate, commons_turf_area, /obj/structure/closet/supplypod/centcompod)
	return commons_turf_area

/datum/vote/public_mats_vote/finalize_vote(winning_option)
	. = ..()
	if(unique_tie_message)
		var/area/target_commons_area = send_supply_drop()
		priority_announce("[station_name()], we are unable to determine if your crew is interested in \
		a material supply drop— we'll send it anyways just to be safe. Your package's designated landing \
		site is the [target_commons_area.name].", \
		"[command_name()] Department of Understaffed Station Logistics", 'sound/announcer/announcement/announce_dig.ogg', \
		has_important_message = TRUE)
		unique_tie_message = FALSE
		return

	if(winning_option == CHOICE_DROP)
		var/area/target_commons_area = send_supply_drop()
		priority_announce("[station_name()], your crew seems interested in a material supply drop, so \
		we're sending it now. Your package's designated landing site is the [target_commons_area.name].", \
		"[command_name()] Department of Understaffed Station Logistics", 'sound/announcer/announcement/announce_dig.ogg', \
		has_important_message = TRUE)
		return

	if(winning_option == CHOICE_NO_DROP)
		priority_announce("[station_name()], your crew seems uninterested in a material supply drop. If \
		you ever start to need materials then we advise you to consider Galactic Materials Market \
		trading, [SSmapping.is_planetary() ? "" : "Lavaland "]shaft mining, or bitrunning. Have a wonderful shift.",
		"[command_name()] Department of Understaffed Station Logistics", 'sound/announcer/announcement/announce_dig.ogg', \
		has_important_message = TRUE)

/datum/vote/public_mats_vote/tiebreaker(list/winners)
	. = ..()
	unique_tie_message = TRUE
	return CHOICE_DROP

#undef CHOICE_DROP
#undef CHOICE_NO_DROP
