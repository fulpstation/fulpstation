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

	tip_theme = "spookyconsole"
	antag_tips = list(
		"You are a Devil, collecting souls for your own personal wealth.",
		"You can see the HUD of all Agents, and they can see you; work with them when they need to turn in a contract, and do not reveal yourself.",
		"To turn in a kill, the person must have a calling card on them, which their hunter crafts by Alt-Clicking a paper. Then you can use your Collect Soul ability on them to tear their soul out, completing the process.",
		"If you die, you will slowly heal, then revive when possible, unless your body is destroyed.",
		"As you collect souls, you will gain new powers until your ascension.",
		"You can also create a limited amount of new agents using your Devil Contracts, which they must agree to individually.",
		"Try to stay low! You work best from the shadows, being open and about will get you caught and punish the Agents.",
	)

	///Amount of contracts that has been signed, once you sign 4 you cannot can't make anymore.
	var/contracts_signed = 0
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
	SSinfernal_affairs.devils += src
	var/datum/objective/devil_souls/devil_objective = new()
	devil_objective.owner = owner
	devil_objective.update_explanation_text()
	objectives += devil_objective

	. = ..()

	obtain_power(/datum/action/cooldown/spell/conjure_item/summon_contract)
	obtain_power(/datum/action/cooldown/spell/pointed/collect_soul)

/datum/antagonist/devil/on_removal()
	for(var/datum/action/all_powers as anything in devil_powers)
		clear_power(all_powers)
	if(src in SSinfernal_affairs.devils)
		SSinfernal_affairs.devils -= src
	return ..()

/datum/antagonist/devil/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	//see IAAs since devils update themselves in `add_team_hud`
	add_team_hud(current_mob, antag_to_check = /datum/antagonist/infernal_affairs)

	RegisterSignal(mob_override, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(mob_override, COMSIG_LIVING_REVIVE, PROC_REF(on_revival))

	if(current_mob.hud_used)
		on_hud_created()
	else
		RegisterSignal(current_mob, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))

/datum/antagonist/devil/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	UnregisterSignal(current_mob, list(COMSIG_LIVING_DEATH, COMSIG_LIVING_REVIVE))
	if(current_mob.hud_used)
		var/datum/hud/hud_used = current_mob.hud_used
		hud_used.infodisplay -= soul_counter
	QDEL_NULL(soul_counter)

/datum/antagonist/devil/add_team_hud(mob/target, antag_to_check)
	. = ..()
	var/datum/atom_hud/alternate_appearance/basic/has_antagonist/hud = team_hud_ref.resolve()

	var/list/mob/living/mob_list = list()
	for(var/datum/antagonist/devil/other_devils as anything in SSinfernal_affairs.devils)
		mob_list += other_devils.owner.current

	for (var/datum/atom_hud/alternate_appearance/basic/has_antagonist/antag_hud as anything in GLOB.has_antagonist_huds)
		if(!(antag_hud.target in mob_list))
			continue
		antag_hud.show_to(target)
		hud.show_to(antag_hud.target)

///Ensure their healing will follow through to their new body.
/datum/antagonist/devil/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	if(old_body.stat == DEAD)
		UnregisterSignal(old_body, COMSIG_LIVING_LIFE)
	if(new_body.stat == DEAD)
		RegisterSignal(new_body, COMSIG_LIVING_LIFE)

/datum/antagonist/devil/get_admin_commands()
	. = ..()
	.["Give Soul"] = CALLBACK(src, PROC_REF(update_souls_owned), 1)
	if(souls)
		.["Take Soul"] = CALLBACK(src, PROC_REF(update_souls_owned), -1)

/datum/antagonist/devil/proc/on_hud_created(datum/source)
	SIGNAL_HANDLER
	var/datum/hud/devil_hud = owner.current.hud_used

	soul_counter = new /atom/movable/screen/devil_soul_counter(devil_hud)
	devil_hud.infodisplay += soul_counter
	soul_counter.update_counter(souls)

	INVOKE_ASYNC(devil_hud, TYPE_PROC_REF(/datum/hud/, show_hud), devil_hud.hud_version)

