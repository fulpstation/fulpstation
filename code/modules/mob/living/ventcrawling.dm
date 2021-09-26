// VENTCRAWLING
// Handles the entrance and exit on ventcrawling
/mob/living/proc/handle_ventcrawl(obj/machinery/atmospherics/components/ventcrawl_target)
	// Being able to always ventcrawl trumps being only able to ventcrawl when wearing nothing
	var/required_nudity = HAS_TRAIT(src, TRAIT_VENTCRAWLER_NUDE) && !HAS_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS)
	// Cache the vent_movement bitflag var from atmos machineries
	var/vent_movement = ventcrawl_target.vent_movement

	if(!Adjacent(ventcrawl_target))
		return
	if(!HAS_TRAIT(src, TRAIT_VENTCRAWLER_NUDE) && !HAS_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS))
		return
	if(stat)
		to_chat(src, span_warning("You must be conscious to do this!"))
		return
	if(HAS_TRAIT(src, TRAIT_IMMOBILIZED))
		to_chat(src, span_warning("You currently can't move into the vent!"))
		return
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		to_chat(src, span_warning("You need to be able to use your hands to ventcrawl!"))
		return
	if(has_buckled_mobs())
		to_chat(src, span_warning("You can't vent crawl with other creatures on you!"))
		return
	if(buckled)
		to_chat(src, span_warning("You can't vent crawl while buckled!"))
		return
	if(iscarbon(src) && required_nudity)
		if(length(get_equipped_items(include_pockets = TRUE)) || get_num_held_items())
			to_chat(src, span_warning("You can't crawl around in the ventilation ducts with items!"))
			return
	if(ventcrawl_target.welded)
		to_chat(src, span_warning("You can't crawl around a welded vent!"))
		return

	if(vent_movement & VENTCRAWL_ENTRANCE_ALLOWED)
		//Handle the exit here
		if(HAS_TRAIT(src, TRAIT_MOVE_VENTCRAWLING) && istype(loc, /obj/machinery/atmospherics) && movement_type & VENTCRAWLING)
			visible_message(span_notice("[src] begins climbing out from the ventilation system...") ,span_notice("You begin climbing out from the ventilation system..."))
			if(!client)
				return
			visible_message(span_notice("[src] scrambles out from the ventilation ducts!"),span_notice("You scramble out from the ventilation ducts."))
			forceMove(ventcrawl_target.loc)
			REMOVE_TRAIT(src, TRAIT_MOVE_VENTCRAWLING, VENTCRAWLING_TRAIT)
			update_pipe_vision()

		//Entrance here
		else
			var/datum/pipeline/vent_parent = ventcrawl_target.parents[1]
			if(vent_parent && (vent_parent.members.len || vent_parent.other_atmosmch))
				visible_message(span_notice("[src] begins climbing into the ventilation system...") ,span_notice("You begin climbing into the ventilation system..."))
				if(!do_after(src, 2.5 SECONDS, target = ventcrawl_target))
					return
				if(!client)
					return
				visible_message(span_notice("[src] scrambles into the ventilation ducts!"),span_notice("You climb into the ventilation ducts."))
				move_into_vent(ventcrawl_target)
			else
				to_chat(src, span_warning("This ventilation duct is not connected to anything!"))

/mob/living/simple_animal/slime/handle_ventcrawl(atom/A)
	if(buckled)
		to_chat(src, "<i>I can't vent crawl while feeding...</i>")
		return
	return ..()

/**
 * Moves living mob directly into the vent as a ventcrawler
 *
 * Arguments:
 * * ventcrawl_target - The vent into which we are moving the mob
 */
/mob/living/proc/move_into_vent(obj/machinery/atmospherics/components/ventcrawl_target)
	forceMove(ventcrawl_target)
	ADD_TRAIT(src, TRAIT_MOVE_VENTCRAWLING, VENTCRAWLING_TRAIT)
	update_pipe_vision()

/**
 * Everything related to pipe vision on ventcrawling is handled by update_pipe_vision().
 * Called on exit, entrance, and pipenet differences (e.g. moving to a new pipenet).
 * One important thing to note however is that the movement of the client's eye is handled by the relaymove() proc in /obj/machinery/atmospherics.
 * We move first and then call update. Dont flip this around
 */
/mob/living/proc/update_pipe_vision()
	// Take the pipe images from the client
	if (!isnull(client))
		for(var/image/current_image in pipes_shown)
			client.images -= current_image
		pipes_shown.len = 0

	// Give the pipe images to the client
	if(HAS_TRAIT(src, TRAIT_MOVE_VENTCRAWLING) && istype(loc, /obj/machinery/atmospherics) && movement_type & VENTCRAWLING)
		var/list/total_members = list()
		var/obj/machinery/atmospherics/current_location = loc
		for(var/datum/pipeline/location_pipeline in current_location.returnPipenets())
			total_members += location_pipeline.members
			total_members += location_pipeline.other_atmosmch

		if(!total_members.len)
			return

		if(client)
			for(var/obj/machinery/atmospherics/pipenet_part in total_members)
				// If the machinery is not in view or is not meant to be seen, continue
				if(!in_view_range(client.mob, pipenet_part))
					continue
				if(!(pipenet_part.vent_movement & VENTCRAWL_CAN_SEE))
					continue

				if(!pipenet_part.pipe_vision_img)
					pipenet_part.pipe_vision_img = image(pipenet_part, pipenet_part.loc, dir = pipenet_part.dir)
					pipenet_part.pipe_vision_img.plane = ABOVE_HUD_PLANE
				client.images += pipenet_part.pipe_vision_img
				pipes_shown += pipenet_part.pipe_vision_img
