/* 		Getting Flaws:
 *
 *	Killing crew
 *
 *	Gaining ranks
 *
 *
 *
 * 			* COMPULSION *  	Things you must do
 *
 *	SELECTIVE:		-Gender/BloodType/Job sustains you, but others give you less.
 *
 *
 *
 *
 * 			* WEAKNESSES *  	Things that may harm you
 *
 *	LIGHTS:			-Bright light nullifies the Examine benefits of Masquerade.
 *  				-Bright lights disable your healing (including in Torpor)
 *
 *	STAKES:			-Stakes kill you immediately.
 *
 *	PAINFUL:		-Your feed victims scream, despite being unconscious.
 *
 *	FIRE:			-You only need your max health (not x2) in fire damage to die.
 *
 *	CORPSE:			-Your Masquerade turns off when unconscious or crit.
 *
 *	FERAL:			-
 *
 *	CRAVEN
 *
 *
 *			// BANES //
 *
 *	These are basically small weaknesses that affect your character in certain circumstances.
 *  As a rule, they should be specific as to when they happen, or have only some certain
 *  drawback.
 *
 * (core ideas)
 * SENSITIVE: 	You are slightly blinded by bright lights.
 * DARKFRIEND: 	Your automatic healing is at a crawl when in bright light.
 * TRADITIONAL:	Every five minutes spent outside a coffin lowers your rate of automatic healing.
 * CONSUMED:	Every five minutes spent outside a coffin increases the rate at which your blood ticks down.
 * GOURMAND:	Animals and blood bags offer you no nourishment when feeding.
 * DEATHMASK:	You no longer fake having a heartbeat, and always show up as pale when examined.
 * BESTIAL:		When your blood is low, you will twitch involuntarily.
 *
 * (alternate ideas)
 * STERILE:		There is a high chance that turning corpses to Bloodsuckers will fail, and further attempts on them by you are impossible.
 * FERAL:		You're a threat to Vampire-kind: New Bloodsuckers may have an Objective to destroy you.
 * UNHOLY:		The Chapel, the Bible, and Holy Water set you on fire.
 * PARANOID:	Only your own claimed coffin counts for healing and banes.
 *
 *
 * 	ON LEVEL-UP:
 * Burn Damage increases
 * Regen Rate increases
 * Max Punch Damage increase
 * Reset Level Timer
 * Select Bane
 *
 *
 * How to Burn Vamps:
 *		C.adjustFireLoss(20)
 *		C.adjust_fire_stacks(6)
 *		C.IgniteMob()
 */


