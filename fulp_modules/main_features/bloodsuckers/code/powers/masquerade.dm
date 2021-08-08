/* 		WITHOUT THIS POWER:
 *	- Mid-Blood: SHOW AS PALE
 *	- Low-Blood: SHOW AS DEAD
 *	- No Heartbeat
 *  - Examine shows actual blood
 *	- Thermal homeostasis (ColdBlooded)
 * 		WITH THIS POWER:
 *	- Normal body temp -- remove Cold Blooded (return on deactivate)
 */

/datum/action/bloodsucker/masquerade
	name = "Masquerade"
	desc = "Feign the vital signs of a mortal, and escape both casual and medical notice as the monster you truly are."
	button_icon_state = "power_human"
	bloodcost = 10
	cooldown = 50
	amToggle = TRUE
	bloodsucker_can_buy = FALSE
	warn_constant_cost = TRUE
	can_use_in_torpor = TRUE
	cooldown_static = TRUE
	must_be_concious = FALSE

/datum/action/bloodsucker/masquerade/ActivatePower(mob/living/carbon/user = owner)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner)
	to_chat(user, span_notice("Your heart beats falsely within your lifeless chest. You may yet pass for a mortal."))
	to_chat(user, span_warning("Your vampiric healing is halted while imitating life."))

	bloodsuckerdatum.poweron_masquerade = TRUE
	user.apply_status_effect(STATUS_EFFECT_MASQUERADE)
	. = ..()

/datum/action/bloodsucker/masquerade/UsePower(mob/living/carbon/user)
	// Checks that we can keep using this.
	if(!..())
		return
	// Check every few seconds to make sure we're still able to use the power.
	addtimer(CALLBACK(src, .proc/UsePower, user), 2 SECONDS)

/datum/action/bloodsucker/masquerade/ContinueActive(mob/living/user)
	// Disable if unable to use power anymore.
//	if(user.stat == DEAD || user.blood_volume <= 0) // not conscious or soft critor uncon, just dead
//		return FALSE
	return ..() // Active, and still Antag

/datum/action/bloodsucker/masquerade/DeactivatePower(mob/living/carbon/user = owner, mob/living/target)
	. = ..() // activate = FALSE

	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	bloodsuckerdatum.poweron_masquerade = FALSE
	user.remove_status_effect(STATUS_EFFECT_MASQUERADE)

/*
 *	# Status effect
 *
 *	This is what the Masquerade power gives, handles their bonuses and gives them a neat icon to tell them they're on Masquerade.
 */

/datum/status_effect/masquerade
	id = "masquerade"
	duration = -1
	tick_interval = 20
	alert_type = /atom/movable/screen/alert/status_effect/masquerade

/atom/movable/screen/alert/status_effect/masquerade
	name = "Masquerade"
	desc = "You are currently hiding your identity using the Masquerade power. This halts Vampiric healing."
	icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	icon_state = "power_human"
	alerttooltipstyle = "cult"

/atom/movable/screen/alert/status_effect/masquerade/MouseEntered(location,control,params)
	desc = initial(desc)
	return ..()

/datum/status_effect/masquerade/on_apply(mob/living/carbon/user = owner)
	// Remove Bloodsucker traits
	REMOVE_TRAIT(user, TRAIT_NOHARDCRIT, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_NOSOFTCRIT, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_VIRUSIMMUNE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_RADIMMUNE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_TOXIMMUNE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_COLDBLOODED, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_RESISTCOLD, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_NOPULSE, BLOODSUCKER_TRAIT)
	// Falsifies Health & Genetic Analyzers
	ADD_TRAIT(user, TRAIT_MASQUERADE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_GENELESS, SPECIES_TRAIT)
	// Organs
	var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
	eyes.flash_protect = initial(eyes.flash_protect)
	var/obj/item/organ/heart/vampheart/vampheart = user.getorganslot(ORGAN_SLOT_HEART)
	if(istype(vampheart))
		vampheart.FakeStart()
	return ..()

/datum/status_effect/masquerade/tick()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner)
	// PASSIVE (Done from LIFE
	// Don't show Pale/Dead on low blood - Don't vomit food - Don't heal.
	if(owner.stat == CONSCIOUS) // Pay Blood Toll if awake.
		bloodsuckerdatum.AddBloodVolume(-0.1)

/datum/status_effect/masquerade/on_remove(mob/living/carbon/user = owner)
	ADD_TRAIT(user, TRAIT_NOHARDCRIT, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_NOSOFTCRIT, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_VIRUSIMMUNE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_RADIMMUNE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_TOXIMMUNE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_COLDBLOODED, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_RESISTCOLD, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_NOPULSE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_MASQUERADE, BLOODSUCKER_TRAIT)
	// Remove genes, then make unable to get new ones.
	user.dna.remove_all_mutations()
	ADD_TRAIT(user, TRAIT_GENELESS, SPECIES_TRAIT)
	// Organs
	var/obj/item/organ/heart/vampheart/vampheart = user.getorganslot(ORGAN_SLOT_HEART)
	if(istype(vampheart))
		vampheart.Stop()
	var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.flash_protect = max(initial(eyes.flash_protect) - 1, FLASH_PROTECTION_SENSITIVE)
	// Remove all diseases
	for(var/thing in user.diseases)
		var/datum/disease/disease = thing
		disease.cure()
	to_chat(user, span_notice("Your heart beats one final time, while your skin dries out and your icy pallor returns."))
