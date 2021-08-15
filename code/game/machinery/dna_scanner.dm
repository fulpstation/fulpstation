/obj/machinery/dna_scannernew
	name = "\improper DNA scanner"
	desc = "It scans DNA structures."
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "scanner"
	base_icon_state = "scanner"
	density = TRUE
	obj_flags = NO_BUILD // Becomes undense when the door is open
	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 300
	occupant_typecache = list(/mob/living, /obj/item/bodypart/head, /obj/item/organ/brain)
	circuit = /obj/item/circuitboard/machine/dnascanner
	var/locked = FALSE
	var/damage_coeff
	var/scan_level
	var/precision_coeff
	var/message_cooldown
	var/breakout_time = 1200
	var/obj/machinery/computer/scan_consolenew/linked_console = null

/obj/machinery/dna_scannernew/RefreshParts()
	scan_level = 0
	damage_coeff = 0
	precision_coeff = 0
	for(var/obj/item/stock_parts/scanning_module/P in component_parts)
		scan_level += P.rating
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		precision_coeff = M.rating
	for(var/obj/item/stock_parts/micro_laser/P in component_parts)
		damage_coeff = P.rating

/obj/machinery/dna_scannernew/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Radiation pulse accuracy increased by factor <b>[precision_coeff**2]</b>.<br>Radiation pulse damage decreased by factor <b>[damage_coeff**2]</b>.")

/obj/machinery/dna_scannernew/update_icon_state()
	//no power or maintenance
	if(machine_stat & (NOPOWER|BROKEN))
		icon_state = "[base_icon_state][state_open ? "_open" : null]_unpowered"
		return ..()

	if((machine_stat & MAINT) || panel_open)
		icon_state = "[base_icon_state][state_open ? "_open" : null]_maintenance"
		return ..()

	//running and someone in there
	if(occupant)
		icon_state = "[base_icon_state]_occupied"
		return ..()

	//running
	icon_state = "[base_icon_state][state_open ? "_open" : null]"
	return ..()

/obj/machinery/dna_scannernew/proc/toggle_open(mob/user)
	if(panel_open)
		to_chat(user, span_notice("Close the maintenance panel first."))
		return

	if(state_open)
		close_machine()
		return

	else if(locked)
		to_chat(user, span_notice("The bolts are locked down, securing the door shut."))
		return

	open_machine()

/obj/machinery/dna_scannernew/container_resist_act(mob/living/user)
	if(!locked)
		open_machine()
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("You see [user] kicking against the door of [src]!"), \
		span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(breakout_time)].)"), \
		span_hear("You hear a metallic creaking from [src]."))
	if(do_after(user,(breakout_time), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src || state_open || !locked)
			return
		locked = FALSE
		user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
			span_notice("You successfully break out of [src]!"))
		open_machine()

/obj/machinery/dna_scannernew/proc/locate_computer(type_)
	for(var/direction in GLOB.cardinals)
		var/C = locate(type_, get_step(src, direction))
		if(C)
			return C
	return null

/obj/machinery/dna_scannernew/close_machine(mob/living/carbon/user)
	if(!state_open)
		return FALSE

	..(user)

	// DNA manipulators cannot operate on severed heads or brains
	if(iscarbon(occupant))
		if(linked_console)
			linked_console.on_scanner_close()

	return TRUE

/obj/machinery/dna_scannernew/open_machine()
	if(state_open)
		return FALSE

	..()

	if(linked_console)
		linked_console.on_scanner_open()

	return TRUE

/obj/machinery/dna_scannernew/relaymove(mob/living/user, direction)
	if(user.stat || locked)
		if(message_cooldown <= world.time)
			message_cooldown = world.time + 50
			to_chat(user, span_warning("[src]'s door won't budge!"))
		return
	open_machine()

/obj/machinery/dna_scannernew/attackby(obj/item/I, mob/user, params)

	if(!occupant && default_deconstruction_screwdriver(user, icon_state, icon_state, I))//sent icon_state is irrelevant...
		update_appearance()//..since we're updating the icon here, since the scanner can be unpowered when opened/closed
		return

	if(default_pry_open(I))
		return

	if(default_deconstruction_crowbar(I))
		return

	return ..()

/obj/machinery/dna_scannernew/interact(mob/user)
	toggle_open(user)

/obj/machinery/dna_scannernew/MouseDrop_T(mob/target, mob/user)
	if(user.stat != CONSCIOUS || HAS_TRAIT(user, TRAIT_UI_BLOCKED) || !Adjacent(user) || !user.Adjacent(target) || !iscarbon(target) || !ISADVANCEDTOOLUSER(user))
		return
	close_machine(target)

//This is only called by the scanner. if you ever want to use this outside of that context you'll need to refactor things a bit
/obj/machinery/dna_scannernew/proc/set_linked_console(new_console)
	if(linked_console)
		UnregisterSignal(linked_console, COMSIG_PARENT_QDELETING)
	linked_console = new_console
	if(linked_console)
		RegisterSignal(linked_console, COMSIG_PARENT_QDELETING, .proc/react_to_console_del)

/obj/machinery/dna_scannernew/proc/react_to_console_del(datum/source)
	SIGNAL_HANDLER
	set_linked_console(null)


//Just for transferring between genetics machines.
/obj/item/disk/data
	name = "DNA data disk"
	icon_state = "datadisk0" //Gosh I hope syndies don't mistake them for the nuke disk.
	var/list/genetic_makeup_buffer = list()
	var/list/mutations = list()
	var/max_mutations = 6
	var/read_only = FALSE //Well,it's still a floppy disk

/obj/item/disk/data/Initialize()
	. = ..()
	icon_state = "datadisk[rand(0,6)]"
	add_overlay("datadisk_gene")

/obj/item/disk/data/attack_self(mob/user)
	read_only = !read_only
	to_chat(user, span_notice("You flip the write-protect tab to [read_only ? "protected" : "unprotected"]."))

/obj/item/disk/data/examine(mob/user)
	. = ..()
	. += "The write-protect tab is set to [read_only ? "protected" : "unprotected"]."
