/// Manager for the lost crew bodies, for spawning and granting rewards
GLOBAL_DATUM_INIT(lost_crew_manager, /datum/lost_crew_manager, new)

/// Handles procs and timers for the lost crew bodies
/datum/lost_crew_manager
	/// How many credits we reward the medical budget on a succesful revive
	var/credits_on_succes = /datum/supply_pack/medical/lost_crew::cost + CARGO_CRATE_VALUE * 2
	/// How long after succesful revival we check to see if theyre still alive, and give rewards
	var/succes_check_time = 3 MINUTES
	/// How much the revived crew start with on their cards
	var/starting_funds = 100

/**
 * Creates a body with random background and injuries
 *
 * Arguments:
 * * revivable - Whether or not we can be revived to grand a ghost controle
 * * forced_class - To force a specific damage class for some specific lore reason
 * * recovered_items - Items recovered, such as some organs, dropped directly with the body
 * * protected_items - Items that can only be recovered by the revived player
 * * body_data - Debug data we can use to get a readout of what has been done
 */
/datum/lost_crew_manager/proc/create_lost_crew(revivable = TRUE, datum/corpse_damage_class/forced_class, list/recovered_items, list/protected_items, list/body_data = list())
	var/mob/living/carbon/human/new_body = new(null)
	new_body.death()

	var/static/list/scenarios = list()
	if(!scenarios.len)
		var/list/types = subtypesof(/datum/corpse_damage_class)
		for(var/datum/corpse_damage_class/scenario as anything in types)
			scenarios[scenario] = initial(scenario.weight)

	var/list/datum/callback/on_revive_and_player_occupancy = list()

	var/datum/corpse_damage_class/scenario = forced_class || pick_weight(scenarios)
	scenario = new scenario ()

	scenario.apply_character(new_body, protected_items, on_revive_and_player_occupancy, body_data)
	scenario.apply_injuries(new_body, recovered_items, on_revive_and_player_occupancy, body_data)
	scenario.death_lore += "I should get a formalized assignment!"

	. = new_body
	// so bodies can also be used for runes, morgue, etc
	if(!revivable)
		return

	//it's not necessary since we dont spawn the body until we open the bodybag, but why not be nice for once
	new_body.reagents.add_reagent(/datum/reagent/toxin/formaldehyde, 5)

	if(!recovered_items)
		return

	var/obj/item/paper/paper = new()
	recovered_items += paper

	if(!HAS_TRAIT(new_body, TRAIT_HUSK))
		paper.name = "DO NOT REMOVE BRAIN"
		paper.add_raw_text("Body swapping is not covered by medical insurance for unhusked bodies. Chemical brain explosives have been administered to enforce stipend.")
		var/obj/item/organ/internal/brain/boombrain = new_body.get_organ_by_type(/obj/item/organ/internal/brain)
		//I swear to fuck I will explode you. you're not clever
		//everyone thought of this, but I am the fool for having any faith
		//in people actually wanting to play the job in an interesting manner
		//instead of just taking the easiest way out and learning nothing
		//(no one abused it yet but I am already getting pinged by people who think they've broken the system when really I just expected better of them)
		boombrain.AddElement(/datum/element/dangerous_organ_removal)
	else
		paper.name = "BODYSWAPPING PERMITTED"
		paper.add_raw_text("Body swapping is covered by medical insurance in case of husking and a lack of skill in the practictioner.")

	var/obj/item/organ/internal/brain/hersens = new_body.get_organ_by_type(/obj/item/organ/internal/brain)
	hersens.AddComponent(
		/datum/component/ghostrole_on_revive, \
		/* refuse_revival_if_failed = */ TRUE, \
		/*on_revival = */ CALLBACK(src, PROC_REF(on_succesful_revive), hersens, scenario.death_lore, on_revive_and_player_occupancy) \
	)

/// Set a timer for awarding succes and drop some awesome deathlore
/datum/lost_crew_manager/proc/on_succesful_revive(obj/item/organ/internal/brain/brain, list/death_lore, list/datum/callback/on_revive_and_player_occupancy)
	var/mob/living/carbon/human/owner = brain.owner

	owner.mind.add_antag_datum(/datum/antagonist/recovered_crew) //for tracking mostly

	var/datum/bank_account/bank_account = new(owner.real_name, owner.mind.assigned_role, owner.dna.species.payday_modifier)
	bank_account.adjust_money(starting_funds, "[starting_funds]cr given to [owner.name] as starting fund.")
	owner.account_id = bank_account.account_id
	bank_account.replaceable = FALSE

	owner.add_mob_memory(/datum/memory/key/account, remembered_id = owner.account_id)

	death_lore += "My account number was [owner.account_id]."

	brain.RemoveElement(/datum/element/dangerous_organ_removal)

	// Drop the sick ass death lore and give them an indicator of who they were and what they can do
	for(var/i in 1 to death_lore.len)
		addtimer(CALLBACK(src, GLOBAL_PROC_REF(to_chat), owner, span_boldnotice(death_lore[i])), 10 SECONDS + 2 SECONDS * i)

	addtimer(CALLBACK(src, PROC_REF(award_succes), owner.mind, death_lore), succes_check_time)

	// Run any callbacks our characters or damages may have placed for some effects for when the player is revived
	for(var/datum/callback/callback as anything in on_revive_and_player_occupancy)
		callback.Invoke()

/// Give medbay a happy announcement and put some money into their budget
/datum/lost_crew_manager/proc/award_succes(datum/mind/revived_mind, list/death_lore)
	var/obj/item/radio/headset/radio = new /obj/item/radio/headset/silicon/ai(revived_mind.current) //radio cant be in nullspace or brit shakes
	radio.set_frequency(FREQ_MEDICAL)
	radio.name = "Medical Announcer"

	// i am incredibly disappointed in you
	if(revived_mind.current.stat == DEAD)
		radio.talk_into(radio, "Sensors indicate lifesigns of [revived_mind.name] have seized. Please inform their family of your failure.", RADIO_CHANNEL_MEDICAL)
		return

	// You are a credit to society
	radio.talk_into(radio, "Sensors indicate continued survival of [revived_mind.name]. Well done, [credits_on_succes]cr has been transferred to the medical budget.", RADIO_CHANNEL_MEDICAL)

	var/datum/bank_account/medical_budget = SSeconomy.get_dep_account(ACCOUNT_MED)
	medical_budget.adjust_money(credits_on_succes)
	qdel(radio)

/// A box for recovered items that can only be opened by the new crewmember
/obj/item/storage/lockbox/mind
	name = "mind lockbox"
	desc = "A locked box, openable only by one mind."

	/// The mind needed to unlock the box
	var/datum/mind/mind

/obj/item/storage/lockbox/mind/attack_self(mob/user, modifiers)
	. = ..()

	if(user.mind == mind)
		atom_storage.locked = STORAGE_NOT_LOCKED
		balloon_alert(user, atom_storage.locked ? "locked" : "unlocked")
		update_appearance()
