/datum/species/lizard/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)

	// What gives them the shoes
	var/obj/item/clothing/shoes/newShoes
	if(!(DIGITIGRADE in equipping.dna.species.species_traits))
		return
	switch(job.title)

		// Assistant
		if("Assistant")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		// Captain
		if("Captain")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		// Security
		if("Head of Security")
			newShoes = new /obj/item/clothing/shoes/jackboots/digitigrade
		if("Warden")
			newShoes = new /obj/item/clothing/shoes/jackboots/digitigrade
		if("Security Officer")
			newShoes = new /obj/item/clothing/shoes/jackboots/digitigrade
		if("Detective")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Brig Physician")
			newShoes = new /obj/item/clothing/shoes/jackboots/digitigrade
		if("Deputy")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		// Deputies
		if("Engineering Deputy")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Medical Deputy")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Science Deputy")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Supply Deputy")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade

		// Medical
		if("Chief Medical Officer")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if("Medical Doctor")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if("Chemist")
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if("Virologist")
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if("Paramedic")
			newShoes = /obj/item/clothing/shoes/brown/digitigrade

		// Engineering
		if("Chief Engineer")
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade
		if("Station Engineer")
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade
		if("Atmospheric Technician")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade

		// Science
		if("Research Director")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Scientist")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if("Roboticist")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if("Geneticist")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade

		// Supply/Service
		if("Head of Personnel")
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if("Quartermaster")
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if("Cargo Technician")
			newShoes = /obj/item/clothing/shoes/brown/digitigrade
		if("Shaft Miner")
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade

		// Clown
		if("Clown")
			newShoes = new /obj/item/clothing/shoes/clown_shoes/digitigrade
		// Mime
		if("Mime")
			newShoes = new /obj/item/clothing/shoes/mime/digitigrade

		if("Prisoner")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if("Cook")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if("Bartender")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Chaplain")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if("Curator")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Lawyer")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Botanist")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if("Janitor")
			newShoes = new /obj/item/clothing/shoes/brown/digitigrade
		if("Psychologist")
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
