//Overwriting /world/New to do all the Fulp-related stuff necessary
/world/New()
	. = ..()

	// Load Mentors
	load_mentors()

	// Call overrides
	override_vox()

	// This is a near copy paste of 'changelog_hash'.
	var/latest_fulp_changelog = file("[global.config.directory]/../fulp_modules/data/html/changelogs/archive/" + time2text(world.timeofday, "YYYY-MM", TIMEZONE_UTC) + ".yml")
	GLOB.fulp_changelog_hash = fexists(latest_fulp_changelog) ? md5(latest_fulp_changelog) : 0

// DON'T CALL PARENT, we don't want to use TG's update_status here, only ours!
/world/update_status()
	var/s = ""
	var/server_name = CONFIG_GET(string/servername)
	var/server_caption = CONFIG_GET(string/servercaption)
	s += "<b>[server_name]</b>\] &#8212; "
	s += "<b>[server_caption]</b>"
	s += " ("
	s += "<a href=\"[CONFIG_GET(string/discordurl)]\">"
	s += "Discord"
	s += "</a>"
	s += ")<br>"

	s += "<br>Beginner Friendly: <b>Learn to play SS13!</b>"
	s += "<br>Roleplay: \[<b>Medium</b>\]"
	s += "<br>Time: \[<b>[gameTimestamp("hh:mm")]</b>\]"
	s += "<br>Map: \[<b>[SSmapping.current_map.map_name]</b>"//\] // Since this is the last line, the ] is done automatically for us.

	status = s
	return s
