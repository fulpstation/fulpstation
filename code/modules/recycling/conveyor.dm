/// Maximum amount of items a conveyor can move at once.
#define MAX_CONVEYOR_ITEMS_MOVE 30
/// Conveyor is currently off.
#define CONVEYOR_OFF 0
/// Conveyor is currently configured to move items forward.
#define CONVEYOR_FORWARD 1
/// Conveyor is currently configured to move items backwards.
#define CONVEYOR_BACKWARDS -1
GLOBAL_LIST_EMPTY(conveyors_by_id)

/obj/machinery/conveyor
	icon = 'icons/obj/recycling.dmi'
	icon_state = "conveyor_map"
	base_icon_state = "conveyor"
	name = "conveyor belt"
	desc = "A conveyor belt."
	layer = BELOW_OPEN_DOOR_LAYER
	processing_flags = START_PROCESSING_MANUALLY
	subsystem_type = /datum/controller/subsystem/processing/conveyors
	/// The current state of the switch.
	var/operating = CONVEYOR_OFF
	/// This is the default (forward) direction, set by the map dir.
	var/forwards
	/// The opposite of forwards. It's set in a special var for corner belts, which aren't using the opposite direction when in reverse.
	var/backwards
	/// The actual direction to move stuff in.
	var/movedir
	/// The control ID - must match at least one conveyor switch's ID to be useful.
	var/id = ""
	/// Inverts the direction the conveyor belt moves when true.
	var/inverted = FALSE
	/// Is the conveyor's belt flipped? Useful mostly for conveyor belt corners. It makes the belt point in the other direction, rather than just going in reverse.
	var/flipped = FALSE
	/// Are we currently conveying items?
	var/conveying = FALSE

/obj/machinery/conveyor/examine(mob/user)
	. = ..()
	if(inverted)
		. += span_notice("It is currently set to go in reverse.")
	. += "\nLeft-click with a <b>wrench</b> to rotate."
	. += "Left-click with a <b>screwdriver</b> to invert its direction."
	. += "Right-click with a <b>screwdriver</b> to flip its belt around."

/obj/machinery/conveyor/centcom_auto
	id = "round_end_belt"

/obj/machinery/conveyor/inverted //Directions inverted so you can use different corner pieces.
	icon_state = "conveyor_map_inverted"
	flipped = TRUE

/obj/machinery/conveyor/inverted/Initialize(mapload)
	. = ..()
	if(mapload && !(ISDIAGONALDIR(dir)))
		log_mapping("[src] at [AREACOORD(src)] spawned without using a diagonal dir. Please replace with a normal version.")


// Auto conveyor is always on unless unpowered.
/obj/machinery/conveyor/auto
	processing_flags = START_PROCESSING_ON_INIT

/obj/machinery/conveyor/auto/Initialize(mapload, newdir)
	operating = TRUE
	return ..()

/obj/machinery/conveyor/auto/update()
	. = ..()
	if(.)
		operating = TRUE
		update_appearance()

/obj/machinery/conveyor/Initialize(mapload, new_dir, new_id)
	. = ..()
	if(new_dir)
		setDir(new_dir)
	if(new_id)
		id = new_id
	update_move_direction()
	LAZYADD(GLOB.conveyors_by_id[id], src)

/obj/machinery/conveyor/Destroy()
	LAZYREMOVE(GLOB.conveyors_by_id[id], src)
	return ..()

/obj/machinery/conveyor/vv_edit_var(var_name, var_value)
	if (var_name == NAMEOF(src, id))
		// if "id" is varedited, update our list membership
		LAZYREMOVE(GLOB.conveyors_by_id[id], src)
		. = ..()
		LAZYADD(GLOB.conveyors_by_id[id], src)
	else
		return ..()

/obj/machinery/conveyor/setDir(newdir)
	. = ..()
	update_move_direction()

/**
 * Proc to handle updating the directions in which the conveyor belt is moving items.
 */
