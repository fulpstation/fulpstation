//backpack item
#define HALFWAYCRITDEATH ((HEALTH_THRESHOLD_CRIT + HEALTH_THRESHOLD_DEAD) * 0.5)

/obj/item/defibrillator
	name = "defibrillator"
	desc = "A device that delivers powerful shocks to detachable paddles that resuscitate incapacitated patients. \
	Has a rear bracket for attachments to wall mounts and medical cyborgs."
	icon = 'icons/obj/defib.dmi'
	icon_state = "defibunit"
	inhand_icon_state = "defibunit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	force = 5
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY
	actions_types = list(/datum/action/item_action/toggle_paddles)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 50)

	var/obj/item/shockpaddles/paddle_type = /obj/item/shockpaddles
	var/on = FALSE //if the paddles are equipped (1) or on the defib (0)
	var/safety = TRUE //if you can zap people with the defibs on harm mode
	var/powered = FALSE //if there's a cell in the defib with enough power for a revive, blocks paddles from reviving otherwise
	var/obj/item/shockpaddles/paddles
	var/obj/item/stock_parts/cell/high/cell
	var/combat = FALSE //if true, revive through hardsuits, allow for combat shocking
	var/cooldown_duration = 5 SECONDS//how long does it take to recharge

/obj/item/defibrillator/get_cell()
	return cell

/obj/item/defibrillator/Initialize() //starts without a cell for rnd
	. = ..()
	paddles = new paddle_type(src)
	update_power()
	return

/obj/item/defibrillator/loaded/Initialize() //starts with hicap
	. = ..()
	cell = new(src)
	update_power()
	return

/obj/item/defibrillator/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if(paddles?.loc == src)
		paddles.fire_act(exposed_temperature, exposed_volume)

/obj/item/defibrillator/extinguish()
	. = ..()
	if(paddles?.loc == src)
		paddles.extinguish()

/obj/item/defibrillator/proc/update_power()
	if(!QDELETED(cell))
		if(QDELETED(paddles) || cell.charge < paddles.revivecost)
			powered = FALSE
		else
			powered = TRUE
	else
		powered = FALSE
	update_appearance()

/obj/item/defibrillator/update_overlays()
	. = ..()

	if(!on)
		. += "[initial(icon_state)]-paddles"
	if(powered)
		. += "[initial(icon_state)]-powered"
		if(!QDELETED(cell))
			var/ratio = cell.charge / cell.maxcharge
			ratio = CEILING(ratio*4, 1) * 25
			. += "[initial(icon_state)]-charge[ratio]"
	if(!cell)
		. += "[initial(icon_state)]-nocell"
	if(!safety)
		. += "[initial(icon_state)]-emagged"

/obj/item/defibrillator/CheckParts(list/parts_list)
	..()
	cell = locate(/obj/item/stock_parts/cell) in contents
	update_power()

/obj/item/defibrillator/ui_action_click()
	toggle_paddles()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/defibrillator/attack_hand(mob/user, list/modifiers)
	if(loc == user)
		if(slot_flags == ITEM_SLOT_BACK)
			if(user.get_item_by_slot(ITEM_SLOT_BACK) == src)
				ui_action_click()
			else
				to_chat(user, "<span class='warning'>Put the defibrillator on your back first!</span>")

		else if(slot_flags == ITEM_SLOT_BELT)
			if(user.get_item_by_slot(ITEM_SLOT_BELT) == src)
				ui_action_click()
			else
				to_chat(user, "<span class='warning'>Strap the defibrillator's belt on first!</span>")
		return
	else if(istype(loc, /obj/machinery/defibrillator_mount))
		ui_action_click() //checks for this are handled in defibrillator.mount.dm
	return ..()

/obj/item/defibrillator/MouseDrop(obj/over_object)
	. = ..()
	if(ismob(loc))
		var/mob/M = loc
		if(!M.incapacitated() && istype(over_object, /atom/movable/screen/inventory/hand))
			var/atom/movable/screen/inventory/hand/H = over_object
			M.putItemFromInventoryInHandIfPossible(src, H.held_index)

/obj/item/defibrillator/attackby(obj/item/W, mob/user, params)
	if(W == paddles)
		toggle_paddles()
	else if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, "<span class='warning'>[src] already has a cell!</span>")
		else
			if(C.maxcharge < paddles.revivecost)
				to_chat(user, "<span class='notice'>[src] requires a higher capacity cell.</span>")
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, "<span class='notice'>You install a cell in [src].</span>")
			update_power()

	else if(W.tool_behaviour == TOOL_SCREWDRIVER)
		if(cell)
			cell.update_appearance()
			cell.forceMove(get_turf(src))
			cell = null
			to_chat(user, "<span class='notice'>You remove the cell from [src].</span>")
			update_power()
	else
		return ..()

