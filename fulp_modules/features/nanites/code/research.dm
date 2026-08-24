/datum/techweb_node/nanite_base
	display_name = "Basic Nanite Programming"
	description = "The basics of nanite construction and programming."
	prerequisite_nodes = list(/datum/techweb_node/programming)
	unlocked_designs = list(
		/datum/design/nanite_disk,
		/datum/design/nanite_remote,
		/datum/design/nanite_comm_remote,
		/datum/design/nanite_scanner,
		"nanite_chamber",
		/datum/design/board/nanite_chamber_control,
		"nanite_programmer",
		"nanite_program_hub",
		/datum/design/board/nanite_cloud_control,
		"relay_nanites",
		"access_nanites",
		"repairing_nanites",
		"sensor_nanite_volume",
		"repeater_nanites",
		"relay_repeater_nanites",
		"red_diag_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS,
	)

/datum/techweb_node/nanite_smart
	display_name = "Smart Nanite Programming"
	description = "Nanite programs that require nanites to perform complex actions, act independently, roam or seek targets."
	prerequisite_nodes = list(
		/datum/techweb_node/nanite_base,
		/datum/techweb_node/robotics,
	)
	unlocked_designs = list(
		"purging_nanites",
		"metabolic_nanites",
		"stealth_nanites",
		"memleak_nanites",
		"sensor_voice_nanites",
		"voice_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_1_POINTS,
	)

/datum/techweb_node/nanite_mesh
	display_name = "Mesh Nanite Programming"
	description = "Nanite programs that require static structures and membranes."
	prerequisite_nodes = list(TECHWEB_NODE_NANITE_BASE, TECHWEB_NODE_PARTS_ADV)
	unlocked_designs = list(
		"hardening_nanites",
		"dermal_button_nanites",
		"refractive_nanites",
		"cryo_nanites",
		"conductive_nanites",
		"shock_nanites",
		"emp_nanites",
		"temperature_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_1_POINTS,
	)

/datum/techweb_node/nanite_bio
	display_name = "Biological Nanite Programming"
	description = "Nanite programs that require complex biological interaction."
	prerequisite_nodes = list(
		/datum/techweb_node/nanite_base,
		/datum/techweb_node/medbay_equip,
	)
	unlocked_designs = list(
		"regenerative_nanites",
		"bloodheal_nanites",
		"coagulating_nanites",
		"poison_nanites",
		"flesheating_nanites",
		"sensor_crit_nanites",
		"sensor_death_nanites",
		"sensor_health_nanites",
		"sensor_damage_nanites",
		"sensor_species_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_1_POINTS,
	)

/datum/techweb_node/nanite_neural
	display_name = "Neural Nanite Programming"
	description = "Nanite programs affecting nerves and brain matter."
	prerequisite_nodes = list(/datum/techweb_node/nanite_bio)
	unlocked_designs = list(
		"nervous_nanites",
		"brainheal_nanites",
		"paralyzing_nanites",
		"stun_nanites",
		"selfscan_nanites",
		"good_mood_nanites",
		"bad_mood_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_2_POINTS,
	)

/datum/techweb_node/nanite_synaptic
	display_name = "Synaptic Nanite Programming"
	description = "Nanite programs affecting mind and thoughts."
	prerequisite_nodes = list(
		/datum/techweb_node/nanite_neural,
		/datum/techweb_node/passive_implants,
	)
	unlocked_designs = list(
		"mindshield_nanites",
		"pacifying_nanites",
		"blinding_nanites",
		"sleep_nanites",
		"mute_nanites",
		"speech_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_2_POINTS,
	)

/datum/techweb_node/nanite_harmonic
	display_name = "Harmonic Nanite Programming"
	description = "Nanite programs that require seamless integration between nanites and biology."
	prerequisite_nodes = list(
		/datum/techweb_node/nanite_bio,
		/datum/techweb_node/nanite_smart,
		/datum/techweb_node/nanite_mesh,
	)
	unlocked_designs = list(
		"fakedeath_nanites",
		"aggressive_nanites",
		"defib_nanites",
		"regenerative_plus_nanites",
		"brainheal_plus_nanites",
		"purging_plus_nanites",
		"adrenaline_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_4_POINTS,
	)

/datum/techweb_node/nanite_combat
	display_name = "Military Nanite Programming"
	description = "Nanite programs that perform military-grade functions."
	prerequisite_nodes = list(
		/datum/techweb_node/nanite_harmonic,
		/datum/techweb_node/syndicate_basic,
	)
	unlocked_designs = list(
		"explosive_nanites",
		"pyro_nanites",
		"meltdown_nanites",
		"viral_nanites",
		"nanite_sting_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_3_POINTS,
	)

/datum/techweb_node/nanite_hazard
	display_name = "Hazard Nanite Programs"
	description = "Extremely advanced Nanite programs with the potential of being extremely dangerous."
	prerequisite_nodes = list(
		/datum/techweb_node/nanite_harmonic,
		/datum/techweb_node/alien/base,
	)
	unlocked_designs = list(
		"spreading_nanites",
		"mindcontrol_nanites",
		"mitosis_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_5_POINTS,
	)

/datum/techweb_node/nanite_replication_protocols
	display_name = "Nanite Replication Protocols"
	description = "Advanced behaviours that allow nanites to exploit certain circumstances to replicate faster."
	prerequisite_nodes = list(/datum/techweb_node/nanite_smart)
	unlocked_designs = list(
		"kickstart_nanites",
		"factory_nanites",
		"tinker_nanites",
		"offline_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_3_POINTS,
	)
	hidden = TRUE
	experimental = TRUE

/datum/techweb_node/nanite_storage_protocols
	display_name = "Nanite Storage Protocols"
	description = "Protocols that overwrite the default nanite storage routine to achieve more efficiency or greater capacity."
	prerequisite_nodes = list(/datum/techweb_node/nanite_smart)
	unlocked_designs = list(
		"free_range_nanites",
		"hive_nanites",
		"unsafe_storage_nanites",
		"zip_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_3_POINTS,
	)
	hidden = TRUE
	experimental = TRUE
