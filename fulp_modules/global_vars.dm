/*
 *	# This file is for any fulp-related global lists.
 *
 */

/// This list is used in job_integration.dm to assign jobs their HUD Icons. When adding new jobs, add them to this list.
GLOBAL_LIST_INIT(fulp_job_assignments, list(
	"Brig Physician",
	"Deputy",
	"Deputy (Supply)",
	"Deputy (Engineering)",
	"Deputy (Medical)",
	"Deputy (Science)",
	"Deputy (Service)",
))

GLOBAL_LIST_INIT(fulp_ban_list, list(
	"Fulp Race Bans" = list(
		SPECIES_FELINE,
		SPECIES_MOTH,
		SPECIES_ETHEREAL,
		SPECIES_PLASMAMAN,
		SPECIES_LIZARD,
		SPECIES_BEEFMAN,
	),
	"Fulp Antagonist Positions" = list(
		ROLE_BLOODSUCKER,
		ROLE_MONSTERHUNTER,
	),
))
