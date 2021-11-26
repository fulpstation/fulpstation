//Overwriting /world/New to do all the Fulp-related stuff necessary
/world/New()
	. = ..()

	// Load Mentors
	load_mentors()

	// Load Fulp species datums
	make_fulp_datum_references_lists()


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
	if(SSmapping.config)
		s += "<br>Map: \[<b>[SSmapping.config.map_name]</b>"//\] // Since this is the last line, the ] is done automatically for us.

	status = s
	return s
