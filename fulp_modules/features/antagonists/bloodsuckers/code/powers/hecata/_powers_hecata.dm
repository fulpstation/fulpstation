/**
  * Hecata, the unified clan of death.
  *
  * Focuses more on their vassals than other clans.
  * Has to rely more on vassals for ranks and blood, as they cannot use the blood altar for leveling up and cannot silent feed.⸸
  * In exchange, they can raise the dead as temporary vassals to do their bidding, or permanently revive dead existing vassals.
  * In addition, they can summon Wraiths (shades) around them for both offense and defense
  * And can send messages to vassals anywhere globally via Dark Communion.
  * In addition, raising the dead with Necromancy turns them into Sanguine Zombies
  * They are pseudo zombies, which have high punch damage and special resistances, but aren't infectious nor can they use guns.
  *
  * ⸸ Blood altars are not implemented on Fulpstation, but this comment has been kept regardless.
  */
/datum/action/cooldown/bloodsucker/targeted/hecata
	purchase_flags = HECATA_CAN_BUY
	background_icon = 'fulp_modules/icons/antagonists/bloodsuckers/actions_hecata_bloodsucker.dmi'
	button_icon = 'fulp_modules/icons/antagonists/bloodsuckers/actions_hecata_bloodsucker.dmi'
	active_background_icon_state = "hecata_power_on"
	base_background_icon_state = "hecata_power_off"

/datum/action/cooldown/bloodsucker/hecata
	purchase_flags = HECATA_CAN_BUY
	background_icon = 'fulp_modules/icons/antagonists/bloodsuckers/actions_hecata_bloodsucker.dmi'
	button_icon = 'fulp_modules/icons/antagonists/bloodsuckers/actions_hecata_bloodsucker.dmi'
	active_background_icon_state = "hecata_power_on"
	base_background_icon_state = "hecata_power_off"
