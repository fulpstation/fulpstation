/datum/techweb_node/nanite_base
	id = "nanite_base"
	display_name = "Basic Nanite Programming"
	description = "The basics of nanite construction and programming."
	prereq_ids = list("datatheory")
	design_ids = list(
		"nanite_disk",
		"nanite_remote",
		"nanite_comm_remote",
		"nanite_scanner",
		"nanite_chamber",
		"nanite_chamber_control",
		"nanite_programmer",
		"nanite_program_hub",
		"nanite_cloud_control",
		"relay_nanites",
		"access_nanites",
		"repairing_nanites",
		"sensor_nanite_volume",
		"repeater_nanites",
		"relay_repeater_nanites",
		"red_diag_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 1000,
	)

/datum/techweb_node/nanite_smart
	id = "nanite_smart"
	display_name = "Smart Nanite Programming"
	description = "Nanite programs that require nanites to perform complex actions, act independently, roam or seek targets."
	prereq_ids = list(
		"nanite_base",
		"robotics",
	)
	design_ids = list(
		"purging_nanites",
		"metabolic_nanites",
		"stealth_nanites",
		"memleak_nanites",
		"sensor_voice_nanites",
		"voice_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 750,
		TECHWEB_POINT_TYPE_NANITES = 500,
	)

/datum/techweb_node/nanite_mesh
	id = "nanite_mesh"
	display_name = "Mesh Nanite Programming"
	description = "Nanite programs that require static structures and membranes."
	prereq_ids = list(
		"nanite_base",
		"engineering",
	)
	design_ids = list(
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
		TECHWEB_POINT_TYPE_GENERIC = 750,
		TECHWEB_POINT_TYPE_NANITES = 500,
	)

/datum/techweb_node/nanite_bio
	id = "nanite_bio"
	display_name = "Biological Nanite Programming"
	description = "Nanite programs that require complex biological interaction."
	prereq_ids = list(
		"nanite_base",
		"biotech",
	)
	design_ids = list(
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
		TECHWEB_POINT_TYPE_GENERIC = 750,
		TECHWEB_POINT_TYPE_NANITES = 500,
	)

/datum/techweb_node/nanite_neural
	id = "nanite_neural"
	display_name = "Neural Nanite Programming"
	description = "Nanite programs affecting nerves and brain matter."
	prereq_ids = list("nanite_bio")
	design_ids = list(
		"nervous_nanites",
		"brainheal_nanites",
		"paralyzing_nanites",
		"stun_nanites",
		"selfscan_nanites",
		"good_mood_nanites",
		"bad_mood_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 1500,
		TECHWEB_POINT_TYPE_NANITES = 1000,
	)

/datum/techweb_node/nanite_synaptic
	id = "nanite_synaptic"
	display_name = "Synaptic Nanite Programming"
	description = "Nanite programs affecting mind and thoughts."
	prereq_ids = list(
		"nanite_neural",
		"neural_programming",
	)
	design_ids = list(
		"mindshield_nanites",
		"pacifying_nanites",
		"blinding_nanites",
		"sleep_nanites",
		"mute_nanites",
		"speech_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 1500,
		TECHWEB_POINT_TYPE_NANITES = 1000,
	)

/datum/techweb_node/nanite_harmonic
	id = "nanite_harmonic"
	display_name = "Harmonic Nanite Programming"
	description = "Nanite programs that require seamless integration between nanites and biology."
	prereq_ids = list(
		"nanite_bio",
		"nanite_smart",
		"nanite_mesh",
	)
	design_ids = list(
		"fakedeath_nanites",
		"aggressive_nanites",
		"defib_nanites",
		"regenerative_plus_nanites",
		"brainheal_plus_nanites",
		"purging_plus_nanites",
		"adrenaline_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 2750,
		TECHWEB_POINT_TYPE_NANITES = 3000,
	)

/datum/techweb_node/nanite_combat
	id = "nanite_military"
	display_name = "Military Nanite Programming"
	description = "Nanite programs that perform military-grade functions."
	prereq_ids = list(
		"nanite_harmonic",
		"syndicate_basic",
	)
	design_ids = list(
		"explosive_nanites",
		"pyro_nanites",
		"meltdown_nanites",
		"viral_nanites",
		"nanite_sting_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 3500,
		TECHWEB_POINT_TYPE_NANITES = 2500,
	)

/datum/techweb_node/nanite_hazard
	id = "nanite_hazard"
	display_name = "Hazard Nanite Programs"
	description = "Extremely advanced Nanite programs with the potential of being extremely dangerous."
	prereq_ids = list(
		"nanite_harmonic",
		"alientech",
	)
	design_ids = list(
		"spreading_nanites",
		"mindcontrol_nanites",
		"mitosis_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 3500,
		TECHWEB_POINT_TYPE_NANITES = 4000,
	)

/datum/techweb_node/nanite_replication_protocols
	id = "nanite_replication_protocols"
	display_name = "Nanite Replication Protocols"
	description = "Advanced behaviours that allow nanites to exploit certain circumstances to replicate faster."
	prereq_ids = list("nanite_smart")
	design_ids = list(
		"kickstart_nanites",
		"factory_nanites",
		"tinker_nanites",
		"offline_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 2000,
		TECHWEB_POINT_TYPE_NANITES = 2500,
	)
	hidden = TRUE
	experimental = TRUE

/datum/techweb_node/nanite_storage_protocols
	id = "nanite_storage_protocols"
	display_name = "Nanite Storage Protocols"
	description = "Protocols that overwrite the default nanite storage routine to achieve more efficiency or greater capacity."
	prereq_ids = list("nanite_smart")
	design_ids = list(
		"free_range_nanites",
		"hive_nanites",
		"unsafe_storage_nanites",
		"zip_nanites",
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = 1000,
		TECHWEB_POINT_TYPE_NANITES = 2500,
	)
	hidden = TRUE
	experimental = TRUE
