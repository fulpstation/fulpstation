
/obj
	animate_movement = SLIDE_STEPS
	speech_span = SPAN_ROBOT
	var/obj_flags = CAN_BE_HIT

	/// Extra examine line to describe controls, such as right-clicking, left-clicking, etc.
	var/desc_controls

	/// Icon to use as a 32x32 preview in crafting menus and such
	var/icon_preview
	var/icon_state_preview

	var/damtype = BRUTE
	var/force = 0

	/// How good a given object is at causing wounds on carbons. Higher values equal better shots at creating serious wounds.
	var/wound_bonus = 0
	/// If this attacks a human with no wound armor on the affected body part, add this to the wound mod. Some attacks may be significantly worse at wounding if there's even a slight layer of armor to absorb some of it vs bare flesh
	var/bare_wound_bonus = 0

	/// A multiplier to an objecet's force when used against a stucture, vechicle, machine, or robot.
	var/demolition_mod = 1

	var/current_skin //Has the item been reskinned?
	var/list/unique_reskin //List of options to reskin.
	///If set to true, we can reskin this item as much as we want.
	var/infinite_reskin = FALSE

	// Access levels, used in modules\jobs\access.dm
	/// List of accesses needed to use this object: The user must possess all accesses in this list in order to use the object.
	/// Example: If req_access = list(ACCESS_ENGINE, ACCESS_CE)- then the user must have both ACCESS_ENGINE and ACCESS_CE in order to use the object.
	var/list/req_access
	/// List of accesses needed to use this object: The user must possess at least one access in this list in order to use the object.
	/// Example: If req_one_access = list(ACCESS_ENGINE, ACCESS_CE)- then the user must have either ACCESS_ENGINE or ACCESS_CE in order to use the object.
	var/list/req_one_access

	/// Custom fire overlay icon
	var/custom_fire_overlay

	var/renamedByPlayer = FALSE //set when a player uses a pen on a renamable object

	var/drag_slowdown // Amont of multiplicative slowdown applied if pulled. >1 makes you slower, <1 makes you faster.

	/// Map tag for something.  Tired of it being used on snowflake items.  Moved here for some semblance of a standard.
	/// Next pr after the network fix will have me refactor door interactions, so help me god.
	var/id_tag = null
	/// Network id. If set it can be found by either its hardware id or by the id tag if thats set.  It can also be
	/// broadcasted to as long as the other guys network is on the same branch or above.
	var/network_id = null

	uses_integrity = TRUE

/obj/vv_edit_var(vname, vval)
	if(vname == NAMEOF(src, obj_flags))
		if ((obj_flags & DANGEROUS_POSSESSION) && !(vval & DANGEROUS_POSSESSION))
			return FALSE
	return ..()

// Call this if you want to add your object to a network
/obj/proc/init_network_id(network_id)
	var/area/A = get_area(src)
	if(A)
		if(!A.network_root_id)
			log_telecomms("Area '[A.name]([REF(A)])' has no network network_root_id, force assigning in object [src]([REF(src)])")
			SSnetworks.lookup_area_root_id(A)
		network_id = NETWORK_NAME_COMBINE(A.network_root_id, network_id) // I regret nothing!!
	else
		log_telecomms("Created [src]([REF(src)] in nullspace, assuming network to be in station")
		network_id = NETWORK_NAME_COMBINE(STATION_NETWORK_ROOT, network_id) // I regret nothing!!
	AddComponent(/datum/component/ntnet_interface, network_id, id_tag)

/// A list of all /obj by their id_tag
GLOBAL_LIST_EMPTY(objects_by_id_tag)

/obj/Initialize(mapload)
	. = ..()

	if (id_tag)
		GLOB.objects_by_id_tag[id_tag] = src

/obj/Destroy(force)
	if(!ismachinery(src))
		STOP_PROCESSING(SSobj, src) // TODO: Have a processing bitflag to reduce on unnecessary loops through the processing lists
	SStgui.close_uis(src)
	GLOB.objects_by_id_tag -= id_tag
	. = ..()

/obj/attacked_by(obj/item/attacking_item, mob/living/user)
	if(!attacking_item.force)
		return

	var/total_force = (attacking_item.force * attacking_item.demolition_mod)

	var/damage = take_damage(total_force, attacking_item.damtype, MELEE, 1)

	var/damage_verb = "hit"

	if(attacking_item.demolition_mod > 1 && damage)
		damage_verb = "pulverise"
	if(attacking_item.demolition_mod < 1)
		damage_verb = "ineffectively pierce"

	user.visible_message(span_danger("[user] [damage_verb][plural_s(damage_verb)] [src] with [attacking_item][damage ? "." : ", without leaving a mark!"]"), \
		span_danger("You [damage_verb] [src] with [attacking_item][damage ? "." : ", without leaving a mark!"]"), null, COMBAT_MESSAGE_RANGE)
	log_combat(user, src, "attacked", attacking_item)

