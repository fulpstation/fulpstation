/obj/structure/punching_bag
	name = "punching bag"
	desc = "A punching bag. Can you get to speed level 4???"
	icon = 'icons/obj/gym_equipment.dmi'
	icon_state = "punchingbag"
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	///List of sounds that can be played when punched.
	var/static/list/hit_sounds = list(
		'sound/weapons/genhit1.ogg',
		'sound/weapons/genhit2.ogg',
		'sound/weapons/genhit3.ogg',
		'sound/weapons/punch1.ogg',
		'sound/weapons/punch2.ogg',
		'sound/weapons/punch3.ogg',
		'sound/weapons/punch4.ogg',
	)

/obj/structure/punching_bag/Initialize(mapload)
	. = ..()

	AddElement( \
		/datum/element/contextual_screentip_bare_hands, \
		lmb_text = "Punch", \
	)

	var/static/list/tool_behaviors = list(
		TOOL_CROWBAR = list(
			SCREENTIP_CONTEXT_RMB = "Deconstruct",
		),

		TOOL_WRENCH = list(
			SCREENTIP_CONTEXT_RMB = "Anchor",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/obj/structure/punching_bag/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	flick("[icon_state]-punch", src)
	playsound(loc, pick(hit_sounds), 25, TRUE, -1)
	user.add_mood_event("exercise", /datum/mood_event/exercise)
	user.apply_status_effect(/datum/status_effect/exercised)

/obj/structure/punching_bag/wrench_act_secondary(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	balloon_alert(user, anchored ? "unsecured" : "secured")
	anchored = !anchored
	return TRUE

/obj/structure/punching_bag/crowbar_act_secondary(mob/living/user, obj/item/tool)
	if(anchored)
		balloon_alert(user, "still secured!")
		return FALSE
	tool.play_tool_sound(src)
	balloon_alert(user, "deconstructing...")
	if (!do_after(user, 10 SECONDS, target = src))
		return FALSE
	new /obj/item/stack/sheet/iron(get_turf(src), 2)
	new /obj/item/stack/rods(get_turf(src))
	new /obj/item/pillow(get_turf(src))
	qdel(src)
	return TRUE
