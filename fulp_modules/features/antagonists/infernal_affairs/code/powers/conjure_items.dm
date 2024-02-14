/datum/action/cooldown/spell/conjure_item/summon_pitchfork
	name = "Summon Pitchfork"
	desc = "A devil's weapon of choice. Not actually great at damage, but sets people ablaze."
	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"
	spell_requirements = NONE

	button_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/actions_devil.dmi'
	button_icon_state = "pitchfork"

	school = SCHOOL_FORBIDDEN
	invocation_type = INVOCATION_NONE

	item_type = /obj/item/pitchfork/demonic

/datum/action/cooldown/spell/conjure_item/violin
	name = "Summon Golden Violin"
	desc = "Play some tunes."
	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"
	spell_requirements = NONE

	button_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/actions_devil.dmi'
	button_icon_state = "golden_violin"

	school = SCHOOL_FORBIDDEN
	invocation = "I aint have this much fun since Georgia."
	invocation_type = INVOCATION_WHISPER

	item_type = /obj/item/instrument/violin/golden
