/datum/species/lizard/before_equip_job(datum/job/J, mob/living/carbon/human/H)

	// What gives them the shoes
	var/obj/item/clothing/shoes/newShoes
	if(!(DIGITIGRADE in H.dna.species_traits))
		return
	switch(J.title)

		// Assistant
		if("Assistant")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		// Captain
		if("Captain")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
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

		// Medical
		if("Chief Medical Officer")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Medical Doctor")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Chemist")
			newShoes = /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Virologist")
			newShoes = /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Paramedic")
			newShoes = /obj/item/clothing/shoes/sneakers/brown/digitigrade

		// Engineering
		if("Chief Engineer")
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade
		if("Station Engineer")
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade
		if("Atmospheric Technician")
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade

		// Science
		if("Research Director")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Scientist")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Roboticist")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Geneticist")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade

		// Supply/Service
		if("Head of Personnel")
			newShoes = /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Quartermaster")
			newShoes = /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Cargo Technician")
			newShoes = /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Shaft Miner")
			newShoes = new /obj/item/clothing/shoes/workboots/digitigrade

		// Clown
		if("Clown")
			newShoes = new /obj/item/clothing/shoes/clown_shoes/digitigrade
		// Mime
		if("Mime")
			newShoes = new /obj/item/clothing/shoes/sneakers/mime/digitigrade

		if("Prisoner")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Cook")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Bartender")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Chaplain")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Curator")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Lawyer")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade
		if("Botanist")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Janitor")
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade
		if("Psychologist")
			newShoes = new /obj/item/clothing/shoes/laceup/digitigrade

		// Civilian
		else
			newShoes = new /obj/item/clothing/shoes/sneakers/brown/digitigrade

	// Deletes the stinky non-digitigrade shoes (if for some reason they spawn with them)

    if (H.shoes)
        qdel(H.shoes)
    // Equip New
    H.equip_to_slot_or_del(new shoes(H),ITEM_SLOT_FEET, TRUE)
    return ..()
