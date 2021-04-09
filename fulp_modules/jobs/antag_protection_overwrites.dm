/// Secret mode
/datum/game_mode/traitor/New()
	. = ..()
	protected_jobs += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/*
/datum/game_mode/traitor/bros/New()
	. = ..()
	protected_jobs += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)
*/

/// We'll allow Command antags for some gamemodes to help prevent metagaming
/datum/game_mode/traitor/internal_affairs/New()
	. = ..()
	protected_jobs -= list(
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/game_mode/cult/New()
	. = ..()
	protected_jobs += list(
	"Brig Physician",
	"Deputy",
	)

/datum/game_mode/revolution/New()
	. = ..()
	protected_jobs += list(
	"Brig Physician",
	"Deputy",
	)

/datum/game_mode/changeling/New()
	. = ..()
	protected_jobs += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/game_mode/heretics/New()
	. = ..()
	protected_jobs += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/// Roundstart dymamic rulesets.
/datum/dynamic_ruleset/roundstart/traitor/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)
	. = ..()

/datum/dynamic_ruleset/roundstart/traitorbro/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/dynamic_ruleset/roundstart/changeling/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/dynamic_ruleset/roundstart/heretics/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/dynamic_ruleset/roundstart/bloodcult/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	)

/datum/dynamic_ruleset/roundstart/revs/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	)

/// Haha, families.
/datum/dynamic_ruleset/roundstart/families/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/// Dynamic Latejoin rulesets
/datum/dynamic_ruleset/latejoin/infiltrator/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/// This is revs btw
/datum/dynamic_ruleset/latejoin/provocateur/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	)

/datum/dynamic_ruleset/latejoin/heretic_smuggler/New()
	. = ..()
	protected_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)
