MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/broadcaster_perma, 26)

GLOBAL_LIST_EMPTY(prison_broadcasters)

/obj/item/radio/intercom/broadcaster_perma
	icon = 'fulp_modules/features/prison/icons/radio.dmi'
	icon_state = "broadcaster"
	name = "shuttle announcer"
	desc = "Makes announcements when a Permabrig shuttle arrives."
	prison_radio = TRUE

/obj/item/radio/intercom/broadcaster_perma/Initialize(mapload, ndir, building)
	. = ..()
	GLOB.prison_broadcasters += src

/obj/item/radio/intercom/broadcaster_perma/Destroy()
	GLOB.prison_broadcasters -= src
	. = ..()

