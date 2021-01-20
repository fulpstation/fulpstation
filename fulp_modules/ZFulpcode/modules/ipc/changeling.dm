/datum/antagonist/changeling/create_initial_profile()
	var/mob/living/carbon/C = owner.current	//only carbons have dna now, so we have to typecaste
	if(isIPC(C))
		C.set_species(/datum/species/human)
	if(ishuman(C))
		add_new_profile(C)

/datum/antagonist/changeling/can_absorb_dna(mob/living/carbon/human/target, var/verbose=1)
	var/mob/living/carbon/user = owner.current
	if(isIPC(target))
		to_chat(user, "<span class='warning'>We cannot absorb mechanical entities!</span>")
		return
	. = ..()

