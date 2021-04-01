//
// ERT Antagonist Datums
//

/datum/antagonist/ert/medic/specialized
	role = "Specialized Medical Officer"
	outfit = /datum/outfit/centcom/ert/medic/specialized

/datum/antagonist/ert/commander/medical
	role = "Chief Medical Officer"
	outfit = /datum/outfit/centcom/ert/commander/medical // This and Specialized MD are actually handled by a Proc, it's just there to show off outfit

/datum/antagonist/ert/security/specialized
	role = "Specialized Security Officer"
	outfit = /datum/outfit/centcom/ert/security/specialized

/datum/antagonist/ert/commander/security
	role = "Head Of Security"
	outfit = /datum/outfit/centcom/ert/commander/security

/datum/antagonist/ert/engineer/specialized
	role = "Specialized Engineering Officer"
	outfit = /datum/outfit/centcom/ert/engineer/specialized

/datum/antagonist/ert/commander/engineer
	role = "Chief Engineer"
	outfit = /datum/outfit/centcom/ert/commander/engineer

/datum/antagonist/ert/clown/honk
	role = "Clown"
	outfit = /datum/outfit/centcom/ert/clown/honk

/datum/antagonist/ert/clown/commander
	role = "Honk Prime"
	outfit = /datum/outfit/centcom/ert/clown/commander

/datum/antagonist/ert/miner
	role = "Mining Officer"
	outfit = /datum/outfit/centcom/ert/miner

/datum/antagonist/ert/commander/miner
	role = "Mining Commander"
	outfit = /datum/outfit/centcom/ert/commander/miner

/datum/antagonist/ert/engineer/specialized/on_gain()
	engi_ert_alert()
	. = ..()

/datum/antagonist/ert/commander/engineer/on_gain()
	engi_ert_alert()
	. = ..()

/datum/antagonist/ert/security/specialized/on_gain()
	. = ..()
	choose_secert_race()

/datum/antagonist/ert/commander/security/on_gain()
	. = ..()
	choose_secert_race()

/datum/antagonist/ert/medic/specialized/on_gain()
	. = ..()
	choose_medert_outfit()

/datum/antagonist/ert/commander/medical/on_gain()
	. = ..()
	choose_commedert_outfit()
