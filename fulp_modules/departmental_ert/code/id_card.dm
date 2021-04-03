/obj/item/card/id/advanced/centcom/ert/miner
	registered_name = "Mining Response Officer"
	trim = /datum/id_trim/centcom/ert/miner

/datum/id_trim/centcom/ert/miner
	assignment = "Mining Response Officer"
	trim_icon = 'fulp_modules/jobs/cards.dmi'
	trim_state = "trim_ert_miner"

/datum/id_trim/centcom/ert/miner/New()
	. = ..()

	access = list(ACCESS_CENT_GENERAL, ACCESS_CENT_LIVING) | (SSid_access.get_region_access_list(list(REGION_ALL_STATION)) - ACCESS_CHANGE_IDS)