/obj/machinery/conveyor/proc/update_move_direction()
	switch(dir)
		if(NORTH)
			forwards = NORTH
			backwards = SOUTH
		if(SOUTH)
			forwards = SOUTH
			backwards = NORTH
		if(EAST)
			forwards = EAST
			backwards = WEST
		if(WEST)
			forwards = WEST
			backwards = EAST
		if(NORTHEAST)
			forwards = EAST
			backwards = SOUTH
		if(NORTHWEST)
			forwards = NORTH
			backwards = EAST
		if(SOUTHEAST)
			forwards = SOUTH
			backwards = WEST
		if(SOUTHWEST)
			forwards = WEST
			backwards = NORTH

	if(inverted)
		var/temp = forwards
		forwards = backwards
		backwards = temp
	// We need to do this this way to ensure good functionality on corner belts.
	// Basically, this allows the conveyor belts that used a flipped belt sprite to
	// still convey items in the direction of their arrows. It's different from inverted,
	// which makes them go backwards so they need to be ran separately, so a flipped conveyor
	// can also be reversed.
	if(flipped)
		var/temp = forwards
		forwards = backwards
		backwards = temp
	if(operating == CONVEYOR_FORWARD)
		movedir = forwards
	else
		movedir = backwards
	update()

/obj/machinery/conveyor/update_icon_state()
	icon_state = "[base_icon_state][inverted ? -operating : operating ][flipped ? "-flipped" : ""]"
	return ..()

/**
 * Proc to update the conveyor depending on if it's got power or not.
 *
 * Returns TRUE if it is still able to be operating after the update, FALSE if not.
 */
/obj/machinery/conveyor/proc/update()
	. = TRUE
	if(machine_stat & NOPOWER)
		operating = FALSE
		. = FALSE
	update_appearance()

// machine process
// move items to the target location
/obj/machinery/conveyor/process()
	if(machine_stat & NOPOWER)
		return

	// If the conveyor is off or already moving items.
	if(!operating || conveying)
		return

	use_power(6)

	// Get the first 30 items in contents.
	var/turf/loc_turf = loc
	var/list/items = loc_turf.contents - src
	if(!LAZYLEN(items)) // Don't do anything at all if theres nothing there but the conveyor.
		return

	var/list/affecting
	if(length(items) > MAX_CONVEYOR_ITEMS_MOVE)
		affecting = items.Copy(1, MAX_CONVEYOR_ITEMS_MOVE + 1) // Lists start at 1 lol.
	else
		affecting = items

	conveying = TRUE

	addtimer(CALLBACK(src, .proc/convey, affecting), 1) // Movement effect.

/**
 * Proc to handle moving items along the conveyor belt.
 */
/obj/machinery/conveyor/proc/convey(list/affecting)
	for(var/thing in affecting)
		if(!ismovable(thing)) // This is like a third faster than for(var/atom/movable in affecting)
			continue
		var/atom/movable/movable_thing = thing
		// Give this a chance to yield if the server is busy
		stoplag()

		if(QDELETED(movable_thing) || (movable_thing.loc != loc))
			continue

		if(iseffect(movable_thing) || isdead(movable_thing))
			continue

		if(isliving(movable_thing))
			var/mob/living/zoom_mob = movable_thing
			if((zoom_mob.movement_type & FLYING) && !zoom_mob.stat)
				continue

		if(!movable_thing.anchored && movable_thing.has_gravity())
			step(movable_thing, movedir)

	conveying = FALSE

/obj/machinery/conveyor/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.tool_behaviour == TOOL_CROWBAR)
		user.visible_message(span_notice("[user] struggles to pry up [src] with [attacking_item]."), \
		span_notice("You struggle to pry up [src] with [attacking_item]."))

		if(!attacking_item.use_tool(src, user, 4 SECONDS, volume = 40))
			return

		var/obj/item/stack/conveyor/belt_item = new /obj/item/stack/conveyor(loc, 1, TRUE, null, null, id)
		transfer_fingerprints_to(belt_item)

		to_chat(user, span_notice("You remove [src]."))
		qdel(src)

	else if(attacking_item.tool_behaviour == TOOL_WRENCH)
		attacking_item.play_tool_sound(src)
		setDir(turn(dir, -45))
		to_chat(user, span_notice("You rotate [src]."))

	else if(attacking_item.tool_behaviour == TOOL_SCREWDRIVER)
		attacking_item.play_tool_sound(src)
		inverted = !inverted
		update_move_direction()
		to_chat(user, span_notice("You set [src]'s direction [inverted ? "backwards" : "back to default"]."))

	else if(!user.combat_mode)
		user.transferItemToLoc(attacking_item, drop_location())
	else
		return ..()

