/datum/game_mode/changeling/New()
	protected_jobs += "Head of Personnel"
	. = ..()

/datum/game_mode/heretics/New()
	protected_jobs += "Head of Personnel"
	. = ..()

/datum/game_mode/traitor/New()
	protected_jobs += "Head of Personnel"
	. = ..()

/datum/dynamic_ruleset/midround/autotraitor/New()
	protected_roles += "Head of Personnel"
	. = ..()

/datum/dynamic_ruleset/roundstart/traitor/New()
	protected_roles += "Head of Personnel"
	. = ..()

/datum/dynamic_ruleset/roundstart/traitorbro/New()
	protected_roles += "Head of Personnel"
	. = ..()

/datum/dynamic_ruleset/roundstart/changeling/New()
	protected_roles += "Head of Personnel"
	. = ..()

/datum/dynamic_ruleset/roundstart/heretics/New()
	protected_roles += "Head of Personnel"
	. = ..()
