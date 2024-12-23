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

	/// Set to 'world.time' whenever the book meows. Referenced to create delay between meows.
	var/last_process
	/// The delay between the book's meows (in seconds). Normally ranges between five and thirty.
	var/delay = 1

/obj/item/book/granter/action/spell/fulp/direct_cat_meteor/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	last_process = world.time

/obj/item/book/granter/action/spell/fulp/direct_cat_meteor/Destroy(force)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/book/granter/action/spell/fulp/direct_cat_meteor/process(seconds_per_tick)
	if(world.time < last_process + delay SECONDS)
		return

	delay = rand(5, 30)
	src.manual_emote("meows")
	playsound(src, get_sfx(SFX_CAT_MEOW), 50, FALSE)
	last_process = world.time

/obj/item/book/granter/action/spell/fulp/direct_cat_meteor/try_carve(obj/item/carving_item, mob/living/user, params)
	. = ..()
	to_chat(user, span_warning("[src] wrathfully winks at you as you raise your [carving_item.name] towards it. A singular ultimatum overwhelms your psyche:"))
	to_chat(user, span_hypnophrase(span_big("NO.")))
	recoil(user)

/obj/item/book/granter/action/spell/fulp/direct_cat_meteor/carve_out(obj/item/carving_item, mob/living/user)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/book/granter/action/spell/fulp/direct_cat_meteor/recoil(mob/living/user)
	. = ..()
	var/obj/effect/meteor/cateor/new_cateor = new /obj/effect/meteor/cateor(get_turf(user), NONE)
	new_cateor.Bump(user)
