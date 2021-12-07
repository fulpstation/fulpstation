/datum/species/beefman/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	// Pre-Equip: Give us a sash so we don't end up with a Uniform!
	var/obj/item/clothing/under/bodysash/new_sash
	switch(job.title)
		// Assistant
		if("Assistant")
			new_sash = new /obj/item/clothing/under/bodysash()
		// Captain
		if("Captain")
			new_sash = new /obj/item/clothing/under/bodysash/captain()
		// Security
		if("Head of Security")
			new_sash = new /obj/item/clothing/under/bodysash/security/hos()
		if("Warden")
			new_sash = new /obj/item/clothing/under/bodysash/security/warden()
		if("Security Officer")
			new_sash = new /obj/item/clothing/under/bodysash/security()
		if("Detective")
			new_sash = new /obj/item/clothing/under/bodysash/security/detective()
		if("Brig Physician")
			new_sash = new /obj/item/clothing/under/bodysash/security/brigdoc()

		if("Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()
		if("Engineering Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()
		if("Medical Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()
		if("Science Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()
		if("Supply Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()

		// Medical
		if("Chief Medical Officer")
			new_sash = new /obj/item/clothing/under/bodysash/medical/cmo()
		if("Medical Doctor")
			new_sash = new /obj/item/clothing/under/bodysash/medical()
		if("Chemist")
			new_sash = new /obj/item/clothing/under/bodysash/medical/chemist()
		if("Virologist")
			new_sash = new /obj/item/clothing/under/bodysash/medical/virologist()
		if("Paramedic")
			new_sash = new /obj/item/clothing/under/bodysash/medical/paramedic()

		// Engineering
		if("Chief Engineer")
			new_sash = new /obj/item/clothing/under/bodysash/engineer/ce()
		if("Station Engineer")
			new_sash = new /obj/item/clothing/under/bodysash/engineer()
		if("Atmospheric Technician")
			new_sash = new /obj/item/clothing/under/bodysash/engineer/atmos()

		// Science
		if("Research Director")
			new_sash = new /obj/item/clothing/under/bodysash/rd()
		if("Scientist")
			new_sash = new /obj/item/clothing/under/bodysash/scientist()
		if("Roboticist")
			new_sash = new /obj/item/clothing/under/bodysash/roboticist()
		if("Geneticist")
			new_sash = new /obj/item/clothing/under/bodysash/geneticist()

		// Supply/Service
		if("Head of Personnel")
			new_sash = new /obj/item/clothing/under/bodysash/hop()
		if("Quartermaster")
			new_sash = new /obj/item/clothing/under/bodysash/qm()
		if("Cargo Technician")
			new_sash = new /obj/item/clothing/under/bodysash/cargo()
		if("Shaft Miner")
			new_sash = new /obj/item/clothing/under/bodysash/miner()

		// Clown
		if("Clown")
			new_sash = new /obj/item/clothing/under/bodysash/clown()
		// Mime
		if("Mime")
			new_sash = new /obj/item/clothing/under/bodysash/mime()
		if("Prisoner")
			new_sash = new /obj/item/clothing/under/bodysash/prisoner()
		if("Cook")
			new_sash = new /obj/item/clothing/under/bodysash/cook()
		if("Bartender")
			new_sash = new /obj/item/clothing/under/bodysash/bartender()
		if("Chaplain")
			new_sash = new /obj/item/clothing/under/bodysash/chaplain()
		if("Curator")
			new_sash = new /obj/item/clothing/under/bodysash/curator()
		if("Lawyer")
			new_sash = new /obj/item/clothing/under/bodysash/lawyer()
		if("Botanist")
			new_sash = new /obj/item/clothing/under/bodysash/botanist()
		if("Janitor")
			new_sash = new /obj/item/clothing/under/bodysash/janitor()
		if("Psychologist")
			new_sash = new /obj/item/clothing/under/bodysash/psychologist()

		else
			new_sash = new /obj/item/clothing/under/bodysash/civilian()

	if(equipping.w_uniform)
		qdel(equipping.w_uniform)
	// Equip New
	equipping.equip_to_slot_or_del(new_sash, ITEM_SLOT_ICLOTHING, TRUE) // TRUE is whether or not this is "INITIAL", as in startup
	return ..()
