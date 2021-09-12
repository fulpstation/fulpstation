/datum/component/bloodsucker_frenzy
	var/datum/antagonist/bloodsucker/bloodsuckerdatum

/datum/component/bloodsucker_frenzy/Initialize(antag)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_LIVING_BIOLOGICAL_LIFE, .proc/FrenzyLifeTick)
	var/mob/living/carbon/human/user = parent
	bloodsuckerdatum = IS_BLOODSUCKER(user)
	// Disable ALL Powers -- Do it here to prevent things like Fortitude's deactivate cancelling our stun immunity.
	if(bloodsuckerdatum.my_clan != CLAN_BRUJAH)
		bloodsuckerdatum.DisableAllPowers()
	// Special Brujah check
	if(bloodsuckerdatum.my_clan == CLAN_BRUJAH)
		user.balloon_alert(parent, "you enter a frenzy!")
		to_chat(parent, span_announce("While in Frenzy, you gain the ability to instantly aggressively grab people, move faster, get stun resistance, and have no blood cost on abilities.<br> \n\
		* In exchange, you will slowly gain Brute damage, cannot speak, hear, or use advanced machineries. Be careful of how you handle it!<br> \n\
		* To leave Frenzy, simply drink enough Blood ([FRENZY_THRESHOLD_EXIT]) to exit.<br>"))
	else
		to_chat(parent, span_userdanger("<FONT size = 3>Blood! You need Blood, now! You enter a total Frenzy!"))
		to_chat(parent, span_announce("* Bloodsucker Tip: While in Frenzy, you instantly Aggresively grab, have stun resistance, cannot speak, hear, or use any powers outside of Feed and Trespass (If you have it)."))

	// Special Malkavian check
	if(bloodsuckerdatum.my_clan == CLAN_MALKAVIAN)
		ADD_TRAIT(parent, TRAIT_STUNIMMUNE, FRENZY_TRAIT) // Brujah can control Frenzy properly, so they don't get any of the effects.
	else
		user.physiology.stamina_mod *= 0.4

	ADD_TRAIT(parent, TRAIT_MUTE, FRENZY_TRAIT)
	ADD_TRAIT(parent, TRAIT_DEAF, FRENZY_TRAIT)
	if(HAS_TRAIT(parent, TRAIT_ADVANCEDTOOLUSER))
		REMOVE_TRAIT(parent, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	user.add_movespeed_modifier(/datum/movespeed_modifier/dna_vault_speedup)
	bloodsuckerdatum.frenzygrab.teach(user, TRUE)
	user.add_client_colour(/datum/client_colour/cursed_heart_blood)//bloodlust) <-- You can barely see shit, cant even see anyone to feed off of them.
	var/obj/cuffs = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	var/obj/legcuffs = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	if(user.handcuffed || user.legcuffed)
		user.clear_cuffs(cuffs, TRUE)
		user.clear_cuffs(legcuffs, TRUE)
	// Keep track of how many times we've entered a Frenzy.
	bloodsuckerdatum.Frenzies += 1
	bloodsuckerdatum.Frenzied = TRUE

/datum/component/bloodsucker_frenzy/Destroy(force, silent)
	UnregisterSignal(parent, COMSIG_LIVING_BIOLOGICAL_LIFE)
	var/mob/living/carbon/human/user = parent
	user.balloon_alert(parent, "you come back to your senses.")
	REMOVE_TRAIT(parent, TRAIT_STUNIMMUNE, FRENZY_TRAIT)
	REMOVE_TRAIT(parent, TRAIT_MUTE, FRENZY_TRAIT)
	REMOVE_TRAIT(parent, TRAIT_DEAF, FRENZY_TRAIT)
	ADD_TRAIT(parent, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	if(bloodsuckerdatum.my_clan != CLAN_BRUJAH)
		user.Dizzy(3 SECONDS)
		user.Paralyze(2 SECONDS)
	if(bloodsuckerdatum.my_clan != CLAN_MALKAVIAN)
		user.physiology.stamina_mod *= 0.4
	user.remove_movespeed_modifier(/datum/movespeed_modifier/dna_vault_speedup)
	bloodsuckerdatum.frenzygrab.remove(user)
	user.remove_client_colour(/datum/client_colour/cursed_heart_blood)
	bloodsuckerdatum.Frenzied = FALSE
	return ..()

/datum/component/bloodsucker_frenzy/proc/FrenzyLifeTick(datum/source)
	SIGNAL_HANDLER

	var/mob/living/carbon/human/user = parent
	if(!bloodsuckerdatum.Frenzied)
		return
	if(bloodsuckerdatum.my_clan == CLAN_BRUJAH)
		user.adjustBruteLoss(1.5 + (bloodsuckerdatum.humanity_lost / 10))
	else
		user.adjustFireLoss(1.5 + (bloodsuckerdatum.humanity_lost / 10))
