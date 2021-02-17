// This file is to add some signal handling to the GPS, to avoid using GetComponent,
// as signals are usually better practice anyway.

// For when a GPS signal's source is renamed. Should be useful in the future for more than minebots.
#define COMSIG_SIGNAL_SOURCE_RENAMED "gps_source_renamed"

/datum/component/gps/Initialize(_gpstag = "COM0")
	. = ..()
	RegisterSignal(parent, COMSIG_SIGNAL_SOURCE_RENAMED, .proc/rename_tag)

/datum/component/gps/proc/rename_tag(datum/source, new_tag)
	SIGNAL_HANDLER

	gpstag = "[new_tag]" // Just in case the new_tag somehow isn't a string already.

