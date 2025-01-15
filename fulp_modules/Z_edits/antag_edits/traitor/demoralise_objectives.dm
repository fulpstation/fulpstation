// THIS CONTENT IS NOT ORIGINAL. SEE '_attribution.md' FOR MORE INFORMATION //
// Comments surrounded with brackets were made during porting.              //

/// [DEMORALISATION PARENT DATUM] ///

#define MAX_CREW_RATIO 0.33
#define MIN_CREW_DEMORALISED 1
#define MAX_CREW_DEMORALISED 16

/datum/traitor_objective_category/demoralise
	name = "Demoralise Crew"
	objectives = list(
		/datum/traitor_objective/demoralise/poster = 1,
		/datum/traitor_objective/demoralise/graffiti = 1,
		/datum/traitor_objective/target_player/assault = 1,
		/datum/traitor_objective/destroy_item/demoralise = 1,
	)

/datum/traitor_objective/demoralise
	name = "Debug your code."
	description = "If you actually get this objective someone fucked up."

	abstract_type = /datum/traitor_objective/demoralise

	/// How many 'mood events' are required?
	var/demoralised_crew_required = 0
	/// How many 'mood events' have happened so far?
	var/demoralised_crew_events = 0

/datum/traitor_objective/demoralise/can_generate_objective(datum/mind/generating_for, list/possible_duplicates)
	if(length(possible_duplicates) > 0)
		return FALSE
	return TRUE

/datum/traitor_objective/demoralise/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	var/crew_count = length(get_crewmember_minds())
	if(crew_count <= 15)
		demoralised_crew_required = floor(crew_count * 0.33) + 1
	else
		demoralised_crew_required = (clamp(rand(MIN_CREW_DEMORALISED, length(get_crewmember_minds()) * MAX_CREW_RATIO), MIN_CREW_DEMORALISED, MAX_CREW_DEMORALISED))
	replace_in_name("%VIEWS%", demoralised_crew_required)
	return TRUE

/**
 * Handles an event which increases your progress towards success.
 *
 * Arguments
 * * source - Source atom of the signal.
 * * victim - Mind of whoever it was you just triggered some kind of effect on.
 */
/datum/traitor_objective/demoralise/proc/on_mood_event(atom/source, datum/mind/victim)
	SIGNAL_HANDLER
	if (victim == handler.owner)
		return

	demoralised_crew_events++
	if (demoralised_crew_events >= demoralised_crew_required)
		to_chat(handler.owner, span_nicegreen("The crew look despondent. Mission accomplished."))
		succeed_objective()

#undef MAX_CREW_RATIO
#undef MIN_CREW_DEMORALISED
#undef MAX_CREW_DEMORALISED


/// [POSTER DEMORALISATION] ///

/datum/traitor_objective/demoralise/poster
	name = "Sow doubt among the crew %VIEWS% times using Syndicate propaganda."
	description = "Use the button below to materialize a pack of posters, \
		which will demoralise nearby crew members (especially those in positions of authority). \
		If your posters are destroyed before they are sufficiently upset, this objective will fail. \
		Try hiding some broken glass behind your poster before you hang it to give  \
		do-gooders who try to take it down a hard time!"

	progression_minimum = 0 MINUTES
	progression_maximum = 30 MINUTES
	progression_reward = list(4 MINUTES, 8 MINUTES)
	telecrystal_reward = 0

	duplicate_type = /datum/traitor_objective/demoralise/poster
	/// Have we handed out a box of stuff yet?
	var/granted_posters = FALSE
	/// All of the posters the traitor gets, if this list is empty they've failed
	var/list/obj/structure/sign/poster/traitor/posters = list()

/datum/traitor_objective/demoralise/poster/generate_ui_buttons(mob/user)
	var/list/buttons = list()
	if (!granted_posters)
		buttons += add_ui_button("", "Pressing this will materialize a box of posters in your hand.", "wifi", "summon_gear")
	else
		buttons += add_ui_button("[length(posters)] posters remaining", "This many propaganda posters remain active somewhere on the station.", "box", "none")
		buttons += add_ui_button("[demoralised_crew_events] / [demoralised_crew_required] propagandised", "This many crew have been exposed to propaganda, out of a required [demoralised_crew_required].", "wifi", "none")
	return buttons

#define POSTERS_PROVIDED 3

/datum/traitor_objective/demoralise/poster/ui_perform_action(mob/living/user, action)
	. = ..()
	switch(action)
		if ("summon_gear")
			if (granted_posters)
				return

			granted_posters = TRUE
			var/obj/item/storage/box/syndie_kit/posterbox = new(user.drop_location())
			for(var/i in 1 to POSTERS_PROVIDED)
				var/obj/item/poster/traitor/added_poster = new /obj/item/poster/traitor(posterbox)
				var/obj/structure/sign/poster/traitor/poster_when_placed = added_poster.poster_structure
				posters += poster_when_placed
				RegisterSignal(poster_when_placed, COMSIG_DEMORALISING_EVENT, PROC_REF(on_mood_event))
				RegisterSignal(poster_when_placed, COMSIG_POSTER_TRAP_SUCCEED, PROC_REF(on_triggered_trap))
				RegisterSignal(poster_when_placed, COMSIG_QDELETING, PROC_REF(on_poster_destroy))

			user.put_in_hands(posterbox)
			posterbox.balloon_alert(user, "the box materializes in your hand")

#undef POSTERS_PROVIDED