/obj/machinery/conveyor/attackby_secondary(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.tool_behaviour == TOOL_SCREWDRIVER)
		attacking_item.play_tool_sound(src)
		flipped = !flipped
		update_move_direction()
		to_chat(user, span_notice("You flip [src]'s belt [flipped ? "around" : "back to normal"]."))

	else if(!user.combat_mode)
		user.transferItemToLoc(attacking_item, drop_location())
	else
		return ..()

// attack with hand, move pulled object onto conveyor
/obj/machinery/conveyor/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	user.Move_Pulled(src)

/obj/machinery/conveyor/power_change()
	. = ..()
	update()


// Conveyor switch
/obj/machinery/conveyor_switch
	name = "conveyor switch"
	desc = "A conveyor control switch."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "switch-off"
	base_icon_state = "switch"
	processing_flags = START_PROCESSING_MANUALLY

	/// The current state of the switch.
	var/position = CONVEYOR_OFF
	/// Last direction setting.
	var/last_pos = CONVEYOR_BACKWARDS
	/// If the switch only operates the conveyor belts in a single direction.
	var/oneway = FALSE
	/// If the level points the opposite direction when it's turned on.
	var/invert_icon = FALSE
	/// The ID of the switch, must match conveyor IDs to control them.
	var/id = ""

/obj/machinery/conveyor_switch/Initialize(mapload, newid)
	. = ..()
	if (newid)
		id = newid

	update_appearance()
	LAZYADD(GLOB.conveyors_by_id[id], src)
	wires = new /datum/wires/conveyor(src)
	AddComponent(/datum/component/usb_port, list(
		/obj/item/circuit_component/conveyor_switch,
	))

/obj/machinery/conveyor_switch/Destroy()
	LAZYREMOVE(GLOB.conveyors_by_id[id], src)
	QDEL_NULL(wires)
	. = ..()

/obj/machinery/conveyor_switch/vv_edit_var(var_name, var_value)
	if (var_name == NAMEOF(src, id))
		// if "id" is varedited, update our list membership
		LAZYREMOVE(GLOB.conveyors_by_id[id], src)
		. = ..()
		LAZYADD(GLOB.conveyors_by_id[id], src)

	else
		return ..()

// update the icon depending on the position
/obj/machinery/conveyor_switch/update_icon_state()
	icon_state = "[base_icon_state]-off"
	if(position < CONVEYOR_OFF)
		icon_state = "[base_icon_state]-[invert_icon ? "fwd" : "rev"]"
	else if(position > CONVEYOR_OFF)
		icon_state = "[base_icon_state]-[invert_icon ? "rev" : "fwd"]"
	return ..()

/// Updates all conveyor belts that are linked to this switch, and tells them to start processing.
/obj/machinery/conveyor_switch/proc/update_linked_conveyors()
	for(var/obj/machinery/conveyor/belt in GLOB.conveyors_by_id[id])
		belt.operating = position
		belt.update_move_direction()
		belt.update_appearance()
		if(belt.operating)
			belt.begin_processing()
		else
			belt.end_processing()
		CHECK_TICK

/// Finds any switches with same `id` as this one, and set their position and icon to match us.
/obj/machinery/conveyor_switch/proc/update_linked_switches()
	for(var/obj/machinery/conveyor_switch/belt_switch in GLOB.conveyors_by_id[id])
		belt_switch.invert_icon = invert_icon
		belt_switch.position = position
		belt_switch.update_appearance()
		CHECK_TICK

