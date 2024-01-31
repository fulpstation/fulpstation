/obj/machinery/public_nanite_chamber
	name = "public nanite chamber"
	desc = "A device that can rapidly implant cloud-synced nanites without an external operator."
	circuit = /obj/item/circuitboard/machine/public_nanite_chamber
	icon = 'fulp_modules/features/nanites/icons/nanite_chamber.dmi'
	icon_state = "nanite_chamber"
	layer = ABOVE_WINDOW_LAYER
	use_power = IDLE_POWER_USE
	anchored = TRUE
	density = TRUE
	idle_power_usage = 50
	active_power_usage = 300

	var/cloud_id = 1
	var/locked = FALSE
	var/breakout_time = 1200
	var/busy = FALSE
	var/busy_icon_state
	var/message_cooldown = 0
	var/datum/techweb/linked_techweb

/obj/machinery/public_nanite_chamber/Initialize()
	. = ..()
	occupant_typecache = GLOB.typecache_living

/obj/machinery/public_nanite_chamber/Destroy()
	linked_techweb = null
	. = ..()

/obj/machinery/public_nanite_chamber/LateInitialize()
	. = ..()
	if(!CONFIG_GET(flag/no_default_techweb_link) && !linked_techweb)
		CONNECT_TO_RND_SERVER_ROUNDSTART(linked_techweb, src)

/obj/machinery/public_nanite_chamber/RefreshParts()
	. = ..()
	var/obj/item/circuitboard/machine/public_nanite_chamber/board = circuit
	if(board)
		cloud_id = board.cloud_id

/obj/machinery/public_nanite_chamber/proc/set_busy(status, working_icon)
	busy = status
	busy_icon_state = working_icon
	update_icon()

/obj/machinery/public_nanite_chamber/proc/inject_nanites(mob/living/attacker)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if((machine_stat & MAINT) || panel_open)
		return
	if(!occupant || busy)
		return

	var/locked_state = locked
	locked = TRUE

	//TODO OMINOUS MACHINE SOUNDS
	set_busy(TRUE, "[initial(icon_state)]_raising")
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "[initial(icon_state)]_active"),20)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "[initial(icon_state)]_falling"),60)
	addtimer(CALLBACK(src, PROC_REF(complete_injection), locked_state, attacker),80)

/obj/machinery/public_nanite_chamber/proc/complete_injection(locked_state, mob/living/attacker)
	//TODO MACHINE DING
	locked = locked_state
	set_busy(FALSE)
	if(!occupant)
		return
	if(attacker)
		log_game("[occupant] was injected with nanites by [key_name(attacker)] using [src] at [AREACOORD(src)].")
		log_combat(attacker, occupant, "injected", null, "with nanites via [src]")
	occupant.AddComponent(/datum/component/nanites, linked_techweb, 75, cloud_id)

/obj/machinery/public_nanite_chamber/proc/change_cloud(mob/living/attacker)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if((machine_stat & MAINT) || panel_open)
		return
	if(!occupant || busy)
		return

	var/locked_state = locked
	locked = TRUE

	set_busy(TRUE, "[initial(icon_state)]_raising")
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "[initial(icon_state)]_active"),20)
	addtimer(CALLBACK(src, PROC_REF(set_busy), TRUE, "[initial(icon_state)]_falling"),40)
	addtimer(CALLBACK(src, PROC_REF(complete_cloud_change), locked_state, attacker),60)

/obj/machinery/public_nanite_chamber/proc/complete_cloud_change(locked_state, mob/living/attacker)
	locked = locked_state
	set_busy(FALSE)
	if(!occupant)
		return
	if(attacker)
		occupant.investigate_log("had their nanite cloud ID changed into [cloud_id] by [key_name(attacker)] using [src] at [AREACOORD(src)].")
	SEND_SIGNAL(occupant, COMSIG_NANITE_SET_CLOUD, cloud_id)

