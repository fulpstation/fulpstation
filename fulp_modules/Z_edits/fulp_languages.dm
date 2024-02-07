// Allows all tongues to speak our languages
/obj/item/organ/internal/tongue/get_possible_languages()
	return ..() + /datum/language/russian