/obj/assume_air(datum/gas_mixture/giver)
	if(loc)
		return loc.assume_air(giver)
	else
		return null

/obj/remove_air(amount)
	if(loc)
		return loc.remove_air(amount)
	else
		return null

/obj/return_air()
	if(loc)
		return loc.return_air()
	else
		return null

/obj/proc/handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
	//Return: (NONSTANDARD)
	// null if object handles breathing logic for lifeform
	// datum/air_group to tell lifeform to process using that breath return
	//DEFAULT: Take air from turf to give to have mob process

	if(breath_request>0)
		var/datum/gas_mixture/environment = return_air()
		var/breath_percentage = BREATH_VOLUME / environment.return_volume()
		return remove_air(environment.total_moles() * breath_percentage)
	else
		return null

/obj/proc/updateUsrDialog()
	if((obj_flags & IN_USE) && !(obj_flags & USES_TGUI))
		var/is_in_use = FALSE
		var/list/nearby = viewers(1, src)
		for(var/mob/M in nearby)
			if ((M.client && M.machine == src))
				is_in_use = TRUE
				ui_interact(M)
		if(issilicon(usr) || isAdminGhostAI(usr))
			if (!(usr in nearby))
				if (usr.client && usr.machine == src) // && M.machine == src is omitted because if we triggered this by using the dialog, it doesn't matter if our machine changed in between triggering it and this - the dialog is probably still supposed to refresh.
					is_in_use = TRUE
					ui_interact(usr)

		// check for TK users

		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			if(!(usr in nearby))
				if(usr.client && usr.machine == src)
					if(H.dna.check_mutation(/datum/mutation/human/telekinesis))
						is_in_use = TRUE
						ui_interact(usr)
		if (is_in_use)
			obj_flags |= IN_USE
		else
			obj_flags &= ~IN_USE

/obj/proc/updateDialog(update_viewers = TRUE,update_ais = TRUE)
	// Check that people are actually using the machine. If not, don't update anymore.
	if(obj_flags & IN_USE)
		var/is_in_use = FALSE
		if(update_viewers)
			for(var/mob/M in viewers(1, src))
				if ((M.client && M.machine == src))
					is_in_use = TRUE
					src.interact(M)
		var/ai_in_use = FALSE
		if(update_ais)
			ai_in_use = AutoUpdateAI(src)

		if(update_viewers && update_ais) //State change is sure only if we check both
			if(!ai_in_use && !is_in_use)
				obj_flags &= ~IN_USE


/obj/attack_ghost(mob/user)
	. = ..()
	if(.)
		return
	SEND_SIGNAL(src, COMSIG_ATOM_UI_INTERACT, user)
	ui_interact(user)

/mob/proc/unset_machine()
	SIGNAL_HANDLER
	if(!machine)
		return
	UnregisterSignal(machine, COMSIG_PARENT_QDELETING)
	machine.on_unset_machine(src)
	machine = null

//called when the user unsets the machine.
/atom/movable/proc/on_unset_machine(mob/user)
	return

/mob/proc/set_machine(obj/O)
	if(machine)
		unset_machine()
	machine = O
	RegisterSignal(O, COMSIG_PARENT_QDELETING, PROC_REF(unset_machine))
	if(istype(O))
		O.obj_flags |= IN_USE

/obj/item/proc/updateSelfDialog()
	var/mob/M = src.loc
	if(istype(M) && M.client && M.machine == src)
		src.attack_self(M)

/obj/singularity_pull(S, current_size)
	..()
	if(move_resist == INFINITY)
		return
	if(!anchored || current_size >= STAGE_FIVE)
		step_towards(src,S)

/obj/get_dumping_location()
	return get_turf(src)

/obj/proc/check_uplink_validity()
	return 1

/obj/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "---")
	VV_DROPDOWN_OPTION(VV_HK_MASS_DEL_TYPE, "Delete all of type")
	VV_DROPDOWN_OPTION(VV_HK_OSAY, "Object Say")

