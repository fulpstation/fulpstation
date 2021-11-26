// AI (i.e. game AI, not the AI player) controlled bots
/mob/living/simple_animal/bot
	icon = 'icons/mob/aibots.dmi'
	layer = MOB_LAYER
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	stop_automated_movement = 1
	wander = 0
	healable = 0
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	maxbodytemp = INFINITY
	minbodytemp = 0
	has_unlimited_silicon_privilege = TRUE
	sentience_type = SENTIENCE_ARTIFICIAL
	status_flags = NONE //no default canpush
	pass_flags = PASSFLAPS
	verb_say = "states"
	verb_ask = "queries"
	verb_exclaim = "declares"
	verb_yell = "alarms"
	initial_language_holder = /datum/language_holder/synthetic
	bubble_icon = "machine"
	speech_span = SPAN_ROBOT
	faction = list("neutral", "silicon" , "turret")
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_power = 0.9

	var/obj/machinery/bot_core/bot_core = null
	var/bot_core_type = /obj/machinery/bot_core
	var/list/users = list() //for dialog updates
	var/window_id = "bot_control"
	var/window_name = "Protobot 1.0" //Popup title
	var/window_width = 0 //0 for default size
	var/window_height = 0
	var/obj/item/paicard/paicard // Inserted pai card.
	///If a pAI is allowed to be inserted into this bot.
	var/allow_pai = TRUE
	var/bot_name

	var/list/player_access = list() //Additonal access the bots gets when player controlled
	var/emagged = FALSE
	var/list/prev_access = list()
	var/on = TRUE
	var/open = FALSE//Maint panel
	var/locked = TRUE
	///If the bot is hacked by silicons or emagged by humans.
	var/hacked = FALSE
	var/text_hack = "" //Custom text returned to a silicon upon hacking a bot.
	var/text_dehack = "" //Text shown when resetting a bots hacked status to normal.
	var/text_dehack_fail = "" //Shown when a silicon tries to reset a bot emagged with the emag item, which cannot be reset.
	var/declare_message = "" //What the bot will display to the HUD user.
	var/frustration = 0 //Used by some bots for tracking failures to reach their target.
	var/base_speed = 2 //The speed at which the bot moves, or the number of times it moves per process() tick.
	var/turf/ai_waypoint //The end point of a bot's path, or the target location.
	var/list/path = list() //List of turfs through which a bot 'steps' to reach the waypoint, associated with the path image, if there is one.
	var/pathset = 0
	var/list/ignore_list = list() //List of unreachable targets for an ignore-list enabled bot to ignore.
	var/mode = BOT_IDLE //Standardizes the vars that indicate the bot is busy with its function.
	var/tries = 0 //Number of times the bot tried and failed to move.
	var/remote_disabled = FALSE //If enabled, the AI cannot *Remotely* control a bot. It can still control it through cameras.
	var/mob/living/silicon/ai/calling_ai //Links a bot to the AI calling it.
	var/obj/item/radio/Radio //The bot's radio, for speaking to people.
	var/radio_key = null //which channels can the bot listen to
	var/radio_channel = RADIO_CHANNEL_COMMON //The bot's default radio channel
	var/auto_patrol = 0// set to make bot automatically patrol
	var/turf/patrol_target // this is turf to navigate to (location of beacon)
	var/turf/summon_target // The turf of a user summoning a bot.
	var/new_destination // pending new destination (waiting for beacon response)
	var/destination // destination description tag
	var/next_destination // the next destination in the patrol route
	var/shuffle = FALSE // If we should shuffle our adjacency checking

	var/blockcount = 0 //number of times retried a blocked path
	var/awaiting_beacon = 0 // count of pticks awaiting a beacon response

	var/nearest_beacon // the nearest beacon's tag
	var/turf/nearest_beacon_loc // the nearest beacon's location

	var/beacon_freq = FREQ_NAV_BEACON
	var/model = "" //The type of bot it is.
	var/bot_type = NONE //The type of bot it is, for radio control.
	var/data_hud_type = DATA_HUD_DIAGNOSTIC_BASIC //The type of data HUD the bot uses. Diagnostic by default.
	//This holds text for what the bot is mode doing, reported on the remote bot control interface. This is in order of the defines for the mode defines in robots.dm, in order
	var/list/mode_name = list("In Pursuit","Preparing to Arrest", "Arresting", \
	"Beginning Patrol", "Patrolling", "Summoned by PDA", \
	"Cleaning", "Repairing", "Proceeding to work site", "Healing", \
	"Proceeding to AI waypoint", "Navigating to Delivery Location", "Navigating to Home", \
	"Waiting for clear path", "Calculating navigation path", "Pinging beacon network", "Unable to reach destination", "Chasing filth")
	var/datum/atom_hud/data/bot_path/path_hud = new /datum/atom_hud/data/bot_path()
	var/path_image_icon = 'icons/mob/aibots.dmi'
	var/path_image_icon_state = "path_indicator"
	var/path_image_color = "#FFFFFF"
	var/reset_access_timer_id
	var/ignorelistcleanuptimer = 1 // This ticks up every automated action, at 300 we clean the ignore list
	var/robot_arm = /obj/item/bodypart/r_arm/robot

	var/commissioned = FALSE // Will other (noncommissioned) bots salute this bot?
	COOLDOWN_DECLARE(next_salute_check)
	var/salute_delay = 60 SECONDS

	hud_possible = list(DIAG_STAT_HUD, DIAG_BOT_HUD, DIAG_HUD, DIAG_PATH_HUD = HUD_LIST_LIST) //Diagnostic HUD views

