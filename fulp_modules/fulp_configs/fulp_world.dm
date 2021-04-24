/// This is used to load Mentors so they can do things like 'their job' and whatnot.
/world/New()
	..()
	load_mentors()

/// Redirect world's update status to use ours instead, used below.
/world/update_status()
	/// DON'T CALL PARENT, we don't want to use TG's update_status here, only ours!
	var/list/features = list()

	if (!GLOB.enter_allowed)
		features += "closed"

	var/s = ""
	var/server_name = CONFIG_GET(string/servername)
	s += "<b>[server_name]</b>\] &#8212; " // Fulpstation: added "\]" so we close the name with a ] - This looks clean!

	var/server_caption = CONFIG_GET(string/servercaption)
	s += "<b>[server_caption]</b>;"
	s += " ("
	s += "<a href=\"[CONFIG_GET(string/discordurl)]\">" //Change this to wherever you want the hub to link to
	s += "Discord"
	s += "</a>"
	s += ")<br>"

	s += "<br>Beginner Friendly: <b>Learn to play SS13!</b>"
	s += "<br>Roleplay: \[<b>Medium</b>\]"
	s += "<br>Map: \[SSmapping.config?.map_name || "In Lobby"\]"

	var/players = GLOB.clients.len

	var/popcaptext = ""
	var/popcap = max(CONFIG_GET(number/extreme_popcap), CONFIG_GET(number/hard_popcap), CONFIG_GET(number/soft_popcap))
	if(popcap)
		popcaptext = "/[popcap]"
	if(players > 1)
		features += "[players][popcaptext] players"
	else if(players > 0)
		features += "[players][popcaptext] player"

	game_state = (CONFIG_GET(number/extreme_popcap) && players >= CONFIG_GET(number/extreme_popcap)) //tells the hub if we are full

	/// FULPSTATION EDIT: We don't list features!
//	if(features)
//		s += ": [jointext(features, ", ")]"

	status = s
	return s
