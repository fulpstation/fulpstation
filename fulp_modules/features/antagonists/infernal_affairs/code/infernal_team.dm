/datum/team/infernal_affairs
	name = "\improper Infernal Affairs"
	member_name = "participants"

/datum/team/infernal_affairs/roundend_report()
	var/list/report = list()

	report += span_header("There were [name] running on the station:")

	report += "<span class='neutraltext big'>The devils enjoying the entertainment over it all were:</span>"
	for(var/datum/antagonist/devil/devil_antag as anything in SSinfernal_affairs.devils)
		report += printplayer(devil_antag.owner)
		report += "Souls collected: [devil_antag.souls]"
		report += printobjectives(devil_antag.objectives)

	report += "<span class='neutraltext big'>The [member_name] of the torturous experiments were:</span>"
	report += printplayerlist(members)

	return "<div class='panel redborder'>[report.Join("<br>")]</div>"
