/obj/machinery/modular_computer/console/preset/prison
	name = "Prison Order Console"
	var/obj/item/computer_hardware/card_slot/id_slot

/obj/machinery/modular_computer/console/preset/prison/install_programs()
	var/obj/item/computer_hardware/hard_drive/hard_drive = cpu.all_components[MC_HDD]
	hard_drive.store_file(new/datum/computer_file/program/budgetorders/prison())

/obj/machinery/modular_computer/console/preset/prison/Initialize(mapload)
	. = ..()
	id_slot = cpu.all_components[MC_CARD]
	id_slot.stored_card = new /obj/item/card/id/departmental_budget/prison

/obj/item/card/id/departmental_budget/prison
	name = "prison budget card"
	desc = "Provides access to the prison budget."
	department_ID = ACCOUNT_PRISON
	department_name = ACCOUNT_PRISON_NAME

/obj/item/card/id/departmental_budget/prison/Initialize()
	. = ..()
	registered_account?.account_job = /datum/job/prisoner

/datum/computer_file/program/budgetorders/prison
	filename = "orderapp-p"
	filedesc = "NT IRN Prison Edition"
	extended_desc = "Nanotrasen Internal Requisition Network interface for designed for supply orders to individuals under penal punishment."
	usage_flags = PROGRAM_CONSOLE
	available_on_ntnet = FALSE

/datum/controller/subsystem/economy/Initialize(timeofday)
	department_accounts += list(ACCOUNT_PRISON = ACCOUNT_PRISON_NAME)
	. = ..()
