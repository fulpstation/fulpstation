// Aquarium related signals
#define COMSIG_AQUARIUM_SURFACE_CHANGED "aquarium_surface_changed"
#define COMSIG_AQUARIUM_FLUID_CHANGED "aquarium_fluid_changed"
///Called on aquarium/attackby: (aquarium)
#define COMSIG_TRY_INSERTING_IN_AQUARIUM "item_try_inserting_in_aquarium"
	///The item will be inserted into the aquarium
	#define COMSIG_CAN_INSERT_IN_AQUARIUM (1<<0)
	///The item won't be inserted into the aquarium, but will early return attackby anyway.
	#define COMSIG_CANNOT_INSERT_IN_AQUARIUM (1<<1)

///Updates the appearance of a newly generated aquarium content visual:(visual)
#define COMSIG_AQUARIUM_CONTENT_GENERATE_APPEARANCE "aquarium_content_apply_appearance"
///Updates the base position of an aquarium content visual:(aquarium, visual)
#define AQUARIUM_CONTENT_RANDOMIZE_POSITION "aquarium_content_randomize_position"
///Updates the animation of an aquarium content visual:(aquarium, visual)
#define COMSIG_AQUARIUM_CONTENT_DO_ANIMATION "aquarium_content_do_animation"

// Fish signals
#define COMSIG_FISH_STATUS_CHANGED "fish_status_changed"
#define COMSIG_FISH_STIRRED "fish_stirred"
///From /obj/item/fish/process: (seconds_per_tick)
#define COMSIG_FISH_LIFE "fish_life"
///From /datum/fish_trait/eat_fish: (predator)
#define COMSIG_FISH_EATEN_BY_OTHER_FISH "fish_eaten_by_other_fish"
///From /obj/item/fish/generate_reagents_to_add, which returns a holder when the fish is eaten or composted for example: (list/reagents)
#define COMSIG_GENERATE_REAGENTS_TO_ADD "generate_reagents_to_add"
///From /obj/item/fish/update_size_and_weight: (new_size, new_weight)
#define COMSIG_FISH_UPDATE_SIZE_AND_WEIGHT "fish_update_size_and_weight"
///From /obj/item/fish/update_fish_force: (weight_rank, bonus_malus)
#define COMSIG_FISH_FORCE_UPDATED "fish_force_updated"

///From /obj/item/fish/interact_with_atom_secondary, sent to the target: (fish)
#define COMSIG_FISH_RELEASED_INTO "fish_released_into"

///From /datum/fishing_challenge/New: (datum/fishing_challenge/challenge)
#define COMSIG_MOB_BEGIN_FISHING "mob_begin_fishing"
///From /datum/fishing_challenge/start_minigame_phase: (datum/fishing_challenge/challenge)
#define COMSIG_MOB_BEGIN_FISHING_MINIGAME "mob_begin_fishing_minigame"
///From /datum/fishing_challenge/completed: (datum/fishing_challenge/challenge, win)
#define COMSIG_MOB_COMPLETE_FISHING "mob_complete_fishing"

/// Rolling a reward path for a fishing challenge
#define COMSIG_FISHING_CHALLENGE_ROLL_REWARD "fishing_roll_reward"
/// Adjusting the difficulty of a rishing challenge, often based on the reward path
#define COMSIG_FISHING_CHALLENGE_GET_DIFFICULTY "fishing_get_difficulty"
/// Fishing challenge completed
/// Sent to the fisherman when the reward is dispensed: (reward)
#define COMSIG_FISH_SOURCE_REWARD_DISPENSED "fish_source_reward_dispensed"

/// Called when you try to use fishing rod on anything
#define COMSIG_PRE_FISHING "pre_fishing"

/// Called when an ai-controlled mob interacts with the fishing spot
#define COMSIG_NPC_FISHING "npc_fishing"
	#define NPC_FISHING_SPOT 1

/// Sent by the target of the fishing rod cast
#define COMSIG_FISHING_ROD_CAST "fishing_rod_cast"
	#define FISHING_ROD_CAST_HANDLED (1 << 0)

/// From /datum/fish_source/proc/dispense_reward(), not set if the reward is a dud: (reward, user)
#define COMSIG_FISHING_ROD_CAUGHT_FISH "fishing_rod_caught_fish"
/// From /obj/item/fishing_rod/proc/hook_item(): (reward, user)
#define COMSIG_FISHING_ROD_HOOKED_ITEM "fishing_rod_hooked_item"
/// From /datum/fish_source/proc/use_slot(), sent to the slotted item: (obj/item/fishing_rod/rod)
#define COMSIG_FISHING_EQUIPMENT_SLOTTED "fishing_equipment_slotted"

/// Sent when the challenge is to be interrupted: (reason)
#define COMSIG_FISHING_SOURCE_INTERRUPT_CHALLENGE "fishing_spot_interrupt_challenge"

/// From /obj/item/fish_analyzer/proc/analyze_status: (fish, user)
#define COMSIG_FISH_ANALYZER_ANALYZE_STATUS "fish_analyzer_analyze_status"

/// From /datum/component/fish_growth/on_fish_life: (seconds_per_tick)
#define COMSIG_FISH_BEFORE_GROWING "fish_before_growing"
	#define COMPONENT_DONT_GROW (1 << 0)
/// From /datum/component/fish_growth/finish_growing: (result)
#define COMSIG_FISH_FINISH_GROWING "fish_finish_growing"
