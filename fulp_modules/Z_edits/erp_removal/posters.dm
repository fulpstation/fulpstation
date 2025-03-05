// blacklists ALL "suggestive" posters— intentionally ironic or otherwise.
/obj/structure/sign/poster/Initialize(mapload)
	blacklisted_types += list(
		/obj/structure/sign/poster/official/no_erp,
		/obj/structure/sign/poster/contraband/got_wood,
		/obj/structure/sign/poster/contraband/lusty_xenomorph,
		/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6,
		/obj/structure/sign/poster/contraband/lizard
	)
	return ..()
