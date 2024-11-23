#define MIKE_BOXING_TRAIT "mike_boxing"

// Actual item, the boxing gloves
/obj/item/clothing/gloves/boxing/mike
	name = "Champion's boxing gloves"
	desc = "The top choice for brawlers across the sector. Their interior is lined with neuronal clamps and shunts,\
			designed to boost the wearer's strength and grant them extensive boxing knowledge. Made of real leather!"
	greyscale_colors = "#a6171e"
	style_to_give = /datum/martial_art/boxing/mike
	/// Athletics level that we grant upon equipping
	var/level_to_give = SKILL_LEVEL_EXPERT
	/// Whether we have already granted a skill boost
	var/spent = FALSE

/obj/item/clothing/gloves/boxing/mike/examine_more(mob/user)
	. = ..()
	. += span_notice("The tag does say it's leather, but it also says they genuinely belonged to an \
					  earth boxer from two centuries ago, so it's probably just neoprene.")

/obj/item/clothing/gloves/boxing/mike/Initialize(mapload)
	. = ..()

	RegisterSignal(src, COMSIG_ITEM_POST_EQUIPPED, PROC_REF(add_effects))
	ADD_TRAIT(src, TRAIT_NODROP, MIKE_BOXING_TRAIT)

/obj/item/clothing/gloves/boxing/mike/proc/add_effects(obj/item/source, mob/living/user, slot)
	SIGNAL_HANDLER
	if(spent)
		return

	if(slot & ITEM_SLOT_GLOVES)
		spent = TRUE
		to_chat(user, span_warning("Knowledge about the art of boxing surges through your mind!"))
		user.mind?.set_level(/datum/skill/athletics, level_to_give)

		for (var/obj/item/implant in user.implants)
			if(istype(implant, /obj/item/implant/sad_trombone/knockout_bell))
				return

		var/obj/item/implant/sad_trombone/knockout_bell/knockout = new
		if(knockout.can_be_implanted_in(user))
			knockout.implant(user, silent = TRUE)
		else
			qdel(knockout)



