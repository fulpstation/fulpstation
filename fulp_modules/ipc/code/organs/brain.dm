/obj/item/organ/brain/ipc_positron
	name = "positronic brain carcass"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC | ORGAN_VITAL
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'fulp_modules/ipc/icons/ipc_organs.dmi'
	icon_state = "posibrain-ipc"

/obj/item/organ/brain/ipc_positron/Insert(mob/living/carbon/C, special = 0, drop_if_replaced = TRUE)
	..()
	if(C.stat == DEAD && ishuman(C))
		var/mob/living/carbon/human/H = C
		if(H?.dna?.species && (REVIVES_BY_HEALING in H.dna.species.species_traits))
			if(H.health > 50)
				H.revive(FALSE)

/obj/item/organ/brain/ipc_positron/emp_act(severity)
	switch(severity)
		if(1)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 75, 150)
			to_chat(owner, "<span class='warning'>Alert: Posibrain heavily damaged.</span>")
		if(2)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 25, 150)
			to_chat(owner, "<span class='warning'>Alert: Posibrain damaged.</span>")
