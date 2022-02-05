/obj/machinery/computer/cargo/request/prison
	name = "prison supply console"
	desc = "Used to request supplies from cargo."
	icon_screen = "request"
	circuit = /obj/item/circuitboard/computer/cargo

	contraband = TRUE
	///The account this console processes and displays. Independent from the account the shuttle processes.
	cargo_account = ACCOUNT_PRISON

/obj/item/circuitboard/computer/cargo/request/prison
	name = "Prison Supply Rquests Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/cargo/request/prison
	contraband = TRUE
