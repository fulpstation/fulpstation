/obj/item/paper/carbon
	name = "sheet of carbon"
	icon_state = "paper_stack"
	inhand_icon_state = "paper"
	show_written_words = FALSE
	var/copied = FALSE
	var/iscopy = FALSE

/obj/item/paper/carbon/update_icon_state()
	if(iscopy)
		icon_state = "cpaper"
	else if(copied)
		icon_state = "paper"
	else
		icon_state = "paper_stack"
	if(info)
		icon_state = "[icon_state]_words"
	return ..()

/obj/item/paper/carbon/examine()
	. = ..()
	if(copied || iscopy)
		return
	. += span_notice("Right-click to tear off the carbon-copy (you must use both hands).")

/obj/item/paper/carbon/proc/removecopy(mob/living/user)
	if(copied || iscopy)
		to_chat(user, span_notice("There are no more carbon copies attached to this paper!"))
	else
		var/obj/item/paper/carbon/C = src
		var/copycontents = C.info
		var/obj/item/paper/carbon/Copy = new /obj/item/paper/carbon(user.loc)

		if(info)
			copycontents = replacetext(copycontents, "<font face=\"[PEN_FONT]\" color=", "<font face=\"[PEN_FONT]\" nocolor=")
			copycontents = replacetext(copycontents, "<font face=\"[CRAYON_FONT]\" color=", "<font face=\"[CRAYON_FONT]\" nocolor=")
			Copy.info += copycontents
			Copy.info += "</font>"
			Copy.name = "Copy - [C.name]"
		to_chat(user, span_notice("You tear off the carbon-copy!"))
		C.copied = TRUE
		Copy.iscopy = TRUE
		Copy.update_icon_state()
		C.update_icon_state()
		user.put_in_hands(Copy)

/obj/item/paper/carbon/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(loc == user && user.is_holding(src))
		removecopy(user)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