/mob/living/simple_animal/bot/proc/get_mode()
	if(client) //Player bots do not have modes, thus the override. Also an easy way for PDA users/AI to know when a bot is a player.
		if(paicard)
			return "<b>pAI Controlled</b>"
		else
			return "<b>Autonomous</b>"
	else if(!on)
		return "<span class='bad'>Inactive</span>"
	else if(!mode)
		return "<span class='good'>Idle</span>"
	else
		return "<span class='average'>[mode_name[mode]]</span>"

/**
 * Returns a status string about the bot's current status, if it's moving, manually controlled, or idle.
 */
/mob/living/simple_animal/bot/proc/get_mode_ui()
	if(client) //Player bots do not have modes, thus the override. Also an easy way for PDA users/AI to know when a bot is a player.
		return paicard ? "pAI Controlled" : "Autonomous"
	else if(!on)
		return "Inactive"
	else if(!mode)
		return "Idle"
	else
		return "[mode_name[mode]]"

/mob/living/simple_animal/bot/proc/turn_on()
	if(stat)
		return FALSE
	on = TRUE
	REMOVE_TRAIT(src, TRAIT_INCAPACITATED, POWER_LACK_TRAIT)
	REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, POWER_LACK_TRAIT)
	REMOVE_TRAIT(src, TRAIT_HANDS_BLOCKED, POWER_LACK_TRAIT)
	set_light_on(on)
	update_appearance()
	to_chat(src, span_boldnotice("You turned on!"))
	diag_hud_set_botstat()
	return TRUE

/mob/living/simple_animal/bot/proc/turn_off()
	on = FALSE
	ADD_TRAIT(src, TRAIT_INCAPACITATED, POWER_LACK_TRAIT)
	ADD_TRAIT(src, TRAIT_IMMOBILIZED, POWER_LACK_TRAIT)
	ADD_TRAIT(src, TRAIT_HANDS_BLOCKED, POWER_LACK_TRAIT)
	set_light_on(on)
	bot_reset() //Resets an AI's call, should it exist.
	to_chat(src, span_userdanger("You turned off!"))
	update_appearance()

/mob/living/simple_animal/bot/Initialize(mapload)
	. = ..()
	GLOB.bots_list += src
	// Give bots a fancy new ID card that can hold any access.
	access_card = new /obj/item/card/id/advanced/simple_bot(src)
	// This access is so bots can be immediately set to patrol and leave Robotics, instead of having to be let out first.
	access_card.set_access(list(ACCESS_ROBOTICS))
	set_custom_texts()
	Radio = new/obj/item/radio(src)
	if(radio_key)
		Radio.keyslot = new radio_key
	Radio.subspace_transmission = TRUE
	Radio.canhear_range = 0 // anything greater will have the bot broadcast the channel as if it were saying it out loud.
	Radio.recalculateChannels()

	bot_core = new bot_core_type(src)

	//Adds bot to the diagnostic HUD system
	prepare_huds()
	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.add_to_hud(src)
	diag_hud_set_bothealth()
	diag_hud_set_botstat()
	diag_hud_set_botmode()

	//If a bot has its own HUD (for player bots), provide it.
	if(data_hud_type)
		var/datum/atom_hud/datahud = GLOB.huds[data_hud_type]
		datahud.add_hud_to(src)
	if(path_hud)
		path_hud.add_to_hud(src)
		path_hud.add_hud_to(src)


/mob/living/simple_animal/bot/Destroy()
	if(path_hud)
		QDEL_NULL(path_hud)
		path_hud = null
	GLOB.bots_list -= src
	if(paicard)
		ejectpai()
	QDEL_NULL(Radio)
	QDEL_NULL(access_card)
	QDEL_NULL(bot_core)
	return ..()

/mob/living/simple_animal/bot/bee_friendly()
	return TRUE

/mob/living/simple_animal/bot/death(gibbed)
	explode()
	..()

/mob/living/simple_animal/bot/proc/explode()
	qdel(src)

/mob/living/simple_animal/bot/emag_act(mob/user)
	if(locked) //First emag application unlocks the bot's interface. Apply a screwdriver to use the emag again.
		locked = FALSE
		to_chat(user, span_notice("You bypass [src]'s controls."))
		return
	if(!locked && open) //Bot panel is unlocked by ID or emag, and the panel is screwed open. Ready for emagging.
		emagged = TRUE
		remote_disabled = TRUE //Manually emagging the bot locks out the AI built in panel.
		locked = TRUE //Access denied forever!
		bot_reset()
		turn_on() //The bot automatically turns on when emagged, unless recently hit with EMP.
		to_chat(src, span_userdanger("(#$*#$^^( OVERRIDE DETECTED"))
		if(user)
			log_combat(user, src, "emagged")
		return
	else //Bot is unlocked, but the maint panel has not been opened with a screwdriver yet.
		to_chat(user, span_warning("You need to open maintenance panel first!"))

