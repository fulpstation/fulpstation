/datum/objective_item/steal/pet_objectives
	targetitem = /obj/item/pet_carrier
	altitems = list(/obj/item/clothing/head/mob_holder)
	var/mob/targetpet

/datum/objective_item/steal/pet_objectives/New()
	special_equipment += /obj/item/pen/lazarus_injector
	..()

/datum/objective_item/steal/pet_objectives/check_special_completion(obj/item/B)
	if(istype(B, /obj/item/pet_carrier))
		var/obj/item/pet_carrier/A = B
		for(var/targetpet/D in A)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
	if(istype(B, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/A = B
		for(var/targetpet/D in A)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
	return FALSE

/datum/objective_item/steal/pet_objectives/ian
	name = "Ian, the Head of Personnel's pet corgi, alive."
	difficulty = 20
	excludefromjob = list("Head of Personnel")
	targetpet = mob/living/simple_animal/pet/dog/corgi/ian

/datum/objective_item/steal/pet_objectives/poly
	name = "Poly, the Chief Engineer's pet parrot, alive"
	difficulty = 30
	excludefromjob = list("Chief Engineer")
	targetpet = mob/living/simple_animal/parrot/poly

/datum/objective_item/steal/pet_objectives/poly/New()
	special_equipment += /obj/item/pet_carrier/mini
	..()

/datum/objective_item/steal/pet_objectives/runtimecat
	name = "Runtime, the Chief Medical Officer's pet, alive."
	difficulty = 20
	excludefromjob = list("Chief Medical Officer")
	targetpet = mob/living/simple_animal/pet/cat/runtime

/datum/objective_item/steal/pet_objectives/renaultfox
	name = "Renault, the Captain's prized fox, alive!"
	difficulty = 20
	excludefromjob = list("Captain")
	targetpet = mob/living/simple_animal/pet/fox/renault

/datum/objective_item/steal/lamarr
	name = "Lamarr The subject of study by the research director."
	targetitem = /obj/item/clothing/mask/facehugger/lamarr
	difficulty = 40
	excludefromjob = list("Research Director")
