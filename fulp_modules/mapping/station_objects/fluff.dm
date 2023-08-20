/// Old nanite machinery.
/obj/structure/showcase/machinery/nanite_programmer
	name = "nanite programmer"
	desc = "An ancient, decommissioned nanite programmer, designed to adjust the functionality of nanite program disks."
	icon = 'fulp_modules/mapping/icons/research.dmi'
	icon_state = "nanite_programmer"

/obj/structure/showcase/machinery/nanite_programmer/Initialize(mapload)
	. = ..()
	become_hearing_sensitive(trait_source = ROUNDSTART_TRAIT)

/obj/structure/showcase/machinery/nanite_programmer/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list(), message_range = 0)
	. = ..()
	var/static/regex/when = regex("(?:^\\W*when|when\\W*$)", "i") //starts or ends with when
	if(findtext(raw_message, when) && !istype(speaker, /obj/structure/showcase/machinery/nanite_programmer))
		say("When you code it!!")

/obj/structure/showcase/machinery/nanite_cloud_controller
	name = "nanite cloud controller"
	desc = "A decommissioned cloud controller, lost to time. Previously used to store and control nanite cloud backups."
	icon = 'fulp_modules/mapping/icons/research.dmi'
	icon_state = "nanite_cloud_controller"

/obj/structure/showcase/machinery/nanite_program_hub
	name = "nanite program hub"
	desc = "A non-functional nanite program hub. Compiled nanite programs from the techweb and downloaded them onto disks."
	icon = 'fulp_modules/mapping/icons/research.dmi'
	icon_state = "nanite_program_hub"

/obj/structure/showcase/machinery/nanite_chamber
	name = "nanite chamber"
	desc = "A nanite chamber, meant to inject nanites onto an user. This one has been decommissioned."
	icon = 'fulp_modules/mapping/icons/research.dmi'
	icon_state = "nanite_chamber"