/obj/item/defibrillator/emag_act(mob/user)
	if(safety)
		safety = FALSE
		to_chat(user, "<span class='warning'>You silently disable [src]'s safety protocols with the cryptographic sequencer.</span>")
	else
		safety = TRUE
		to_chat(user, "<span class='notice'>You silently enable [src]'s safety protocols with the cryptographic sequencer.</span>")

/obj/item/defibrillator/emp_act(severity)
	. = ..()
	if(cell && !(. & EMP_PROTECT_CONTENTS))
		deductcharge(1000 / severity)
	if (. & EMP_PROTECT_SELF)
		return
	if(safety)
		safety = FALSE
		visible_message("<span class='notice'>[src] beeps: Safety protocols disabled!</span>")
		playsound(src, 'sound/machines/defib_saftyOff.ogg', 50, FALSE)
	else
		safety = TRUE
		visible_message("<span class='notice'>[src] beeps: Safety protocols enabled!</span>")
		playsound(src, 'sound/machines/defib_saftyOn.ogg', 50, FALSE)
	update_power()

/obj/item/defibrillator/proc/toggle_paddles()
	set name = "Toggle Paddles"
	set category = "Object"
	on = !on

	var/mob/living/carbon/user = usr
	if(on)
		//Detach the paddles into the user's hands
		if(!usr.put_in_hands(paddles))
			on = FALSE
			to_chat(user, "<span class='warning'>You need a free hand to hold the paddles!</span>")
			update_power()
			return
	else
		//Remove from their hands and back onto the defib unit
		remove_paddles(user)

	update_power()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()


/obj/item/defibrillator/equipped(mob/user, slot)
	..()
	if((slot_flags == ITEM_SLOT_BACK && slot != ITEM_SLOT_BACK) || (slot_flags == ITEM_SLOT_BELT && slot != ITEM_SLOT_BELT))
		remove_paddles(user)
		update_power()

/obj/item/defibrillator/item_action_slot_check(slot, mob/user)
	if(slot == user.getBackSlot())
		return 1

/obj/item/defibrillator/proc/remove_paddles(mob/user) //this fox the bug with the paddles when other player stole you the defib when you have the paddles equiped
	if(ismob(paddles.loc))
		var/mob/M = paddles.loc
		M.dropItemToGround(paddles, TRUE)
	return

/obj/item/defibrillator/Destroy()
	if(on)
		var/M = get(paddles, /mob)
		remove_paddles(M)
	QDEL_NULL(paddles)
	QDEL_NULL(cell)
	return ..()

/obj/item/defibrillator/proc/deductcharge(chrgdeductamt)
	if(cell)
		if(cell.charge < (paddles.revivecost+chrgdeductamt))
			powered = FALSE
			update_power()
		if(cell.use(chrgdeductamt))
			update_power()
			return TRUE
		else
			return FALSE

/obj/item/defibrillator/proc/cooldowncheck(mob/user)
		addtimer(CALLBACK(src, .proc/finish_charging), cooldown_duration)

/obj/item/defibrillator/proc/finish_charging()
	if(cell)
		if(cell.charge >= paddles.revivecost)
			visible_message("<span class='notice'>[src] beeps: Unit ready.</span>")
			playsound(src, 'sound/machines/defib_ready.ogg', 50, FALSE)
		else
			visible_message("<span class='notice'>[src] beeps: Charge depleted.</span>")
			playsound(src, 'sound/machines/defib_failed.ogg', 50, FALSE)
	paddles.cooldown = FALSE
	paddles.update_appearance()
	update_power()

/obj/item/defibrillator/compact
	name = "compact defibrillator"
	desc = "A belt-equipped defibrillator that can be rapidly deployed."
	icon_state = "defibcompact"
	inhand_icon_state = "defibcompact"
	worn_icon_state = "defibcompact"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT

/obj/item/defibrillator/compact/item_action_slot_check(slot, mob/user)
	if(slot == user.getBeltSlot())
		return TRUE

/obj/item/defibrillator/compact/loaded/Initialize()
	. = ..()
	cell = new(src)
	update_power()

