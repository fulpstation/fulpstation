/datum/species
	/// The description upon someone with brute damage gets examined. "X has severe bruising!"
	var/bruising_desc = "bruising"
	/// The description upon someone with burn damage gets examined. "X has severe burns!"
	var/burns_desc = "burns"
	/// The description upon someone with cellular damage gets examined. "X has severe cellular damage!"
	var/cellulardamage_desc = "cellular damage"

/mob/living/proc/getBruteLoss_nonProsthetic()
	return getBruteLoss()

/mob/living/proc/getFireLoss_nonProsthetic()
	return getFireLoss()

/mob/living/carbon/getBruteLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/bodyparts in bodyparts)
		if (bodyparts.status < BODYPART_ROBOTIC)
			amount += bodyparts.brute_dam
	return amount

/mob/living/carbon/getFireLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/bodyparts in bodyparts)
		if (bodyparts.status < BODYPART_ROBOTIC)
			amount += bodyparts.burn_dam
	return amount
