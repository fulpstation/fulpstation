///How much a Devil will slowly heal themselves when they die.
#define DEVIL_LIFE_HEALING_AMOUNT 0.5
///How much damage+burn you need at most to be able to revive
#define DEVIL_REVIVE_AMOUNT_REQUIRED 180

/datum/antagonist/devil
	name = "Devil"
	roundend_category = "infernal affairs agents"
	antagpanel_category = "Devil Affairs"
	antag_hud_name = "devil"
	hud_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/devil_antag_hud.dmi'
	job_rank = ROLE_INFERNAL_AFFAIRS_DEVIL
	show_in_roundend = FALSE
	suicide_cry = "OVER AND OUT, SEE YOU LATER SUCKERS!"
	ui_name = "AntagInfoDevil"

	tip_theme = "spookyconsole"
	antag_tips = list(
		"You are a Devil, collecting souls for your own personal wealth.",
		"You can see the HUD of all Agents, and they can see you; work with them when they need to turn in a contract, and do not reveal yourself.",
		"To turn in a kill, the person must have a calling card on them, which their hunter crafts by Alt-Clicking a paper. Then you can use your Soul Manipulate ability with Left-Click on them to tear their soul out, completing the process.",
		"If you die, you will slowly heal, then revive when possible, unless your body is destroyed.",
		"As you collect souls, you will gain new powers until your ascension.",
		"If there are not enough agents for you to Ascend with, you can use your Soul Manipulation ability with Right-Click to turn someone into an Agent, it requires they are not moved for a 30 second timer, so ensure they can't get external help!",
		"Try to stay low! You work best from the shadows, being open and about will get you caught and punish the Agents.",
	)

	///The person currently the target of spells being performed on them by the Devil.
	var/mob/living/carbon/human/spells_target
	///The amount of souls the devil has so far.
	var/souls = 0
	///List of Powers we currently have unlocked, sorted by typepath.
	///This is so we don't have to init new powers we won't use if we already have it.
	var/list/datum/action/devil_powers = list()
	///Soul counter HUD given to Devils so they always know how many they have.
	var/atom/movable/screen/devil_soul_counter/soul_counter

/datum/antagonist/devil/get_preview_icon()
	return finish_preview_icon(icon('fulp_modules/features/antagonists/infernal_affairs/icons/devil_cut.dmi', "true_devil"))

/datum/antagonist/devil/on_gain()
	SSmapping.lazy_load_template(LAZY_TEMPLATE_DEVIL_CELL)
	GLOB.infernal_affair_manager.devils += src
	var/datum/objective/devil_souls/devil_objective = new()
	devil_objective.owner = owner
	devil_objective.update_explanation_text()
	objectives += devil_objective

	. = ..()

	obtain_power(/datum/action/cooldown/spell/devil_spells)
	obtain_power(/datum/action/cooldown/spell/pointed/collect_soul)

/datum/antagonist/devil/on_removal()
	spells_target = null
	for(var/datum/action/all_powers as anything in devil_powers)
		clear_power(all_powers)
	if(src in GLOB.infernal_affair_manager.devils)
		GLOB.infernal_affair_manager.devils -= src
	return ..()

/datum/antagonist/devil/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	//see IAAs since devils update themselves in `add_team_hud`
	add_team_hud(current_mob, antag_to_check = /datum/antagonist/infernal_affairs)

	RegisterSignal(current_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(current_mob, COMSIG_LIVING_REVIVE, PROC_REF(on_revival))
	RegisterSignal(current_mob, COMSIG_PREQDELETED, PROC_REF(on_host_destroy))

	if(current_mob.hud_used)
		on_hud_created()
	else
		RegisterSignal(current_mob, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))

	owner.unconvertable = TRUE

/datum/antagonist/devil/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	UnregisterSignal(current_mob, list(COMSIG_LIVING_DEATH, COMSIG_LIVING_REVIVE, COMSIG_PREQDELETED))
	if(current_mob.hud_used)
		var/datum/hud/hud_used = current_mob.hud_used
		hud_used.infodisplay -= soul_counter
	owner.unconvertable = initial(owner.unconvertable)
	QDEL_NULL(soul_counter)

