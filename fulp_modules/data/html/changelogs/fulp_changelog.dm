//-----------------------------------------//
//         Fulpstation's Changelog         //
//-----------------------------------------//

/**
 * This file contains all DM code related to Fulpstation's changelog.
 */

GLOBAL_DATUM(fulp_changelog_tgui, /datum/fulp_changelog)

/datum/fulp_changelog
	var/static/list/fulp_changelog_items = list()

/datum/fulp_changelog/ui_state()
	return GLOB.always_state

/datum/fulp_changelog/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "Changelog")
		ui.open()

/datum/fulp_changelog/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(action == "get_month")
		var/datum/asset/changelog_item/changelog_item = fulp_changelog_items[params["date"]]
		if (!changelog_item)
			changelog_item = new /datum/asset/changelog_item(params["date"])
			fulp_changelog_items[params["date"]] = changelog_item
		return ui.send_asset(changelog_item)

/datum/fulp_changelog/ui_static_data()
	var/list/data = list( "dates" = list() )
	var/regex/ymlRegex = regex(@"\.yml", "g")

	for(var/archive_file in sort_list(flist("fulp_modules/data/html/changelogs/archive")))
		var/archive_date = ymlRegex.Replace(archive_file, "")
		data["dates"] = list(archive_date) + data["dates"]

	return data

/client/verb/fulp_changelog()
	set name = "Fulpstation Changelog"
	set category = "OOC"
	if(!GLOB.fulp_changelog_tgui)
		GLOB.fulp_changelog_tgui = new /datum/fulp_changelog()

	GLOB.fulp_changelog_tgui.ui_interact(mob)
	if(prefs.lastchangelog != GLOB.changelog_hash)
		prefs.lastchangelog = GLOB.changelog_hash
		prefs.save_preferences()
		winset(src, "infowindow.changelog", "font-style=;")
