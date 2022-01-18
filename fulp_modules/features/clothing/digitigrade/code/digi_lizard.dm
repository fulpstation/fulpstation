/datum/species/lizard/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)

	// What gives them the shoes
	var/obj/item/clothing/shoes/newShoes
	if(!(DIGITIGRADE in equipping.dna.species.species_traits))
		return
	switch(job.title)

		// Assistant
		if(JOB_ASSISTANT)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		// Captain
		if(JOB_CAPTAIN)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		// Security
		if(JOB_HEAD_OF_SECURITY)
			newShoes = new /obj/item/clothing/shoes/jackboots/digitigrade
		if(JOB_WARDEN)
			newShoes = new /obj/item/clothing/shoes/jackboots/digitigrade
		if(JOB_SECURITY_OFFICER)
			newShoes = new /obj/item/clothing/shoes/jackboots/digitigrade
		if(JOB_DETECTIVE)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if(JOB_BRIG_PHYSICIAN)
			newShoes = new /obj/item/clothing/shoes/jackboots/digitigrade
		if(JOB_DEPUTY)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		// Deputies
		if(JOB_DEPUTY_ENG)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if(JOB_DEPUTY_MED)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if(JOB_DEPUTY_SCI)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if(JOB_DEPUTY_SUP)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if(JOB_DEPUTY_SRV)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade

		// Medical
		if(JOB_CHIEF_MEDICAL_OFFICER)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_MEDICAL_DOCTOR)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_CHEMIST)
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_VIROLOGIST)
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_PARAMEDIC)
			newShoes = /obj/item/clothing/shoes/brown/digitigrade

		// Engineering
		if(JOB_CHIEF_ENGINEER)
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade
		if(JOB_STATION_ENGINEER)
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade
		if(JOB_ATMOSPHERIC_TECHNICIAN)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade

		// Science
		if(JOB_RESEARCH_DIRECTOR)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if(JOB_SCIENTIST)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_ROBOTICIST)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_GENETICIST)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade

		// Supply
		if(JOB_HEAD_OF_PERSONNEL)
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_QUARTERMASTER)
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_CARGO_TECHNICIAN)
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_SHAFT_MINER)
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade

		// Clown
		if(JOB_CLOWN)
			newShoes = new /obj/item/clothing/shoes/clown_shoes/digitigrade
		// Mime
		if(JOB_MIME)
			newShoes = new /obj/item/clothing/shoes/mime/digitigrade

		if(JOB_PRISONER)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_COOK)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_BARTENDER)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if(JOB_CHAPLAIN)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_CURATOR)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if(JOB_LAWYER)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if(JOB_BOTANIST)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_JANITOR)
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if(JOB_PSYCHOLOGIST)
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade

		// Civilian
		else
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade

	// Deletes the stinky non-digitigrade shoes (if for some reason they spawn with them)

	if(equipping.shoes)
		qdel(equipping.shoes)
	// Equip New
	equipping.equip_to_slot_or_del(newShoes, ITEM_SLOT_FEET, TRUE)
	return ..()