/obj/machinery/public_nanite_chamber/update_icon_state()
	. = ..()
	//running and someone in there
	if(occupant)
		if(busy)
			icon_state = busy_icon_state
		else
			icon_state = initial(icon_state) + "_occupied"
	else
		//running
		icon_state = initial(icon_state) + (state_open ? "_open" : "")

/obj/machinery/public_nanite_chamber/update_overlays()
	. = ..()
	if((machine_stat & MAINT) || panel_open)
		. += "maint"

	else if(!(machine_stat & (NOPOWER|BROKEN)))
		if(busy || locked)
			. += "red"
			if(locked)
				. += "bolted"
		else
			. += "green"

/obj/machinery/public_nanite_chamber/proc/toggle_open(mob/user)
	if(panel_open)
		to_chat(user, span_notice("Close the maintenance panel first."))
		return

	if(state_open)
		close_machine(null, user)
		return

	else if(locked)
		to_chat(user, span_notice("The bolts are locked down, securing the door shut."))
		return

	open_machine()

/obj/machinery/public_nanite_chamber/container_resist_act(mob/living/user)
	if(!locked)
		open_machine()
		return
	if(busy)
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(
		span_notice("You see [user] kicking against the door of [src]!"),
		span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(breakout_time)].)"),
		span_hear("You hear a metallic creaking from [src]."),
	)
	if(do_after(user,(breakout_time), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src || state_open || !locked || busy)
			return
		locked = FALSE
		user.visible_message(
			span_warning("[user] successfully broke out of [src]!"),
			span_notice("You successfully break out of [src]!"),
		)
		open_machine()

/obj/machinery/public_nanite_chamber/open_machine(drop = TRUE, density_to_set = FALSE)
	if(state_open)
		return FALSE
	return ..()

/obj/machinery/public_nanite_chamber/close_machine(atom/movable/target, density_to_set = TRUE)
	if(!state_open)
		return FALSE
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(try_inject_nanites), target), 30) //If someone is shoved in give them a chance to get out before the injection starts

/obj/machinery/public_nanite_chamber/proc/try_inject_nanites(mob/living/target)
	if(occupant)
		var/mob/living/L = occupant
		var/datum/component/nanites/nanites = L.GetComponent(/datum/component/nanites)
		if(nanites && nanites.cloud_id != cloud_id)
			change_cloud(target)
			return
		if(L.mob_biotypes & (MOB_ORGANIC | MOB_UNDEAD))
			inject_nanites(target)

/obj/machinery/public_nanite_chamber/relaymove(mob/living/user, direction)
	if(user.stat || locked)
		if(message_cooldown <= world.time)
			message_cooldown = world.time + 50
			to_chat(user, span_warning("[src]'s door won't budge!"))
		return
	open_machine()

/obj/machinery/public_nanite_chamber/nanite_cloud_controller/multitool_act(mob/living/user, obj/item/multitool/tool)
	if(!QDELETED(tool.buffer) && istype(tool.buffer, /datum/techweb))
		linked_techweb = tool.buffer
	return TRUE

/obj/machinery/public_nanite_chamber/screwdriver_act(mob/living/user, obj/item/tool)
	if(!occupant && default_deconstruction_screwdriver(user, icon_state, icon_state, tool))
		update_appearance()
		return TOOL_ACT_TOOLTYPE_SUCCESS
	return ..()

/obj/machinery/public_nanite_chamber/crowbar_act(mob/living/user, obj/item/tool)
	if(default_pry_open(tool) || default_deconstruction_crowbar(tool))
		return TOOL_ACT_TOOLTYPE_SUCCESS
	return ..()


/obj/machinery/public_nanite_chamber/interact(mob/user)
	toggle_open(user)

/obj/machinery/public_nanite_chamber/MouseDrop_T(mob/target, mob/user)
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH) || !Adjacent(target) || !user.Adjacent(target))
		return
	if(close_machine(target, user))
		log_combat(user, target, "inserted", null, "into [src].")
	add_fingerprint(user)
