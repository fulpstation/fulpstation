///List of all Bloodsuckers in a clan, separated by their clans.
GLOBAL_LIST_EMPTY(bloodsucker_clan_members)

/**
 * Bloodsucker clans
 *
 * Handles everything related to clans.
 * the entire idea of datumizing this came to me in a dream.
 */
/datum/bloodsucker_clan
	///The name of the clan we're in.
	var/name = CLAN_NONE
	///Description of what the clan is, given when joining and through your antag UI.
	var/description = "The Caitiff is as basic as you can get with Bloodsuckers. \n\
		Entirely Clan-less, they are blissfully unaware of who they really are. \n\
		No additional abilities is gained, nothing is lost, if you want a plain Bloodsucker, this is it. \n\
		The Favorite Vassal will gain the Brawn ability, to help in combat."
	///The clan objective that is required to greentext.
	var/clan_objective
	///The icon of the radial icon to join this clan.
	var/join_icon = 'fulp_modules/features/antagonists/bloodsuckers/icons/clan_icons.dmi'
	///Same as join_icon, but the state
	var/join_icon_state = "caitiff"
	///Description shown when trying to join the clan.
	var/join_description = "The default, Classic Bloodsucker."
	///Whether the clan can be joined by players. FALSE for flavortext-only clans.
	var/joinable_clan = TRUE

	///How the Bloodsucker ranks up, if they do.
	var/rank_up_type = BLOODSUCKER_RANK_UP_NORMAL
	///Whether they become entirely stun immune when entering Frenzy.
	var/frenzy_stun_immune = FALSE
	///How we will drink blood using Feed.
	var/blood_drink_type = BLOODSUCKER_DRINK_NORMAL

/datum/bloodsucker_clan/New(mob/living/carbon/user)
	. = ..()
	if(!GLOB.bloodsucker_clan_members["[name]"])
		GLOB.bloodsucker_clan_members["[name]"] = list()
	GLOB.bloodsucker_clan_members["[name]"] |= user

	RegisterSignal(src, BLOODSUCKER_HANDLE_LIFE, .proc/handle_clan_life)
	RegisterSignal(src, BLOODSUCKER_RANK_UP, .proc/on_spend_rank)

	RegisterSignal(src, BLOODSUCKER_PRE_MAKE_FAVORITE, .proc/on_offer_favorite)
	RegisterSignal(src, BLOODSUCKER_MAKE_FAVORITE, .proc/on_favorite_vassal)

	RegisterSignal(src, BLOODSUCKER_MADE_VASSAL, .proc/on_vassal_made)
	RegisterSignal(src, BLOODSUCKER_EXIT_TORPOR, .proc/on_exit_torpor)

	give_clan_objective(user)

/datum/bloodsucker_clan/Destroy(force, mob/living/carbon/user)
	UnregisterSignal(src, BLOODSUCKER_HANDLE_LIFE)
	UnregisterSignal(src, BLOODSUCKER_RANK_UP)
	UnregisterSignal(src, BLOODSUCKER_PRE_MAKE_FAVORITE)
	UnregisterSignal(src, BLOODSUCKER_MAKE_FAVORITE)
	UnregisterSignal(src, BLOODSUCKER_MADE_VASSAL)
	UnregisterSignal(src, BLOODSUCKER_EXIT_TORPOR)
	GLOB.bloodsucker_clan_members[name] -= user
	return ..()

///legacy code support
/datum/bloodsucker_clan/proc/get_clan()
	return name

/datum/bloodsucker_clan/proc/give_clan_objective(mob/living/user)
	if(isnull(clan_objective))
		return
	var/datum/objective/bloodsucker/given_objective = new clan_objective
	given_objective.owner = user.mind
	given_objective.objective_name = "Clan Objective"
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	bloodsuckerdatum.objectives += given_objective
	user.mind.announce_objectives()

/**
 * Called when a Bloodsucker exits Torpor
 * args:
 * user - the Bloodsucker exiting Torpor
 */
/datum/bloodsucker_clan/proc/on_exit_torpor(atom/source, mob/living/carbon/user)
	SIGNAL_HANDLER

/**
 * Called during Bloodsucker's LifeTick
 * args:
 * bloodsuckerdatum - the antagonist datum of the Bloodsucker running this.
 */
/datum/bloodsucker_clan/proc/handle_clan_life(atom/source, datum/antagonist/bloodsucker/bloodsuckerdatum)
	SIGNAL_HANDLER

/**
 * Called when a Bloodsucker successfully Vassalizes someone.
 * args:
 * bloodsuckerdatum - the antagonist datum of the Bloodsucker running this.
 */
/datum/bloodsucker_clan/proc/on_vassal_made(atom/source, datum/antagonist/bloodsucker/bloodsuckerdatum)
	SIGNAL_HANDLER

/**
 * Called when a Bloodsucker successfully starts spending their Rank
 * args:
 * bloodsuckerdatum - the antagonist datum of the Bloodsucker running this.
 * target - The Vassal (if any) we are upgrading.
 * cost_rank - TRUE/FALSE on whether this will cost us a rank when we go through with it.
 * blood_cost - A number saying how much it costs to rank up.
 */
/datum/bloodsucker_clan/proc/on_spend_rank(datum/source, datum/antagonist/bloodsucker/bloodsuckerdatum, mob/living/carbon/target, cost_rank = TRUE, blood_cost)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, .proc/spend_rank, bloodsuckerdatum, target, cost_rank, blood_cost)

