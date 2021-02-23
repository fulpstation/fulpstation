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
