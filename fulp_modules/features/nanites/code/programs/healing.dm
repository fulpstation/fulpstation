/datum/nanite_program/regenerative
	name = "Accelerated Regeneration"
	desc = "The nanites boost the host's natural regeneration, increasing their healing speed. Does not consume nanites if the host is unharmed."
	use_rate = 0.5
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/regenerative/check_conditions()
	if(!host_mob.getBruteLoss() && !host_mob.getFireLoss())
		return FALSE
	if(iscarbon(host_mob))
		var/mob/living/carbon/host_carbon = host_mob
		var/list/parts = host_carbon.get_damaged_bodyparts(brute = TRUE, burn = TRUE, required_bodytype = BODYTYPE_ORGANIC)
		if(!parts.len)
			return FALSE
	return ..()

/datum/nanite_program/regenerative/active_effect()
	if(iscarbon(host_mob))
		var/mob/living/carbon/host_carbon = host_mob
		var/list/parts = host_carbon.get_damaged_bodyparts(brute = TRUE, burn = TRUE, required_bodytype = BODYTYPE_ORGANIC)
		if(!parts.len)
			return
		for(var/obj/item/bodypart/bodyparts as anything in parts)
			if(bodyparts.heal_damage(0.5 / parts.len, 0.5 / parts.len, null, required_bodytype = BODYTYPE_ORGANIC))
				host_mob.update_damage_overlays()
	else
		host_mob.adjustBruteLoss(-0.5, TRUE)
		host_mob.adjustFireLoss(-0.5, TRUE)

/datum/nanite_program/temperature
	name = "Temperature Adjustment"
	desc = "The nanites adjust the host's internal temperature to an ideal level. Does not consume nanites if the host has a nominal temperature."
	use_rate = 3.5
	rogue_types = list(/datum/nanite_program/skin_decay)

/datum/nanite_program/temperature/check_conditions()
	if(host_mob.bodytemperature > (host_mob.get_body_temp_normal(apply_change = FALSE) - 30) && host_mob.bodytemperature < (host_mob.get_body_temp_normal(apply_change = FALSE) + 30))
		return FALSE
	return ..()

/datum/nanite_program/temperature/active_effect()
	if(host_mob.bodytemperature > host_mob.get_body_temp_normal(apply_change=FALSE))
		host_mob.adjust_bodytemperature(-40 * TEMPERATURE_DAMAGE_COEFFICIENT, host_mob.get_body_temp_normal(apply_change=FALSE))
	else if(host_mob.bodytemperature < (host_mob.get_body_temp_normal(apply_change=FALSE) + 1))
		host_mob.adjust_bodytemperature(40 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, host_mob.get_body_temp_normal(apply_change=FALSE))

/datum/nanite_program/purging
	name = "Blood Purification"
	desc = "The nanites purge toxins and chemicals from the host's bloodstream."
	use_rate = 1
	rogue_types = list(/datum/nanite_program/suffocating, /datum/nanite_program/necrotic)

/datum/nanite_program/purging/check_conditions()
	var/foreign_reagent = length(host_mob.reagents?.reagent_list)
	if(!host_mob.getToxLoss() && !foreign_reagent)
		return FALSE
	return ..()

/datum/nanite_program/purging/active_effect()
	host_mob.adjustToxLoss(-1)
	for(var/datum/reagent/reagents as anything in host_mob.reagents.reagent_list)
		host_mob.reagents.remove_reagent(reagents.type, amount = 1)

/datum/nanite_program/brain_heal
	name = "Neural Regeneration"
	desc = "The nanites fix neural connections in the host's brain, reversing brain damage and minor traumas."
	use_rate = 1.5
	rogue_types = list(/datum/nanite_program/brain_decay)

/datum/nanite_program/brain_heal/check_conditions()
	var/problems = FALSE
	if(iscarbon(host_mob))
		var/mob/living/carbon/carbon_host = host_mob
		if(length(carbon_host.get_traumas()))
			problems = TRUE
	if(host_mob.get_organ_loss(ORGAN_SLOT_BRAIN) > 0)
		problems = TRUE
	return problems ? ..() : FALSE

