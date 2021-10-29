/datum/antagonist/ert/proc/engi_ert_alert()
	if(prob(5))
		// You get a sudden urge to build a NEW state-of-the-art supermatter chamber!
		owner.current.playsound_local(get_turf(owner.current), 'fulp_modules/features/ert/sounds/home_depot.ogg', 100, FALSE, pressure_affected = FALSE)

/datum/antagonist/ert/proc/choose_medert_outfit()
	var/mob/living/carbon/human/user = owner.current
	var/normal_outfit = /datum/outfit/centcom/ert/medic/specialized
	var/alien_outfit = /datum/outfit/centcom/ert/medic/specialized/alien
	var/oath_outfit = /datum/outfit/centcom/ert/medic/specialized/oath
	var/specialty = pick_weight(list("Default" = 85, "Alien" = 5, "Oath" = 10))
	user.delete_equipment() //To prevent double equipment shenanigans

	switch(specialty)
		if("Alien")
			user.set_species(/datum/species/abductor)
			user.equipOutfit(alien_outfit)
		if("Oath")
			user.equipOutfit(oath_outfit)
		else
			user.equipOutfit(normal_outfit)

/datum/antagonist/ert/proc/choose_commedert_outfit()
	var/mob/living/carbon/human/user = owner.current
	var/normal_outfit = /datum/outfit/centcom/ert/commander/medical
	var/alien_outfit = /datum/outfit/centcom/ert/commander/medical/alien
	var/oath_outfit = /datum/outfit/centcom/ert/commander/medical/oath
	var/specialty = pick_weight(list("Default" = 85, "Alien" = 5, "Oath" = 10))
	user.delete_equipment()

	switch(specialty)
		if("Alien")
			user.set_species(/datum/species/abductor)
			user.equipOutfit(alien_outfit)
		if("Oath")
			user.equipOutfit(oath_outfit)
		else
			user.equipOutfit(normal_outfit)

/datum/antagonist/ert/proc/choose_secert_race()
	var/mob/living/carbon/human/user = owner.current
	var/synth = /datum/species/synth
	var/mil_synth = /datum/species/synth/military
	var/race = pick_weight(list("Default" = 90, "Military" = 1, "Synth" = 9)) // VERY low chance to become a Military Synth, 1/10 chance to become a synth

	switch(race)
		if("Military")
			user.set_species(mil_synth)
		if("Synth")
			user.set_species(synth)
		else
			return FALSE
