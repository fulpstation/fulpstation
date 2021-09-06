
/////////////////////////////////////////
/////////////////Mining//////////////////
/////////////////////////////////////////
/datum/design/cargo_express
	name = "Computer Design (Express Supply Console)"//shes beautiful
	desc = "Allows for the construction of circuit boards used to build an Express Supply Console."//who?
	id = "cargoexpress"//the coder reading this
	build_type = IMPRINTER
	materials = list(/datum/material/glass = 1000)
	build_path = /obj/item/circuitboard/computer/cargo/express
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/bluespace_pod
	name = "Supply Drop Pod Upgrade Disk"
	desc = "Allows the Cargo Express Console to call down the Bluespace Drop Pod, greatly increasing user safety."//who?
	id = "bluespace_pod"//the coder reading this
	build_type = PROTOLATHE
	materials = list(/datum/material/glass = 1000)
	build_path = /obj/item/disk/cargo/bluespace_pod
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/drill
	name = "Mining Drill"
	desc = "Yours is the drill that will pierce through the rock walls."
	id = "drill"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 6000, /datum/material/glass = 1000) //expensive, but no need for miners.
	build_path = /obj/item/pickaxe/drill
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/drill_diamond
	name = "Diamond-Tipped Mining Drill"
	desc = "Yours is the drill that will pierce the heavens!"
	id = "drill_diamond"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 6000, /datum/material/glass = 1000, /datum/material/diamond = 2000) //Yes, a whole diamond is needed.
	build_path = /obj/item/pickaxe/drill/diamonddrill
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/plasmacutter
	name = "Plasma Cutter"
	desc = "You could use it to cut limbs off of xenos! Or, you know, mine stuff."
	id = "plasmacutter"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500, /datum/material/glass = 500, /datum/material/plasma = 400)
	build_path = /obj/item/gun/energy/plasmacutter
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/plasmacutter_adv
	name = "Advanced Plasma Cutter"
	desc = "It's an advanced plasma cutter, oh my god."
	id = "plasmacutter_adv"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 1000, /datum/material/plasma = 2000, /datum/material/gold = 500)
	build_path = /obj/item/gun/energy/plasmacutter/adv
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/jackhammer
	name = "Sonic Jackhammer"
	desc = "Essentially a handheld planet-cracker. Can drill through walls with ease as well."
	id = "jackhammer"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 6000, /datum/material/glass = 2000, /datum/material/silver = 2000, /datum/material/diamond = 6000)
	build_path = /obj/item/pickaxe/drill/jackhammer
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/superresonator
	name = "Upgraded Resonator"
	desc = "An upgraded version of the resonator that allows more fields to be active at once."
	id = "superresonator"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 4000, /datum/material/glass = 1500, /datum/material/silver = 1000, /datum/material/uranium = 1000)
	build_path = /obj/item/resonator/upgraded
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO
