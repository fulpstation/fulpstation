#define NANITE_HUD "nanite_hud"
#define DIAG_NANITE_FULL_HUD "nanite_full_hud"

/mob/living/proc/hud_set_nanite_indicator()
	var/image/holder = hud_list[NANITE_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = null
	holder.icon = 'fulp_modules/features/nanites/icons/nanite_hud.dmi'
	holder.icon_state = "nanite_ping"

///Updates the nanite volume bar visible in diagnostic HUDs
/datum/component/nanites/proc/set_nanite_bar(remove = FALSE)
	var/image/holder = host_mob.hud_list[DIAG_NANITE_FULL_HUD]
	var/icon/I = icon(host_mob.icon, host_mob.icon_state, host_mob.dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = null
	if(remove || stealth)
		return //bye icon
	var/nanite_percent = (nanite_volume / max_nanites) * 100
	nanite_percent = clamp(CEILING(nanite_percent, 10), 10, 100)
	holder.icon = 'fulp_modules/features/nanites/icons/nanite_hud.dmi'
	holder.icon_state = "nanites[nanite_percent]"

/mob/New()
	hud_possible += list(NANITE_HUD, DIAG_NANITE_FULL_HUD)
	return ..()

/datum/atom_hud/data/human/medical/New()
	. = ..()
	hud_icons += list(NANITE_HUD)

/datum/atom_hud/data/human/security/advanced/New()
	. = ..()
	hud_icons += list(NANITE_HUD)

/datum/atom_hud/data/diagnostic/basic/New()
	. = ..()
	hud_icons += list(NANITE_HUD, DIAG_NANITE_FULL_HUD)

/datum/atom_hud/data/diagnostic/advanced/New()
	. = ..()
	hud_icons += list(NANITE_HUD, DIAG_NANITE_FULL_HUD)
