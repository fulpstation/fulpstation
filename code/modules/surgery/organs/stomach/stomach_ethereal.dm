/obj/item/organ/stomach/ethereal
	name = "biological battery"
	icon_state = "stomach-p" //Welp. At least it's more unique in functionaliy.
	desc = "A crystal-like organ that stores the electric charge of ethereals."
	///basically satiety but electrical
	var/crystal_charge = ETHEREAL_CHARGE_FULL
	///used to keep ethereals from spam draining power sources
	var/drain_time = 0

/obj/item/organ/stomach/ethereal/on_life(delta_time, times_fired)
	. = ..()
	adjust_charge(-ETHEREAL_CHARGE_FACTOR * delta_time)
	handle_charge(owner, delta_time, times_fired)

/obj/item/organ/stomach/ethereal/Insert(mob/living/carbon/carbon, special = 0)
	. = ..()
	RegisterSignal(owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, .proc/charge)
	RegisterSignal(owner, COMSIG_LIVING_ELECTROCUTE_ACT, .proc/on_electrocute)
	ADD_TRAIT(owner, TRAIT_NOHUNGER, src)

/obj/item/organ/stomach/ethereal/Remove(mob/living/carbon/carbon, special = 0)
	UnregisterSignal(owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT)
	UnregisterSignal(owner, COMSIG_LIVING_ELECTROCUTE_ACT)
	REMOVE_TRAIT(owner, TRAIT_NOHUNGER, src)

	carbon.clear_alert("ethereal_charge")
	carbon.clear_alert("ethereal_overcharge")

	return ..()

/obj/item/organ/stomach/ethereal/handle_hunger_slowdown(mob/living/carbon/human/human)
	human.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/hunger, multiplicative_slowdown = (1.5 * (1 - crystal_charge / 100)))

/obj/item/organ/stomach/ethereal/proc/charge(datum/source, amount, repairs)
	SIGNAL_HANDLER
	adjust_charge(amount / 3.5)

/obj/item/organ/stomach/ethereal/proc/on_electrocute(datum/source, shock_damage, siemens_coeff = 1, flags = NONE)
	SIGNAL_HANDLER
	if(flags & SHOCK_ILLUSION)
		return
	adjust_charge(shock_damage * siemens_coeff * 2)
	to_chat(owner, span_notice("You absorb some of the shock into your body!"))

/obj/item/organ/stomach/ethereal/proc/adjust_charge(amount)
	crystal_charge = clamp(crystal_charge + amount, ETHEREAL_CHARGE_NONE, ETHEREAL_CHARGE_DANGEROUS)

/obj/item/organ/stomach/ethereal/proc/handle_charge(mob/living/carbon/carbon, delta_time, times_fired)
	switch(crystal_charge)
		if(-INFINITY to ETHEREAL_CHARGE_NONE)
			carbon.throw_alert("ethereal_charge", /atom/movable/screen/alert/emptycell/ethereal)
			if(carbon.health > 10.5)
				carbon.apply_damage(0.65, TOX, null, null, carbon)
		if(ETHEREAL_CHARGE_NONE to ETHEREAL_CHARGE_LOWPOWER)
			carbon.throw_alert("ethereal_charge", /atom/movable/screen/alert/lowcell/ethereal, 3)
			if(carbon.health > 10.5)
				carbon.apply_damage(0.325 * delta_time, TOX, null, null, carbon)
		if(ETHEREAL_CHARGE_LOWPOWER to ETHEREAL_CHARGE_NORMAL)
			carbon.throw_alert("ethereal_charge", /atom/movable/screen/alert/lowcell/ethereal, 2)
		if(ETHEREAL_CHARGE_FULL to ETHEREAL_CHARGE_OVERLOAD)
			carbon.throw_alert("ethereal_overcharge", /atom/movable/screen/alert/ethereal_overcharge, 1)
			carbon.apply_damage(0.2, TOX, null, null, carbon)
		if(ETHEREAL_CHARGE_OVERLOAD to ETHEREAL_CHARGE_DANGEROUS)
			carbon.throw_alert("ethereal_overcharge", /atom/movable/screen/alert/ethereal_overcharge, 2)
			carbon.apply_damage(0.325 * delta_time, TOX, null, null, carbon)
			if(DT_PROB(5, delta_time)) // 5% each seacond for ethereals to explosively release excess energy if it reaches dangerous levels
				discharge_process(carbon)
		else
			carbon.clear_alert("ethereal_charge")
			carbon.clear_alert("ethereal_overcharge")

/obj/item/organ/stomach/ethereal/proc/discharge_process(mob/living/carbon/carbon)
	to_chat(carbon, span_warning("You begin to lose control over your charge!"))
	carbon.visible_message(span_danger("[carbon] begins to spark violently!"))

	var/static/mutable_appearance/overcharge //shameless copycode from lightning spell
	overcharge = overcharge || mutable_appearance('icons/effects/effects.dmi', "electricity", EFFECTS_LAYER)
	carbon.add_overlay(overcharge)

	if(do_after(carbon, 5 SECONDS, timed_action_flags = (IGNORE_USER_LOC_CHANGE|IGNORE_HELD_ITEM|IGNORE_INCAPACITATED)))
		if(ishuman(carbon))
			var/mob/living/carbon/human/human = carbon
			if(human.dna?.species)
				//fixed_mut_color is also ethereal color (for some reason)
				carbon.flash_lighting_fx(5, 7, human.dna.species.fixed_mut_color ? human.dna.species.fixed_mut_color : human.dna.features["mcolor"])

		playsound(carbon, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
		carbon.cut_overlay(overcharge)
		tesla_zap(carbon, 2, crystal_charge*2.5, ZAP_OBJ_DAMAGE | ZAP_ALLOW_DUPLICATES)
		adjust_charge(ETHEREAL_CHARGE_FULL - crystal_charge)
		to_chat(carbon, span_warning("You violently discharge energy!"))
		carbon.visible_message(span_danger("[carbon] violently discharges energy!"))

		if(prob(10)) //chance of developing heart disease to dissuade overcharging oneself
			var/datum/disease/D = new /datum/disease/heart_failure
			carbon.ForceContractDisease(D)
			to_chat(carbon, span_userdanger("You're pretty sure you just felt your heart stop for a second there.."))
			carbon.playsound_local(carbon, 'sound/effects/singlebeat.ogg', 100, 0)

		carbon.Paralyze(100)