/obj/vv_do_topic(list/href_list)
	if(!(. = ..()))
		return
	if(href_list[VV_HK_OSAY])
		if(check_rights(R_FUN, FALSE))
			usr.client.object_say(src)

	if(href_list[VV_HK_MASS_DEL_TYPE])
		if(check_rights(R_DEBUG|R_SERVER))
			var/action_type = tgui_alert(usr, "Strict type ([type]) or type and all subtypes?",,list("Strict type","Type and subtypes","Cancel"))
			if(action_type == "Cancel" || !action_type)
				return

			if(tgui_alert(usr, "Are you really sure you want to delete all objects of type [type]?",,list("Yes","No")) != "Yes")
				return

			if(tgui_alert(usr, "Second confirmation required. Delete?",,list("Yes","No")) != "Yes")
				return

			var/O_type = type
			switch(action_type)
				if("Strict type")
					var/i = 0
					for(var/obj/Obj in world)
						if(Obj.type == O_type)
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No objects of this type exist")
						return
					log_admin("[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted) ")
					message_admins(span_notice("[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted) "))
				if("Type and subtypes")
					var/i = 0
					for(var/obj/Obj in world)
						if(istype(Obj,O_type))
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No objects of this type exist")
						return
					log_admin("[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted) ")
					message_admins(span_notice("[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted) "))

/obj/examine(mob/user)
	. = ..()
	if(desc_controls)
		. += span_notice(desc_controls)
	if(obj_flags & UNIQUE_RENAME)
		. += span_notice("Use a pen on it to rename it or change its description.")
	if(unique_reskin && (!current_skin || infinite_reskin))
		. += span_notice("Alt-click it to reskin it.")

/obj/AltClick(mob/user)
	. = ..()
	if(unique_reskin && (!current_skin || infinite_reskin) && user.can_perform_action(src, NEED_DEXTERITY))
		reskin_obj(user)

/**
 * Reskins object based on a user's choice
 *
 * Arguments:
 * * M The mob choosing a reskin option
 */
/obj/proc/reskin_obj(mob/M)
	if(!LAZYLEN(unique_reskin))
		return

	var/list/items = list()
	for(var/reskin_option in unique_reskin)
		var/image/item_image = image(icon = src.icon, icon_state = unique_reskin[reskin_option])
		items += list("[reskin_option]" = item_image)
	sort_list(items)

	var/pick = show_radial_menu(M, src, items, custom_check = CALLBACK(src, PROC_REF(check_reskin_menu), M), radius = 38, require_near = TRUE)
	if(!pick)
		return
	if(!unique_reskin[pick])
		return
	current_skin = pick
	icon_state = unique_reskin[pick]
	to_chat(M, "[src] is now skinned as '[pick].'")

/**
 * Checks if we are allowed to interact with a radial menu for reskins
 *
 * Arguments:
 * * user The mob interacting with the menu
 */
/obj/proc/check_reskin_menu(mob/user)
	if(QDELETED(src))
		return FALSE
	if(!infinite_reskin && current_skin)
		return FALSE
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/analyzer_act(mob/living/user, obj/item/analyzer/tool)
	if(atmos_scan(user=user, target=src, silent=FALSE))
		return TRUE
	return ..()

/obj/proc/plunger_act(obj/item/plunger/P, mob/living/user, reinforced)
	return

// Should move all contained objects to it's location.
/obj/proc/dump_contents()
	CRASH("Unimplemented.")

/obj/handle_ricochet(obj/projectile/P)
	. = ..()
	if(. && receive_ricochet_damage_coeff)
		take_damage(P.damage * receive_ricochet_damage_coeff, P.damage_type, P.armor_flag, 0, turn(P.dir, 180), P.armour_penetration) // pass along receive_ricochet_damage_coeff damage to the structure for the ricochet

/obj/update_overlays()
	. = ..()
	if(resistance_flags & ON_FIRE)
		. += custom_fire_overlay ? custom_fire_overlay : GLOB.fire_overlay

/// Handles exposing an object to reagents.
/obj/expose_reagents(list/reagents, datum/reagents/source, methods=TOUCH, volume_modifier=1, show_message=TRUE)
	. = ..()
	if(. & COMPONENT_NO_EXPOSE_REAGENTS)
		return

	SEND_SIGNAL(source, COMSIG_REAGENTS_EXPOSE_OBJ, src, reagents, methods, volume_modifier, show_message)
	for(var/reagent in reagents)
		var/datum/reagent/R = reagent
		. |= R.expose_obj(src, reagents[R])

///attempt to freeze this obj if possible. returns TRUE if it succeeded, FALSE otherwise.
/obj/proc/freeze()
	if(HAS_TRAIT(src, TRAIT_FROZEN))
		return FALSE
	if(obj_flags & FREEZE_PROOF)
		return FALSE

	AddElement(/datum/element/frozen)
	return TRUE

///unfreezes this obj if its frozen
/obj/proc/unfreeze()
	SEND_SIGNAL(src, COMSIG_OBJ_UNFREEZE)
