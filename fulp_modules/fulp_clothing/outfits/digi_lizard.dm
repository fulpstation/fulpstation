///It doesn't work at the moment, even with the written down jobs, I'm gonna try to fix it.

/datum/species/lizard/before_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	var/current_job = J.title
	var/datum/outfit/digitigrade/O = new /datum/outfit/digitigrade
	if(!(DIGITIGRADE in H.dna.species.species_traits))
		return //not sure this is neccessary since its 'equip or delete', but removes redundancy
	switch(current_job)
		if("Chaplain", "Janitor", "Cook", "Botanist", "Medical Doctor", "Chemist", "Geneticist", "Roboticist", "Virologist", "Scientist", "Chief Medical Officer", "Captain")
			O = new /datum/outfit/digitigrade

		if("Curator", "Bartender", "Lawyer", "Detective", "Head of Personnel", "Research Director")
			O = new /datum/outfit/digitigrade/laceups

		if("Security Officer", "Warden", "Head of Security")
			O = new /datum/outfit/digitigrade/jackboots

		if("Cargo Technician", "Quartermaster", "Shaft Miner", "Station Engineer", "Atmospheric Technician", "Chief Engineer")
			O = new /datum/outfit/digitigrade/workboots

		if("Mime")
			O = new /datum/outfit/digitigrade/mime

		if("Clown")
			O = new /datum/outfit/digitigrade/clown

	H.equipOutfit(O, visualsOnly)
	return 0

