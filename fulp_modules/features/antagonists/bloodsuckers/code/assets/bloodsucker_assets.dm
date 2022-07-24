/datum/asset/simple/bloodsucker_icons

/datum/asset/simple/bloodsucker_icons/register()
	for(var/datum/bloodsucker_clan/clans as anything in typesof(/datum/bloodsucker_clan))
		if(!initial(clans.joinable_clan))
			continue
		add_clan_icon(initial(clans.join_icon), initial(clans.join_icon_state))

	return ..()

/datum/asset/simple/bloodsucker_icons/proc/add_clan_icon(clan_icon, clan_icon_state)
	assets[SANITIZE_FILENAME("bloodsucker.[clan_icon_state].png")] = icon('fulp_modules/features/antagonists/bloodsuckers/icons/clan_icons.dmi', clan_icon_state)
