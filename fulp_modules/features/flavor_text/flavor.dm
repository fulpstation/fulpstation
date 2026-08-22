/// How many characters of flavor text gets displayed before it cut off in base examine.
#define EXAMINE_FLAVOR_MAX_DISPLAYED 65

// -- Flavor text datum stuff. --
/// Global list of all flavor texts we have generated. Associated list of [mob name] to [datum ref]
GLOBAL_LIST_EMPTY(flavor_texts)

/**
 * Gets the mob's flavor text datum from the global associated lists of flavor texts.
 * If no flavor text was found, create a new flavor text datum for [added_mob]
 *
 * Returns a datum instance - either a new flavor text or a flavor text from the global list
 * Returns null if the mob was not living or something goes wrong
 */
/proc/add_or_get_mob_flavor_text(mob/living/added_mob)
	RETURN_TYPE(/datum/flavor_text)

	if(!istype(added_mob))
		return null

	var/datum/flavor_text/found_text = GLOB.flavor_texts[added_mob.real_name]
	if(!found_text)
		found_text = new /datum/flavor_text(added_mob)
		GLOB.flavor_texts[added_mob.real_name] = found_text
		if(added_mob.linked_flavor)
			stack_trace("We just made a new flavor text datum for [added_mob] even though it had flavor text linked already, something is messed up")
		added_mob.linked_flavor = found_text

	return found_text


/// Flavor text define for carbons.
/mob/living
	/// The flavor text linked to our carbon.
	var/datum/flavor_text/linked_flavor

/mob/living/Destroy()
	linked_flavor = null // We should never QDEL flavor text datums.
	return ..()

/// The actual flavor text datum. This should never be qdeleted - just leave it floating in the global list.
/datum/flavor_text
	/// The mob that owns this flavor text.
	var/datum/weakref/owner
	/// The name associated with this flavor text.
	var/name
	/// The species associated with this flavor text.
	var/linked_species
	/// The actual flavor text, shown on examine.
	var/flavor_text

/datum/flavor_text/New(mob/living/initial_linked_mob)
	owner = WEAKREF(initial_linked_mob)
	name = initial_linked_mob.real_name

	if(issilicon(initial_linked_mob))
		return
	else if(ishuman(initial_linked_mob))
		var/mob/living/carbon/human/human_mob = initial_linked_mob
		linked_species = human_mob.dna?.species?.id
	else
		linked_species = "simple"

	RegisterSignal(initial_linked_mob, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(initial_linked_mob, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(on_examine_more))

/datum/flavor_text/Destroy(force)
	owner = null
	return ..()

/datum/flavor_text/proc/on_examine(mob/living/source, mob/examiner, list/examine_list)
	SIGNAL_HANDLER

	// Who's identity are we dealing with? In most cases it's the same as [src], but it could be disguised people, or null.
	var/datum/flavor_text/known_identity = !(linked_species == "simple" || astype(source, /mob/living/carbon/human)?.is_face_obscured())
	if(!known_identity)
		return
	examine_list += (separator_hr("Flavor text") + get_flavor_text(examiner, shorten = TRUE))

/datum/flavor_text/proc/on_examine_more(datum/source, mob/examiner, list/examine_list)
	SIGNAL_HANDLER

	var/datum/flavor_text/known_identity = !(linked_species == "simple" || astype(source, /mob/living/carbon/human)?.is_face_obscured())
	if(known_identity)
		. += span_info(get_flavor_text(examiner, shorten = FALSE))
	else if(ishuman(source))
		. += span_smallnoticeital("You can't make out any details of this individual.")
	examine_list += .

/**
 * Get the flavor text formatted.
 *
 * examiner - who's POV we're gettting this flavor text from
 * shorten - whether to cut it off at [EXAMINE_FLAVOR_MAX_DISPLAYED]
 *
 * returns a string
 */
/datum/flavor_text/proc/get_flavor_text(mob/living/carbon/human/examiner, shorten = TRUE)
	var/found_text = flavor_text
	if(!length(found_text))
		return

	if(shorten && length(found_text) > EXAMINE_FLAVOR_MAX_DISPLAYED)
		found_text = text_preview(found_text, EXAMINE_FLAVOR_MAX_DISPLAYED)
		var/mob/living/examined_person = owner?.resolve()
		found_text += " <a href='byond://?src=[REF(examiner)];run_examinate=[REF(examined_person)]'>\[More\]</a>"

	return found_text

#undef EXAMINE_FLAVOR_MAX_DISPLAYED