/datum/bloodsucker_clan/proc/spend_rank(datum/antagonist/bloodsucker/bloodsuckerdatum, mob/living/carbon/target, cost_rank = TRUE, blood_cost)
	// Purchase Power Prompt
	var/list/options = list()
	for(var/datum/action/bloodsucker/power as anything in bloodsuckerdatum.all_bloodsucker_powers)
		if(initial(power.purchase_flags) & BLOODSUCKER_CAN_BUY && !(locate(power) in bloodsuckerdatum.powers))
			options[initial(power.name)] = power

	if(options.len < 1)
		to_chat(bloodsuckerdatum.owner.current, span_notice("You grow more ancient by the night!"))
	else
		// Give them the UI to purchase a power.
		var/choice = tgui_input_list(bloodsuckerdatum.owner.current, "You have the opportunity to grow more ancient. Select a power to advance your Rank.", "Your Blood Thickens...", options)
		// Prevent Bloodsuckers from closing/reopning their coffin to spam Levels.
		if(cost_rank && bloodsuckerdatum.bloodsucker_level_unspent <= 0)
			return
		// Did you choose a power?
		if(!choice || !options[choice])
			to_chat(bloodsuckerdatum.owner.current, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return
		// Prevent Bloodsuckers from closing/reopning their coffin to spam Levels.
		if(locate(options[choice]) in bloodsuckerdatum.powers)
			to_chat(bloodsuckerdatum.owner.current, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return
		// Prevent Bloodsuckers from purchasing a power while outside of their Coffin.
		if(!istype(bloodsuckerdatum.owner.current.loc, /obj/structure/closet/crate/coffin))
			to_chat(bloodsuckerdatum.owner.current, span_warning("You must be in your Coffin to purchase Powers."))
			return

		// Good to go - Buy Power!
		var/datum/action/bloodsucker/purchased_power = options[choice]
		bloodsuckerdatum.BuyPower(new purchased_power)
		bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "learned [choice]!")
		to_chat(bloodsuckerdatum.owner.current, span_notice("You have learned how to use [choice]!"))

	finalize_spend_rank(bloodsuckerdatum, cost_rank, blood_cost)

/datum/bloodsucker_clan/proc/finalize_spend_rank(datum/antagonist/bloodsucker/bloodsuckerdatum, cost_rank = TRUE, blood_cost)
	bloodsuckerdatum.LevelUpPowers()
	bloodsuckerdatum.bloodsucker_regen_rate += 0.05
	bloodsuckerdatum.max_blood_volume += 100

	if(ishuman(bloodsuckerdatum.owner.current))
		var/mob/living/carbon/human/human_user = bloodsuckerdatum.owner.current
		var/datum/species/user_species = human_user.dna.species
		user_species.punchdamagelow += 0.5
		// This affects the hitting power of Brawn.
		user_species.punchdamagehigh += 0.5

	// We're almost done - Spend your Rank now.
	bloodsuckerdatum.bloodsucker_level++
	if(cost_rank)
		bloodsuckerdatum.bloodsucker_level_unspent--
	if(blood_cost)
		bloodsuckerdatum.AddBloodVolume(-blood_cost)

	// Ranked up enough to get your true Reputation?
	if(bloodsuckerdatum.bloodsucker_level == 4)
		bloodsuckerdatum.SelectReputation(am_fledgling = FALSE, forced = TRUE)

	to_chat(bloodsuckerdatum.owner.current, span_notice("You are now a rank [bloodsuckerdatum.bloodsucker_level] Bloodsucker. \
		Your strength, health, feed rate, regen rate, and maximum blood capacity have all increased! \n\
		* Your existing powers have all ranked up as well!"))
	bloodsuckerdatum.owner.current.playsound_local(null, 'sound/effects/pope_entry.ogg', 25, TRUE, pressure_affected = FALSE)
	bloodsuckerdatum.update_hud()

/**
 * Called when we are trying to turn someone into a Favorite Vassal
 * args:
 * bloodsuckerdatum - the antagonist datum of the Bloodsucker performing this.
 * vassaldatum - the antagonist datum of the Vassal being offered up.
 */
/datum/bloodsucker_clan/proc/on_offer_favorite(datum/source, datum/antagonist/bloodsucker/bloodsuckerdatum, datum/antagonist/vassal/vassaldatum)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, .proc/offer_favorite, bloodsuckerdatum, vassaldatum)

/datum/bloodsucker_clan/proc/offer_favorite(datum/antagonist/bloodsucker/bloodsuckerdatum, datum/antagonist/vassal/vassaldatum)
	to_chat(bloodsuckerdatum.owner.current, span_notice("Would you like to turn this Vassal into your completely loyal Servant? This costs 150 Blood to do. You cannot undo this."))
	var/list/favorite_options = list(
		"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
		"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no"),
	)
	var/favorite_response = show_radial_menu(bloodsuckerdatum.owner.current, vassaldatum.owner.current, favorite_options, radius = 36, require_near = TRUE)
	switch(favorite_response)
		if("Yes")
			bloodsuckerdatum.bloodsucker_blood_volume -= 150
			bloodsuckerdatum.has_favorite_vassal = TRUE
			vassaldatum.make_favorite(bloodsuckerdatum.owner.current)
		else
			to_chat(bloodsuckerdatum.owner.current, span_danger("You decide not to turn [vassaldatum.owner.current] into your Favorite Vassal."))

/**
 * Called when we are successfully turn a Vassal into a Favorite Vassal
 * args:
 * vassaldatum - the antagonist datum of the Vassal being offered up.
 * bloodsucker - mob of the Bloodsucker who turned them into a Vassal.
 */
/datum/bloodsucker_clan/proc/on_favorite_vassal(datum/source, datum/antagonist/vassal/vassaldatum, mob/living/bloodsucker)
	SIGNAL_HANDLER
	vassaldatum.BuyPower(new /datum/action/bloodsucker/targeted/brawn)
