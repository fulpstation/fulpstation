/datum/component/spirit_holding/unhinged_door

/datum/component/spirit_holding/unhinged_door/Initialize()
	. = ..()

	if(!istype(parent,/obj/machinery/door/airlock))
		return COMPONENT_INCOMPATIBLE

	attempting_awakening = TRUE

/datum/component/spirit_holding/unhinged_door/RegisterWithParent()
	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(on_destroy))

/datum/component/spirit_holding/unhinged_door/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_QDELETING))

//this is the parent proc copied because I could not figure out how to do the changes while inheriting...
/datum/component/spirit_holding/unhinged_door/affix_spirit(mob/awakener, mob/dead/observer/ghost)
	var/obj/machinery/door/airlock/thing = parent

	if(isnull(ghost))
		thing.balloon_alert(awakener, "silence...")
		banish()
		return

	if(QDELETED(thing)) //if the thing that we're conjuring a spirit in has been destroyed, don't create a spirit
		to_chat(ghost, span_userdanger("The new vessel for your spirit has been destroyed! You remain an unbound ghost."))
		banish()
		return

	bound_spirit = new(thing)
	bound_spirit.ckey = ghost.ckey
	bound_spirit.fully_replace_character_name(null, "The spirit of [thing]")
	bound_spirit.status_flags |= GODMODE
	bound_spirit.copy_languages(awakener, LANGUAGE_MASTER)
	bound_spirit.get_language_holder().omnitongue = TRUE

	RegisterSignal(thing, COMSIG_ATOM_RELAYMOVE, PROC_REF(block_buckle_message))
	RegisterSignal(thing, COMSIG_BIBLE_SMACKED, PROC_REF(on_bible_smacked))

	attempting_awakening = FALSE
	REMOVE_TRAIT(parent,TRAIT_UNHINGED_SEARCHING,src)
	ADD_TRAIT(parent,TRAIT_UNHINGED,src)

	bound_spirit.mind.add_antag_datum(/datum/antagonist/unhinged_door)

	for(var/datum/action/unhinged_door/ability_path as anything in subtypesof(/datum/action/unhinged_door))
		var/datum/action/unhinged_door/action_to_grant = new ability_path(bound_spirit)
		action_to_grant.Grant(bound_spirit)
		action_to_grant.linked_comp = src

	//make the airlock unusable by any other means
	thing.aiControlDisabled = AI_WIRE_DISABLED
	thing.hackProof = TRUE
	thing.opens_with_door_remote = FALSE
	if(islist(thing.req_access))
		thing.req_access += ACCESS_MANSUS
	else
		thing.req_access = list(ACCESS_MANSUS)

/datum/component/spirit_holding/unhinged_door/proc/banish()
	if(attempting_awakening)
		REMOVE_TRAIT(parent,TRAIT_UNHINGED_SEARCHING,src)
	else
		REMOVE_TRAIT(parent,TRAIT_UNHINGED,src)

	//restore airlock functionality
	var/obj/machinery/door/airlock/thing = parent
	thing.aiControlDisabled = AI_WIRE_NORMAL
	thing.hackProof = FALSE
	thing.opens_with_door_remote = TRUE
	thing.req_access -= ACCESS_MANSUS


	qdel(src)

/datum/component/spirit_holding/unhinged_door/attempt_exorcism(mob/exorcist)
	. = ..()
	if(!.)
		return
	banish()

/datum/component/spirit_holding/unhinged_door/on_destroy(datum/source)
	. = ..()
	banish()


/datum/action/unhinged_door
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	var/datum/component/spirit_holding/unhinged_door/linked_comp

/datum/action/unhinged_door/ghost
	name = "Return to the Shed"
	desc = "If you find your existence unfulfilling, you may leave this body behind and become a ghost once again."
	button_icon = 'icons/mob/simple/mob.dmi'
	button_icon_state = "ghost"

/datum/action/unhinged_door/ghost/Trigger(trigger_flags)
	var/response = tgui_alert(owner, "Are you sure? You will be a formless ghost once again, and not able to return!", "Abandon form?", list("Yes", "No"))
	if(response == "Yes")
		linked_comp.banish()

/datum/action/unhinged_door/open_close
	name = "Toggle Door"
	desc = "Open and close (violently)."
	button_icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/spells.dmi'
	button_icon_state = "unhinge"

/datum/action/unhinged_door/open_close/Trigger(trigger_flags)
	var/obj/machinery/door/airlock/form = linked_comp.parent
	if(form.welded)
		to_chat(owner, span_warning("You have been welded shut!"))
	else
		if(form.density)
			form.secure_open()
		else
			form.locked = FALSE
			form.close(forced = TRUE, force_crush = TRUE)
			form.update_appearance()


// mostly copied from heretic_monster:
/datum/antagonist/unhinged_door
	name = "\improper Unhinged Door"
	roundend_category = "Heretics"
	antagpanel_category = ANTAG_GROUP_HORRORS
	antag_moodlet = /datum/mood_event/heretics
	job_rank = ROLE_HERETIC
	antag_hud_name = "heretic_beast"
	suicide_cry = "TO THE SHED WE GO!!!"
	show_in_antagpanel = FALSE
	/// Linked airlock
	var/obj/machinery/door/body

/datum/antagonist/unhinged_door/on_gain()
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/ecult_op.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)//subject to change

	var/datum/objective/door_obj = new()
	door_obj.owner = owner
	door_obj.explanation_text = pick(world.file2list("fulp_modules/features/antagonists/fulp_heretic/unhinged_objectives.txt"))
	door_obj.completed = TRUE

	objectives += door_obj
	owner.announce_objectives()
	to_chat(owner, span_boldnotice("You are an airlock given a mind through the gates of the Shed."))

	. = ..()
