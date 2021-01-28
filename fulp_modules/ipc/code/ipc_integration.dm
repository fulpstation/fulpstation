/datum/species
	///Override of icon file of which we're taking the icons from for our limbs
	var/limbs_icon
	var/reagent_flags = PROCESS_ORGANIC

/datum/species/android
	limbs_icon = 'icons/mob/augmentation/augments.dmi'
	reagent_flags = PROCESS_SYNTHETIC

/obj/item/bodypart
	//Works in conjuction with limbs_icon to provide the overlay of the limb.
	var/rendered_bp_icon

/datum/species/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(ROBOTIC_LIMBS in species_traits)
		for(var/obj/item/bodypart/B in C.bodyparts)
			B.change_bodypart_status(BODYPART_ROBOTIC, FALSE, TRUE)

/datum/species/on_species_loss(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(ROBOTIC_LIMBS in species_traits)
		for(var/obj/item/bodypart/B in C.bodyparts)
			B.change_bodypart_status(BODYPART_ORGANIC, FALSE, TRUE)

/proc/ipc_name()
	return "[pick(GLOB.posibrain_names)]-\Roman[rand(1,99)]"

/proc/random_unique_ipc_name(attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(ipc_name())

		if(!findname(.))
			break
