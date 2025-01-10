/// A subtype of 'poster/random' that differs from its parent only in that it also
/// blacklists ALL "suggestive" posters— intentionally ironic or otherwise.
/obj/structure/sign/poster/random/fulp
	blacklisted_types = list(
		/obj/structure/sign/poster/traitor,
		/obj/structure/sign/poster/abductor,
		/obj/structure/sign/poster/official/no_erp,
		/obj/structure/sign/poster/contraband/got_wood,
		/obj/structure/sign/poster/contraband/lusty_xenomorph,
		/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6,
		/obj/structure/sign/poster/contraband/lizard
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/random/fulp, 32)

/// Proc called on Initialize() to override posters by replacing them with a different one.
/obj/structure/sign/poster/proc/fulp_poster_override()
	var/obj/structure/sign/replacement_poster = new /obj/structure/sign/poster/random/fulp(src.loc)
	// If we start out in a poster item (rolled up) then replace that poster item's poster.
	if(istype(src.loc, /obj/item/poster))
		var/obj/item/poster/poster_container = src.loc
		replacement_poster = poster_container.poster_structure
		replacement_poster = poster_container.poster_type
		qdel(src)
		return

	replacement_poster.dir = src.dir
	replacement_poster.pixel_x = src.pixel_x
	replacement_poster.pixel_y = src.pixel_y

	qdel(src)


//// 'Initialize()' proc overrides ////

/obj/structure/sign/poster/contraband/got_wood/Initialize(mapload)
	. = ..()
	fulp_poster_override()

/obj/structure/sign/poster/official/no_erp/Initialize(mapload)
	. = ..()
	fulp_poster_override()

/obj/structure/sign/poster/contraband/lusty_xenomorph/Initialize(mapload)
	. = ..()
	fulp_poster_override()

/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6/Initialize(mapload)
	. = ..()
	fulp_poster_override()

/obj/structure/sign/poster/contraband/lizard/Initialize(mapload)
	. = ..()
	fulp_poster_override()
