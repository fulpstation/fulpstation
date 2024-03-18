/**
 * ##calling card
 *
 * This item is required to be on someone to know if rewards should be given out.
 */
/obj/item/paper/devil_calling_card
	name = "calling card"
	color = "#ff5050"
	default_raw_text = {"<b>My life's ledger is etched in crimson, a debt so profound that only the Devil's whispered promises \
		could keep me from the abyss. With this card, I repay some of that crimson debt, and the scales of infernal justice \
		begin to even. \
		<br> \
		Know that as these words rest upon you, my fate and yours are irrevocably intertwined. \
		The Devil's grip on my soul compels my every move, and the debt I owe shall be your reckoning. \
		<br> \
		Until then, carry the weight of your choices, for I am but a vessel, and our fates are bound by the Devil's contract.\
		<br> \
		<br> \
		Gooodnight now, and forever. \
		</b><br><br>"}

	///A weakref to the antag datum who signed the paper, so simply holding a paper for YOUR target doesn't make you eligible.
	var/datum/weakref/signed_by_ref

/obj/item/paper/devil_calling_card/Initialize(mapload, obj/item/paper/newPaper)
	. = ..()
	if(newPaper)
		qdel(newPaper)

/obj/item/paper/devil_calling_card/Destroy()
	signed_by_ref = null
	return ..()


/**
 * Paper overwrites
 * We overwrite the examine and AltClick to inject our mechanics.
 */
/obj/item/paper/examine(mob/user, force = FALSE)
	. = ..()
	if(IS_INFERNAL_AGENT(user))
		. += span_warning("Folding the paper plane allows you to turn it into a calling card if you need to.")

/obj/item/paper/AltClick(mob/living/user, obj/item/I)
	if(!user.can_perform_action(src, NEED_DEXTERITY|NEED_HANDS))
		return
	var/datum/antagonist/infernal_affairs/infernal_datum = IS_INFERNAL_AGENT(user)
	if(infernal_datum)
		var/plane_response = tgui_input_list(user, "Do you wish for a plane or a calling card?", "Your Calling", list("Calling Card", "Airplane"))
		if(plane_response == "Calling Card")
			var/obj/item/paper/devil_calling_card/card = make_plane(user, plane_type = /obj/item/paper/devil_calling_card)
			card.signed_by_ref = WEAKREF(infernal_datum)
			return
	return ..()
