//-----------------------------------------//
//         Fulpstation's Changelog         //
//-----------------------------------------//

/***
 * This file contains all DM code related to Fulpstation's changelog.
 *
 * Most of this is just a very rough copying of existing /tg/ code with "fulp" appended to it,
 * so credit for all of it goes to the various people who made /tg/'s changelog.
 **/


/// FULP CHANGELOG DATUM ///

GLOBAL_DATUM(fulp_changelog_tgui, /datum/fulp_changelog)
GLOBAL_VAR_INIT(fulp_changelog_hash, "")

/datum/fulp_changelog
	var/static/list/fulp_changelog_items = list()

/datum/fulp_changelog/ui_state()
	return GLOB.always_state

/datum/fulp_changelog/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "FulpChangelog")
		ui.open()

/datum/fulp_changelog/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(action == "get_month")
		var/datum/asset/fulp_changelog_item/fulp_changelog_item = fulp_changelog_items[params["date"]]
		if (!fulp_changelog_item)
			fulp_changelog_item = new /datum/asset/fulp_changelog_item(params["date"])
			fulp_changelog_items[params["date"]] = fulp_changelog_item
		return ui.send_asset(fulp_changelog_item)
	if(action == "open_tg_log") //this is a fulp-exclusive edit, unlike the rest of this file copied mostly from TG's changelog.
		var/mob/user = ui.user
		user.client.tg_changelog()
		return TRUE

/datum/fulp_changelog/ui_static_data()
	var/list/data = list( "dates" = list() )
	var/regex/ymlRegex = regex(@"\.yml", "g")

	for(var/archive_file in sort_list(flist("fulp_modules/data/html/changelogs/archive/")))
		var/archive_date = ymlRegex.Replace(archive_file, "")
		data["dates"] = list(archive_date) + data["dates"]

	return data


/// CHANGELOG VERB ///

/client/verb/changelog()
	set name = "Changelog"
	set category = "OOC"
	if(!GLOB.fulp_changelog_tgui)
		GLOB.fulp_changelog_tgui = new /datum/fulp_changelog()

	GLOB.fulp_changelog_tgui.ui_interact(mob)
	if(prefs.last_fulp_changelog != GLOB.fulp_changelog_hash)
		prefs.last_fulp_changelog = GLOB.fulp_changelog_hash
		prefs.save_preferences()
		winset(src, "infowindow.changelog", "font-style=;")


/// FULP CHANGELOG ITEM ASSET ///

/datum/asset/fulp_changelog_item
	_abstract = /datum/asset/fulp_changelog_item
	var/item_filename

/datum/asset/fulp_changelog_item/New(date)
	item_filename = SANITIZE_FILENAME("[date].yml")
	SSassets.transport.register_asset(item_filename, file("fulp_modules/data/html/changelogs/archive/" + item_filename))

/datum/asset/fulp_changelog_item/send(client)
	if (!item_filename)
		return
	. = SSassets.transport.send_assets(client, item_filename)

/datum/asset/fulp_changelog_item/get_url_mappings()
	if (!item_filename)
		return
	. = list("[item_filename]" = SSassets.transport.get_asset_url(item_filename))


// See 'world.dm' for a changelog-related Fulp edit. //
