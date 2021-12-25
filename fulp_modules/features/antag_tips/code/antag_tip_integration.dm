/datum/antagonist
	var/tips

/datum/antagonist/on_gain()
	. = ..()
	if(owner.current.client?.prefs?.read_preference(/datum/preference/toggle/antag_tips))
		if(!silent && !isnull(tips))
			show_tips(tips)

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

/**
 * Antag tips that would be nice to have:
 * - Obsessed
 * - Blood Brother
 */

/datum/antagonist/abductor
	tips = ABDUCTOR_TIPS

/datum/antagonist/changeling
	tips = CHANGELING_TIPS

/datum/antagonist/cult
	tips = CULTIST_TIPS

/datum/antagonist/cult/master
	tips = null

/datum/antagonist/heretic
	tips = HERETIC_TIPS

/datum/antagonist/malf_ai
	tips = MALF_TIPS

/datum/antagonist/nukeop
	tips = NUKIE_TIPS

/datum/antagonist/rev
	tips = REVOLUTIONARY_TIPS

/datum/antagonist/traitor
	tips = TRAITOR_TIPS

/datum/antagonist/wizard
	tips = WIZARD_TIPS

/datum/antagonist/wizard/apprentice
	tips = WIZARD_APPRENTICE_TIPS

/datum/antagonist/wizard/apprentice/imposter
	tips = WIZ_IMPOSTER_TIPS
