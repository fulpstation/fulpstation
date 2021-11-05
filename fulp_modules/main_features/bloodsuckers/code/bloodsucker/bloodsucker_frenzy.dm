
/**
 * # FrenzyGrab
 *
 * The martial art given to Bloodsuckers so they can instantly aggressively grab people.
 */
/datum/martial_art/frenzygrab
	name = "Frenzy Grab"
	id = MARTIALART_FRENZYGRAB

/datum/martial_art/frenzygrab/grab_act(mob/living/user, mob/living/target)
	if(user != target)
		target.grabbedby(user)
		target.grippedby(user, instant = TRUE)
		return TRUE
	..()

/**
 * # Status effect
 *
 * This is the status effect given to Bloodsuckers in a Frenzy
 * This deals with everything entering/exiting Frenzy is meant to deal with.
 */

/datum/status_effect/frenzy
	id = "Frenzy"
	status_type = STATUS_EFFECT_UNIQUE
	duration = -1
	tick_interval = 10
	examine_text = "<span class='notice'>They seem... inhumane, and feral!</span>"
	alert_type = /atom/movable/screen/alert/status_effect/frenzy
	/// Store whether they were a tool user to return afterwards.
	var/was_tooluser = FALSE
	/// The stored Bloodsucker antag datum
	var/datum/antagonist/bloodsucker/bloodsuckerdatum

/atom/movable/screen/alert/status_effect/frenzy
	name = "Frenzy"
	desc = "You are in a Frenzy! You are entirely Feral and, depending on your Clan, fighting for your life!"
	icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	icon_state = "power_recover"
	alerttooltipstyle = "cult"

/atom/movable/screen/alert/status_effect/masquerade/MouseEntered(location,control,params)
	desc = initial(desc)
	return ..()

/datum/status_effect/frenzy/on_apply()
	var/mob/living/carbon/human/user = owner
	bloodsuckerdatum = IS_BLOODSUCKER(user)

	// Disable ALL Powers
	if(bloodsuckerdatum.my_clan != CLAN_BRUJAH)
		bloodsuckerdatum.DisableAllPowers()
	owner.balloon_alert(owner, "you enter a frenzy!")

	// Notify their entry
	if(bloodsuckerdatum.my_clan != CLAN_BRUJAH)
		to_chat(owner, span_userdanger("<FONT size = 3>Blood! You need Blood, now! You enter a total Frenzy!"))
		to_chat(owner, span_announce("* Bloodsucker Tip: While in Frenzy, you instantly Aggresively grab, have stun resistance, cannot speak, hear, or use any powers outside of Feed and Trespass (If you have it)."))

	// Stamina resistances
	if(bloodsuckerdatum.my_clan == CLAN_MALKAVIAN)
		ADD_TRAIT(owner, TRAIT_STUNIMMUNE, FRENZY_TRAIT)
	else if(bloodsuckerdatum.my_clan != CLAN_BRUJAH)
		user.physiology.stamina_mod *= 0.4

	// Give the other Frenzy effects
	ADD_TRAIT(owner, TRAIT_MUTE, FRENZY_TRAIT)
	ADD_TRAIT(owner, TRAIT_DEAF, FRENZY_TRAIT)
	if(HAS_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER))
		was_tooluser = TRUE
		REMOVE_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/dna_vault_speedup)
	bloodsuckerdatum.frenzygrab.teach(user, TRUE)
	owner.add_client_colour(/datum/client_colour/cursed_heart_blood)
	var/obj/cuffs = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	var/obj/legcuffs = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	if(user.handcuffed || user.legcuffed)
		user.clear_cuffs(cuffs, TRUE)
		user.clear_cuffs(legcuffs, TRUE)
	// Keep track of how many times we've entered a Frenzy.
	bloodsuckerdatum.frenzies += 1
	bloodsuckerdatum.frenzied = TRUE
	return ..()

/datum/status_effect/frenzy/on_remove()
	var/mob/living/carbon/human/user = owner
	owner.balloon_alert(owner, "you come back to your senses.")
	REMOVE_TRAIT(owner, TRAIT_STUNIMMUNE, FRENZY_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_MUTE, FRENZY_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_DEAF, FRENZY_TRAIT)
	if(was_tooluser)
		ADD_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
		was_tooluser = FALSE
	if(bloodsuckerdatum.my_clan != CLAN_BRUJAH)
		owner.Dizzy(3 SECONDS)
		owner.Paralyze(2 SECONDS)
	if(bloodsuckerdatum.my_clan != CLAN_MALKAVIAN)
		user.physiology.stamina_mod *= 0.4
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/dna_vault_speedup)
	bloodsuckerdatum.frenzygrab.remove(user)
	owner.remove_client_colour(/datum/client_colour/cursed_heart_blood)
	bloodsuckerdatum.frenzied = FALSE
	return ..()

/datum/status_effect/frenzy/tick()
	var/mob/living/carbon/human/user = owner
	if(!bloodsuckerdatum.frenzied)
		return
	if(bloodsuckerdatum.my_clan == CLAN_BRUJAH)
		user.adjustBruteLoss(1 + (bloodsuckerdatum.humanity_lost / 10))
	else
		user.adjustFireLoss(1.5 + (bloodsuckerdatum.humanity_lost / 10))
