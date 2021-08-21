/datum/action/bloodsucker/tremere
	name = "Vampiric Gift"
	desc = "A vampiric gift."
	///This is the FILE for the background icon
	button_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	///This is the ICON_STATE for the background icon
	background_icon_state = "vamp_power_off"
	/// Power's parent type
	var/list/next_knowledge = list()

/datum/action/bloodsucker/tremere/dominate_one

/datum/action/bloodsucker/tremere/dominate_two

/datum/action/bloodsucker/tremere/dominate_three

/datum/antagonist/bloodsucker/proc/get_tremere_magic()
	var/list/researchable_knowledge = list()
	for(var/datum/action/bloodsucker/tremere/tremere_power in powers)
		researchable_knowledge |= tremere_power.next_knowledge
	return researchable_knowledge

// code used for purchasing powers
	if(!(locate(power) in powers) && initial(power.bloodsucker_can_buy))
		options[initial(power.name)] = power


/*
 *	# Powers:
 *
 *	Dominate;
 *	Level 1 - Mesmerizes targetted person
 *	Level 2 - Target get a heart attack
 *	Level 3 - Target temporarily become a Vassal before losing the antag status and dying
 *
 *	Thaumaturgy;
 *	Level 1 - One shot bloodbeam spell
 *	Level 2 - One shot bloodbeam spell that causes target to vomit
 *	Level 3 - One shot bloodbeam spell that causes target to vomit and sets them on fire
 *
 *	Auspex;
 *	Level 1 - Gives Night Vision
 *	Level 2 - Targetted spell that burns everyone nearby
 *	Level 3 - Targetted spell that creates a burning fire (Like Heretic)
 */
