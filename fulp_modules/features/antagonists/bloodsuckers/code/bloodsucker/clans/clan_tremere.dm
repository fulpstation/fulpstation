/datum/bloodsucker_clan/tremere
	name = CLAN_TREMERE
	description = "Tremere Clan <br> \
		The Tremere Clan is extremely weak to True Faith, and will burn when entering areas considered such, like the Chapel. <br> \
		Additionally, a whole new moveset is learned, built on Blood magic rather than Blood abilities, which are upgraded overtime. <br> \
		More ranks can be gained by Vassalizing crewmembers. <br> \
		The Favorite Vassal gains the Batform spell, being able to morph themselves at will."
	clan_objective = /datum/objective/bloodsucker/tremere_power
	join_description = "You will burn if you enter the Chapel, lose all default powers, \
		but gain Blood Magic instead, powers you level up overtime."

/datum/bloodsucker_clan/tremere/New(mob/living/carbon/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	bloodsuckerdatum.remove_nondefault_powers()
	bloodsuckerdatum.bloodsucker_level_unspent++
	bloodsuckerdatum.BuyPower(new /datum/action/cooldown/bloodsucker/targeted/tremere/dominate)
	bloodsuckerdatum.BuyPower(new /datum/action/cooldown/bloodsucker/targeted/tremere/auspex)
	bloodsuckerdatum.BuyPower(new /datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy)

/datum/bloodsucker_clan/tremere/handle_clan_life(atom/source, datum/antagonist/bloodsucker/bloodsuckerdatum)
	. = ..()
	var/area/current_area = get_area(bloodsuckerdatum.owner.current)
	if(istype(current_area, /area/station/service/chapel))
		to_chat(bloodsuckerdatum.owner.current, span_warning("You don't belong in holy areas! The Faith burns you!"))
		bloodsuckerdatum.owner.current.adjustFireLoss(10)
		bloodsuckerdatum.owner.current.adjust_fire_stacks(2)
		bloodsuckerdatum.owner.current.ignite_mob()

/datum/bloodsucker_clan/tremere/spend_rank(datum/antagonist/bloodsucker/antag_datum, mob/living/carbon/user, mob/living/carbon/target, spend_rank = TRUE)
	// Purchase Power Prompt
	var/list/options = list()
	for(var/datum/action/cooldown/bloodsucker/targeted/tremere/power as anything in antag_datum.powers)
		if(!(power.purchase_flags & TREMERE_CAN_BUY))
			continue
		if(isnull(power.upgraded_power))
			continue
		options[initial(power.name)] = power

	if(options.len < 1)
		to_chat(user, span_notice("You grow more ancient by the night!"))
	else
		// Give them the UI to purchase a power.
		var/choice = tgui_input_list(user, "You have the opportunity to grow more ancient. Select a power you wish to upgrade.", "Your Blood Thickens...", options)
		// Prevent Bloodsuckers from closing/reopning their coffin to spam Levels.
		if(spend_rank && antag_datum.bloodsucker_level_unspent <= 0)
			return
		// Did you choose a power?
		if(!choice || !options[choice])
			to_chat(user, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return
		// Prevent Bloodsuckers from purchasing a power while outside of their Coffin.
		if(!istype(user.loc, /obj/structure/closet/crate/coffin))
			to_chat(user, span_warning("You must be in your Coffin to purchase Powers."))
			return

		// Good to go - Buy Power!
		var/datum/action/cooldown/bloodsucker/purchased_power = options[choice]
		var/datum/action/cooldown/bloodsucker/targeted/tremere/tremere_power = purchased_power
		if(isnull(tremere_power.upgraded_power))
			user.balloon_alert(user, "cannot upgrade [choice]!")
			to_chat(user, span_notice("[choice] is already at max level!"))
			return
		antag_datum.BuyPower(new tremere_power.upgraded_power)
		antag_datum.RemovePower(tremere_power)
		user.balloon_alert(user, "upgraded [choice]!")
		to_chat(user, span_notice("You have upgraded [choice]!"))

	finalize_spend_rank(antag_datum, user, spend_rank)

/datum/bloodsucker_clan/tremere/on_favorite_vassal(datum/source, datum/antagonist/vassal/vassaldatum, mob/living/bloodsucker)
	var/datum/action/cooldown/spell/shapeshift/bat/batform = new()
	batform.Grant(vassaldatum.owner.current)

/datum/bloodsucker_clan/tremere/on_vassal_made(atom/source, datum/antagonist/bloodsucker/bloodsuckerdatum)
	to_chat(bloodsuckerdatum.owner.current, span_danger("You have now gained an additional Rank to spend!"))
	bloodsuckerdatum.bloodsucker_level_unspent++