/obj/item/defibrillator/compact/combat
	name = "combat defibrillator"
	desc = "A belt-equipped blood-red defibrillator. Can revive through thick clothing, has an experimental self-recharging battery, and can be utilized in combat via applying the paddles in a disarming or aggressive manner."
	icon_state = "defibcombat" //needs defib inhand sprites
	inhand_icon_state = "defibcombat"
	worn_icon_state = "defibcombat"
	combat = TRUE
	safety = FALSE
	cooldown_duration = 2.5 SECONDS
	paddle_type = /obj/item/shockpaddles/syndicate

/obj/item/defibrillator/compact/combat/loaded/Initialize()
	. = ..()
	cell = new /obj/item/stock_parts/cell/infinite(src)
	update_power()

/obj/item/defibrillator/compact/combat/loaded/attackby(obj/item/W, mob/user, params)
	if(W == paddles)
		toggle_paddles()
		return

/obj/item/defibrillator/compact/combat/loaded/nanotrasen
	name = "elite Nanotrasen defibrillator"
	desc = "A belt-equipped state-of-the-art defibrillator. Can revive through thick clothing, has an experimental self-recharging battery, and can be utilized in combat via applying the paddles in a disarming or agressive manner."
	icon_state = "defibnt" //needs defib inhand sprites
	inhand_icon_state = "defibnt"
	worn_icon_state = "defibnt"
	paddle_type = /obj/item/shockpaddles/syndicate/nanotrasen

//paddles

/obj/item/shockpaddles
	name = "defibrillator paddles"
	desc = "A pair of plastic-gripped paddles with flat metal surfaces that are used to deliver powerful electric shocks."
	icon = 'icons/obj/defib.dmi'
	icon_state = "defibpaddles0"
	inhand_icon_state = "defibpaddles0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'

	force = 0
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = INDESTRUCTIBLE
	base_icon_state = "defibpaddles"

	var/revivecost = 1000
	var/cooldown = FALSE
	var/busy = FALSE
	var/obj/item/defibrillator/defib
	var/req_defib = TRUE
	var/combat = FALSE //If it penetrates armor and gives additional functionality
	var/wielded = FALSE // track wielded status on item

/obj/item/shockpaddles/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	AddComponent(/datum/component/two_handed, force_unwielded=8, force_wielded=12)

/// triggered on wield of two handed item
/obj/item/shockpaddles/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/shockpaddles/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/shockpaddles/Destroy()
	defib = null
	return ..()

/obj/item/shockpaddles/equipped(mob/user, slot)
	. = ..()
	if(!req_defib)
		return
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/check_range)

/obj/item/shockpaddles/Moved()
	. = ..()
	check_range()

/obj/item/shockpaddles/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if((req_defib && defib) && loc != defib)
		defib.fire_act(exposed_temperature, exposed_volume)

/obj/item/shockpaddles/proc/check_range()
	SIGNAL_HANDLER

	if(!req_defib || !defib)
		return
	if(!in_range(src,defib))
		if(isliving(loc))
			var/mob/living/user = loc
			to_chat(user, "<span class='warning'>[defib]'s paddles overextend and come out of your hands!</span>")
		else
			visible_message("<span class='notice'>[src] snap back into [defib].</span>")
		snap_back()

/obj/item/shockpaddles/proc/recharge(time)
	if(req_defib || !time)
		return
	cooldown = TRUE
	update_appearance()
	sleep(time)
	var/turf/T = get_turf(src)
	T.audible_message("<span class='notice'>[src] beeps: Unit is recharged.</span>")
	playsound(src, 'sound/machines/defib_ready.ogg', 50, FALSE)
	cooldown = FALSE
	update_appearance()

/obj/item/shockpaddles/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, GENERIC_ITEM_TRAIT) //stops shockpaddles from being inserted in BoH
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)
	if(!req_defib)
		return //If it doesn't need a defib, just say it exists
	if (!loc || !istype(loc, /obj/item/defibrillator)) //To avoid weird issues from admin spawns
		return INITIALIZE_HINT_QDEL
	defib = loc
	busy = FALSE
	update_appearance()