/mob/living/simple_animal/bot/examine(mob/user)
	. = ..()
	if(health < maxHealth)
		if(health > maxHealth/3)
			. += "[src]'s parts look loose."
		else
			. += "[src]'s parts look very loose!"
	else
		. += "[src] is in pristine condition."
	. += span_notice("Its maintenance panel is [open ? "open" : "closed"].")
	. += span_info("You can use a <b>screwdriver</b> to [open ? "close" : "open"] it.")
	if(open)
		. += span_notice("Its control panel is [locked ? "locked" : "unlocked"].")
		var/is_sillycone = issilicon(user)
		if(!emagged && (is_sillycone || user.Adjacent(src)))
			. += span_info("Alt-click [is_sillycone ? "" : "or use your ID on "]it to [locked ? "un" : ""]lock its control panel.")
	if(paicard)
		. += span_notice("It has a pAI device installed.")
		if(!open)
			. += span_info("You can use a <b>hemostat</b> to remove it.")

/mob/living/simple_animal/bot/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	if(amount>0 && prob(10))
		new /obj/effect/decal/cleanable/oil(loc)
	. = ..()

/mob/living/simple_animal/bot/updatehealth()
	..()
	diag_hud_set_bothealth()

/mob/living/simple_animal/bot/med_hud_set_health()
	return //we use a different hud

/mob/living/simple_animal/bot/med_hud_set_status()
	return //we use a different hud

/mob/living/simple_animal/bot/handle_automated_action() //Master process which handles code common across most bots.
	diag_hud_set_botmode()

	if (ignorelistcleanuptimer % 300 == 0) // Every 300 actions, clean up the ignore list from old junk
		for(var/ref in ignore_list)
			var/atom/referredatom = locate(ref)
			if (!referredatom || !istype(referredatom) || QDELETED(referredatom))
				ignore_list -= ref
		ignorelistcleanuptimer = 1
	else
		ignorelistcleanuptimer++

	if(!on || client)
		return FALSE

	if(commissioned && COOLDOWN_FINISHED(src, next_salute_check))
		COOLDOWN_START(src, next_salute_check, salute_delay)
		for(var/mob/living/simple_animal/bot/B in view(5, src))
			if(!B.commissioned && B.on)
				visible_message("<b>[B]</b> performs an elaborate salute for [src]!")
				break

	switch(mode) //High-priority overrides are processed first. Bots can do nothing else while under direct command.
		if(BOT_RESPONDING) //Called by the AI.
			call_mode()
			return FALSE
		if(BOT_SUMMON) //Called to a location
			bot_summon()
			return FALSE
	return TRUE //Successful completion. Used to prevent child process() continuing if this one is ended early.


/mob/living/simple_animal/bot/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(!user.combat_mode)
		ui_interact(user)
	else
		return ..()

/mob/living/simple_animal/bot/attack_ai(mob/user)
	if(!topic_denied(user))
		ui_interact(user)
	else
		to_chat(user, span_warning("[src]'s interface is not responding!"))

/mob/living/simple_animal/bot/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SimpleBot", name)
		ui.open()

/mob/living/simple_animal/bot/AltClick(mob/user)
	. = ..()
	if(!can_interact(user))
		return
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	unlock_with_id(user)

/mob/living/simple_animal/bot/proc/unlock_with_id(mob/user)
	if(emagged)
		to_chat(user, span_danger("ERROR"))
		return
	if(open)
		to_chat(user, span_warning("Please close the access panel before [locked ? "un" : ""]locking it."))
		return
	if(!bot_core.allowed(user))
		to_chat(user, span_warning("Access denied."))
		return
	locked = !locked
	to_chat(user, span_notice("Controls are now [locked ? "locked" : "unlocked"]."))
	return TRUE

/mob/living/simple_animal/bot/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.tool_behaviour == TOOL_SCREWDRIVER)
		if(!locked)
			open = !open
			to_chat(user, span_notice("The maintenance panel is now [open ? "opened" : "closed"]."))
		else
			to_chat(user, span_warning("The maintenance panel is locked!"))
	else if(attacking_item.GetID())
		unlock_with_id(user)
	else if(istype(attacking_item, /obj/item/paicard))
		insertpai(user, attacking_item)
	else if(attacking_item.tool_behaviour == TOOL_HEMOSTAT && paicard)
		if(open)
			to_chat(user, span_warning("Close the access panel before manipulating the personality slot!"))
		else
			to_chat(user, span_notice("You attempt to pull [paicard] free..."))
			if(do_after(user, 30, target = src))
				if (paicard)
					user.visible_message(span_notice("[user] uses [attacking_item] to pull [paicard] out of [bot_name]!"),span_notice("You pull [paicard] out of [bot_name] with [attacking_item]."))
					ejectpai(user)
	else
		user.changeNext_move(CLICK_CD_MELEE)
		if(attacking_item.tool_behaviour == TOOL_WELDER && !user.combat_mode)
			if(health >= maxHealth)
				to_chat(user, span_warning("[src] does not need a repair!"))
				return
			if(!open)
				to_chat(user, span_warning("Unable to repair with the maintenance panel closed!"))
				return

			if(attacking_item.use_tool(src, user, 0, volume=40))
				adjustHealth(-10)
				user.visible_message(span_notice("[user] repairs [src]!"),span_notice("You repair [src]."))
		else
			if(attacking_item.force) //if force is non-zero
				do_sparks(5, TRUE, src)
			..()

