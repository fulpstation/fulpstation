/obj/machinery/nanite_program_hub
	name = "nanite program hub"
	desc = "Compiles nanite programs from the techweb servers and downloads them into disks."
	icon = 'fulp_modules/features/nanites/icons/research.dmi'
	icon_state = "nanite_program_hub"
	use_power = IDLE_POWER_USE
	anchored = TRUE
	density = TRUE
	circuit = /obj/item/circuitboard/machine/nanite_program_hub

	var/obj/item/disk/nanite_program/disk
	var/datum/techweb/linked_techweb
	var/current_category = "Main"
	var/detail_view = TRUE
	var/categories = list(
		list(name = NANITE_CATEGORY_UTILITIES),
		list(name = NANITE_CATEGORY_MEDICAL),
		list(name = NANITES_CATEGORY_SENSOR),
		list(name = NANITES_CATEGORY_AUGMENTATION),
		list(name = NANITES_CATEGORY_SUPPRESSION),
		list(name = NANITES_CATEGORY_WEAPONIZED),
		list(name = NANITES_CATEGORY_PROTOCOLS),
	)
	///List of all unlocked nanite designs.
	var/list/datum/design/nanites/cached_designs = list()

/obj/machinery/nanite_program_hub/Destroy()
	linked_techweb = null
	. = ..()

/obj/machinery/nanite_program_hub/LateInitialize()
	. = ..()
	if(!CONFIG_GET(flag/no_default_techweb_link) && !linked_techweb)
		CONNECT_TO_RND_SERVER_ROUNDSTART(linked_techweb, src)
	if(linked_techweb)
		on_connected_techweb()

/obj/machinery/nanite_program_hub/proc/connect_techweb(datum/techweb/new_techweb)
	if(linked_techweb)
		UnregisterSignal(linked_techweb, list(COMSIG_TECHWEB_ADD_DESIGN))
	linked_techweb = new_techweb
	if(!isnull(linked_techweb))
		on_connected_techweb()

/obj/machinery/nanite_program_hub/proc/on_connected_techweb()
	for (var/researched_design_id in linked_techweb.researched_designs)
		var/datum/design/nanites/design = SSresearch.techweb_design_by_id(researched_design_id)
		if (!ispath(design))
			continue

		cached_designs[design.program_type] = design.id

	RegisterSignal(linked_techweb, COMSIG_TECHWEB_ADD_DESIGN, PROC_REF(on_research))

/obj/machinery/nanite_program_hub/proc/on_research(datum/source, datum/design/nanites/added_design, custom)
	SIGNAL_HANDLER
	// We're probably going to get more than one update (design) at a time, so batch
	// them together.
	addtimer(CALLBACK(src, PROC_REF(update_menu_tech)), 2 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

/**
 * Updates the `final_sets` and `buildable_parts` for the current mecha fabricator.
 */
/obj/machinery/nanite_program_hub/proc/update_menu_tech()
	var/previous_design_count = cached_designs.len

	cached_designs.Cut()
	for(var/v in linked_techweb.researched_designs)
		var/datum/design/nanites/design = SSresearch.techweb_design_by_id(v)

		if(istype(design))
			cached_designs |= design

	var/design_delta = cached_designs.len - previous_design_count

	if(design_delta > 0)
		say("Received [design_delta] new design[design_delta == 1 ? "" : "s"].")
		playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)

	update_static_data_for_all_viewers()

/obj/machinery/nanite_program_hub/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/disk/nanite_program))
		if(user.transferItemToLoc(weapon, src))
			if(disk)
				balloon_alert(user, "disk swapped")
				eject(user)
			else
				balloon_alert(user, "disk inserted")
			playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
			disk = weapon
		return
	return ..()

/obj/machinery/nanite_program_hub/multitool_act(mob/living/user, obj/item/multitool/tool)
	if(!QDELETED(tool.buffer) && istype(tool.buffer, /datum/techweb))
		connect_techweb(tool.buffer)
	return TRUE

/obj/machinery/nanite_program_hub/proc/eject(mob/living/user)
	if(!disk)
		return
	if(!istype(user) || !Adjacent(user) || !user.put_in_active_hand(disk))
		disk.forceMove(drop_location())
	disk = null

/obj/machinery/nanite_program_hub/attack_hand_secondary(mob/user, list/modifiers)
	if(disk && user.can_perform_action(src, ALLOW_SILICON_REACH))
		balloon_alert(user, "disk ejected")
		eject(user)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	return ..()

/obj/machinery/nanite_program_hub/ui_interact(mob/user, datum/tgui/ui)
	if(!linked_techweb)
		visible_message("Warning: no linked server!")
		SStgui.close_uis(src)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NaniteProgramHub", name)
		ui.open()

/obj/machinery/nanite_program_hub/ui_data()
	var/list/data = list()
	if(disk)
		data["has_disk"] = TRUE
		var/list/disk_data = list()
		var/datum/nanite_program/P = disk.program
		if(P)
			data["has_program"] = TRUE
			disk_data["name"] = P.name
			disk_data["desc"] = P.desc
		data["disk"] = disk_data
	else
		data["has_disk"] = FALSE

	data["detail_view"] = detail_view

	return data

/obj/machinery/nanite_program_hub/ui_static_data(mob/user)
	var/list/data = list()
	data["programs"] = list()
	data["categories"] = list()
	for(var/i in linked_techweb.researched_designs)
		var/datum/design/nanites/D = SSresearch.techweb_design_by_id(i)
		if(!istype(D))
			continue
		var/cat_name = D.category[1] //just put them in the first category fuck it
		if(!(cat_name in data["categories"]))
			data["categories"] += cat_name
		if(isnull(data["programs"][cat_name]))
			data["programs"][cat_name] = list()
		var/list/program_design = list()
		program_design["id"] = D.id
		program_design["name"] = D.name
		program_design["desc"] = D.desc
		data["programs"][cat_name] += list(program_design)

	if(!length(data["programs"]))
		data["programs"] = null

	return data

/obj/machinery/nanite_program_hub/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("eject")
			eject(usr)
			return TRUE
		if("download")
			if(!disk)
				return
			var/datum/design/nanites/downloaded = linked_techweb.isDesignResearchedID(params["program_id"]) //check if it's a valid design
			if(!istype(downloaded))
				return
			if(disk.program)
				qdel(disk.program)
			disk.program = new downloaded.program_type
			disk.name = "[initial(disk.name)] \[[disk.program.name]\]"
			playsound(src, 'sound/machines/terminal_prompt.ogg', 25, FALSE)
			return TRUE
		if("refresh")
			update_static_data(usr)
			return TRUE
		if("toggle_details")
			detail_view = !detail_view
			return TRUE
		if("clear")
			if(disk && disk.program)
				qdel(disk.program)
				disk.program = null
				disk.name = initial(disk.name)
				playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 25, FALSE)
			return TRUE
