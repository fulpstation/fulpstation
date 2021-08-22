/datum/action/bloodsucker/tremere
	name = "Tremere Gift"
	desc = "A tremere exclusive gift."
	button_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	background_icon_state = "vamp_power_off"
	tremere_power = TRUE
	var/upgraded_power

/// If the Power you're upgrading has an improved version, we will deactivate, then delete your old one, then buy the new one.
/datum/antagonist/bloodsucker/proc/tremere_upgrade_power(datum/action/bloodsucker/tremere/tremerepower)
	for(var/datum/action/bloodsucker/power in powers)
		if(!istype(power, initial(tremerepower)))
			continue
		if(!initial(tremerepower.upgraded_power))
			return FALSE
		var/datum/action/bloodsucker/tremere/tremere_upgraded_power = initial(tremerepower.upgraded_power)
		BuyPower(new tremere_upgraded_power)
		powers -= power
		if(power.active)
			power.DeactivatePower()
		power.Remove(owner.current)
		return TRUE

/datum/action/bloodsucker/tremere/dominate_one
	name = "Dominate One"
	bloodsucker_can_buy = TRUE
	upgraded_power = /datum/action/bloodsucker/tremere/dominate_two

/datum/action/bloodsucker/tremere/dominate_two
	name = "Dominate Two"
	bloodsucker_can_buy = TRUE
	upgraded_power = /datum/action/bloodsucker/tremere/dominate_three

/datum/action/bloodsucker/tremere/dominate_three
	name = "Dominate Three"
	bloodsucker_can_buy = TRUE
	upgraded_power = /datum/action/bloodsucker/tremere/dominate_four

/datum/action/bloodsucker/tremere/dominate_four
	name = "Dominate Four"
	bloodsucker_can_buy = TRUE
	upgraded_power = /datum/action/bloodsucker/tremere/dominate_five

/datum/action/bloodsucker/tremere/dominate_five
	name = "Dominate Five"
	bloodsucker_can_buy = TRUE


/* // Code used to purchase Powers.
	if(!(locate(power) in powers) && initial(power.bloodsucker_can_buy))
		options[initial(power.name)] = power
 */


/*
 *	# Powers:
 *
 *	Dominate;
 *	Level 1 - Mesmerizes target
 *	Level 2 - Mesmerizes and mutes target
 *	Level 3 - Mesmerizes, blinds and mutes target
 *	Level 4 - Target get a heart attack
 *	Level 5 - Target temporarily become a Vassal before losing the antag status and dying
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
