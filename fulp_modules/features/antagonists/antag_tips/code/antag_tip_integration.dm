/datum/antagonist
	///The antag tip datum that holds our UI.
	var/datum/antag_tip/tips
	///Antag tip datum's UI name.
	var/antag_tips

/datum/antagonist/on_gain()
	. = ..()
	if(!owner.current.client?.prefs?.read_preference(/datum/preference/toggle/antag_tips))
		return
	if(silent || isnull(antag_tips))
		return
	tips = new(antag_tips, name)
	tips.ui_interact(owner.current)
	add_verb(owner.current, /mob/living/proc/open_tips)

/datum/antagonist/on_removal()
	if(tips)
		QDEL_NULL(tips)
	return ..()

/**
 * Open Tips
 *
 * Tied to the Mob, allows anyone to see their antag tips
 */
/mob/living/proc/open_tips()
	set name = "Open Antag tips"
	set category = "Mentor"

	var/list/datum/antagonist/antag_datum_list = list()

	for(var/datum/antagonist/antag_datum as anything in mind.antag_datums)
		if(isnull(antag_datum.antag_tips))
			continue
		antag_datum_list += antag_datum

	if(!antag_datum_list.len) //none? You shouldn't have this then.
		remove_verb(src, /mob/living/proc/open_tips)
		return
	if(antag_datum_list.len <= 1) //only one? skip ui
		for(var/datum/antagonist/antag_datum as anything in antag_datum_list)
			antag_datum.tips.ui_interact(src)
			return

	var/choice = tgui_input_list(src, "What tips are we interested in?", "Antagonist tips", antag_datum_list)
	if(!choice)
		return
	var/datum/antagonist/chosen_datum = choice
	chosen_datum.tips.ui_interact(src)

/**
 * Antag Tip datum
 *
 * Holds the UI we will run to see our TGUI Antag tips.
 */
/datum/antag_tip
	///Name of the Antagonist, used in the UI's title
	var/name
	///Name of the UI we will open, set on New.
	var/tip_ui_name

/datum/antag_tip/New(tip_ui_name, name)
	. = ..()
	src.tip_ui_name = tip_ui_name
	src.name = name

/datum/antag_tip/ui_state()
	return GLOB.always_state

/datum/antag_tip/ui_static_data(mob/user)
	. = ..()
	var/list/data = list()

	data["name"] = name

	return data

/datum/antag_tip/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/simple/antag_tip_icons),
	)

/datum/antag_tip/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tip_ui_name, "[name] tips")
		ui.open()

/**
 * Antag tips that would be nice to have:
 * - Obsessed
 * - Blood Brother
 */

/datum/antagonist/abductor
	antag_tips = ABDUCTOR_TIPS

/datum/antagonist/changeling
	antag_tips = CHANGELING_TIPS

/datum/antagonist/cult
	antag_tips = CULTIST_TIPS

/datum/antagonist/cult/master
	antag_tips = null

/datum/antagonist/heretic
	antag_tips = HERETIC_TIPS

/datum/antagonist/malf_ai
	antag_tips = MALF_TIPS

/datum/antagonist/nukeop
	antag_tips = NUKIE_TIPS

/datum/antagonist/rev
	antag_tips = REVOLUTIONARY_TIPS

/datum/antagonist/traitor
	antag_tips = TRAITOR_TIPS

/datum/antagonist/wizard
	antag_tips = WIZARD_TIPS

/datum/antagonist/wizard/apprentice
	antag_tips = WIZARD_APPRENTICE_TIPS

/datum/antagonist/wizard/apprentice/imposter
	antag_tips = null
