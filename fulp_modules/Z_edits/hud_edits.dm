/mob/New()
	// add our nanite huds to everyone so they can (if possible) actually see nanites.
	hud_possible += list(NANITE_HUD, DIAG_NANITE_FULL_HUD)
	return ..()

/datum/atom_hud/data/human/medical/New()
	. = ..()
	hud_icons += list(NANITE_HUD)

/datum/atom_hud/data/human/security/advanced/New()
	. = ..()
	hud_icons += list(NANITE_HUD)

/datum/atom_hud/data/diagnostic/New()
	. = ..()
	hud_icons += list(DIAG_NANITE_FULL_HUD)

/datum/atom_hud/data/bot_path/New()
	. = ..()
	hud_icons += list(DIAG_NANITE_FULL_HUD)
