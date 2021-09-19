/datum/species/beefman/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/beefboy, visuals_only = FALSE)

	// Pre-Equip: Give us a sash so we don't end up with a Uniform!
	var/obj/item/clothing/under/bodysash/newSash
	switch(job.title)

		// Assistant
		if("Assistant")
			newSash = new /obj/item/clothing/under/bodysash()
		// Captain
		if("Captain")
			newSash = new /obj/item/clothing/under/bodysash/captain()
		// Security
		if("Head of Security")
			newSash = new /obj/item/clothing/under/bodysash/hos()
		if("Warden")
			newSash = new /obj/item/clothing/under/bodysash/warden()
		if("Security Officer")
			newSash = new /obj/item/clothing/under/bodysash/security()
		if("Detective")
			newSash = new /obj/item/clothing/under/bodysash/detective()
		if("Brig Physician")
			newSash = new /obj/item/clothing/under/bodysash/brigdoc()
		if("Deputy")
			newSash = new /obj/item/clothing/under/bodysash/deputy()

		// Medical
		if("Chief Medical Officer")
			newSash = new /obj/item/clothing/under/bodysash/cmo()
		if("Medical Doctor")
			newSash = new /obj/item/clothing/under/bodysash/medical()
		if("Chemist")
			newSash = new /obj/item/clothing/under/bodysash/chemist()
		if("Virologist")
			newSash = new /obj/item/clothing/under/bodysash/virologist()
		if("Paramedic")
			newSash = new /obj/item/clothing/under/bodysash/paramedic()

		// Engineering
		if("Chief Engineer")
			newSash = new /obj/item/clothing/under/bodysash/ce()
		if("Station Engineer")
			newSash = new /obj/item/clothing/under/bodysash/engineer()
		if("Atmospheric Technician")
			newSash = new /obj/item/clothing/under/bodysash/atmos()

		// Science
		if("Research Director")
			newSash = new /obj/item/clothing/under/bodysash/rd()
		if("Scientist")
			newSash = new /obj/item/clothing/under/bodysash/scientist()
		if("Roboticist")
			newSash = new /obj/item/clothing/under/bodysash/roboticist()
		if("Geneticist")
			newSash = new /obj/item/clothing/under/bodysash/geneticist()

		// Supply
		if("Head of Personnel")
			newSash = new /obj/item/clothing/under/bodysash/hop()
		if("Quartermaster")
			newSash = new /obj/item/clothing/under/bodysash/qm()
		if("Cargo Technician")
			newSash = new /obj/item/clothing/under/bodysash/cargo()
		if("Shaft Miner")
			newSash = new /obj/item/clothing/under/bodysash/miner()

		// Service
		if("Clown")
			newSash = new /obj/item/clothing/under/bodysash/clown()
		if("Mime")
			newSash = new /obj/item/clothing/under/bodysash/mime()
		if("Prisoner")
			newSash = new /obj/item/clothing/under/bodysash/prisoner()
		if("Cook")
			newSash = new /obj/item/clothing/under/bodysash/cook()
		if("Bartender")
			newSash = new /obj/item/clothing/under/bodysash/bartender()
		if("Chaplain")
			newSash = new /obj/item/clothing/under/bodysash/chaplain()
		if("Curator")
			newSash = new /obj/item/clothing/under/bodysash/curator()
		if("Lawyer")
			newSash = new /obj/item/clothing/under/bodysash/lawyer()
		if("Botanist")
			newSash = new /obj/item/clothing/under/bodysash/botanist()
		if("Janitor")
			newSash = new /obj/item/clothing/under/bodysash/janitor()
		if("Psychologist")
			newSash = new /obj/item/clothing/under/bodysash/psychologist()

		// Civilian
		else
			newSash = new /obj/item/clothing/under/bodysash/civilian()

	if (beefboy.w_uniform)
		qdel(beefboy.w_uniform)
	beefboy.equip_to_slot_or_del(newSash, ITEM_SLOT_ICLOTHING, TRUE)
	return ..()
