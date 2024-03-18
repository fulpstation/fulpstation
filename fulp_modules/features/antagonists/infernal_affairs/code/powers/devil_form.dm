/datum/action/cooldown/spell/shapeshift/devil
	name = "Devil Form"
	desc = "Take on the true shape of a devil."
	spell_requirements = NONE
	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"

	button_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/actions_devil.dmi'
	button_icon_state = "devil_form"

	school = SCHOOL_FORBIDDEN
	invocation = "P'ease't d'y 'o' a w'lk!"
	invocation_type = INVOCATION_WHISPER

	possible_shapes = list(/mob/living/basic/devil)
