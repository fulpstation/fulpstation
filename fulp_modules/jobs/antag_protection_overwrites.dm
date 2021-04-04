/// Secret mode
/datum/game_mode/traitor/New()
	protected_jobs += list("Brig Physician", "Deputy")
	. = ..()

/datum/game_mode/cult/New()
	protected_jobs += list("Brig Physician", "Deputy")
	. = ..()

/datum/game_mode/revolution/New()
	protected_jobs += list("Brig Physician", "Deputy")
	. = ..()

/datum/game_mode/changeling/New()
	protected_jobs += list("Brig Physician", "Deputy")
	. = ..()

/datum/game_mode/eldritch_cult/New()
	protected_jobs += list("Brig Physician", "Deputy")
	. = ..()

/// Roundstart dymamic rulesets.
/datum/dynamic_ruleset/roundstart/traitor/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()

/datum/dynamic_ruleset/roundstart/traitorbro/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()

/datum/dynamic_ruleset/roundstart/changeling/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()

/datum/dynamic_ruleset/roundstart/heretics/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()

/datum/dynamic_ruleset/roundstart/bloodcult/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()

/datum/dynamic_ruleset/roundstart/revs/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()

/datum/dynamic_ruleset/roundstart/families/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()

/// Dynamic Latejoin rulesets
/datum/dynamic_ruleset/latejoin/infiltrator/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()

/datum/dynamic_ruleset/latejoin/provocateur/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()

/datum/dynamic_ruleset/latejoin/heretic_smuggler/New()
	protected_roles += list("Brig Physician", "Deputy")
	. = ..()
