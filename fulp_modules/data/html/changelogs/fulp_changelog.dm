//-----------------------------------------//
//         Fulpstation's Changelog         //
//-----------------------------------------//

/***
 * This file contains all DM code related to Fulpstation's changelog.
 *
 * Most of this is just a very rough copying of existing /tg/ code with "fulp" appended to it,
 * so credit for all of it goes to the various people who made /tg/'s changelog.
 **/

//Overwrite TG's Changelog to open ours instead, which includes theirs anyways.
//THIS MEANS WE DO NOT CALL PARENT!!
/datum/changelog/ui_interact(mob/user, datum/tgui/ui)
	if(!GLOB.fulp_changelog_tgui)
		GLOB.fulp_changelog_tgui = new /datum/fulp_changelog()
	GLOB.fulp_changelog_tgui.ui_interact(user)


/// FULP CHANGELOG DATUM ///

GLOBAL_DATUM(fulp_changelog_tgui, /datum/fulp_changelog)

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
	GLOB.changelog_tgui.ui_act(action, params, ui, state)
	if(action == "get_month")
		var/datum/asset/fulp_changelog_item/fulp_changelog_item = fulp_changelog_items[params["date"]]
		if (!fulp_changelog_item)
			fulp_changelog_item = new /datum/asset/fulp_changelog_item(params["date"])
			fulp_changelog_items[params["date"]] = fulp_changelog_item
		return ui.send_asset(fulp_changelog_item)

/datum/fulp_changelog/ui_static_data()
	var/list/data = list( "fulp_dates" = list() )
	var/regex/ymlRegex = regex(@"\.yml", "g")

	for(var/archive_file in sort_list(flist("fulp_modules/data/html/changelogs/archive/")))
		var/archive_date = ymlRegex.Replace(archive_file, "")
		data["fulp_dates"] = list(archive_date) + data["fulp_dates"]

	data += GLOB.changelog_tgui.ui_static_data()

	return data

/// FULP CHANGELOG ITEM ASSET ///

/datum/asset/fulp_changelog_item
	abstract_type = /datum/asset/fulp_changelog_item
	var/item_filename

/datum/asset/fulp_changelog_item/New(date)
	item_filename = SANITIZE_FILENAME("fulp_[date].yml")
	SSassets.transport.register_asset(item_filename, file("fulp_modules/data/html/changelogs/archive/" + "[date].yml"))

/datum/asset/fulp_changelog_item/send(client)
	if (!item_filename)
		return
	. = SSassets.transport.send_assets(client, item_filename)

/datum/asset/fulp_changelog_item/get_url_mappings()
	if (!item_filename)
		return
	. = list("[item_filename]" = SSassets.transport.get_asset_url(item_filename))


// See 'world.dm' for a changelog-related Fulp edit. //