/mob/living/simple_animal/bot/bullet_act(obj/projectile/Proj)
	if(Proj && (Proj.damage_type == BRUTE || Proj.damage_type == BURN))
		if(prob(75) && Proj.damage > 0)
			do_sparks(5, TRUE, src)
	return ..()

/mob/living/simple_animal/bot/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	var/was_on = on
	stat |= EMPED
	new /obj/effect/temp_visual/emp(loc)
	if(paicard)
		paicard.emp_act(severity)
		src.visible_message(span_notice("[paicard] is flies out of [bot_name]!"),span_warning("You are forcefully ejected from [bot_name]!"))
		ejectpai(0)
	if(on)
		turn_off()
	addtimer(CALLBACK(src, .proc/emp_reset, was_on), severity*30 SECONDS)

/mob/living/simple_animal/bot/proc/emp_reset(was_on)
	stat &= ~EMPED
	if(was_on)
		turn_on()

/mob/living/simple_animal/bot/proc/set_custom_texts() //Superclass for setting hack texts. Appears only if a set is not given to a bot locally.
	text_hack = "You hack [name]."
	text_dehack = "You reset [name]."
	text_dehack_fail = "You fail to reset [name]."

/mob/living/simple_animal/bot/proc/speak(message,channel) //Pass a message to have the bot say() it. Pass a frequency to say it on the radio.
	if((!on) || (!message))
		return
	if(channel && Radio.channels[channel])// Use radio if we have channel key
		Radio.talk_into(src, message, channel)
	else
		say(message)

/mob/living/simple_animal/bot/radio(message, list/message_mods = list(), list/spans, language)
	. = ..()
	if(.)
		return

	if(message_mods[MODE_HEADSET])
		Radio.talk_into(src, message, , spans, language, message_mods)
		return REDUCE_RANGE
	else if(message_mods[RADIO_EXTENSION] == MODE_DEPARTMENT)
		Radio.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
		return REDUCE_RANGE
	else if(message_mods[RADIO_EXTENSION] in GLOB.radiochannels)
		Radio.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
		return REDUCE_RANGE

