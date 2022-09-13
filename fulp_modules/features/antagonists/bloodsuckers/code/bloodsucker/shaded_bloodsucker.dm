///a malkavian bloodsucker that has entered final death. does nothing, other than signify they suck
/datum/antagonist/shaded_bloodsucker
	name = "\improper Shaded Bloodsucker"
	antagpanel_category = "Bloodsucker"
	show_in_roundend = FALSE
	job_rank = ROLE_BLOODSUCKER
	antag_hud_name = "bloodsucker"

/obj/item/soulstone/bloodsucker
	theme = THEME_WIZARD

/obj/item/soulstone/bloodsucker/init_shade(mob/living/carbon/human/victim, mob/user, message_user = FALSE, mob/shade_controller)
	. = ..()
	for(var/mob/shades in contents)
		shades.mind.add_antag_datum(/datum/antagonist/shaded_bloodsucker)

/obj/item/soulstone/bloodsucker/get_ghost_to_replace_shade(mob/living/carbon/victim, mob/user)
	var/mob/dead/observer/chosen_ghost
	chosen_ghost = victim.get_ghost(TRUE,TRUE) //Try to grab original owner's ghost first
	if(!chosen_ghost || !chosen_ghost.client) //Failing that, we grab a ghosts
		var/list/consenting_candidates = poll_ghost_candidates("Would you like to play as a Shade?", "Cultist", ROLE_CULTIST, 50, POLL_IGNORE_SHADE)
		if(consenting_candidates.len)
			chosen_ghost = pick(consenting_candidates)
	if(!victim)
		return FALSE
	if(!chosen_ghost)
		victim.dust()
		return FALSE
	if(contents.len) //If they used the soulstone on someone else in the meantime
		return FALSE
	victim.unequip_everything()
	init_shade(victim, user, shade_controller = chosen_ghost)
	return TRUE
