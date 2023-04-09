/// Lets you make hitting a turf with a shovel pop something out, and scrape the turf
/datum/element/diggable
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH_ON_HOST_DESTROY // Detach for turfs
	argument_hash_start_idx = 2
	/// Typepath of what we spawn on shovel
	var/atom/to_spawn
	/// Amount to spawn on shovel
	var/amount
	/// What should we tell the user they did? (Eg: "You dig up the turf.")
	var/action_text
	/// What should we tell other people what the user did? (Eg: "Guy digs up the turf.")
	var/action_text_third_person
	/// Percentage chance of receiving a bonus worm
	var/worm_chance

/datum/element/diggable/Attach(datum/target, to_spawn, amount = 1, worm_chance = 30, action_text = "dig up", action_text_third_person = "digs up")
	. = ..()
	if(!isturf(target))
		return ELEMENT_INCOMPATIBLE
	if(!to_spawn)
		stack_trace("[type] wasn't passed a typepath to spawn attaching to [target].")
		return ELEMENT_INCOMPATIBLE

	src.to_spawn = to_spawn
	src.amount = amount
	src.worm_chance = worm_chance
	src.action_text = action_text
	src.action_text_third_person = action_text_third_person

	RegisterSignal(target, COMSIG_ATOM_TOOL_ACT(TOOL_SHOVEL), PROC_REF(on_shovel))

/datum/element/diggable/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_TOOL_ACT(TOOL_SHOVEL))

/// Signal proc for [COMSIG_ATOM_TOOL_ACT] via [TOOL_SHOVEL].
/datum/element/diggable/proc/on_shovel(turf/source, mob/user, obj/item/tool)
	SIGNAL_HANDLER

	for(var/i in 1 to amount)
		new to_spawn(source)
	if (prob(worm_chance))
		new /obj/item/food/bait/worm(source)

	user.visible_message(
		span_notice("[user] [action_text_third_person] [source]."),
		span_notice("You [action_text] [source]."),
	)

	playsound(source, 'sound/effects/shovel_dig.ogg', 50, TRUE)
	source.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
