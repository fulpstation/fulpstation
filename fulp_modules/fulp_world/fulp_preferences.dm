/datum/preferences
	// Extra characters, why not.
	max_save_slots = 5


#define MAX_FLAVOR_LEN 2048

/datum/preference/multiline_text
	abstract_type = /datum/preference/multiline_text
	can_randomize = FALSE
	var/max_length = MAX_FLAVOR_LEN

/datum/preference/multiline_text/deserialize(input, datum/preferences/preferences)
	return STRIP_HTML_SIMPLE("[input]", max_length)

/datum/preference/multiline_text/serialize(input)
	return STRIP_HTML_SIMPLE(input, max_length)

/datum/preference/multiline_text/is_valid(value)
	return istext(value) && !isnull(STRIP_HTML_SIMPLE(value, max_length))

/datum/preference/multiline_text/create_default_value()
	return null

/datum/preference/multiline_text/compile_constant_data()
	return list("maximum_length" = max_length)

/// Preferences that add onto flavor text datum
/datum/preference/multiline_text/flavor_datum
	abstract_type = /datum/preference/multiline_text/flavor_datum
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_NAMES
	should_update_preview = FALSE

/datum/preference/multiline_text/flavor_datum/apply_to_human(mob/living/carbon/human/target, value)
	if(!length(value) || istype(target, /mob/living/carbon/human/dummy)) // Don't stick flavor text on dummies
		return

	var/datum/flavor_text/our_flavor = target.linked_flavor || add_or_get_mob_flavor_text(target)
	if(isnull(our_flavor))
		return

	add_to_flavor_datum(our_flavor, value)

/datum/preference/multiline_text/flavor_datum/proc/add_to_flavor_datum(datum/flavor_text/our_flavor, value)
	SHOULD_CALL_PARENT(FALSE)
	stack_trace("add_to_flavor_datum not implemented for [type]")

/datum/preference/multiline_text/flavor_datum/flavor
	savefile_key = "flavor_text"

/datum/preference/multiline_text/flavor_datum/flavor/add_to_flavor_datum(datum/flavor_text/our_flavor, value)
	our_flavor.flavor_text = value

#undef MAX_FLAVOR_LEN
