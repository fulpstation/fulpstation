/datum/team/infernal_affairs
	name = "\improper Infernal Affairs"
	member_name = "participants"

/datum/team/infernal_affairs/roundend_report()
	var/list/report = list()

	report += span_header("There were [name] running on the station:")

	report += "<b>The devils enjoying the entertainment over it all were:</b>"
	for(var/datum/antagonist/devil/devil_antag as anything in GLOB.infernal_affair_manager.devils)
		report += "[printplayer(devil_antag.owner)]"
		report += "<ul><b>Souls collected</b>: [devil_antag.souls]"
		report += "[printobjectives(devil_antag.objectives)]</ul>"

	report += "<b>The [member_name] of the torturous experiments were:</b>"
	report += printplayerlist(members)

	return "<div class='panel redborder'>[report.Join("<br>")]</div>"
