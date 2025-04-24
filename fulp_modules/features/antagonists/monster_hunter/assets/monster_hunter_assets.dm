// Partially copied from 'fulp_modules\features\antagonists\bloodsuckers\code\assets\bloodsucker_assets.dm'
// Currently only contains the "white_rabbit" icon.

/datum/asset/simple/monster_hunter_icons

/datum/asset/simple/monster_hunter_icons/register()
	add_monster_hunter_icon('fulp_modules/icons/antagonists/monster_hunter/rabbit.dmi', "white_rabbit")
	return ..()

/datum/asset/simple/monster_hunter_icons/proc/add_monster_hunter_icon(monster_hunter_icon, monster_hunter_icon_state)
	assets[SANITIZE_FILENAME("monster_hunter.[monster_hunter_icon_state].png")] = icon(monster_hunter_icon, monster_hunter_icon_state)

