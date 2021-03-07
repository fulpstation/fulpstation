// Base
/obj/item/modular_computer/tablet/preset/fulp
	icon = 'fulp_modules/tablet/tablet.dmi'
	icon_state = "tablet-white"
	has_variants = FALSE

/obj/item/modular_computer/tablet/preset/fulp/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(new /obj/item/computer_hardware/hard_drive/small)
	install_component(new /obj/item/computer_hardware/network_card)

/obj/item/modular_computer/tablet/preset/fulp/update_overlays()
	// /obj/item/modular_computer/update_overlays() returns early if !display_overlays, allowing us to bypass it
	var/temp = display_overlays
	display_overlays = FALSE
	. = ..()
	display_overlays = temp

	if(!display_overlays)
		return

	if(enabled)
		var/icostate = icon_state_menu
		if(active_program)
			icostate = active_program.program_icon_state ? active_program.program_icon_state : icon_state_menu
		else
			icostate = icon_state_menu
		. += image('icons/obj/modular_tablet.dmi', icon_state=icostate)

	if(obj_integrity <= integrity_failure * max_integrity)
		. += "bsod"
		. += "broken"

// Engineer
/obj/item/modular_computer/tablet/preset/fulp/engi
	name = "engineering tablet"
	icon_state = "tablet-engi"

/obj/item/modular_computer/tablet/preset/fulp/engi/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/sensorpackage)

	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/alarm_monitor)
	hard_drive.store_file(new /datum/computer_file/program/supermatter_monitor)

// Atmos
/obj/item/modular_computer/tablet/preset/fulp/engi/atmos
	name = "atmospherics tablet"
	icon_state = "tablet-atmos"

/obj/item/modular_computer/tablet/preset/fulp/engi/atmos/Initialize()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/atmosscan)

// CE
/obj/item/modular_computer/tablet/preset/fulp/engi/chief
	name = "chief engineer's tablet"
	icon_state = "tablet-chief"

/obj/item/modular_computer/tablet/preset/fulp/engi/chief/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/card_slot)
	install_component(new /obj/item/computer_hardware/card_slot/secondary)
	install_component(new /obj/item/computer_hardware/printer/mini)

	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/atmosscan)
	hard_drive.store_file(new /datum/computer_file/program/budgetorders)
	hard_drive.store_file(new /datum/computer_file/program/card_mod)
	hard_drive.store_file(new /datum/computer_file/program/crew_manifest)

// Outfit
/datum/outfit/job/engineer/backpack_contents = list(/obj/item/modular_computer/tablet/preset/fulp/engi=1)
/datum/outfit/job/atmos/backpack_contents = list(/obj/item/modular_computer/tablet/preset/fulp/engi/atmos=1)
/datum/outfit/job/ce/backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/fulp/engi/chief=1)
