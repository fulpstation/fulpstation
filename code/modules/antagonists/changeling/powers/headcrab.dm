/datum/action/changeling/headcrab
	name = "Last Resort"
	desc = "We sacrifice our current body in a moment of need, placing us in control of a vessel that can plant our likeness in a new host. Costs 20 chemicals."
	helptext = "We will be placed in control of a small, fragile creature. We may attack a corpse like this to plant an egg which will slowly mature into a new form for us."
	button_icon_state = "last_resort"
	chemical_cost = 20
	dna_cost = 1
	req_human = 1

/datum/action/changeling/headcrab/sting_action(mob/living/user)
	set waitfor = FALSE
	if(tgui_alert(usr,"Are we sure we wish to kill ourself and create a headslug?",,list("Yes", "No")) == "No")
		return
	..()
	var/datum/mind/M = user.mind
	var/list/organs = user.getorganszone(BODY_ZONE_HEAD, 1)

	for(var/obj/item/organ/I in organs)
		I.Remove(user, 1)

	explosion(user, light_impact_range = 2, adminlog = TRUE)
	for(var/mob/living/carbon/human/H in range(2,user))
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		to_chat(H, span_userdanger("You are blinded by a shower of blood!"))
		H.Stun(20)
		H.blur_eyes(20)
		eyes?.applyOrganDamage(5)
		H.add_confusion(3)
	for(var/mob/living/silicon/S in range(2,user))
		to_chat(S, span_userdanger("Your sensors are disabled by a shower of blood!"))
		S.Paralyze(60)
	var/turf/user_turf = get_turf(user)
	user.transfer_observers_to(user_turf) // user is about to be deleted, store orbiters on the turf
	user.gib()
	. = TRUE
	sleep(5) // So it's not killed in explosion
	var/mob/living/simple_animal/hostile/headcrab/crab = new(user_turf)
	for(var/obj/item/organ/I in organs)
		I.forceMove(crab)
	crab.origin = M
	if(crab.origin)
		crab.origin.active = TRUE
		crab.origin.transfer_to(crab)
		user_turf.transfer_observers_to(crab)
		to_chat(crab, span_warning("You burst out of the remains of your former body in a shower of gore!"))
