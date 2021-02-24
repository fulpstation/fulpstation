/obj/item/pen/lazarus_injector
	desc = "It's a normal black ink pen."
	name = "pen"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_EARS
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=10)
	pressure_resistance = 2
	grind_results = list(/datum/reagent/iron = 2, /datum/reagent/iodine = 1)
	var/colour = "black"	//what colour the ink is!
	var/degrees = 0
	var/font = PEN_FONT
	embedding = list()
	sharpness = SHARP_POINTY
    var/loaded = 1
	var/malfunctioning = 0
	var/revive_type = SENTIENCE_ORGANIC //So you can't revive boss monsters or robots 

/obj/item/pen/lazarus_injector/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(!loaded)
		return
	if(isliving(target) && proximity_flag)
		if(isanimal(target))
			var/mob/living/simple_animal/M = target
			if(M.sentience_type != revive_type)
				to_chat(user, "<span class='info'>[src] does not work on this sort of creature.</span>")
				return
			if(M.stat == DEAD)
				M.faction = list("neutral")
				M.revive(full_heal = TRUE, admin_revive = TRUE)
				if(ishostile(target))
					var/mob/living/simple_animal/hostile/H = M
					if(malfunctioning)
						H.faction |= list("lazarus", "[REF(user)]")
						H.robust_searching = 1
						H.friends += user
						H.attack_same = 1
						log_game("[key_name(user)] has revived hostile mob [key_name(target)] with a malfunctioning lazarus injector")
					else
						H.attack_same = 0
				loaded = 0
				user.visible_message("<span class='notice'>[user] injects [M] with [src], reviving it.</span>")
				SSblackbox.record_feedback("tally", "lazarus_injector", 1, M.type)
				playsound(src,'sound/effects/refill.ogg',50,TRUE)
				icon_state = "lazarus_empty"
				return
			else
				to_chat(user, "<span class='info'>[src] is only effective on the dead.</span>")
				return
		else
			to_chat(user, "<span class='info'>[src] is only effective on lesser beings.</span>")
			return

/obj/item/pen/lazarus_injector/emp_act()
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!malfunctioning)
		malfunctioning = 1

/obj/item/pen/lazarus_injector/examine(mob/user)
	. = ..()
	if(!loaded)
		. += "<span class='info'>[src] is empty.</span>"
	if(malfunctioning)
		. += "<span class='info'>The display on [src] seems to be flickering.</span>"

/obj/item/pen/lazarus_injector/Initialize()