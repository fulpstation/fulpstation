#define MEATSPIKE_IRONROD_REQUIREMENT 4

/obj/structure/kitchenspike_frame
	name = "meatspike frame"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spikeframe"
	desc = "The frame of a meat spike."
	density = TRUE
	anchored = FALSE
	max_integrity = 200

/obj/structure/kitchenspike_frame/welder_act(mob/living/user, obj/item/tool)
	if(!tool.tool_start_check(user, amount = 0))
		return FALSE
	to_chat(user, span_notice("You begin cutting \the [src] apart..."))
	if(!tool.use_tool(src, user, 5 SECONDS, volume = 50))
		return TRUE
	visible_message(span_notice("[user] slices apart \the [src]."),
		span_notice("You cut \the [src] apart with \the [tool]."),
		span_hear("You hear welding."))
	new /obj/item/stack/sheet/iron(loc, MEATSPIKE_IRONROD_REQUIREMENT)
	qdel(src)
	return TRUE

/obj/structure/kitchenspike_frame/wrench_act(mob/living/user, obj/item/tool)
	default_unfasten_wrench(user, tool)
	return TRUE

/obj/structure/kitchenspike_frame/attackby(obj/item/attacking_item, mob/user, params)
	add_fingerprint(user)
	if(!istype(attacking_item, /obj/item/stack/rods))
		return ..()
	var/obj/item/stack/rods/used_rods = attacking_item
	if(used_rods.get_amount() >= MEATSPIKE_IRONROD_REQUIREMENT)
		used_rods.use(MEATSPIKE_IRONROD_REQUIREMENT)
		to_chat(user, span_notice("You add spikes to the frame."))
		var/obj/structure/new_meatspike = new /obj/structure/kitchenspike(loc)
		transfer_fingerprints_to(new_meatspike)
		qdel(src)

/obj/structure/kitchenspike
	name = "meat spike"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spike"
	desc = "A spike for collecting meat from animals."
	density = TRUE
	anchored = TRUE
	buckle_lying = FALSE
	can_buckle = TRUE
	max_integrity = 250

/obj/structure/kitchenspike/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/kitchenspike/crowbar_act(mob/living/user, obj/item/tool)
	if(has_buckled_mobs())
		to_chat(user, span_warning("You can't do that while something's on the spike!"))
		return TRUE

	if(tool.use_tool(src, user, 2 SECONDS, volume = 100))
		to_chat(user, span_notice("You pry the spikes out of the frame."))
		deconstruct(TRUE)
		return TRUE
	return FALSE

/obj/structure/kitchenspike/user_buckle_mob(mob/living/target, mob/user, check_loc = TRUE)
	if(!iscarbon(target) && !isanimal_or_basicmob(target))
		return
	if(!do_mob(user, target, 10 SECONDS))
		return
	return ..()

/obj/structure/kitchenspike/post_buckle_mob(mob/living/target)
	playsound(src.loc, 'sound/effects/splat.ogg', 25, TRUE)
	target.emote("scream")
	target.add_splatter_floor()
	target.adjustBruteLoss(30)
	target.setDir(2)
	var/matrix/m180 = matrix(target.transform)
	m180.Turn(180)
	animate(target, transform = m180, time = 3)
	target.pixel_y = target.base_pixel_y + PIXEL_Y_OFFSET_LYING

/obj/structure/kitchenspike/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(buckled_mob != user)
		buckled_mob.visible_message(span_notice("[user] tries to pull [buckled_mob] free of [src]!"),\
			span_notice("[user] is trying to pull you off [src], opening up fresh wounds!"),\
			span_hear("You hear a squishy wet noise."))
		if(!do_after(user, 30 SECONDS, target = src))
			if(buckled_mob?.buckled)
				buckled_mob.visible_message(span_notice("[user] fails to free [buckled_mob]!"),\
					span_notice("[user] fails to pull you off of [src]."))
			return

	else
		buckled_mob.visible_message(span_warning("[buckled_mob] struggles to break free from [src]!"),\
		span_notice("You struggle to break free from [src], exacerbating your wounds! (Stay still for two minutes.)"),\
		span_hear("You hear a wet squishing noise.."))
		buckled_mob.adjustBruteLoss(30)
		if(!do_after(buckled_mob, 2 MINUTES, target = src))
			if(buckled_mob?.buckled)
				to_chat(buckled_mob, span_warning("You fail to free yourself!"))
			return
	return ..()

/obj/structure/kitchenspike/post_unbuckle_mob(mob/living/buckled_mob)
	buckled_mob.adjustBruteLoss(30)
	INVOKE_ASYNC(buckled_mob, /mob/proc/emote, "scream")
	buckled_mob.AdjustParalyzed(20)
	var/matrix/m180 = matrix(buckled_mob.transform)
	m180.Turn(180)
	animate(buckled_mob, transform = m180, time = 3)
	buckled_mob.pixel_y = buckled_mob.base_pixel_y + PIXEL_Y_OFFSET_LYING

/obj/structure/kitchenspike/deconstruct(disassembled = TRUE)
	if(disassembled)
		var/obj/structure/meatspike_frame = new /obj/structure/kitchenspike_frame(src.loc)
		transfer_fingerprints_to(meatspike_frame)
	else
		new /obj/item/stack/sheet/iron(src.loc, 4)
	new /obj/item/stack/rods(loc, MEATSPIKE_IRONROD_REQUIREMENT)
	qdel(src)

#undef MEATSPIKE_IRONROD_REQUIREMENT
