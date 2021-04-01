/obj/item/card/id/ert/miner
	registered_name = "Mining Response Officer"
	assignment = "Mining Response Officer"
	icon = 'fulp_modules/jobs/cards.dmi'
	icon_state = "idminingresponseofficer"

/obj/item/card/id/ert/miner/Initialize()
	access = get_all_accesses()
	. = ..()