/// Updates the switch's `position` and `last_pos` variable. Useful so that the switch can properly cycle between the forwards, backwards and neutral positions.
/obj/machinery/conveyor_switch/proc/update_position()
	if(position == CONVEYOR_OFF)
		if(oneway)   //is it a oneway switch
			position = oneway
		else
			if(last_pos < CONVEYOR_OFF)
				position = CONVEYOR_FORWARD
				last_pos = CONVEYOR_OFF
			else
				position = CONVEYOR_BACKWARDS
				last_pos = CONVEYOR_OFF
	else
		last_pos = position
		position = CONVEYOR_OFF

/// Called when a user clicks on this switch with an open hand.
/obj/machinery/conveyor_switch/interact(mob/user)
	add_fingerprint(user)
	update_position()
	update_appearance()
	update_linked_conveyors()
	update_linked_switches()


/obj/machinery/conveyor_switch/attackby(obj/item/attacking_item, mob/user, params)
	if(is_wire_tool(attacking_item))
		wires.interact(user)
		return TRUE

/obj/machinery/conveyor_switch/crowbar_act(mob/user, obj/item/tool)
	tool.play_tool_sound(src, 50)
	var/obj/item/conveyor_switch_construct/switch_construct = new/obj/item/conveyor_switch_construct(src.loc)
	switch_construct.id = id
	transfer_fingerprints_to(switch_construct)
	to_chat(user, span_notice("You detach [src]."))
	qdel(src)
	return TRUE

/obj/machinery/conveyor_switch/screwdriver_act(mob/user, obj/item/tool)
	tool.play_tool_sound(src, 50)
	oneway = !oneway
	to_chat(user, span_notice("You set [src] to [oneway ? "one way" : "default"] configuration."))
	return TRUE

/obj/machinery/conveyor_switch/wrench_act(mob/user, obj/item/tool)
	tool.play_tool_sound(src, 50)
	invert_icon = !invert_icon
	update_appearance()
	to_chat(user, span_notice("You set [src] to [invert_icon ? "inverted": "normal"] position."))
	return TRUE

/obj/machinery/conveyor_switch/examine(mob/user)
	. = ..()
	. += span_notice("[src] is set to [oneway ? "one way" : "default"] configuration. It can be changed with a <b>screwdriver</b>.")
	. += span_notice("[src] is set to [invert_icon ? "inverted": "normal"] position. It can be rotated with a <b>wrench</b>.")

/obj/machinery/conveyor_switch/oneway
	icon_state = "conveyor_switch_oneway"
	desc = "A conveyor control switch. It appears to only go in one direction."
	oneway = TRUE

/obj/machinery/conveyor_switch/oneway/Initialize(mapload)
	. = ..()
	if((dir == NORTH) || (dir == WEST))
		invert_icon = TRUE

/obj/item/conveyor_switch_construct
	name = "conveyor switch assembly"
	desc = "A conveyor control switch assembly."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "switch-off"
	w_class = WEIGHT_CLASS_BULKY
	// ID of the switch-in-the-making, to link conveyor belts to it.
	var/id = ""

/obj/item/conveyor_switch_construct/Initialize(mapload)
	. = ..()
	id = "[rand()]" //this couldn't possibly go wrong

/obj/item/conveyor_switch_construct/attack_self(mob/user)
	for(var/obj/item/stack/conveyor/belt in view())
		belt.id = id
	to_chat(user, span_notice("You have linked all nearby conveyor belt assemblies to this switch."))

/obj/item/conveyor_switch_construct/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || user.stat || !isfloorturf(target) || istype(target, /area/shuttle))
		return

	var/found = FALSE
	for(var/obj/machinery/conveyor/belt in view())
		if(belt.id == src.id)
			found = TRUE
			break
	if(!found)
		to_chat(user, "[icon2html(src, user)]" + span_notice("The conveyor switch did not detect any linked conveyor belts in range."))
		return
	var/obj/machinery/conveyor_switch/built_switch = new/obj/machinery/conveyor_switch(target, id)
	transfer_fingerprints_to(built_switch)
	qdel(src)