/obj/item/shockpaddles/suicide_act(mob/user)
	user.visible_message("<span class='danger'>[user] is putting the live paddles on [user.p_their()] chest! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	if(req_defib)
		defib.deductcharge(revivecost)
	playsound(src, 'sound/machines/defib_zap.ogg', 50, TRUE, -1)
	return (OXYLOSS)

/obj/item/shockpaddles/update_icon_state()
	icon_state = "[base_icon_state][wielded]"
	inhand_icon_state = icon_state
	if(cooldown)
		icon_state = "[base_icon_state][wielded]_cooldown"
	return ..()

/obj/item/shockpaddles/dropped(mob/user)
	. = ..()
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
	if(req_defib)
		if(user)
			to_chat(user, "<span class='notice'>The paddles snap back into the main unit.</span>")
		snap_back()

/obj/item/shockpaddles/proc/snap_back()
	if(!defib)
		return
	defib.on = FALSE
	forceMove(defib)
	defib.update_power()

/obj/item/shockpaddles/attack(mob/M, mob/living/user, params)
	if(busy)
		return
	if(req_defib && !defib.powered)
		user.visible_message("<span class='notice'>[defib] beeps: Unit is unpowered.</span>")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, FALSE)
		return
	if(!wielded)
		if(iscyborg(user))
			to_chat(user, "<span class='warning'>You must activate the paddles in your active module before you can use them on someone!</span>")
		else
			to_chat(user, "<span class='warning'>You need to wield the paddles in both hands before you can use them on someone!</span>")
		return
	if(cooldown)
		if(req_defib)
			to_chat(user, "<span class='warning'>[defib] is recharging!</span>")
		else
			to_chat(user, "<span class='warning'>[src] are recharging!</span>")
		return

	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		do_disarm(M, user)
		return

	if(!iscarbon(M))
		if(req_defib)
			to_chat(user, "<span class='warning'>The instructions on [defib] don't mention how to revive that...</span>")
		else
			to_chat(user, "<span class='warning'>You aren't sure how to revive that...</span>")
		return
	var/mob/living/carbon/H = M

	if(user.zone_selected != BODY_ZONE_CHEST)
		to_chat(user, "<span class='warning'>You need to target your patient's chest with [src]!</span>")
		return

	if(user.combat_mode)
		do_harm(H, user)
		return

	if(H.can_defib() == DEFIB_POSSIBLE)
		H.notify_ghost_cloning("Your heart is being defibrillated!")
		H.grab_ghost() // Shove them back in their body.

	do_help(H, user)

/obj/item/shockpaddles/proc/shock_touching(dmg, mob/H)
	if(isliving(H.pulledby)) //CLEAR!
		var/mob/living/M = H.pulledby
		if(M.electrocute_act(30, H))
			M.visible_message("<span class='danger'>[M] is electrocuted by [M.p_their()] contact with [H]!</span>")
			M.emote("scream")

/obj/item/shockpaddles/proc/do_disarm(mob/living/M, mob/living/user)
	if(req_defib && defib.safety)
		return
	if(!req_defib && !combat)
		return
	busy = TRUE
	M.visible_message("<span class='danger'>[user] touches [M] with [src]!</span>", \
			"<span class='userdanger'>[user] touches [M] with [src]!</span>")
	M.adjustStaminaLoss(60)
	M.Knockdown(75)
	M.Jitter(50)
	M.apply_status_effect(STATUS_EFFECT_CONVULSING)
	playsound(src,  'sound/machines/defib_zap.ogg', 50, TRUE, -1)
	if(HAS_TRAIT(M,MOB_ORGANIC))
		M.emote("gasp")
	log_combat(user, M, "zapped", src)
	if(req_defib)
		defib.deductcharge(revivecost)
		cooldown = TRUE
	busy = FALSE
	update_appearance()
	if(req_defib)
		defib.cooldowncheck(user)
	else
		recharge(60)

