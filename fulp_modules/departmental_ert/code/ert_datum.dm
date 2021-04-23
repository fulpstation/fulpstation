/datum/ert/medical
	roles = list(/datum/antagonist/ert/medic/specialized)
	leader_role = /datum/antagonist/ert/commander/medical
	rename_team = "Medical ERT"
	mission = "Assist your assigned Department."
	polldesc = "a Medical Nanotrasen Emergency Response Team"

/datum/ert/security
	roles = list(/datum/antagonist/ert/security/specialized)
	leader_role = /datum/antagonist/ert/commander/security
	rename_team = "Security ERT"
	mission = "Assist your assigned Department."
	polldesc = "a Security Nanotrasen Emergency Response Team"

/datum/ert/engineer
	roles = list(/datum/antagonist/ert/engineer/specialized)
	leader_role = /datum/antagonist/ert/commander/engineer
	rename_team = "Engineer ERT"
	mission = "Assist your assigned Department."
	polldesc = "an Engineering Nanotrasen Emergency Response Team"

/datum/ert/clown
	roles = list(/datum/antagonist/ert/clown/honk)
	leader_role = /datum/antagonist/ert/clown/commander
	rename_team = "Clown ERT"
	mission = "Honk the crew!"
	polldesc = "a Code HONK Nanotrasen Emergency Response Team"

/// safety moth 

/datum/ert/safety_moth
	mobtype = /mob/living/carbon/human/species/moth
	leader_role = /datum/antagonist/ert/safety_moth
	enforce_human = FALSE
	roles = list(/datum/antagonist/ert/safety_moth)
	mission = "Ensure that proper safety protocols are being followed by the crew."
	teamsize = 1
	polldesc = "an experienced Nanotrasen engineering expert"
	opendoors = FALSE
	
