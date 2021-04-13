/datum/antagonist
	var/tips

/datum/antagonist/on_gain()
	. = ..()
	if(owner && owner.current)
		if(!silent && tips)
			show_tips(tips)

/datum/antagonist/proc/show_tips(fileid)
	if(!owner || !owner.current || !owner.current.client)
		return
	var/datum/asset/stuff = get_asset_datum(/datum/asset/simple/antag_tip_icons)
	stuff.send(owner.current.client)
	var/datum/browser/popup = new(owner.current, "antagTips", null, 600, 600)
	popup.set_window_options("titlebar=1;can_minimize=0;can_resize=0")
	popup.set_content(replacetext(rustg_file_read("fulp_modules/antag_tips/html/[html_encode(fileid)].html"), regex("\\w*.png", "gm"), /datum/antagonist/proc/get_asset_url_from))
	popup.open(FALSE)

/datum/antagonist/proc/get_asset_url_from(match)
	return SSassets.transport.get_asset_url(match)
