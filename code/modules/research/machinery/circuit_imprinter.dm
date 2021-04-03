/obj/machinery/rnd/production/circuit_imprinter
	name = "circuit imprinter"
	desc = "Manufactures circuit boards for the construction of machines."
	icon_state = "circuit_imprinter"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter
	categories = list(
								"AI Modules",
								"Computer Boards",
								"Teleportation Machinery",
								"Medical Machinery",
								"Engineering Machinery",
								"Exosuit Modules",
								"Hydroponics Machinery",
								"Subspace Telecomms",
								"Research Machinery",
								"Misc. Machinery",
								"Computer Parts"
								)
	production_animation = "circuit_imprinter_ani"
	allowed_buildtypes = IMPRINTER

/obj/machinery/rnd/production/circuit_imprinter/calculate_efficiency()
	. = ..()
	var/total_rating = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		total_rating += M.rating * 2 //There is only one.
	total_rating = max(1, total_rating)
	efficiency_coeff = total_rating

/obj/machinery/rnd/production/circuit_imprinter/offstation
	name = "ancient circuit imprinter"
	desc = "Manufactures circuit boards for the construction of machines. Its ancient construction may limit its ability to print all known technology."
	allowed_buildtypes = AWAY_IMPRINTER
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/offstation
