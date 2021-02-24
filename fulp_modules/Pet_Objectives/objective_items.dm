/datum/objective_item/steal/iandog
	name = "Ian, the Head of Personnel's pet corgi, alive."
	targetitem = /obj/item/pet_carrier
	difficulty = 20
	excludefromjob = list("Head of Personnel")
	altitems = list(/obj/item/clothing/head/mob_holder)

/datum/objective_item/steal/iandog/New()
	special_equipment += /obj/item/pen/lazarus_injector
	..()

/datum/objective_item/steal/iandog/check_special_completion(obj/item/I)
	if(istype(I, /obj/item/pet_carrier))
		var/obj/item/pet_carrier/C = I
		for(var/mob/living/simple_animal/pet/dog/corgi/ian/D in C)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
		for(var/mob/living/simple_animal/pet/dog/corgi/puppy/D in C)
			if(D.stat != DEAD)//checks if pet is alive.
				if(D.desc == "It's the HoP's beloved corgi puppy.")
					return TRUE
	if(istype(I, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/C = I
		for(var/mob/living/simple_animal/pet/dog/corgi/ian/D in C)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
		for(var/mob/living/simple_animal/pet/dog/corgi/puppy/D in C)
			if(D.stat != DEAD)//checks if pet is alive.
				if(D.desc == "It's the HoP's beloved corgi puppy.")
					return TRUE
	return FALSE 

/datum/objective_item/steal/poly
	name = "Poly, the Chief Engineer's pet parrot, alive"
	targetitem = /obj/item/pet_carrier
	difficulty = 30
	excludefromjob = list("Chief Engineer")
	altitems = list(/obj/item/clothing/head/mob_holder)

/datum/objective_item/steal/poly/New()
	special_equipment += /obj/item/pen/lazarus_injector
	..()

/datum/objective_item/steal/poly/check_special_completion(obj/item/B)
	if(istype(B, /obj/item/pet_carrier))
		var/obj/item/pet_carrier/A = B
		for(var/mob/living/simple_animal/parrot/poly/D in A)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
	if(istype(B, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/A = B
		for(var/mob/living/simple_animal/parrot/poly/D in A)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
	return FALSE

/datum/objective_item/steal/runtimecat
	name = "Runtime, the Chief Medical Officer's pet, alive."
	targetitem = /obj/item/pet_carrier
	difficulty = 20
	excludefromjob = list("Chief Medical Officer")
	altitems = list(/obj/item/clothing/head/mob_holder)

/datum/objective_item/steal/runtimecat/New()
	special_equipment += /obj/item/pen/lazarus_injector
	..()

/datum/objective_item/steal/runtimecat/check_special_completion(obj/item/H)
	if(istype(H, /obj/item/pet_carrier))
		var/obj/item/pet_carrier/T = H
		for(var/mob/living/simple_animal/pet/cat/runtime/D in T)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
	if(istype(H, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/T = H
		for(var/mob/living/simple_animal/pet/cat/runtime/D in T)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
	return FALSE

/datum/objective_item/steal/renaultfox
	name = "Renault, the Captain's prized fox, alive!"
	targetitem = /obj/item/pet_carrier
	difficulty = 20
	excludefromjob = list("Captain")
	altitems = list(/obj/item/clothing/head/mob_holder)

/datum/objective_item/steal/renaultfox/New()
	special_equipment += /obj/item/pen/lazarus_injector
	..()

/datum/objective_item/steal/renaultfox/check_special_completion(obj/item/K)
	if(istype(K, /obj/item/pet_carrier))
		var/obj/item/pet_carrier/G = K
		for(var/mob/living/simple_animal/pet/fox/renault/D in G)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
	if(istype(K, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/G = K
		for(var/mob/living/simple_animal/pet/fox/renault/D in G)
			if(D.stat != DEAD)//checks if pet is alive.
				return TRUE
	return FALSE

/datum/objective_item/steal/lamarr
	name = "Lamarr The subject of study by the research director."
	targetitem = /obj/item/clothing/mask/facehugger/lamarr
	difficulty = 40
	excludefromjob = list("Research Director")
