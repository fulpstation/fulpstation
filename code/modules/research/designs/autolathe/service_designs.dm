/datum/design/bucket
	name = "Bucket"
	id = "bucket"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/reagent_containers/cup/bucket
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/watering_can
	name = "Watering Can"
	id = "watering_can"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/reagent_containers/cup/watering_can
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/mop
	name = "Mop"
	id = "mop"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/mop
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/broom
	name = "Push Broom"
	id = "pushbroom"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/pushbroom
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_JANITORIAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/camera
	name = "Camera"
	id = "camera"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 100)
	build_path = /obj/item/camera
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/camera_film
	name = "Camera Film Cartridge"
	id = "camera_film"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 10, /datum/material/glass = 10)
	build_path = /obj/item/camera_film
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/kitchen_knife
	name = "Kitchen Knife"
	id = "kitchen_knife"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 12000)
	build_path = /obj/item/knife/kitchen
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_knife
	name = "Plastic Knife"
	id = "plastic_knife"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 100)
	build_path = /obj/item/knife/plastic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/fork
	name = "Fork"
	id = "fork"
	build_type =  AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 80)
	build_path = /obj/item/kitchen/fork
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_fork
	name = "Plastic Fork"
	id = "plastic_fork"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 80)
	build_path = /obj/item/kitchen/fork/plastic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/spoon
	name = "Spoon"
	id = "spoon"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 120)
	build_path = /obj/item/kitchen/spoon
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_spoon
	name = "Plastic Spoon"
	id = "plastic_spoon"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 120)
	build_path = /obj/item/kitchen/spoon/plastic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/tray
	name = "Serving Tray"
	id = "servingtray"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 3000)
	build_path = /obj/item/storage/bag/tray
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plate
	name = "Plate"
	id = "plate"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 3500)
	build_path = /obj/item/plate
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/cafeteria_tray
	name = "Cafeteria Tray"
	id = "foodtray"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 3000)
	build_path = /obj/item/storage/bag/tray/cafeteria
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/bowl
	name = "Bowl"
	id = "bowl"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = 500)
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	build_path = /obj/item/reagent_containers/cup/bowl
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/drinking_glass
	name = "Drinking Glass"
	id = "drinking_glass"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = 500)
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	build_path = /obj/item/reagent_containers/cup/glass/drinkingglass
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/shot_glass
	name = "Shot Glass"
	id = "shot_glass"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = 100)
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	build_path = /obj/item/reagent_containers/cup/glass/drinkingglass/shotglass
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/shaker
	name = "Shaker"
	id = "shaker"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500)
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	build_path = /obj/item/reagent_containers/cup/glass/shaker
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/cultivator
	name = "Cultivator"
	id = "cultivator"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron=50)
	build_path = /obj/item/cultivator
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plant_analyzer
	name = "Plant Analyzer"
	id = "plant_analyzer"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 30, /datum/material/glass = 20)
	build_path = /obj/item/plant_analyzer
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/shovel
	name = "Shovel"
	id = "shovel"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 50)
	build_path = /obj/item/shovel
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_CARGO

/datum/design/spade
	name = "Spade"
	id = "spade"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 50)
	build_path = /obj/item/shovel/spade
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/hatchet
	name = "Hatchet"
	id = "hatchet"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/hatchet
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/secateurs
	name = "Secateurs"
	id = "secateurs"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/secateurs
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/radio_headset
	name = "Radio Headset"
	id = "radio_headset"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 75)
	build_path = /obj/item/radio/headset
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/bounced_radio
	name = "Station Bounced Radio"
	id = "bounced_radio"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 75, /datum/material/glass = 25)
	build_path = /obj/item/radio/off
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_TELECOMMS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/handlabeler
	name = "Hand Labeler"
	id = "handlabel"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 150, /datum/material/glass = 125)
	build_path = /obj/item/hand_labeler
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/pet_carrier
	name = "Pet Carrier"
	id = "pet_carrier"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 7500, /datum/material/glass = 100)
	build_path = /obj/item/pet_carrier
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toygun
	name = "Cap Gun"
	id = "toygun"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 100, /datum/material/glass = 50)
	build_path = /obj/item/toy/gun
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/capbox
	name = "Box of Cap Gun Shots"
	id = "capbox"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 20, /datum/material/glass = 5)
	build_path = /obj/item/toy/ammo/gun
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toy_balloon
	name = "Plastic Balloon"
	id = "toy_balloon"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 1200)
	build_path = /obj/item/toy/balloon
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toy_armblade
	name = "Plastic Armblade"
	id = "toy_armblade"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 2000)
	build_path = /obj/item/toy/foamblade
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_tree
	name = "Plastic Potted Plant"
	id = "plastic_trees"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 8000)
	build_path = /obj/item/kirbyplants/fullysynthetic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/beads
	name = "Plastic Bead Necklace"
	id = "plastic_necklace"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/clothing/neck/beads
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_ring
	name = "Plastic Can Rings"
	id = "ring_holder"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 1200)
	build_path = /obj/item/storage/cans
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/plastic_box
	name = "Plastic Box"
	id = "plastic_box"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 1000)
	build_path = /obj/item/storage/box/plastic
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/sticky_tape
	name = "Sticky Tape"
	id = "sticky_tape"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/stack/sticky_tape
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT)
	maxstack = 5
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/chisel
	name = "Chisel"
	id = "chisel"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 75)
	build_path = /obj/item/chisel
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/paperroll
	name = "Hand Labeler Paper Roll"
	id = "roll"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 25)
	build_path = /obj/item/hand_labeler_refill
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toner
	name = "Toner Cartridge"
	id = "toner"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 10, /datum/material/glass = 10)
	build_path = /obj/item/toner
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/toner/large
	name = "Toner Cartridge (Large)"
	id = "toner_large"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 35, /datum/material/glass = 35)
	build_path = /obj/item/toner/large
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/fishing_rod_basic
	name = "Fishing Rod"
	id = "fishing_rod"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200)
	build_path = /obj/item/fishing_rod
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/ticket_machine
	name = "Ticket Machine Frame"
	id = "ticket_machine"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 14000, /datum/material/glass = 8000)
	build_path = /obj/item/wallframe/ticket_machine
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/telescreen_bar
	name = "Bar Telescreen"
	id = "telescreen_bar"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = 10000,
		/datum/material/glass = 5000,
	)
	build_path = /obj/item/wallframe/telescreen/bar
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/telescreen_entertainment
	name = "Entertainment Telescreen"
	id = "telescreen_entertainment"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = 10000,
		/datum/material/glass = 5000,
	)
	build_path = /obj/item/wallframe/telescreen/entertainment
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
