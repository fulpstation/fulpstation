GLOBAL_LIST_EMPTY(prison_broadcasters)

/obj/item/radio/intercom/prison
	icon = 'fulp_modules/features/prison/icons/radio.dmi'
	icon_state = "broadcaster"
	prison_radio = TRUE

/obj/item/radio/intercom/prison/Initialize(mapload, ndir, building)
	. = ..()
	GLOB.prison_broadcasters += src

/obj/item/radio/intercom/prison/Destroy()
	GLOB.prison_broadcasters -= src
	return ..()

