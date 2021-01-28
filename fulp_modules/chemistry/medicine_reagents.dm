/datum/reagent/medicine/syndicate_nanites //Used exclusively by Syndicate medical cyborgs
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Let's not cripple synth ops

/datum/reagent/medicine/lesser_syndicate_nanites
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/medicine/stimulants
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Syndicate developed 'accelerants' for synths?

/datum/reagent/medicine/leporazine
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/medicine/liquid_solder
	name = "Liquid Solder"
	description = "Repairs brain damage in synthetics."
	color = "#727272"
	taste_description = "metal"
	process_flags = REAGENT_SYNTHETIC

/datum/reagent/medicine/liquid_solder/on_mob_life(mob/living/carbon/C)
	C.adjustOrganLoss(ORGAN_SLOT_BRAIN, -3*REM)
	if(prob(10))
		C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)
	..()

/obj/item/storage/pill_bottle/mannitol/synth
	name = "bottle of liquid solder pills"
	desc = "Contains pills used to treat brain damage in synthetic lifeforms."

/obj/item/storage/pill_bottle/mannitol/synth/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/liquid_solder(src)

/obj/item/reagent_containers/pill/liquid_solder
	name = "liquid solder pill"
	desc = "Used to treat brain damage in synthetics."
	icon_state = "pill17"
	list_reagents = list(/datum/reagent/medicine/liquid_solder = 50)
	rename_with_volume = TRUE
