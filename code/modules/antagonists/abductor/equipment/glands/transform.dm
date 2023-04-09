/obj/item/organ/internal/heart/gland/transform
	abductor_hint = "anthropmorphic transmorphosizer. The abductee will occasionally change appearance and species."
	cooldown_low = 900
	cooldown_high = 1800
	uses = -1
	human_only = TRUE
	icon_state = "species"
	mind_control_uses = 7
	mind_control_duration = 300

/obj/item/organ/internal/heart/gland/transform/activate()
	to_chat(owner, span_notice("You feel unlike yourself."))
	randomize_human(owner)
	var/species = pick(list(/datum/species/human, /datum/species/lizard, /datum/species/moth, /datum/species/fly))
	owner.set_species(species)