/datum/nanite_program/brain_heal/active_effect()
	host_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1)
	if(iscarbon(host_mob) && prob(10))
		var/mob/living/carbon/carbon_host = host_mob
		carbon_host.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)

#define NANITE_BLOOD_RESTORE_DEFAULT 2

/datum/nanite_program/blood_restoring
	name = "Blood Regeneration"
	desc = "The nanites stimulate and boost blood cell production in the host."
	use_rate = 1
	rogue_types = list(/datum/nanite_program/suffocating)
	///The amount of blood that we restore every active effect tick.
	var/blood_restore_amount = NANITE_BLOOD_RESTORE_DEFAULT

/datum/nanite_program/blood_restoring/check_conditions()
	if(!iscarbon(host_mob))
		return FALSE
	var/mob/living/carbon/carbon_host = host_mob
	if(carbon_host.blood_volume >= BLOOD_VOLUME_SAFE)
		return FALSE
	return ..()

/datum/nanite_program/blood_restoring/active_effect()
	if(!iscarbon(host_mob))
		return
	var/mob/living/carbon/carbon_host = host_mob
	carbon_host.blood_volume += blood_restore_amount

#undef NANITE_BLOOD_RESTORE_DEFAULT

/datum/nanite_program/repairing
	name = "Mechanical Repair"
	desc = "The nanites fix damage in the host's mechanical limbs."
	use_rate = 0.5
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/repairing/check_conditions()
	if(!host_mob.getBruteLoss() && !host_mob.getFireLoss())
		return FALSE

	if(!iscarbon(host_mob))
		if(!(host_mob.mob_biotypes & MOB_ROBOTIC))
			return FALSE
		return ..()

	var/mob/living/carbon/carbon_host = host_mob
	var/list/parts = carbon_host.get_damaged_bodyparts(brute = TRUE, burn = TRUE, required_bodytype = BODYTYPE_ROBOTIC)
	if(!parts.len)
		return FALSE
	return ..()

/datum/nanite_program/repairing/active_effect(mob/living/M)
	if(!iscarbon(host_mob))
		host_mob.adjustBruteLoss(-1.5, TRUE)
		host_mob.adjustFireLoss(-1.5, TRUE)
		return
	var/mob/living/carbon/carbon_host = host_mob
	var/list/parts = carbon_host.get_damaged_bodyparts(brute = TRUE, burn = TRUE, required_bodytype = BODYTYPE_ROBOTIC)
	if(!parts.len)
		return
	var/update = FALSE
	for(var/obj/item/bodypart/bodypart as anything in parts)
		if(bodypart.heal_damage(1.5 / parts.len, 1.5 / parts.len, null, BODYTYPE_ROBOTIC)) //much faster than organic healing
			update = TRUE
	if(update)
		host_mob.update_damage_overlays()

/datum/nanite_program/purging_advanced
	name = "Selective Blood Purification"
	desc = "The nanites purge toxins and dangerous chemicals from the host's bloodstream, while ignoring beneficial chemicals. \
			The added processing power required to analyze the chemicals severely increases the nanite consumption rate."
	use_rate = 2
	rogue_types = list(/datum/nanite_program/suffocating, /datum/nanite_program/necrotic)

/datum/nanite_program/purging_advanced/check_conditions()
	var/foreign_reagent = FALSE
	for(var/datum/reagent/toxin/toxic_reagents in host_mob.reagents.reagent_list)
		foreign_reagent = TRUE
		break
	if(!host_mob.getToxLoss() && !foreign_reagent)
		return FALSE
	return ..()

/datum/nanite_program/purging_advanced/active_effect()
	host_mob.adjustToxLoss(-1)
	for(var/datum/reagent/toxin/toxic_reagents in host_mob.reagents.reagent_list)
		host_mob.reagents.remove_reagent(toxic_reagents.type, 1)

