// Allows all tongues to speak our languages
/obj/item/organ/tongue/get_possible_languages()
	return ..() + /datum/language/russian
