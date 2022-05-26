/// Base Skillchip
/obj/item/skillchip/job/deputy
	name = "D3PU7Y skillchip"
	desc = "You think they learn this stuff naturally?"
	skill_icon = "sitemap"
	var/deputy
	var/department
	var/datum/martial_art/deputyblock/style

/obj/item/skillchip/job/deputy/Initialize()
	. = ..()
	if(deputy)
		name = "[deputy]-D3PU7Y skillchip"
	if(department)
		skill_name = "[department] deputy"
		skill_description = "Recognizes [department] as their home, making them feel happy in it, and tends to be harsher on criminals with their grabs."
		activate_message = span_notice("You suddenly feel safe in [department].")
		deactivate_message = span_notice("[department] no longer feels safe.")
	style = new

/obj/item/skillchip/job/deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	style.teach(user, TRUE)

/obj/item/skillchip/job/deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	style.remove(user)
	return ..()

/*
 *	Deputies are meant to get NOGUNS trait.
 *	Lore-wise reason is that they are privately-owned, and trained by non-NT folk.
 *	These folk believe professionalism and the way people look at you, is more important than efficiency.
 *	No one wants to see a deputy with a gun, so they're trained in not using it.
 *
 *	Actual reason why is balance and to prevent powergaming.
 */

/// Engineering Skillchip
/obj/item/skillchip/job/deputy/engineering
	deputy = "3NG1N3ER1N9"
	department = "Engineering"
	auto_traits = list(TRAIT_ENGINEERINGDEPUTY, TRAIT_NOGUNS, TRAIT_SUPERMATTER_MADNESS_IMMUNE) /// Engineering deputies on their way to arrest the SM

/area/engineering
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_ENGINEERINGDEPUTY

/// Medical Skillchip
/obj/item/skillchip/job/deputy/medical
	deputy = "M3D1C4L"
	department = "Medbay"
	auto_traits = list(TRAIT_MEDICALDEPUTY, TRAIT_NOGUNS, TRAIT_QUICK_CARRY) /// Medical deputies on their way to arrest dead bodies?

/area/medical
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_MEDICALDEPUTY

/// Science Skillchip
/obj/item/skillchip/job/deputy/science
	deputy = "5C1ENC3"
	department = "Science"
	auto_traits = list(TRAIT_SCIENCEDEPUTY, TRAIT_NOGUNS) /// No bonus here, they get a Mutadone medipen instead.

/area/science
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SCIENCEDEPUTY

/// Supply Skillchip
/obj/item/skillchip/job/deputy/supply
	deputy = "5UPP1Y"
	department = "Cargo"
	auto_traits = list(TRAIT_SUPPLYDEPUTY, TRAIT_NOGUNS) /// No bonus here, they get an armor vest instead.

/area/cargo
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SUPPLYDEPUTY

/// Service Skillchip
/obj/item/skillchip/job/deputy/service
	deputy = "S5RV1C3"
	department = "Service"
	auto_traits = list(TRAIT_SERVICEDEPUTY, TRAIT_NOGUNS, TRAIT_SUPERMATTER_SOOTHER) /// Psychologist bonus without the hallucination protection.

/area/service
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SERVICEDEPUTY

/// Mood buff from being within your department.
/datum/mood_event/deputy_helpful
	description = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_change = 5