/mob/living/simple_animal/bot/proc/drop_part(obj/item/drop_item, dropzone)
	var/obj/item/dropped_item
	if(ispath(drop_item))
		dropped_item = new drop_item(dropzone)
	else
		dropped_item = drop_item
		dropped_item.forceMove(dropzone)

	if(istype(dropped_item, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/dropped_cell = dropped_item
		dropped_cell.charge = 0
		dropped_cell.update_appearance()

	else if(istype(dropped_item, /obj/item/storage))
		var/obj/item/storage/S = dropped_item
		S.contents = list()

	else if(istype(dropped_item, /obj/item/gun/energy))
		var/obj/item/gun/energy/dropped_gun = dropped_item
		dropped_gun.cell.charge = 0
		dropped_gun.update_appearance()

//Generalized behavior code, override where needed!

/*
scan() will search for a given type (such as turfs, human mobs, or objects) in the bot's view range, and return a single result.
Arguments: The object type to be searched (such as "/mob/living/carbon/human"), the old scan result to be ignored, if one exists,
and the view range, which defaults to 7 (full screen) if an override is not passed.
If the bot maintains an ignore list, it is also checked here.

Example usage: patient = scan(/mob/living/carbon/human, oldpatient, 1)
The proc would return a human next to the bot to be set to the patient var.
Pass the desired type path itself, declaring a temporary var beforehand is not required.
*/
/mob/living/simple_animal/bot/proc/scan(scan_type, old_target, scan_range = DEFAULT_SCAN_RANGE)
	var/turf/T = get_turf(src)
	if(!T)
		return
	var/list/adjacent = T.get_atmos_adjacent_turfs(1)
	if(shuffle) //If we were on the same tile as another bot, let's randomize our choices so we dont both go the same way
		adjacent = shuffle(adjacent)
		shuffle = FALSE
	for(var/scan in adjacent)//Let's see if there's something right next to us first!
		if(check_bot(scan)) //Is there another bot there? Then let's just skip it
			continue
		if(isturf(scan_type)) //If we're lookeing for a turf we can just run the checks directly!
			var/final_result = checkscan(scan,scan_type,old_target)
			if(final_result)
				return final_result
		else
			var/turf/turfy = scan
			for(var/deepscan in turfy.contents)//Check the contents since adjacent is turfs
				var/final_result = checkscan(deepscan,scan_type,old_target)
				if(final_result)
					return final_result
	for (var/scan in shuffle(view(scan_range, src))-adjacent) //Search for something in range!
		var/final_result = checkscan(scan,scan_type,old_target)
		if(final_result)
			return final_result

/mob/living/simple_animal/bot/proc/checkscan(scan, scan_type, old_target)
	if(!istype(scan, scan_type)) //Check that the thing we found is the type we want!
		return FALSE //If not, keep searching!
	if( (REF(scan) in ignore_list) || (scan == old_target) ) //Filter for blacklisted elements, usually unreachable or previously processed oness
		return FALSE

	var/scan_result = process_scan(scan) //Some bots may require additional processing when a result is selected.
	if(scan_result)
		return scan_result
	else
		return FALSE //The current element failed assessment, move on to the next.

/mob/living/simple_animal/bot/proc/check_bot(targ)
	var/turf/T = get_turf(targ)
	if(T)
		for(var/C in T.contents)
			if(istype(C,type) && (C != src)) //Is there another bot there already? If so, let's skip it so we dont all atack on top of eachother.
				return TRUE //Let's abort if we find a bot so we dont have to keep rechecking

//When the scan finds a target, run bot specific processing to select it for the next step. Empty by default.
/mob/living/simple_animal/bot/proc/process_scan(scan_target)
	return scan_target


/mob/living/simple_animal/bot/proc/add_to_ignore(subject)
	if(ignore_list.len < 50) //This will help keep track of them, so the bot is always trying to reach a blocked spot.
		ignore_list += REF(subject)
	else  //If the list is full, insert newest, delete oldest.
		ignore_list.Cut(1,2)
		ignore_list += REF(subject)

/*
Movement proc for stepping a bot through a path generated through A-star.
Pass a positive integer as an argument to override a bot's default speed.
*/
/mob/living/simple_animal/bot/proc/bot_move(dest, move_speed)
	if(!dest || !path || path.len == 0) //A-star failed or a path/destination was not set.
		set_path(null)
		return FALSE
	dest = get_turf(dest) //We must always compare turfs, so get the turf of the dest var if dest was originally something else.
	var/turf/last_node = get_turf(path[path.len]) //This is the turf at the end of the path, it should be equal to dest.
	if(get_turf(src) == dest) //We have arrived, no need to move again.
		return TRUE
	else if(dest != last_node) //The path should lead us to our given destination. If this is not true, we must stop.
		set_path(null)
		return FALSE
	var/step_count = move_speed ? move_speed : base_speed //If a value is passed into move_speed, use that instead of the default speed var.

	if(step_count >= 1 && tries < BOT_STEP_MAX_RETRIES)
		for(var/step_number in 1 to step_count)
			addtimer(CALLBACK(src, .proc/bot_step), BOT_STEP_DELAY*(step_number-1))
	else
		return FALSE
	return TRUE

/// Performs a step_towards and increments the path if successful. Returns TRUE if the bot moved and FALSE otherwise.
/mob/living/simple_animal/bot/proc/bot_step()
	if(!length(path))
		return FALSE

	if(SEND_SIGNAL(src, COMSIG_MOB_BOT_PRE_STEP) & COMPONENT_MOB_BOT_BLOCK_PRE_STEP)
		return FALSE

	if(!step_towards(src, path[1]))
		tries++
		return FALSE

	increment_path()
	tries = 0
	SEND_SIGNAL(src, COMSIG_MOB_BOT_STEP)
	return TRUE


/mob/living/simple_animal/bot/proc/check_bot_access()
	if(mode != BOT_SUMMON && mode != BOT_RESPONDING)
		access_card.set_access(prev_access)

/mob/living/simple_animal/bot/proc/call_bot(caller, turf/waypoint, message=TRUE)
	bot_reset() //Reset a bot before setting it to call mode.

	//For giving the bot temporary all-access. This method is bad and makes me feel bad. Refactoring access to a component is for another PR.
	var/obj/item/card/id/all_access = new /obj/item/card/id/advanced/gold/captains_spare()
	set_path(get_path_to(src, waypoint, 200, id=all_access))
	qdel(all_access)
	calling_ai = caller //Link the AI to the bot!
	ai_waypoint = waypoint

	if(path?.len) //Ensures that a valid path is calculated!
		var/end_area = get_area_name(waypoint)
		if(!on)
			turn_on() //Saves the AI the hassle of having to activate a bot manually.
		access_card.set_access(REGION_ACCESS_ALL_STATION) //Give the bot all-access while under the AI's command.
		if(client)
			reset_access_timer_id = addtimer(CALLBACK (src, .proc/bot_reset), 60 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE) //if the bot is player controlled, they get the extra access for a limited time
			to_chat(src, span_notice("[span_big("Priority waypoint set by [icon2html(calling_ai, src)] <b>[caller]</b>. Proceed to <b>[end_area]</b>.")]<br>[path.len-1] meters to destination. You have been granted additional door access for 60 seconds."))
		if(message)
			to_chat(calling_ai, span_notice("[icon2html(src, calling_ai)] [name] called to [end_area]. [path.len-1] meters to destination."))
		pathset = 1
		mode = BOT_RESPONDING
		tries = 0
	else
		if(message)
			to_chat(calling_ai, span_danger("Failed to calculate a valid route. Ensure destination is clear of obstructions and within range."))
		calling_ai = null
		set_path(null)

/mob/living/simple_animal/bot/proc/call_mode() //Handles preparing a bot for a call, as well as calling the move proc.
//Handles the bot's movement during a call.
	var/success = bot_move(ai_waypoint, 3)
	if(!success)
		if(calling_ai)
			to_chat(calling_ai, "[icon2html(src, calling_ai)] [get_turf(src) == ai_waypoint ? span_notice("[src] successfully arrived to waypoint.") : span_danger("[src] failed to reach waypoint.")]")
			calling_ai = null
		bot_reset()

/mob/living/simple_animal/bot/proc/bot_reset()
	if(calling_ai) //Simple notification to the AI if it called a bot. It will not know the cause or identity of the bot.
		to_chat(calling_ai, span_danger("Call command to a bot has been reset."))
		calling_ai = null
	if(reset_access_timer_id)
		deltimer(reset_access_timer_id)
		reset_access_timer_id = null
	set_path(null)
	summon_target = null
	pathset = 0
	access_card.set_access(prev_access)
	tries = 0
	mode = BOT_IDLE
	diag_hud_set_botstat()
	diag_hud_set_botmode()




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Patrol and summon code!
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/mob/living/simple_animal/bot/proc/bot_patrol()
	patrol_step()
	addtimer(CALLBACK(src, .proc/do_patrol), 5)

/mob/living/simple_animal/bot/proc/do_patrol()
	if(mode == BOT_PATROL)
		patrol_step()

/mob/living/simple_animal/bot/proc/start_patrol()

	if(tries >= BOT_STEP_MAX_RETRIES) //Bot is trapped, so stop trying to patrol.
		auto_patrol = 0
		tries = 0
		speak("Unable to start patrol.")

		return

	if(!auto_patrol) //A bot not set to patrol should not be patrolling.
		mode = BOT_IDLE
		return

	if(patrol_target) // has patrol target
		INVOKE_ASYNC(src, .proc/target_patrol)
	else // no patrol target, so need a new one
		speak("Engaging patrol mode.")
		find_patrol_target()
		tries++
	return

/mob/living/simple_animal/bot/proc/target_patrol()
	calc_path() // Find a route to it
	if(!path.len)
		patrol_target = null
		return
	mode = BOT_PATROL
// perform a single patrol step

/mob/living/simple_animal/bot/proc/patrol_step()

	if(client) // In use by player, don't actually move.
		return

	if(loc == patrol_target) // reached target
		//Find the next beacon matching the target.
		if(!get_next_patrol_target())
			find_patrol_target() //If it fails, look for the nearest one instead.
		return

	else if(path.len > 0 && patrol_target) // valid path
		if(path[1] == loc)
			increment_path()
			return


		var/moved = bot_move(patrol_target)//step_towards(src, next) // attempt to move
		if(!moved) //Couldn't proceed the next step of the path BOT_STEP_MAX_RETRIES times
			addtimer(CALLBACK(src, .proc/patrol_step_not_moved), 2)

	else // no path, so calculate new one
		mode = BOT_START_PATROL

/mob/living/simple_animal/bot/proc/patrol_step_not_moved()
	calc_path()
	if(!length(path))
		find_patrol_target()
	tries = 0

// finds the nearest beacon to self
/mob/living/simple_animal/bot/proc/find_patrol_target()
	nearest_beacon = null
	new_destination = null
	find_nearest_beacon()
	if(nearest_beacon)
		patrol_target = nearest_beacon_loc
		destination = next_destination
	else
		auto_patrol = FALSE
		mode = BOT_IDLE
		speak("Disengaging patrol mode.")

/mob/living/simple_animal/bot/proc/get_next_patrol_target()
	// search the beacon list for the next target in the list.
	for(var/obj/machinery/navbeacon/NB in GLOB.navbeacons["[z]"])
		if(NB.location == next_destination) //Does the Beacon location text match the destination?
			destination = new_destination //We now know the name of where we want to go.
			patrol_target = NB.loc //Get its location and set it as the target.
			next_destination = NB.codes["next_patrol"] //Also get the name of the next beacon in line.
			return TRUE

/mob/living/simple_animal/bot/proc/find_nearest_beacon()
	for(var/obj/machinery/navbeacon/NB in GLOB.navbeacons["[z]"])
		var/dist = get_dist(src, NB)
		if(nearest_beacon) //Loop though the beacon net to find the true closest beacon.
			//Ignore the beacon if were are located on it.
			if(dist>1 && dist<get_dist(src,nearest_beacon_loc))
				nearest_beacon = NB.location
				nearest_beacon_loc = NB.loc
				next_destination = NB.codes["next_patrol"]
			else
				continue
		else if(dist > 1) //Begin the search, save this one for comparison on the next loop.
			nearest_beacon = NB.location
			nearest_beacon_loc = NB.loc
	patrol_target = nearest_beacon_loc
	destination = nearest_beacon

//PDA control. Some bots, especially MULEs, may have more parameters.
/mob/living/simple_animal/bot/proc/bot_control(command, mob/user, list/user_access = list())
	if(!on || emagged || remote_disabled) //Emagged bots do not respect anyone's authority! Bots with their remote controls off cannot get commands.
		return TRUE //ACCESS DENIED
	if(client)
		bot_control_message(command, user)
	// process control input
	switch(command)
		if("patroloff")
			bot_reset() //HOLD IT!! //OBJECTION!!
			auto_patrol = FALSE

		if("patrolon")
			auto_patrol = TRUE

		if("summon")
			bot_reset()
			summon_target = get_turf(user)
			if(user_access.len != 0)
				access_card.set_access(user_access + prev_access) //Adds the user's access, if any.
			mode = BOT_SUMMON
			speak("Responding.", radio_channel)

			calc_summon_path()

		if("ejectpai")
			ejectpairemote(user)
	return


/mob/living/simple_animal/bot/proc/bot_control_message(command, user)
	switch(command)
		if("patroloff")
			to_chat(src, "<span class='warning big'>STOP PATROL</span>")
		if("patrolon")
			to_chat(src, "<span class='warning big'>START PATROL</span>")
		if("summon")
			to_chat(src, "<span class='warning big'>PRIORITY ALERT:[user] in [get_area_name(user)]!</span>")
		if("stop")
			to_chat(src, "<span class='warning big'>STOP!</span>")

		if("go")
			to_chat(src, "<span class='warning big'>GO!</span>")

		if("home")
			to_chat(src, "<span class='warning big'>RETURN HOME!</span>")
		if("ejectpai")
			return
		else
			to_chat(src, span_warning("Unidentified control sequence received:[command]"))

/mob/living/simple_animal/bot/proc/bot_summon() // summoned to PDA
	summon_step()

// calculates a path to the current destination
// given an optional turf to avoid
/mob/living/simple_animal/bot/proc/calc_path(turf/avoid)
	check_bot_access()
	set_path(get_path_to(src, patrol_target, 120, id=access_card, exclude=avoid))

/mob/living/simple_animal/bot/proc/calc_summon_path(turf/avoid)
	check_bot_access()
	INVOKE_ASYNC(src, .proc/do_calc_summon_path, avoid)

/mob/living/simple_animal/bot/proc/do_calc_summon_path(turf/avoid)
	set_path(get_path_to(src, summon_target, 150, id=access_card, exclude=avoid))
	if(!length(path)) //Cannot reach target. Give up and announce the issue.
		speak("Summon command failed, destination unreachable.",radio_channel)
		bot_reset()

/mob/living/simple_animal/bot/proc/summon_step()

	if(client) // In use by player, don't actually move.
		return

	if(loc == summon_target) // Arrived to summon location.
		bot_reset()
		return

	else if(path.len > 0 && summon_target) //Proper path acquired!
		if(path[1] == loc)
			increment_path()
			return

		var/moved = bot_move(summon_target, 3) // Move attempt
		if(!moved)
			addtimer(CALLBACK(src, .proc/summon_step_not_moved), 2)

	else // no path, so calculate new one
		calc_summon_path()

/mob/living/simple_animal/bot/proc/summon_step_not_moved()
	calc_summon_path()
	tries = 0

/mob/living/simple_animal/bot/Bump(atom/A) //Leave no door unopened!
	. = ..()
	if((istype(A, /obj/machinery/door/airlock) || istype(A, /obj/machinery/door/window)) && (!isnull(access_card)))
		var/obj/machinery/door/D = A
		if(D.check_access(access_card))
			D.open()
			frustration = 0

// Variables sent to TGUI
/mob/living/simple_animal/bot/ui_data(mob/user)
	var/list/data = list()
	data["can_hack"] = (issilicon(user) || isAdminGhostAI(user))
	data["custom_controls"] = list()
	data["emagged"] = emagged
	data["locked"] = locked
	data["pai"] = list()
	data["settings"] = list()
	if(!locked || issilicon(user) || isAdminGhostAI(user))
		data["pai"]["allow_pai"] = allow_pai
		data["pai"]["card_inserted"] = paicard
		data["settings"]["airplane_mode"] = remote_disabled
		data["settings"]["maintenance_lock"] = !open
		data["settings"]["power"] = on
		data["settings"]["patrol_station"] = auto_patrol
	return data

// Actions received from TGUI
/mob/living/simple_animal/bot/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!bot_core.allowed(usr) && !usr.has_unlimited_silicon_privilege)
		to_chat(usr, span_warning("Access denied."))
		return
	if(action == "lock")
		locked = !locked
	if(locked && !(issilicon(usr) || isAdminGhostAI(usr)))
		return
	switch(action)
		if("power")
			on = !on
			update_appearance()
		if("maintenance")
			open = !open
		if("patrol")
			auto_patrol = !auto_patrol
			bot_reset()
		if("airplane")
			remote_disabled = !remote_disabled
		if("hack")
			if(!(issilicon(usr) || isAdminGhostAI(usr)))
				return
			if(!emagged)
				emagged = TRUE
				hacked = TRUE
				locked = TRUE
				to_chat(usr, span_warning("[text_hack]"))
				message_admins("Safety lock of [ADMIN_LOOKUPFLW(src)] was disabled by [ADMIN_LOOKUPFLW(usr)] in [ADMIN_VERBOSEJMP(src)]")
				log_game("Safety lock of [src] was disabled by [key_name(usr)] in [AREACOORD(src)]")
				bot_reset()
			else if(!hacked)
				to_chat(usr, span_boldannounce("[text_dehack_fail]"))
			else
				emagged = FALSE
				hacked = FALSE
				to_chat(usr, span_notice("[text_dehack]"))
				log_game("Safety lock of [src] was re-enabled by [key_name(usr)] in [AREACOORD(src)]")
				bot_reset()
		if("eject_pai")
			if(locked && !(issilicon(usr) || isAdminGhostAI(usr)))
				return
			if(paicard)
				to_chat(usr, span_notice("You eject [paicard] from [bot_name]."))
				ejectpai(usr)
	return

/mob/living/simple_animal/bot/update_icon_state()
	icon_state = "[initial(icon_state)][on]"
	return ..()

// Machinery to simplify topic and access calls
/obj/machinery/bot_core
	use_power = NO_POWER_USE
	anchored = FALSE

/obj/machinery/bot_core/Initialize(mapload)
	. = ..()
	if(!isbot(loc))
		return INITIALIZE_HINT_QDEL

/mob/living/simple_animal/bot/proc/topic_denied(mob/user) //Access check proc for bot topics! Remember to place in a bot's individual Topic if desired.
	if(!user.canUseTopic(src, !issilicon(user)))
		return TRUE
	// 0 for access, 1 for denied.
	if(emagged) //An emagged bot cannot be controlled by humans, silicons can if one hacked it.
		if(!hacked) //Manually emagged by a human - access denied to all.
			return TRUE
		else if(!issilicon(user) && !isAdminGhostAI(user)) //Bot is hacked, so only silicons and admins are allowed access.
			return TRUE
	return FALSE

/mob/living/simple_animal/bot/proc/insertpai(mob/user, obj/item/paicard/card)
	if(paicard)
		to_chat(user, span_warning("A [paicard] is already inserted!"))
	else if(allow_pai && !key)
		if(!locked && !open)
			if(card.pai && card.pai.mind)
				if(!user.transferItemToLoc(card, src))
					return
				paicard = card
				user.visible_message(span_notice("[user] inserts [card] into [src]!"), span_notice("You insert [card] into [src]."))
				paicard.pai.mind.transfer_to(src)
				to_chat(src, span_notice("You sense your form change as you are uploaded into [src]."))
				bot_name = name
				name = paicard.pai.name
				faction = user.faction.Copy()
				log_combat(user, paicard.pai, "uploaded to [bot_name],")
				return TRUE
			else
				to_chat(user, span_warning("[card] is inactive."))
		else
			to_chat(user, span_warning("The personality slot is locked."))
	else
		to_chat(user, span_warning("[src] is not compatible with [card]!"))

/mob/living/simple_animal/bot/proc/ejectpai(mob/user = null, announce = 1)
	if(paicard)
		if(mind && paicard.pai)
			mind.transfer_to(paicard.pai)
		else if(paicard.pai)
			paicard.pai.key = key
		else
			ghostize(0) // The pAI card that just got ejected was dead.
		key = null
		paicard.forceMove(loc)
		if(user)
			log_combat(user, paicard.pai, "ejected from [src.bot_name],")
		else
			log_combat(src, paicard.pai, "ejected")
		if(announce)
			to_chat(paicard.pai, span_notice("You feel your control fade as [paicard] ejects from [bot_name]."))
		paicard = null
		name = bot_name
		faction = initial(faction)

/mob/living/simple_animal/bot/proc/ejectpairemote(mob/user)
	if(bot_core.allowed(user) && paicard)
		speak("Ejecting personality chip.", radio_channel)
		ejectpai(user)

/mob/living/simple_animal/bot/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	// If we have any bonus player accesses, add them to our internal ID card.
	if(length(player_access))
		access_card.add_access(player_access)
	diag_hud_set_botmode()

/mob/living/simple_animal/bot/Logout()
	. = ..()
	bot_reset()

/mob/living/simple_animal/bot/revive(full_heal = FALSE, admin_revive = FALSE)
	if(..())
		update_appearance()
		. = TRUE

/mob/living/simple_animal/bot/ghost()
	if(stat != DEAD) // Only ghost if we're doing this while alive, the pAI probably isn't dead yet.
		..()
	if(paicard && (!client || stat == DEAD))
		ejectpai(0)

/mob/living/simple_animal/bot/sentience_act()
	faction -= "silicon"

/mob/living/simple_animal/bot/proc/set_path(list/newpath)
	path = newpath ? newpath : list()
	if(!path_hud)
		return
	var/list/path_huds_watching_me = list(GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED])
	if(path_hud)
		path_huds_watching_me += path_hud
	for(var/V in path_huds_watching_me)
		var/datum/atom_hud/H = V
		H.remove_from_hud(src)

	var/list/path_images = hud_list[DIAG_PATH_HUD]
	QDEL_LIST(path_images)
	if(newpath)
		for(var/i in 1 to newpath.len)
			var/turf/T = newpath[i]
			if(T == loc) //don't bother putting an image if it's where we already exist.
				continue
			var/direction = NORTH
			if(i > 1)
				var/turf/prevT = path[i - 1]
				var/image/prevI = path[prevT]
				direction = get_dir(prevT, T)
				if(i > 2)
					var/turf/prevprevT = path[i - 2]
					var/prevDir = get_dir(prevprevT, prevT)
					var/mixDir = direction|prevDir
					if(ISDIAGONALDIR(mixDir))
						prevI.dir = mixDir
						if(prevDir & (NORTH|SOUTH))
							var/matrix/ntransform = matrix()
							ntransform.Turn(90)
							if((mixDir == NORTHWEST) || (mixDir == SOUTHEAST))
								ntransform.Scale(-1, 1)
							else
								ntransform.Scale(1, -1)
							prevI.transform = ntransform
			var/mutable_appearance/MA = new /mutable_appearance()
			MA.icon = path_image_icon
			MA.icon_state = path_image_icon_state
			MA.layer = ABOVE_OPEN_TURF_LAYER
			MA.plane = 0
			MA.appearance_flags = RESET_COLOR|RESET_TRANSFORM
			MA.color = path_image_color
			MA.dir = direction
			var/image/I = image(loc = T)
			I.appearance = MA
			path[T] = I
			path_images += I

	for(var/V in path_huds_watching_me)
		var/datum/atom_hud/H = V
		H.add_to_hud(src)


/mob/living/simple_animal/bot/proc/increment_path()
	if(!length(path))
		return
	var/image/I = path[path[1]]
	if(I)
		I.icon_state = null
	path.Cut(1, 2)

	if(!length(path))
		set_path(null)

/mob/living/simple_animal/bot/rust_heretic_act()
	adjustBruteLoss(400)
