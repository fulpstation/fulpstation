/obj/item/clothing/gloves/boxing/evil/mike
	name = "Champion's boxing gloves"
	desc = "The top choice for brawlers across the sector. Their interior is lined with neuronal clamps and shunts,\
			designed to boost the wearer's strength and grant them extensive boxing knowledge. Made of real leather!"
	greyscale_colors = "#a6171e"

/obj/item/clothing/gloves/boxing/evil/mike/examine_more(mob/user)
	. = ..()
	. += span_notice("The tag does say it's leather, but it also says they genuinely belonged to an\
					  earth boxer from two centuries ago, so it's probably just neoprene.")

/obj/item/clothing/gloves/boxing/evil/mike/Initialize(mapload)
	. = ..()

	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(add_effects))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(remove_effects))

/obj/item/clothing/gloves/boxing/evil/mike/add_effects(obj/item/source, mob/living/user, slot)
	SIGNAL_HANDLER

	to_chat(user, span_warning("Knowledge about the art of boxing surges through your mind!"))
	user.mind?.adjust_experience(/datum/skill/athletics, SKILL_EXP_MASTER)

/obj/item/clothing/gloves/boxing/evil/mike/remove_effects()
	SIGNAL_HANDLER

	to_chat(user, span_warning("You forget the skills the gloves taught you."))
	wielder.mind?.adjust_experience(/datum/skill/athletics, -SKILL_EXP_MASTER)
