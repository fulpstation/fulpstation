/datum/antagonist/traitor/devil_affairs
	name = "\improper Devil Affairs Agent"
	roundend_category = "devil affairs agents"
	suicide_cry = "FOR MY SOUL!!"
	job_rank = ROLE_DEVIL_AFFAIRS
	preview_outfit = /datum/outfit/devil_affair_agent
	should_give_codewords = FALSE

	///List of all targets we have stolen thus far.
	var/list/datum/mind/targets_stolen = list()

/datum/antagonist/traitor/devil_affairs/on_gain()
	. = ..()
	ADD_TRAIT(owner.current, TRAIT_DEFIB_BLACKLISTED, REF(src))
	RegisterSignal(owner.current, COMSIG_LIVING_REVIVE, .proc/on_revive)
	RegisterSignal(owner.current, COMSIG_LIVING_DEATH, .proc/on_death)
	uplink_handler.has_progression = FALSE
	pick_employer()

/datum/antagonist/traitor/devil_affairs/on_removal()
	UnregisterSignal(owner.current, COMSIG_LIVING_DEATH)
	UnregisterSignal(owner.current, COMSIG_LIVING_REVIVE)
	REMOVE_TRAIT(owner.current, TRAIT_DEFIB_BLACKLISTED, REF(src))
	return ..()

/datum/antagonist/traitor/devil_affairs/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/datum_owner = mob_override || owner.current
	datum_owner.apply_status_effect(/datum/status_effect/agent_pinpointer/devil_affairs)

/datum/antagonist/traitor/devil_affairs/remove_innate_effects(mob/living/mob_override)
	var/mob/living/datum_owner = mob_override || owner.current
	datum_owner.remove_status_effect(/datum/status_effect/agent_pinpointer/devil_affairs)
	return ..()

/// Affairs Agents can only roll Internal or External, rather than the normal factions.
/datum/antagonist/traitor/devil_affairs/pick_employer(faction)
	employer = ROLE_DEVIL_AFFAIRS
	traitor_flavor = strings(DEVILAFFAIR_FLAVOR_FILE, employer, directory = "fulp_modules/strings")

/datum/antagonist/traitor/devil_affairs/greet()
	. = ..()
	var/crime = pick(
		"distribution of contraband",
		"unauthorized erotic action on duty",
		"embezzlement",
		"piloting under the influence",
		"dereliction of duty",
		"syndicate collaboration",
		"mutiny",
		"multiple homicides",
		"corporate espionage",
		"receiving bribes",
		"malpractice",
		"worship of prohibited life forms",
		"possession of profane texts",
		"murder",
		"arson",
		"insulting their manager",
		"grand theft",
		"conspiracy",
		"attempting to unionize",
		"vandalism",
		"gross incompetence",
	)
	to_chat(owner.current, span_userdanger("After having sold your soul to the Devil to get away with [crime], you are in desperate need to pay your dues. Luckily, the Devil offered to let you off the hook, if you collect the souls of those with debts owed to the Devil."))
	to_chat(owner.current, span_userdanger("Watch your back, as it isn't uncommon for the Devil to play around with their victims, and likely offered someone else the same deal."))
	owner.announce_objectives()

/datum/antagonist/traitor/devil_affairs/forge_traitor_objectives()
	var/datum/objective/survive_objective = new /datum/objective/escape
	survive_objective.owner = owner
	objectives += survive_objective

/// When someone is (somehow) revived, their hunter(s) have to kill them again, as to not get several DAGD's
/datum/antagonist/traitor/devil_affairs/proc/on_revive()
	SIGNAL_HANDLER

	for(var/datum/mind/internal_minds as anything in get_antag_minds(/datum/antagonist/traitor/devil_affairs))
		for(var/datum/objective/assassinate/internal/internal_objectives as anything in internal_minds.get_all_objectives())
			if(!internal_objectives.target || internal_objectives.target != owner)
				continue
			if(internal_objectives.check_completion())
				CRASH("[src] ran on_revive but still completed an objective.")
			to_chat(internal_minds.current, span_userdanger("Your sensors tell you that [internal_objectives.target.current.real_name], one of the targets you were meant to have killed, pulled one over on you, and is still alive - do the job properly this time!"))
			internal_objectives.stolen = FALSE
			objectives -= internal_objectives

