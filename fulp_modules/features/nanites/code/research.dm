/datum/techweb_node/nanite_base
	display_name = "Basic Nanite Programming"
	description = "The basics of nanite construction and programming."
	prerequisite_nodes = list(/datum/techweb_node/programming)
	unlocked_designs = list(
		/datum/design/nanite_disk,
		/datum/design/nanite_remote,
		/datum/design/nanite_comm_remote,
		/datum/design/nanite_scanner,
		/datum/design/board/nanite_chamber,
		/datum/design/board/nanite_chamber_control,
		/datum/design/board/nanite_programmer,
		/datum/design/board/nanite_program_hub,
		/datum/design/board/nanite_cloud_control,
		/datum/design/nanites/relay,
		/datum/design/nanites/access,
		/datum/design/nanites/repairing,
		/datum/design/nanites/sensor_nanite_volume,
		/datum/design/nanites/repeater,
		/datum/design/nanites/relay_repeater,
		/datum/design/nanites/reduced_diagnostics,
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
		/datum/design/nanites/purging,
		/datum/design/nanites/metabolic_synthesis,
		/datum/design/nanites/stealth,
		/datum/design/nanites/memory_leak,
		/datum/design/nanites/sensor_voice,
		/datum/design/nanites/voice,
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_1_POINTS,
	)

/datum/techweb_node/nanite_mesh
	display_name = "Mesh Nanite Programming"
	description = "Nanite programs that require static structures and membranes."
	prerequisite_nodes = list(
		/datum/techweb_node/nanite_base,
		/datum/techweb_node/parts_adv,
	)
	unlocked_designs = list(
		/datum/design/nanites/hardening,
		/datum/design/nanites/dermal_button,
		/datum/design/nanites/refractive,
		/datum/design/nanites/cryo,
		/datum/design/nanites/conductive,
		/datum/design/nanites/shock,
		/datum/design/nanites/emp,
		/datum/design/nanites/temperature,
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
		/datum/design/nanites/regenerative,
		/datum/design/nanites/blood_restoring,
		/datum/design/nanites/coagulating,
		/datum/design/nanites/poison,
		/datum/design/nanites/flesh_eating,
		/datum/design/nanites/sensor_crit,
		/datum/design/nanites/sensor_death,
		/datum/design/nanites/sensor_health,
		/datum/design/nanites/sensor_damage,
		/datum/design/nanites/sensor_species,
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
		/datum/design/nanites/nervous,
		/datum/design/nanites/brain_heal,
		/datum/design/nanites/paralyzing,
		/datum/design/nanites/stun,
		/datum/design/nanites/self_scan,
		/datum/design/nanites/good_mood,
		/datum/design/nanites/bad_mood,
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
		/datum/design/nanites/mindshield,
		/datum/design/nanites/pacifying,
		/datum/design/nanites/blinding,
		/datum/design/nanites/sleepy,
		/datum/design/nanites/mute,
		/datum/design/nanites/speech,
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
		/datum/design/nanites/fake_death,
		/datum/design/nanites/aggressive_replication,
		/datum/design/nanites/defib,
		/datum/design/nanites/regenerative_advanced,
		/datum/design/nanites/brain_heal_advanced,
		/datum/design/nanites/purging_advanced,
		/datum/design/nanites/adrenaline,
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
		/datum/design/nanites/explosive,
		/datum/design/nanites/pyro,
		/datum/design/nanites/meltdown,
		/datum/design/nanites/viral,
		/datum/design/nanites/nanite_sting,
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
		/datum/design/nanites/spreading,
		/datum/design/nanites/mind_control,
		/datum/design/nanites/mitosis,
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_5_POINTS,
	)

/datum/techweb_node/nanite_replication_protocols
	display_name = "Nanite Replication Protocols"
	description = "Advanced behaviours that allow nanites to exploit certain circumstances to replicate faster."
	node_flags = parent_type::node_flags | TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL
	prerequisite_nodes = list(/datum/techweb_node/nanite_smart)
	unlocked_designs = list(
		/datum/design/nanites/kickstart,
		/datum/design/nanites/factory,
		/datum/design/nanites/tinker,
		/datum/design/nanites/offline,
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_3_POINTS,
	)

/datum/techweb_node/nanite_storage_protocols
	display_name = "Nanite Storage Protocols"
	description = "Protocols that overwrite the default nanite storage routine to achieve more efficiency or greater capacity."
	node_flags = parent_type::node_flags | TECHWEB_NODE_HIDDEN | TECHWEB_NODE_EXPERIMENTAL
	prerequisite_nodes = list(/datum/techweb_node/nanite_smart)
	unlocked_designs = list(
		/datum/design/nanites/free_range,
		/datum/design/nanites/hive,
		/datum/design/nanites/unsafe_storage,
		/datum/design/nanites/zip,
	)
	research_costs = list(
		TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS,
		TECHWEB_POINT_TYPE_NANITES = TECHWEB_TIER_3_POINTS,
	)
