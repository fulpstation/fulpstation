/*
 *	# Roundstart rulesets
 */

/datum/dynamic_ruleset/roundstart/traitor/New()
	. = ..()
	restricted_roles += list(
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
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/dynamic_ruleset/roundstart/changeling/New()
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/dynamic_ruleset/roundstart/heretics/New()
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/dynamic_ruleset/roundstart/bloodcult/New()
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	)

/datum/dynamic_ruleset/roundstart/revs/New()
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	)

/datum/dynamic_ruleset/roundstart/families/New() // Haha, families.
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)


/*
 *	# Latejoin rulesets
 */

/datum/dynamic_ruleset/latejoin/infiltrator/New()
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/dynamic_ruleset/latejoin/provocateur/New() // Revs
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	)

/datum/dynamic_ruleset/latejoin/heretic_smuggler/New()
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/*
 *	# Midround rulesets
 */

/datum/dynamic_ruleset/midround/autotraitor
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)

/datum/dynamic_ruleset/midround/families
	. = ..()
	restricted_roles += list(
	"Brig Physician",
	"Deputy",
	"Head of Personnel",
	"Research Director",
	"Chief Engineer",
	"Chief Medical Officer",
	)