/datum/nanite_program/regenerative_advanced
	name = "Bio-Reconstruction"
	desc = "The nanites manually repair and replace organic cells, acting much faster than normal regeneration. \
			However, this program cannot detect the difference between harmed and unharmed, causing it to consume nanites even if it has no effect."
	use_rate = 5.5
	rogue_types = list(/datum/nanite_program/suffocating, /datum/nanite_program/necrotic)

/datum/nanite_program/regenerative_advanced/active_effect()
	if(!iscarbon(host_mob))
		host_mob.adjustBruteLoss(-3, TRUE)
		host_mob.adjustFireLoss(-3, TRUE)
		return
	var/mob/living/carbon/carbon_host = host_mob
	var/list/parts = carbon_host.get_damaged_bodyparts(brute = TRUE, burn = TRUE, required_bodytype = BODYTYPE_ORGANIC)
	if(!parts.len)
		return
	var/update = FALSE
	for(var/obj/item/bodypart/bodypart as anything in parts)
		if(bodypart.heal_damage(3 / parts.len, 3 / parts.len, null, BODYTYPE_ORGANIC))
			update = TRUE
	if(update)
		host_mob.update_damage_overlays()

/datum/nanite_program/brain_heal_advanced
	name = "Neural Reimaging"
	desc = "The nanites are able to backup and restore the host's neural connections, potentially replacing entire chunks of missing or damaged brain matter."
	use_rate = 3
	rogue_types = list(/datum/nanite_program/brain_decay, /datum/nanite_program/brain_misfire)

/datum/nanite_program/brain_heal_advanced/check_conditions()
	var/problems = FALSE
	if(iscarbon(host_mob))
		var/mob/living/carbon/carbon_host = host_mob
		if(length(carbon_host.get_traumas()))
			problems = TRUE
	if(host_mob.get_organ_loss(ORGAN_SLOT_BRAIN) > 0)
		problems = TRUE
	return problems ? ..() : FALSE

/datum/nanite_program/brain_heal_advanced/active_effect()
	host_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, -2)
	if(iscarbon(host_mob) && prob(10))
		var/mob/living/carbon/carbon_host = host_mob
		carbon_host.cure_trauma_type(resilience = TRAUMA_RESILIENCE_LOBOTOMY)

/datum/nanite_program/defib
	name = "Defibrillation"
	desc = "The nanites shock the host's heart when triggered, bringing them back to life if the body can sustain it."
	can_trigger = TRUE
	trigger_cost = 25
	trigger_cooldown = 120
	rogue_types = list(/datum/nanite_program/shocking)

/datum/nanite_program/defib/on_trigger(comm_message)
	host_mob.notify_revival("Your heart is being defibrillated by nanites. Re-enter your corpse if you want to be revived!")
	addtimer(CALLBACK(src, PROC_REF(start_defibrilation)), 5 SECONDS)

/datum/nanite_program/defib/proc/check_revivable()
	if(!iscarbon(host_mob))
		return FALSE
	var/mob/living/carbon/carbon_host = host_mob
	return carbon_host.can_defib()

/datum/nanite_program/defib/proc/start_defibrilation()
	playsound(host_mob, 'sound/machines/defib_charge.ogg', 50, FALSE)
	addtimer(CALLBACK(src, PROC_REF(perform_defibrilation)), 3 SECONDS)

/datum/nanite_program/defib/proc/perform_defibrilation()
	var/mob/living/carbon/carbon_host = host_mob
	playsound(carbon_host, 'sound/machines/defib_zap.ogg', 50, FALSE)
	if(!check_revivable())
		playsound(carbon_host, 'sound/machines/defib_failed.ogg', 50, FALSE)
		return
	playsound(carbon_host, 'sound/machines/defib_success.ogg', 50, FALSE)
	carbon_host.set_heartattack(FALSE)
	carbon_host.revive()
	carbon_host.emote("gasp")
	carbon_host.set_timed_status_effect(10 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	SEND_SIGNAL(carbon_host, COMSIG_LIVING_MINOR_SHOCK)
	log_game("[carbon_host] has been successfully defibrillated by nanites.")