/datum/antagonist/devil/add_team_hud(mob/target, antag_to_check)
	. = ..()
	var/datum/atom_hud/alternate_appearance/basic/has_antagonist/hud = team_hud_ref.resolve()

	var/list/mob/living/mob_list = list()
	for(var/datum/antagonist/devil/other_devils as anything in GLOB.infernal_affair_manager.devils)
		mob_list += other_devils.owner.current

	for (var/datum/atom_hud/alternate_appearance/basic/has_antagonist/antag_hud as anything in GLOB.has_antagonist_huds)
		if(!(antag_hud.target in mob_list))
			continue
		antag_hud.show_to(target)
		hud.show_to(antag_hud.target)

///Ensure their healing will follow through to their new body.
/datum/antagonist/devil/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	for(var/power_type in devil_powers)
		var/datum/action/moving_power = devil_powers[power_type]
		if(old_body)
			moving_power.Remove(old_body)
		moving_power.Grant(new_body)
	if(old_body.stat == DEAD)
		UnregisterSignal(old_body, COMSIG_LIVING_LIFE)
	if(new_body.stat == DEAD)
		RegisterSignal(new_body, COMSIG_LIVING_LIFE)

/datum/antagonist/devil/get_admin_commands()
	. = ..()
	.["Give Soul"] = CALLBACK(src, PROC_REF(update_souls_owned), 1)
	if(souls)
		.["Take Soul"] = CALLBACK(src, PROC_REF(update_souls_owned), -1)

/datum/antagonist/devil/ui_data(mob/user)
	var/list/data = ..()
	data["agent_amount"] = length(GLOB.infernal_affair_manager.agent_datums)
	data["souls_collected"] = souls

	for(var/mob/living/carbon/human/all_agents as anything in GLOB.infernal_affair_manager.agent_icons)
		if(all_agents in GLOB.infernal_affair_manager.stored_humans)
			continue
		var/list/agent_data = list()
		agent_data["current_target"] = !!(all_agents == spells_target)
		agent_data["agent_body_ref"] = REF(all_agents)
		agent_data["agent_dead"] = (all_agents.stat == DEAD)
		agent_data["agent_name"] = all_agents.real_name
		agent_data["agent_icon"] = GLOB.infernal_affair_manager.agent_icons[all_agents]
		data["agents"] += list(agent_data)

	return data

/datum/antagonist/devil/ui_static_data(mob/user)
	var/list/data = ..()
	var/datum/objective/devil_souls/devil_objective = locate() in objectives
	data["souls_to_ascend"] = devil_objective.souls_needed
	return data

/datum/antagonist/devil/ui_act(action, params)
	. = ..()
	switch(action)
		if("set_target")
			var/mob/living/carbon/human/new_target = locate(params["agent_body_ref"]) in GLOB.mob_list
			if(!istype(new_target))
				return
			spells_target = new_target
			return TRUE

/datum/antagonist/devil/proc/on_hud_created(datum/source)
	SIGNAL_HANDLER
	var/datum/hud/devil_hud = owner.current.hud_used

	soul_counter = new /atom/movable/screen/devil_soul_counter(src, devil_hud)
	devil_hud.infodisplay += soul_counter
	soul_counter.update_counter(souls)

	INVOKE_ASYNC(devil_hud, TYPE_PROC_REF(/datum/hud/, show_hud), devil_hud.hud_version)

///Begins your healing process when you die.
/datum/antagonist/devil/proc/on_death(atom/source, gibbed)
	SIGNAL_HANDLER
	if(gibbed)
		return
	RegisterSignal(source, COMSIG_LIVING_LIFE, PROC_REF(on_dead_life))

///Ends your healing process when you are revived
/datum/antagonist/devil/proc/on_revival(atom/source, full_heal, admin_revive)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_LIVING_LIFE)

/datum/antagonist/devil/proc/on_host_destroy(atom/source, force)
	SIGNAL_HANDLER
	if(!LAZYLEN(GLOB.infernal_affair_manager.stored_humans))
		return
	var/turf/spawn_loc = find_maintenance_spawn(atmos_sensitive = TRUE)
	if(!spawn_loc)
		return
	var/mob/living/random_person = pick(GLOB.infernal_affair_manager.stored_humans)
	GLOB.infernal_affair_manager.remove_agent(random_person)
	random_person.revive(HEAL_ALL, force_grab_ghost = FALSE) //we grab ghost later
	random_person.forceMove(spawn_loc)
	owner.transfer_to(random_person, force_key_move = TRUE)
	update_souls_owned(-1)