///When an agent dies, their hunter completes their objective and inherits their targets
/datum/antagonist/traitor/devil_affairs/proc/on_death()
	SIGNAL_HANDLER

	for(var/datum/mind/internal_minds as anything in get_antag_minds(/datum/antagonist/traitor/devil_affairs))
		if(!internal_minds.current || internal_minds.current.stat == DEAD)
			continue
		for(var/datum/objective/assassinate/internal/internal_objectives as anything in internal_minds.get_all_objectives())
			if(!internal_objectives.target || internal_objectives.target != owner)
				continue
			if(!internal_objectives.check_completion())
				CRASH("[src] ran on_death and failed to complete an objective.")
			if(internal_objectives.stolen)
				break
			var/datum/antagonist/traitor/devil_affairs/iaa_datum = internal_minds.has_antag_datum(/datum/antagonist/traitor/devil_affairs)
			//This is on the TARGET's antag datum, NOT ours.
			iaa_datum.steal_targets(internal_objectives.target)
			internal_objectives.stolen = TRUE
			break

/// Upon killing a target, we steal their target, to continue the cycle.
/datum/antagonist/traitor/devil_affairs/proc/steal_targets(datum/mind/victim)
	if(!owner.current || owner.current.stat == DEAD)
		return

	to_chat(owner.current, span_userdanger("Target eliminated: [victim.current]"))
	for(var/datum/objective/assassinate/internal/objective as anything in victim.get_all_objectives())
		if(!objective.target || objective.target == owner)
			continue
		if(targets_stolen.Find(objective.target) == 0)
			var/datum/objective/assassinate/internal/new_objective = new
			new_objective.owner = owner
			new_objective.target = objective.target
			new_objective.update_explanation_text()
			objectives += new_objective

			owner.announce_objectives()
			objective.stolen = TRUE

			targets_stolen += objective.target
			var/status_text = objective.check_completion() ? "neutralised" : "active"
			to_chat(owner.current, span_userdanger("New target added to database: [objective.target.current] ([status_text])"))

	check_last_man_standing()

/// Check all our internal objectives, if one fails, return. Otherwise, we're the last man standing.
/datum/antagonist/traitor/devil_affairs/proc/check_last_man_standing()
	for(var/datum/objective/assassinate/internal/objective as anything in owner.get_all_objectives())
		if(!istype(objective, /datum/objective/assassinate/internal))
			continue
		if(!objective.check_completion())
			return

	to_chat(owner.current, span_userdanger("All the other agents are dead, and you're finally free to do as you please. You no longer have any limits on collateral damage."))

	replace_escape_objective()
	make_agents_unrevivable()

/// Upon becoming the last man standing, all other agents become unrevivable
/datum/antagonist/traitor/devil_affairs/proc/make_agents_unrevivable()
	for(var/datum/mind/internal_minds as anything in get_antag_minds(/datum/antagonist/traitor/devil_affairs))
		var/mob/living/carbon/agents = internal_minds.current
		if(istype(agents) && agents.stat == DEAD)
			agents.makeUncloneable()
			agents.med_hud_set_status()

/// When you are the final agent, your 'Escape' objective is replaced with Die a Glorious Death
/datum/antagonist/traitor/devil_affairs/proc/replace_escape_objective()
	if(!owner || !objectives.len)
		return
	for(var/datum/objective/objective as anything in owner.get_all_objectives())
		if(!istype(objective, /datum/objective/escape) && !istype(objective, /datum/objective/survive))
			continue
		objectives -= objective

	var/datum/objective/martyr/martyr_objective = new
	martyr_objective.owner = owner
	objectives += martyr_objective
	owner.announce_objectives()

/datum/outfit/devil_affair_agent
	name = "Devil Affairs Agent (Preview only)"

	suit = /obj/item/clothing/suit/costume_2019/devil
	head = /obj/item/clothing/head/costume_2019/devil_horns
	glasses = /obj/item/clothing/glasses/sunglasses
	r_hand = /obj/item/melee/energy/sword

/datum/outfit/devil_affair_agent/post_equip(mob/living/carbon/human/owner, visualsOnly)
	var/obj/item/melee/energy/sword/sword = locate() in owner.held_items
	sword.icon_state = "e_sword_on_blue"
	sword.worn_icon_state = "e_sword_on_blue"

	owner.update_inv_hands()