/obj/item/stack/conveyor
	name = "conveyor belt assembly"
	desc = "A conveyor belt assembly."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "conveyor_construct"
	max_amount = 30
	singular_name = "conveyor belt"
	w_class = WEIGHT_CLASS_BULKY
	merge_type = /obj/item/stack/conveyor
	/// ID for linking a belt to one or more switches, all conveyors with the same ID will be controlled the same switch(es).
	var/id = ""

/obj/item/stack/conveyor/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1, _id)
	. = ..()
	id = _id

/obj/item/stack/conveyor/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || user.stat || !isfloorturf(target) || istype(target, /area/shuttle))
		return
	var/belt_dir = get_dir(target, user)
	if(target == user.loc)
		to_chat(user, span_warning("You cannot place a conveyor belt under yourself!"))
		return
	var/obj/machinery/conveyor/belt = new/obj/machinery/conveyor(target, belt_dir, id)
	transfer_fingerprints_to(belt)
	use(1)

/obj/item/stack/conveyor/attackby(obj/item/item_used, mob/user, params)
	..()
	if(istype(item_used, /obj/item/conveyor_switch_construct))
		to_chat(user, span_notice("You link the switch to the conveyor belt assembly."))
		var/obj/item/conveyor_switch_construct/switch_construct = item_used
		id = switch_construct.id

/obj/item/stack/conveyor/update_weight()
	return FALSE

/obj/item/stack/conveyor/thirty
	amount = 30

/obj/item/paper/guides/conveyor
	name = "paper- 'Nano-it-up U-build series, #9: Build your very own conveyor belt, in SPACE'"
	info = "<h1>Congratulations!</h1><p>You are now the proud owner of the best conveyor set available for \
		space mail order! We at Nano-it-up know you love to prepare your own structures without wasting time, \
		so we have devised a special streamlined assembly procedure that puts all other mail-order products to \
		shame!</p><p>Firstly, you need to link the conveyor switch assembly to each of the conveyor belt \
		assemblies. After doing so, you simply need to install the belt assemblies onto the floor, et voila, \
		belt built. Our special Nano-it-up smart switch will detected any linked assemblies as far as the eye \
		can see! This convenience, you can only have it when you Nano-it-up. Stay nano!</p>"

#undef MAX_CONVEYOR_ITEMS_MOVE

/obj/item/circuit_component/conveyor_switch
	display_name = "Conveyor Switch"
	desc = "Allows to control connected conveyor belts."
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL

	/// The current direction of the conveyor attached to the component.
	var/datum/port/output/direction
	/// The switch this conveyor switch component is attached to.
	var/obj/machinery/conveyor_switch/attached_switch

/obj/item/circuit_component/conveyor_switch/populate_ports()
	direction = add_output_port("Conveyor Direction", PORT_TYPE_NUMBER)

/obj/item/circuit_component/conveyor_switch/get_ui_notices()
	. = ..()
	. += create_ui_notice("Conveyor direction 0 means that it is stopped, 1 means that it is active and -1 means that it is working in reverse mode", "orange", "info")

/obj/item/circuit_component/conveyor_switch/register_usb_parent(atom/movable/shell)
	. = ..()
	if(istype(shell, /obj/machinery/conveyor_switch))
		attached_switch = shell

/obj/item/circuit_component/conveyor_switch/unregister_usb_parent(atom/movable/shell)
	attached_switch = null
	return ..()

/obj/item/circuit_component/conveyor_switch/input_received(datum/port/input/port)
	if(!attached_switch)
		return

	INVOKE_ASYNC(src, .proc/update_conveyers, port)

/obj/item/circuit_component/conveyor_switch/proc/update_conveyers(datum/port/input/port)
	if(!attached_switch)
		return

	attached_switch.update_position()
	attached_switch.update_appearance()
	attached_switch.update_linked_conveyors()
	attached_switch.update_linked_switches()
	direction.set_output(attached_switch.position)

#undef CONVEYOR_BACKWARDS
#undef CONVEYOR_OFF
#undef CONVEYOR_FORWARD
