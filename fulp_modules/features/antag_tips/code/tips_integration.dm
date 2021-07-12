/datum/preferences
	var/show_antag_tips = TRUE

/datum/antagonist
	var/tips
	var/datum/action/antag_tip/antag_tips

/datum/antagonist/on_gain()
	. = ..()
	// Do we have tips & Are we not silent & Do they WANT tips?
	if(tips && !silent && owner.current.client?.prefs?.show_antag_tips)
		// Grant tips and use it roundstart.
		antag_tips = new(owner.current, src)
		antag_tips.Grant(owner.current)
		antag_tips.Trigger()

/datum/antagonist/on_removal()
	if(antag_tips)
		QDEL_NULL(antag_tips)
	. = ..()

/datum/antagonist/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tips, name)
		ui.open()

/datum/antagonist/ui_state(mob/user)
	return GLOB.always_state

/// Trigger button to show antag info
/datum/action/antag_tip
	name = "Open Antag Information:"
	button_icon_state = "round_end"
	var/datum/antagonist/antag_datum

/datum/action/antag_tip/New(Target, datum/antagonist/antag_datum)
	. = ..()
	src.antag_datum = antag_datum
	name += " [antag_datum.name] Tips"

/datum/action/antag_tip/Trigger()
	if(antag_datum)
		antag_datum.ui_interact(owner)

/datum/action/antag_tip/IsAvailable()
	return TRUE


/// Old version - REMOVE BEFORE MERGING
/datum/antagonist/proc/show_tips(fileid)
	if(!owner || !owner.current || !owner.current.client)
		return
	var/datum/asset/stuff = get_asset_datum(/datum/asset/simple/antag_tip_icons)
	stuff.send(owner.current.client)
	var/datum/browser/popup = new(owner.current, "antagTips", null, 600, 600)
	popup.set_window_options("titlebar=1;can_minimize=0;can_resize=0")
	popup.set_content(replacetext(rustg_file_read("fulp_modules/features/antag_tips/html/[html_encode(fileid)].html"), regex("\\w*.png", "gm"), /datum/antagonist/proc/get_asset_url_from))
	popup.open(FALSE)

/datum/antagonist/proc/get_asset_url_from(match)
	return SSassets.transport.get_asset_url(match)
