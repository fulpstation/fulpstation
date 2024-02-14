/datum/action/cooldown/spell/devil_spells
	name = "Cast Spells"
	desc = "LMB: Cast a spell on your current spell targete. RMB: Use the most recently used spell."
	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"

	spell_requirements = NONE
	school = SCHOOL_EVOCATION
	cooldown_time = 5 SECONDS //5 seconds, so the smoke can't be spammed

	button_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/actions_devil.dmi'
	button_icon_state = "spell_default"

	///Boolean on whether to skip to the most reecently used spell, decided by whether you are RMB'ing the action.
	var/use_recent_used_spell = FALSE
	///The last chosen spell, which we use.
	var/datum/devil_spell/last_used_spell

/datum/action/cooldown/spell/devil_spells/Trigger(trigger_flags)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		use_recent_used_spell = TRUE
	else
		use_recent_used_spell = FALSE
	return ..()

/datum/action/cooldown/spell/devil_spells/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(owner))
		return FALSE
	var/datum/antagonist/devil/devil_datum = IS_DEVIL(owner)
	if(!devil_datum || !devil_datum.spells_target)
		if(feedback)
			owner.balloon_alert(owner, "no target set!")
		return FALSE
	if(!devil_datum.souls)
		if(feedback)
			owner.balloon_alert(owner, "no souls to use!")
		return FALSE
	return TRUE

/datum/action/cooldown/spell/devil_spells/cast(atom/target)
	. = ..()
	var/datum/antagonist/devil/devil_datum = IS_DEVIL(owner)
	if(!use_recent_used_spell || !last_used_spell)
		var/list/available_spells = list()
		for(var/datum/devil_spell/spells as anything in GLOB.devil_spells)
			if(devil_datum.souls < spells.level_needed)
				continue
			available_spells[spells.name] = spells
		if(!available_spells.len)
			return FALSE
		var/choice = tgui_input_list(owner, "What spell would you like to use on [devil_datum.spells_target]?", "Infernal Spells", available_spells)
		last_used_spell = available_spells[choice] || null
	if(last_used_spell && istype(last_used_spell))
		if(last_used_spell.use_spell(devil_datum, devil_datum.spells_target))
			return TRUE
	return FALSE

///Initialized list of all Devil spells used so any devil can use them if they meet the requirements.
GLOBAL_LIST_INIT(devil_spells, setup_devil_spells())

/proc/setup_devil_spells()
	var/list/all_spells = list()
	for(var/datum/devil_spell/spell as anything in subtypesof(/datum/devil_spell))
		all_spells += new spell
	return all_spells

/**
 * # Devil Spell
 *
 * Unique Spells that Devils can cast on a specific Agent in order to benefit or take away
 * some of their abilities, giving them more power and say over the agent.
 */
/datum/devil_spell
	///The name of the spell shown in the UI
	var/name
	///What level the devil needs in order to use this.
	var/level_needed = 0

///Gets called when using the spell on a target, this is where the effects come from.
/datum/devil_spell/proc/use_spell(datum/antagonist/devil/devil_datum, mob/living/carbon/human/target)
	SHOULD_CALL_PARENT(FALSE)
	WARNING("Devil Spell [src] has no effect! This is a major bug and should be reported ASAP!")

/**
 * Whisper
 *
 * Lets you send a message to one of the Agents, in case you need to
 * give some private information.
 */
/datum/devil_spell/whisper
	name = "Whisper"
	level_needed = 1

/datum/devil_spell/whisper/use_spell(datum/antagonist/devil/devil_datum, mob/living/carbon/human/target)
	var/input = tgui_input_text(devil_datum.owner.current, "What would you like to Whisper?", "Voice of Hell")
	if(!input || devil_datum.spells_target != target)
		return FALSE

	var/list/filter_result = CAN_BYPASS_FILTER(devil_datum.owner.current) ? null : is_ic_filtered(input)
	if(filter_result)
		REPORT_CHAT_FILTER_TO_USER(devil_datum.owner.current, filter_result)
		return FALSE

	var/list/soft_filter_result = CAN_BYPASS_FILTER(devil_datum.owner.current) ? null : is_soft_ic_filtered(input)
	if(soft_filter_result)
		if(tgui_alert(devil_datum.owner.current,"Your message contains \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\", Are you sure you want to say it?", "Soft Blocked Word", list("Yes", "No")) != "Yes")
			return FALSE
		message_admins("[ADMIN_LOOKUPFLW(devil_datum.owner.current)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[html_encode(input)]\"")
		log_admin_private("[key_name(devil_datum.owner.current)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[input]\"")
	to_chat(devil_datum.owner.current, span_cultlarge("DEVIL WHISPER: [input]"))
	to_chat(target, span_cultlarge("DEVIL WHISPER: [input]"))
	return TRUE