/datum/antagonist/bloodsucker/proc/AssignClanAndBane()
	var/static/list/clans = list(
		CLAN_BRUJAH,
		CLAN_NOSFERATU,
		CLAN_TREMERE,
		CLAN_VENTRUE,
		CLAN_MALKAVIAN,
		)
	var/list/options = list()
	options = clans
	var/mob/living/carbon/human/bloodsucker = owner.current
	/// Beefmen can't be Malkavian, they already get all the side effects from it.
	if(isbeefman(bloodsucker))
		options -= CLAN_MALKAVIAN
	/// Brief descriptions in case they don't read the Wiki.
	to_chat(owner, "<span class='announce'>List of all Clans:<br> \
		Brujah - Prone to Frenzy, Brawn buffed.<br> \
		Nosferatu - Disfigured, no Masquerade, Ventcrawl.<br> \
		Tremere - Burn in the Chapel, Vassal Mutilation.<br> \
		Ventrue - Cant drink from mindless mobs, can't level up, raise a vassal instead.<br></span>")
	if(!isbeefman(bloodsucker))
		to_chat(owner, "<span class='announce'>Malakavian - Hallucinations and Bluespace prophet.<br></span>")
	to_chat(owner, "<span class='announce'>* Read more about Clans here: https://wiki.fulp.gg/en/Bloodsucker.<br></span>")

	var/answer = tgui_input_list(owner.current, "You have Ranked up far enough to remember your clan. Which clan are you part of?", "Our mind feels luxurious...", options)
	switch(answer)
		if(CLAN_BRUJAH)
			my_clan = CLAN_BRUJAH
			to_chat(owner, "<span class='announce'>You have Ranked up enough to learn: You are part of the Brujah Clan!<br> \
				* As part of the Bujah Clan, you are more prone to falling into Frenzy, don't let your blood drop too low!<br> \
				* Additionally, Brawn and punches deal more damage than other Bloodsuckers. Use this to your advantage!</span>")
			/// Makes their max punch, and by extension Brawn, stronger - Stolen from SpendRank()
			var/datum/species/S = bloodsucker.dna.species
			S.punchdamagehigh += 1.5
			return
		if(CLAN_NOSFERATU)
			my_clan = CLAN_NOSFERATU
			to_chat(owner, "<span class='announce'>You have Ranked up enough to learn: You are part of the Nosferatu Clan!<br> \
				* As part of the Nosferatu Clan, you are less interested in disguising yourself within the crew, as such you do not know how to use the Masquerade ability.<br> \
				* Additionally, in exchange for having a bad back and not being identifiable, you can fit into vents using Alt+Click</span>")
			for(var/datum/action/bloodsucker/power in powers)
				if(istype(power, /datum/action/bloodsucker/masquerade))
					powers -= power
					power.Remove(owner.current)
			if(!bloodsucker.has_quirk(/datum/quirk/badback))
				bloodsucker.add_quirk(/datum/quirk/badback)
			if(!HAS_TRAIT(bloodsucker, TRAIT_VENTCRAWLER_ALWAYS))
				ADD_TRAIT(bloodsucker, TRAIT_VENTCRAWLER_ALWAYS, BLOODSUCKER_TRAIT)
			if(!HAS_TRAIT(bloodsucker, TRAIT_DISFIGURED))
				ADD_TRAIT(bloodsucker, TRAIT_DISFIGURED, BLOODSUCKER_TRAIT)
			return
		if(CLAN_TREMERE)
			my_clan = CLAN_TREMERE
			to_chat(owner, "<span class='announce'>You have Ranked up enough to learn: You are part of the Tremere Clan!<br> \
				* As part of the Tremere Clan, you are weak to Anti-magic, and will catch fire if you enter the Chapel.<br> \
				* Additionally, you magically protect your Vassals from being disconnected with you via Mindshielding, and can mutilate them by putting them on a persuasion rack.<br> \
				* Finally, you can revive dead non-Vassals by using the Persuasion Rack as they lie on it.</span>")
			return
		if(CLAN_VENTRUE) // WILLARD TODO: Make a Ventrue-unique objective to drink X amount of Blood?
			my_clan = CLAN_VENTRUE
			to_chat(owner, "<span class='announce'>You have Ranked up enough to learn: You are part of the Ventrue Clan!<br> \
				* As part of the Ventrue Clan, you are extremely snobby with your meals, and refuse to drink blood from people without a Mind.<br> \
				* Additionally, you will no longer Rank up. You are now instead able to get a Favorite vassal, by putting a Vassal on the persuasion rack and attempting to Tortute them.<br> \
				* Finally, you may Rank your Favorite Vassal up by buckling them onto a Candelabrum.</span>")
			to_chat(owner, "<span class='announce'>* Bloodsucker Tip: Examine the Persuasion Rack/Candelabrum to see how they operate!</span>")
			return
		if(CLAN_MALKAVIAN)
			my_clan = CLAN_MALKAVIAN
			to_chat(owner, "<span class='announce'>You have Ranked up enough to learn: You are part of the Malkavian Clan!<br> \
				* As part of the Malkavian Clan, you see the world in a different way, suffering hallucinations and seeing strange portals everywhere.</span>")
			// WILLARD TODO: Make Masquerade hide brain traumas? Unless you're a Beefman, that is. Also applies to Frenzy.
			bloodsucker.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
			bloodsucker.gain_trauma(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
			return

		else
			to_chat(owner, "<span class='warning'>You have wilingfully decided to stay ignorant.</span>")
			return
