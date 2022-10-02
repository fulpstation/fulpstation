////////////////////////////////////////
///////////Computer Parts///////////////
////////////////////////////////////////

/datum/design/disk/normal
	name = "Hard Disk Drive"
	id = "hdd_basic"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 400, /datum/material/glass = 100)
	build_path = /obj/item/computer_hardware/hard_drive
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/disk/advanced
	name = "Advanced Hard Disk Drive"
	id = "hdd_advanced"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 800, /datum/material/glass = 200)
	build_path = /obj/item/computer_hardware/hard_drive/advanced
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/disk/super
	name = "Super Hard Disk Drive"
	id = "hdd_super"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1600, /datum/material/glass = 400)
	build_path = /obj/item/computer_hardware/hard_drive/super
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/disk/cluster
	name = "Cluster Hard Disk Drive"
	id = "hdd_cluster"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 3200, /datum/material/glass = 800)
	build_path = /obj/item/computer_hardware/hard_drive/cluster
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/disk/small
	name = "Solid State Drive"
	id = "ssd_small"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 800, /datum/material/glass = 200)
	build_path = /obj/item/computer_hardware/hard_drive/small
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/disk/micro
	name = "Micro Solid State Drive"
	id = "ssd_micro"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 400, /datum/material/glass = 100)
	build_path = /obj/item/computer_hardware/hard_drive/micro
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

// Data disks
/datum/design/portabledrive/basic
	name = "Data Disk"
	id = "portadrive_basic"
	build_type = IMPRINTER | AWAY_IMPRINTER
	materials = list(/datum/material/glass = 800)
	build_path = /obj/item/computer_hardware/hard_drive/portable
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/portabledrive/advanced
	name = "Advanced Data Disk"
	id = "portadrive_advanced"
	build_type = IMPRINTER | AWAY_IMPRINTER
	materials = list(/datum/material/glass = 1600)
	build_path = /obj/item/computer_hardware/hard_drive/portable/advanced
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/portabledrive/super
	name = "Super Data Disk"
	id = "portadrive_super"
	build_type = IMPRINTER | AWAY_IMPRINTER
	materials = list(/datum/material/glass = 3200)
	build_path = /obj/item/computer_hardware/hard_drive/portable/super
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

// Card slot
/datum/design/cardslot
	name = "ID Card Slot"
	id = "cardslot"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 600)
	build_path = /obj/item/computer_hardware/card_slot
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

// Batteries
/datum/design/battery/controller
	name = "Power Cell Controller"
	id = "bat_control"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 400)
	build_path = /obj/item/computer_hardware/battery
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/battery/normal
	name = "Battery Module"
	id = "bat_normal"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 400)
	build_path = /obj/item/stock_parts/cell/computer
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/battery/advanced
	name = "Advanced Battery Module"
	id = "bat_advanced"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 800)
	build_path = /obj/item/stock_parts/cell/computer/advanced
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/battery/super
	name = "Super Battery Module"
	id = "bat_super"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1600)
	build_path = /obj/item/stock_parts/cell/computer/super
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/battery/nano
	name = "Nano Battery Module"
	id = "bat_nano"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/stock_parts/cell/computer/nano
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/battery/micro
	name = "Micro Battery Module"
	id = "bat_micro"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 400)
	build_path = /obj/item/stock_parts/cell/computer/micro
	category = list(RND_CATEGORY_COMPUTER_PARTS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
