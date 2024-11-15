/obj/item/book/granter/action/spell/fulp/direct_cat_meteor
	granted_action = /datum/action/cooldown/spell/conjure_item/infinite_guns/direct_cateor
	action_name = "direct cat meteor"
	icon_state ="direct_cat_meteor"
	desc = "This book's simple cover is confounding in the sheer amount of mirth it conveys."
	remarks = list(
		"Fow some weason ow othew thewe awe no \"R's\" or \"W's\" in this text...",
		"Undew what ciwcumstances wouwd this be usefuw..?",
		"The mage who fiwst discovewed this speww twied to censow aww knowwedge of it...",
		"Wegends teww of stations bwought to wuin when this was cast on a cat muwtipwe times...",
		"Fewinids awe supposedwy wess affected by this...",
		"Wizawd Fedewation subsects have attempted to outwaw this in sevewal sectors...",
		"CAT..."
	)

/obj/item/book/granter/action/spell/fulp/direct_cat_meteor/recoil(mob/living/user)
	. = ..()
	var/obj/effect/meteor/cateor/new_cateor = new /obj/effect/meteor/cateor(get_turf(user), NONE)
	new_cateor.Bump(user)