///Called on Life, but only while you are dead. Handles slowly healing and coming back to life when eligible.
/datum/antagonist/devil/proc/on_dead_life(atom/source, delta_time, times_fired)
	SIGNAL_HANDLER
	owner.current.heal_overall_damage(DEVIL_LIFE_HEALING_AMOUNT, DEVIL_LIFE_HEALING_AMOUNT)
	if(owner.current.blood_volume < BLOOD_VOLUME_NORMAL)
		owner.current.blood_volume += (DEVIL_LIFE_HEALING_AMOUNT * 2)

	if((owner.current.getBruteLoss() + owner.current.getFireLoss()) > DEVIL_REVIVE_AMOUNT_REQUIRED)
		return
	INVOKE_ASYNC(owner.current, TYPE_PROC_REF(/mob/living, revive), HEAL_DAMAGE|HEAL_BODY)
	INVOKE_ASYNC(owner.current, TYPE_PROC_REF(/mob/living, grab_ghost))

/**
 * ##update_souls_owned
 *
 * Used to edit the amount of souls a Devil has. This can be a negative number to take away.
 * Will give Powers when getting to the proper level, or attempts to take them away if they go under
 * That way this works for both adding and removing.
 */
/datum/antagonist/devil/proc/update_souls_owned(souls_adding)
	souls += souls_adding
	if(soul_counter)
		soul_counter.update_counter(souls)
	var/datum/objective/devil_souls/devil_objective = locate() in objectives
	switch(souls)
		if(3)
			clear_power(/datum/action/cooldown/spell/conjure_item/violin)
		if(4)
			obtain_power(/datum/action/cooldown/spell/conjure_item/violin)
			clear_power(/datum/action/cooldown/spell/conjure_item/summon_pitchfork)
		if(5)
			obtain_power(/datum/action/cooldown/spell/conjure_item/summon_pitchfork)
			clear_power(/datum/action/cooldown/spell/jaunt/ethereal_jaunt/infernal_jaunt)
		if(6)
			obtain_power(/datum/action/cooldown/spell/jaunt/ethereal_jaunt/infernal_jaunt)
	if(!devil_objective)
		WARNING("Devil has no objective to harvest souls, this removes their ability to ascend!")
	//these can't be in switch because they are using a var.
	if(souls == devil_objective.souls_needed - 1)
		clear_power(/datum/action/cooldown/spell/summon_dancefloor)
		clear_power(/datum/action/cooldown/spell/pointed/projectile/fireball/hellish)
		clear_power(/datum/action/cooldown/spell/shapeshift/devil)
	else if(souls == devil_objective.souls_needed)
		owner.current.client?.give_award(/datum/award/achievement/misc/devil_ascension, owner.current)
		obtain_power(/datum/action/cooldown/spell/summon_dancefloor)
		obtain_power(/datum/action/cooldown/spell/pointed/projectile/fireball/hellish)
		obtain_power(/datum/action/cooldown/spell/shapeshift/devil)

///Adds an action button to the owner of the antag and stores it in `devil_powers`
/datum/antagonist/devil/proc/obtain_power(datum/action/new_power)
	if(new_power in devil_powers)
		return FALSE
	new_power = new new_power
	devil_powers[new_power.type] += new_power
	new_power.Grant(owner.current)
	return TRUE

///Removes a power if it's in `devil_powers`, arg is the type.
/datum/antagonist/devil/proc/clear_power(datum/action/removed_power)
	if(!(removed_power in devil_powers))
		return FALSE
	var/datum/action/power_action = devil_powers[removed_power]
	devil_powers -= removed_power
	power_action.Remove(owner.current)
	qdel(power_action)
	return TRUE

/obj/effect/temp_visual/devil
	icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/bubblegum.dmi'
	icon_state = "goingup"

/obj/effect/temp_visual/devil/hand_open
	icon_state = "goingup"
	duration = 9
	///The person being eaten by the hands, which we move to nullspace and ghostize.
	var/mob/living/food

/obj/effect/temp_visual/devil/hand_open/Initialize(mapload, mob/living/new_food)
	. = ..()
	food = new_food

/obj/effect/temp_visual/devil/hand_open/Destroy(force)
	if(food)
		food.ghostize(can_reenter_corpse = FALSE)
		food.forceMove(get_turf(pick(GLOB.devil_cell_landmark)))
	food = null
	new /obj/effect/temp_visual/devil/hand_closed(get_turf(src))
	return ..()

/obj/effect/temp_visual/devil/hand_closed
	icon_state = "goingdown"
	duration = 9

#undef DEVIL_LIFE_HEALING_AMOUNT
#undef DEVIL_REVIVE_AMOUNT_REQUIRED