/obj/item/shockpaddles/proc/do_harm(mob/living/carbon/H, mob/living/user)
	if(req_defib && defib.safety)
		return
	if(!req_defib && !combat)
		return
	user.visible_message("<span class='warning'>[user] begins to place [src] on [H]'s chest.</span>",
		"<span class='warning'>You overcharge the paddles and begin to place them onto [H]'s chest...</span>")
	busy = TRUE
	update_appearance()
	if(do_after(user, 1.5 SECONDS, H))
		user.visible_message("<span class='notice'>[user] places [src] on [H]'s chest.</span>",
			"<span class='warning'>You place [src] on [H]'s chest and begin to charge them.</span>")
		var/turf/T = get_turf(defib)
		playsound(src, 'sound/machines/defib_charge.ogg', 50, FALSE)
		if(req_defib)
			T.audible_message("<span class='warning'>\The [defib] lets out an urgent beep and lets out a steadily rising hum...</span>")
		else
			user.audible_message("<span class='warning'>[src] let out an urgent beep.</span>")
		if(do_after(user, 1.5 SECONDS, H)) //Takes longer due to overcharging
			if(!H)
				busy = FALSE
				update_appearance()
				return
			if(H && H.stat == DEAD)
				to_chat(user, "<span class='warning'>[H] is dead.</span>")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, FALSE)
				busy = FALSE
				update_appearance()
				return
			user.visible_message("<span class='boldannounce'><i>[user] shocks [H] with \the [src]!</span>", "<span class='warning'>You shock [H] with \the [src]!</span>")
			playsound(src, 'sound/machines/defib_zap.ogg', 100, TRUE, -1)
			playsound(src, 'sound/weapons/egloves.ogg', 100, TRUE, -1)
			H.emote("scream")
			shock_touching(45, H)
			if(H.can_heartattack() && !H.undergoing_cardiac_arrest())
				if(!H.stat)
					H.visible_message("<span class='warning'>[H] thrashes wildly, clutching at [H.p_their()] chest!</span>",
						"<span class='userdanger'>You feel a horrible agony in your chest!</span>")
				H.set_heartattack(TRUE)
			H.apply_damage(50, BURN, BODY_ZONE_CHEST)
			log_combat(user, H, "overloaded the heart of", defib)
			H.Paralyze(100)
			H.Jitter(100)
			if(req_defib)
				defib.deductcharge(revivecost)
				cooldown = TRUE
			busy = FALSE
			update_appearance()
			if(!req_defib)
				recharge(60)
			if(req_defib && (defib.cooldowncheck(user)))
				return
	busy = FALSE
	update_appearance()