///Begins your healing process when you die.
/datum/antagonist/devil/proc/on_death(atom/source, gibbed)
	SIGNAL_HANDLER
	RegisterSignal(source, COMSIG_LIVING_LIFE, PROC_REF(on_dead_life))

///Ends your healing process when you are revived
/datum/antagonist/devil/proc/on_revival(atom/source, full_heal, admin_revive)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_LIVING_LIFE)

///Called on Life, but only while you are dead. Handles slowly healing and coming back to life when eligible.
/datum/antagonist/devil/proc/on_dead_life(atom/source, delta_time, times_fired)
	SIGNAL_HANDLER
	owner.current.heal_overall_damage(DEVIL_LIFE_HEALING_AMOUNT, DEVIL_LIFE_HEALING_AMOUNT)
	if(owner.current.blood_volume < BLOOD_VOLUME_NORMAL)
		owner.current.blood_volume += (DEVIL_LIFE_HEALING_AMOUNT * 2)

	if((owner.current.getBruteLoss() + owner.current.getFireLoss()) > DEVIL_REVIVE_AMOUNT_REQUIRED)
		return
	INVOKE_ASYNC(owner.current, TYPE_PROC_REF(/mob/living, revive), FALSE, excess_healing = 100)
	INVOKE_ASYNC(owner.current, TYPE_PROC_REF(/mob/living, grab_ghost))

///Called when a Devil successfully gets a contract signed, removing the ability to make contracts if necessary and updating objectives.
/datum/antagonist/devil/proc/on_contract_signed()
	contracts_signed++
	if(contracts_signed >= DEVIL_MAX_CONTRACTS)
		clear_power(/datum/action/cooldown/spell/conjure_item/summon_contract)
	SSinfernal_affairs.update_objective_datums()

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

	switch(souls)
		if(1)
			clear_power(/datum/action/cooldown/spell/conjure_item/violin)
		if(2)
			obtain_power(/datum/action/cooldown/spell/conjure_item/violin)
			clear_power(/datum/action/cooldown/spell/conjure_item/summon_pitchfork)
		if(3)
			obtain_power(/datum/action/cooldown/spell/conjure_item/summon_pitchfork)
			clear_power(/datum/action/cooldown/spell/jaunt/ethereal_jaunt/infernal_jaunt)
		if(4)
			obtain_power(/datum/action/cooldown/spell/jaunt/ethereal_jaunt/infernal_jaunt)
		if(7)
			clear_power(/datum/action/cooldown/spell/summon_dancefloor)
			clear_power(/datum/action/cooldown/spell/pointed/projectile/fireball/hellish)
			clear_power(/datum/action/cooldown/spell/shapeshift/devil)
		if(DEVIL_SOULS_TO_ASCEND)
			owner.current.client?.give_award(/datum/award/achievement/misc/devil_ascension, owner.current)
			obtain_power(/datum/action/cooldown/spell/summon_dancefloor)
			obtain_power(/datum/action/cooldown/spell/pointed/projectile/fireball/hellish)
			obtain_power(/datum/action/cooldown/spell/shapeshift/devil)

///Adds an action button to the owner of the antag and stores it in `devil_powers`
/datum/antagonist/devil/proc/obtain_power(datum/action/new_power)
	if(new_power in devil_powers)
		return
	new_power = new new_power
	devil_powers[new_power.type] = new_power
	new_power.Grant(owner.current)
	return TRUE

///Removes a power if it's in `devil_powers`, arg is the type.
/datum/antagonist/devil/proc/clear_power(datum/action/removed_power)
	if(devil_powers[removed_power])
		QDEL_NULL(devil_powers[removed_power])

#undef DEVIL_LIFE_HEALING_AMOUNT
#undef DEVIL_REVIVE_AMOUNT_REQUIRED