/datum/traitor_objective/demoralise/poster/ungenerate_objective()
	for (var/poster in posters)
		UnregisterSignal(poster, COMSIG_DEMORALISING_EVENT)
		UnregisterSignal(poster, COMSIG_QDELETING)
	posters.Cut()
	return ..()

/**
 * Called if someone gets glass stuck in their hand from one of your posters.
 *
 * Arguments
 * * victim - A mob who just got something stuck in their hand.
 */
/datum/traitor_objective/demoralise/poster/proc/on_triggered_trap(datum/source, mob/victim)
	SIGNAL_HANDLER
	on_mood_event(victim.mind)

/**
 * Handles a poster being destroyed, increasing your progress towards failure.
 *
 * Arguments
 * * poster - A poster which someone just ripped up.
 */
/datum/traitor_objective/demoralise/poster/proc/on_poster_destroy(obj/structure/sign/poster/traitor/poster)
	SIGNAL_HANDLER
	posters.Remove(poster)
	UnregisterSignal(poster, COMSIG_DEMORALISING_EVENT)
	if (length(posters) <= 0)
		to_chat(handler.owner, span_warning("The trackers on your propaganda posters have stopped responding."))
		fail_objective(penalty_cost = telecrystal_penalty)


/// [GRAFITTI DEMORALISATION] ///

/datum/traitor_objective/demoralise/graffiti
	name = "Sow doubt among the crew %VIEWS% times using Syndicate graffiti."
	description = "Use the button below to materialize a seditious spray can, \
		and use it to draw a 3x3 tag in a place where people will come across it. \
		Special syndicate sealing agent ensures that it can't be removed for \
		five minutes following application, and it's slippery too! \
		People seeing or slipping on your graffiti grants progress towards success."

	progression_minimum = 0 MINUTES
	progression_maximum = 30 MINUTES
	progression_reward = list(4 MINUTES, 8 MINUTES)
	telecrystal_reward = list(0, 1)

	duplicate_type = /datum/traitor_objective/demoralise/graffiti
	/// Have we given out a spray can yet?
	var/obtained_spray = FALSE
	/// Graffiti 'rune' which we will be drawing
	var/obj/effect/decal/cleanable/traitor_rune/rune

/datum/traitor_objective/demoralise/graffiti/generate_ui_buttons(mob/user)
	var/list/buttons = list()
	if (!obtained_spray)
		buttons += add_ui_button("", "Pressing this will materialize a syndicate spraycan in your hand.", "wifi", "summon_gear")
	else
		buttons += add_ui_button("[demoralised_crew_events] / [demoralised_crew_required] propagandised", "This many crew have been exposed to propaganda, out of a required [demoralised_crew_required].", "wifi", "none")
	return buttons

/datum/traitor_objective/demoralise/graffiti/ui_perform_action(mob/living/user, action)
	. = ..()
	switch(action)
		if ("summon_gear")
			if (obtained_spray)
				return

			obtained_spray = TRUE
			var/obj/item/traitor_spraycan/spray = new(user.drop_location())
			user.put_in_hands(spray)
			spray.balloon_alert(user, "the spraycan materializes in your hand")

			RegisterSignal(spray, COMSIG_QDELETING, PROC_REF(on_spray_destroyed))
			RegisterSignal(spray, COMSIG_TRAITOR_GRAFFITI_DRAWN, PROC_REF(on_rune_complete))

/**
 * Called when the spray can is deleted.
 * If it's already been expended we don't care, if it hasn't you just made your objective impossible.area
 *
 * Arguments
 * * spray - the spraycan which was just deleted
 */
/datum/traitor_objective/demoralise/graffiti/proc/on_spray_destroyed()
	SIGNAL_HANDLER
	// You fucked up pretty bad if you let this happen
	if (!rune)
		fail_objective(penalty_cost = telecrystal_penalty)

/**
 * Called when you managed to draw a traitor rune.
 * Sets up tracking for objective progress, and unregisters signals for the spraycan because we don't care about it any more.
 *
 * Arguments
 * * drawn_rune - graffiti 'rune' which was just drawn.
 */
/datum/traitor_objective/demoralise/graffiti/proc/on_rune_complete(atom/spray, obj/effect/decal/cleanable/traitor_rune/drawn_rune)
	SIGNAL_HANDLER
	rune = drawn_rune
	UnregisterSignal(spray, COMSIG_QDELETING)
	UnregisterSignal(spray, COMSIG_TRAITOR_GRAFFITI_DRAWN)
	RegisterSignal(drawn_rune, COMSIG_QDELETING, PROC_REF(on_rune_destroyed))
	RegisterSignal(drawn_rune, COMSIG_DEMORALISING_EVENT, PROC_REF(on_mood_event))
	RegisterSignal(drawn_rune, COMSIG_TRAITOR_GRAFFITI_SLIPPED, PROC_REF(on_mood_event))

/**
 * Called when your traitor rune is destroyed. If you haven't suceeded by now, you fail.area
 *
 * Arguments
 * * rune - the rune which just got destroyed.
 */
/datum/traitor_objective/demoralise/graffiti/proc/on_rune_destroyed(obj/effect/decal/cleanable/traitor_rune/rune)
	SIGNAL_HANDLER
	fail_objective(penalty_cost = telecrystal_penalty)

/datum/traitor_objective/demoralise/graffiti/ungenerate_objective()
	if (rune)
		UnregisterSignal(rune, COMSIG_QDELETING)
		UnregisterSignal(rune, COMSIG_DEMORALISING_EVENT)
		UnregisterSignal(rune, COMSIG_TRAITOR_GRAFFITI_SLIPPED)
		rune = null
	return ..()