/obj/item/shockpaddles/proc/do_help(mob/living/carbon/H, mob/living/user)
	user.visible_message("<span class='warning'>[user] begins to place [src] on [H]'s chest.</span>", "<span class='warning'>You begin to place [src] on [H]'s chest...</span>")
	busy = TRUE
	update_appearance()
	if(do_after(user, 3 SECONDS, H)) //beginning to place the paddles on patient's chest to allow some time for people to move away to stop the process
		user.visible_message("<span class='notice'>[user] places [src] on [H]'s chest.</span>", "<span class='warning'>You place [src] on [H]'s chest.</span>")
		playsound(src, 'sound/machines/defib_charge.ogg', 75, FALSE)
		var/obj/item/organ/heart = H.getorgan(/obj/item/organ/heart)
		if(do_after(user, 2 SECONDS, H)) //placed on chest and short delay to shock for dramatic effect, revive time is 5sec total
			if((!combat && !req_defib) || (req_defib && !defib.combat))
				for(var/obj/item/clothing/C in H.get_equipped_items())
					if((C.body_parts_covered & CHEST) && (C.clothing_flags & THICKMATERIAL)) //check to see if something is obscuring their chest.
						user.audible_message("<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Patient's chest is obscured. Operation aborted.</span>")
						playsound(src, 'sound/machines/defib_failed.ogg', 50, FALSE)
						busy = FALSE
						update_appearance()
						return
			if(H.stat == DEAD)
				H.visible_message("<span class='warning'>[H]'s body convulses a bit.</span>")
				playsound(src, "bodyfall", 50, TRUE)
				playsound(src, 'sound/machines/defib_zap.ogg', 75, TRUE, -1)
				shock_touching(30, H)

				var/defib_result = H.can_defib()
				var/fail_reason

				switch (defib_result)
					if (DEFIB_FAIL_SUICIDE)
						fail_reason = "Recovery of patient impossible. Further attempts futile."
					if (DEFIB_FAIL_NO_HEART)
						fail_reason = "Patient's heart is missing."
					if (DEFIB_FAIL_FAILING_HEART)
						fail_reason = "Patient's heart too damaged, replace or repair and try again."
					if (DEFIB_FAIL_TISSUE_DAMAGE)
						fail_reason = "Tissue damage too severe, repair and try again."
					if (DEFIB_FAIL_HUSK)
						fail_reason = "Patient's body is a mere husk, repair and try again."
					if (DEFIB_FAIL_FAILING_BRAIN)
						fail_reason = "Patient's brain is too damaged, repair and try again."
					if (DEFIB_FAIL_NO_INTELLIGENCE)
						fail_reason = "No intelligence pattern can be detected in patient's brain. Further attempts futile."
					if (DEFIB_FAIL_NO_BRAIN)
						fail_reason = "Patient's brain is missing. Further attempts futile."

				if(fail_reason)
					user.visible_message("<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - [fail_reason]</span>")
					playsound(src, 'sound/machines/defib_failed.ogg', 50, FALSE)
				else
					var/total_brute = H.getBruteLoss()
					var/total_burn = H.getFireLoss()

					//If the body has been fixed so that they would not be in crit when defibbed, give them oxyloss to put them back into crit
					if (H.health > HALFWAYCRITDEATH)
						H.adjustOxyLoss(H.health - HALFWAYCRITDEATH, 0)
					else
						var/overall_damage = total_brute + total_burn + H.getToxLoss() + H.getOxyLoss()
						var/mobhealth = H.health
						H.adjustOxyLoss((mobhealth - HALFWAYCRITDEATH) * (H.getOxyLoss() / overall_damage), 0)
						H.adjustToxLoss((mobhealth - HALFWAYCRITDEATH) * (H.getToxLoss() / overall_damage), 0, TRUE) // force tox heal for toxin lovers too
						H.adjustFireLoss((mobhealth - HALFWAYCRITDEATH) * (total_burn / overall_damage), 0)
						H.adjustBruteLoss((mobhealth - HALFWAYCRITDEATH) * (total_brute / overall_damage), 0)
					H.updatehealth() // Previous "adjust" procs don't update health, so we do it manually.
					user.visible_message("<span class='notice'>[req_defib ? "[defib]" : "[src]"] pings: Resuscitation successful.</span>")
					playsound(src, 'sound/machines/defib_success.ogg', 50, FALSE)
					H.set_heartattack(FALSE)
					H.grab_ghost()
					H.revive(full_heal = FALSE, admin_revive = FALSE)
					H.emote("gasp")
					H.Jitter(100)
					SEND_SIGNAL(H, COMSIG_LIVING_MINOR_SHOCK)
					SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "saved_life", /datum/mood_event/saved_life)
					log_combat(user, H, "revived", defib)
				if(req_defib)
					defib.deductcharge(revivecost)
					cooldown = 1
				update_appearance()
				if(req_defib)
					defib.cooldowncheck(user)
				else
					recharge(60)
			else if (!H.getorgan(/obj/item/organ/heart))
				user.visible_message("<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Patient's heart is missing. Operation aborted.</span>")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, FALSE)
			else if(H.undergoing_cardiac_arrest())
				playsound(src, 'sound/machines/defib_zap.ogg', 50, TRUE, -1)
				if(!(heart.organ_flags & ORGAN_FAILING))
					H.set_heartattack(FALSE)
					user.visible_message("<span class='notice'>[req_defib ? "[defib]" : "[src]"] pings: Patient's heart is now beating again.</span>")
				else
					user.visible_message("<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed, heart damage detected.</span>")

			else
				user.visible_message("<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Patient is not in a valid state. Operation aborted.</span>")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, FALSE)
	busy = FALSE
	update_appearance()

/obj/item/shockpaddles/cyborg
	name = "cyborg defibrillator paddles"
	icon = 'icons/obj/defib.dmi'
	icon_state = "defibpaddles0"
	inhand_icon_state = "defibpaddles0"
	req_defib = FALSE

/obj/item/shockpaddles/cyborg/attack(mob/M, mob/user)
	if(iscyborg(user))
		var/mob/living/silicon/robot/R = user
		if(R.emagged)
			combat = TRUE
		else
			combat = FALSE
	else
		combat = FALSE

	. = ..()

/obj/item/shockpaddles/syndicate
	name = "syndicate defibrillator paddles"
	desc = "A pair of paddles used to revive deceased operatives. They possess both the ability to penetrate armor and to deliver powerful or disabling shocks offensively."
	combat = TRUE
	icon = 'icons/obj/defib.dmi'
	icon_state = "syndiepaddles0"
	inhand_icon_state = "syndiepaddles0"
	base_icon_state = "syndiepaddles"

/obj/item/shockpaddles/syndicate/nanotrasen
	name = "elite nanotrasen defibrillator paddles"
	desc = "A pair of paddles used to revive deceased ERT members. They possess both the ability to penetrate armor and to deliver powerful or disabling shocks offensively."
	icon_state = "ntpaddles0"
	inhand_icon_state = "ntpaddles0"
	base_icon_state = "ntpaddles"

/obj/item/shockpaddles/syndicate/cyborg
	req_defib = FALSE

#undef HALFWAYCRITDEATH
