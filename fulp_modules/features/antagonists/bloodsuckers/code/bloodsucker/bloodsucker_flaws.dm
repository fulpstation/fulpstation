/**
 * Gives Bloodsuckers the ability to choose a Clan
 * This will give them their benefits and downsides
 * This is selected through a radial menu over the player's body.
 * Args:
 * person_selecting - Mob override for stuff like Admins selecting someone's clan.
 */
/datum/antagonist/bloodsucker/proc/assign_clan_and_bane(mob/person_selecting)
	if(my_clan)
		return
	if(!person_selecting)
		person_selecting = owner.current

	var/list/options = list()
	var/list/radial_display = list()
	for(var/datum/bloodsucker_clan/all_clans as anything in typesof(/datum/bloodsucker_clan))
		if(!initial(all_clans.joinable_clan)) //flavortext only
			continue
		options[initial(all_clans.name)] = all_clans

		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(all_clans.join_icon), icon_state = initial(all_clans.join_icon_state))
		option.info = "[initial(all_clans.name)] - [span_boldnotice(initial(all_clans.join_description))]"
		radial_display[initial(all_clans.name)] = option

	var/chosen_clan = show_radial_menu(person_selecting, owner.current, radial_display)
	chosen_clan = options[chosen_clan]
	if(QDELETED(src) || QDELETED(owner.current))
		return FALSE
	if(!chosen_clan)
		to_chat(owner.current, span_announce("You choose to remain ignorant, for now."))
		return
	my_clan = new chosen_clan(src)

/datum/antagonist/bloodsucker/proc/remove_clan(mob/admin)
	QDEL_NULL(my_clan)
	to_chat(owner.current, span_announce("You have been forced out of your clan! You can re-enter one by regular means."))

/datum/antagonist/bloodsucker/proc/admin_set_clan(mob/admin)
	assign_clan_and_bane(admin)
