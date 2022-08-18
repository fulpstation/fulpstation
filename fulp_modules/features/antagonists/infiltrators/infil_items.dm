/obj/item/adv_mulligan
	name = "advanced mulligan"
	desc = "A one use autoinjector with a toxin that permanently changes your DNA to the DNA of a previously injected person. Use it on the victim to extract their DNA then inject it into yourself!"
	icon = 'icons/obj/syringe.dmi'
	icon_state = "dnainjector0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	var/used = FALSE ///determines wether the injector is used up or nah
	var/datum/weakref/store  ///the mob currently stored in the injector

/obj/item/adv_mulligan/afterattack(atom/movable/victim, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(user))
		return
	if(used)
		to_chat(user, span_warning("[src] has been already used, you can't activate it again!"))
		return
	if(ishuman(victim))
		var/mob/living/carbon/human/target = victim
		if(user.real_name != target.dna.real_name)
			store = WEAKREF(target)
			to_chat(user, span_notice("You stealthly stab [target.name] with [src]."))
			icon_state = "dnainjector"
		else
			if(store)
				mutate(user)
			else
				to_chat(user, span_notice("You can't stab yourself with [src]!"))

/obj/item/adv_mulligan/attack_self(mob/living/carbon/user)
	mutate(user)

/obj/item/adv_mulligan/proc/mutate(mob/living/carbon/user)
	if(used)
		to_chat(user, span_notice("[src] has been already used, you can't activate it again!"))
		return
	if(!store)
		to_chat(user, span_notice("[src] doesn't have any DNA loaded in it!"))
		return

	if(!do_after(user, 2 SECONDS))
		return

	var/mob/living/carbon/human/stored = store.resolve()

	user.visible_message(span_warning("[user.name] shivers in pain and soon transforms into [stored.dna.real_name]!"), \
		span_notice("You inject yourself with [src] and suddenly become a copy of [stored.dna.real_name]."))

	user.real_name = stored.real_name
	stored.dna.transfer_identity(user, transfer_SE=1)
	user.updateappearance(mutcolor_update=1)
	user.domutcheck()
	used = TRUE

	icon_state = "dnainjector0"
	store = null

/obj/item/adv_mulligan/examine(mob/user)
	. = ..()
	if (used)
		. += "This one is all used up."


/obj/item/infiltrator_radio
	name = "Infiltrator Radio"
	desc = "How is this thing running without a battery?"
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "infiltrator_radio"
	w_class = WEIGHT_CLASS_SMALL
	///has the player claimed all his objectives' rewards?
	var/objectives_complete = FALSE
	///List of objectives we have already checked
	var/list/checked_objectives = list()
	///Pool of rewards
	var/reward_items = list(
		/obj/item/card/emag,
		/obj/item/card/emag/doorjack,
		/obj/item/grenade/syndieminibomb,
		/obj/item/grenade/c4/x4,
		/obj/item/pen/edagger,
		/obj/item/guardiancreator/tech/choose/traitor,
		/obj/item/jammer,
		/obj/item/reagent_containers/hypospray/medipen/stimulants,
		/obj/item/storage/box/syndie_kit/imp_stealth,
	)
	///determines wether the final objective is a dagd or not
	var/dagd = FALSE

/obj/item/infiltrator_radio/Initialize(mapload)
	. = ..()
	add_overlay("infiltrator_radio_overlay")

/obj/item/infiltrator_radio/proc/check_reward_status(mob/living/user)
	for(var/datum/objective/goal in user.mind.get_all_objectives())
		if(goal.check_completion() && !(goal.explanation_text in checked_objectives))
			return goal
	return FALSE

/obj/item/infiltrator_radio/proc/give_reward(mob/living/user)
	var/datum/objective/addobj = check_reward_status(user)
	checked_objectives += addobj.explanation_text
	var/reward = pick(reward_items)
	podspawn(list(
		"target" = get_turf(user),
		"style" = STYLE_SYNDICATE,
		"spawn" = reward,
		))
	log_uplink("[key_name(user)] received \a [reward] through [src].")
	reward_items -= reward //cant get duplicate rewards
	var/list/bitch = user.mind.get_all_objectives()
	if(checked_objectives.len == bitch.len)
		objectives_complete = TRUE
		var/datum/objective/reward_obj
		if(prob(60))
			reward_obj = new /datum/objective/hijack
		else
			reward_obj = new /datum/objective/martyr
			dagd = TRUE
		reward_obj.owner = user.mind
		for(var/datum/antagonist/traitor/infiltrator/antag_datum in user.mind.antag_datums)
			antag_datum.objectives += reward_obj


/obj/item/infiltrator_radio/ui_interact(mob/user, datum/tgui/ui)
	if(!user.mind?.has_antag_datum(/datum/antagonist/traitor/infiltrator))
		to_chat(user, span_warning("The interface is covered with strange unintelligible encrypted symbols."))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InfilRadio", name)
		ui.open()


/obj/item/infiltrator_radio/ui_data(mob/user)
	var/list/data = list()
	data["check"] = check_reward_status(user)
	data["completed"] = objectives_complete
	data["dagd"] = dagd
	return data

/obj/item/infiltrator_radio/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("claim_reward")
			if(check_reward_status(usr))
				give_reward(usr)
	return

/obj/item/gorilla_serum
	name = "Gorilla Serum"
	desc = "Allows one to unleash the beast within."
	icon = 'icons/obj/syringe.dmi'
	icon_state = "dnainjector0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	///the target mob
	var/datum/weakref/target
	var/used = FALSE ///determines wether the injector is used up or nah

/obj/item/gorilla_serum/proc/set_objective(datum/antagonist/traitor/infiltrator/criminal)
	if(!criminal)
		return
	var/datum/objective/gorillize/objective = locate() in criminal.objectives
	if(!objective)
		return
	if(objective.target)
		target = WEAKREF(objective.target.current)

/obj/item/gorilla_serum/afterattack(atom/movable/victim, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(used)
		to_chat(user, span_notice("[src] has been already used, you can't activate it again!"))
		return
	var/datum/antagonist/traitor/infiltrator/criminal = user.mind.has_antag_datum(/datum/antagonist/traitor/infiltrator)
	if(!criminal)
		to_chat(user, span_notice("You don't understand how this injector works."))
		return
	if(!ishuman(victim))
		return
	var/mob/living/carbon/human/man = victim
	if(man != target.resolve())
		to_chat(user, span_notice("The serum is not compatible with this entity."))
		return
	if(!do_after(user, 15 SECONDS))
		return
	var/mob/living/simple_animal/hostile/gorilla/albino/ape
	var/mob/dead/observer/chosen_ghost
	chosen_ghost = man.grab_ghost(TRUE,TRUE)
	if(!chosen_ghost)
		var/list/consenting_candidates = poll_ghost_candidates("Would you like to play as a Syndicate Gorilla?", "Syndicate", ROLE_TRAITOR , 5 SECONDS, POLL_IGNORE_SHADE)
		if(length(consenting_candidates))
			chosen_ghost = pick(consenting_candidates)
	ape = new /mob/living/simple_animal/hostile/gorilla/albino(get_turf(man))
	if(chosen_ghost)
		ape.key = chosen_ghost.key
	man.gib()
	ape.mind?.enslave_mind_to_creator(user)
	used = TRUE
	target = null
	var/datum/objective/gorillize/crime = locate() in criminal.objectives
	if(!crime)
		return
	crime.completed = TRUE

/obj/item/card/emag/silicon_hack
	name = "single-use silicon cryptographic sequencer"
	desc = "A specialized cryptographic sequencer used to free cyborgs. Will become voided after a one time use."
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "cyborg_hack"
    //whether we have successfully emagged a borg
	var/used = FALSE

/obj/item/card/emag/silicon_hack/proc/use_charge(mob/user)
    used = TRUE
    to_chat(user, span_boldwarning("You use [src], and it interfaces with the cyborg's panel."))

/obj/item/card/emag/silicon_hack/examine(mob/user)
    . = ..()
    . += span_notice("It can only be used on cyborgs.")

/obj/item/card/emag/silicon_hack/can_emag(atom/target, mob/user)
    if(used)
        to_chat(user, span_warning("[src] is used up."))
        return FALSE
    if(!istype(target, /mob/living/silicon/robot))
        to_chat(user, span_warning("[src] is unable to interface with this. It only seems to interface with cyborg panels."))
        return FALSE
    return TRUE

/mob/living/silicon/robot/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(!istype(emag_card, /obj/item/card/emag/silicon_hack))
		return
	if(!opened)
		return
	var/obj/item/card/emag/silicon_hack/hack_card = emag_card
	hack_card.use_charge(user)
	playsound(src, 'sound/machines/beep.ogg', 50, FALSE)

/obj/item/missile_disk
	name = "missile disk"
	desc = "Used to store the coordinates of the station."
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "missiledisk"
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	///Does the disk have the station coordinates?
	var/stored = FALSE

/obj/item/missile_disk/afterattack(atom/movable/victim, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(victim, /obj/machinery/computer/communications))
		return
	if(stored)
		to_chat(user, span_warning("Disk already contains station coordinates."))
		return
	to_chat(user, span_warning("Downloading station coordinates..."))
	if(!do_after(user, 8 SECONDS))
		return
	playsound(src, 'sound/machines/beep.ogg', 50, FALSE)
	to_chat(user, span_warning("Station coordinates successfully downloaded!"))
	stored = TRUE

/obj/item/missilephone
	name = "large handphone"
	desc = "Hello? Is this the police?"
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "missilephone"
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NOBLUDGEON
	///has a disk been inserted into the phone?
	var/disk = FALSE
	///has the phone served its purpose?
	var/used = FALSE

/obj/item/missilephone/attackby(obj/item/missile_disk/terrorism, mob/user)
	if(!terrorism.stored)
		return
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
	to_chat(user, span_warning("Station coordinates uploaded to phone!"))
	disk = TRUE
	qdel(terrorism)
	add_overlay("missilephone_overlay")


/obj/item/missilephone/ui_data(mob/user)
	var/list/data = list()
	data["disk_inserted"] = disk
	data["used"] = used
	data["can_use"] = !used && disk
	return data

/obj/item/missilephone/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("launch_missiles")
			if(!disk)
				return
			used = TRUE
			var/datum/round_event_control/missilegalore/missiles = new
			missiles.runEvent()
			var/datum/antagonist/traitor/infiltrator/terrorist = usr.mind.has_antag_datum(/datum/antagonist/traitor/infiltrator)
			if(!terrorist)
				return
			var/datum/objective/missiles/terrorism = locate() in terrorist.objectives
			if(!terrorism)
				return
			terrorism.completed = TRUE

	return

/obj/item/missilephone/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MissilePhone", name)
		ui.open()

/obj/item/grenade/c4/wormhole
	name = "Wormhole Projector"
	desc = "A device that opens up a portal gateway to our allies."
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	lefthand_file = 'fulp_modules/features/antagonists/infiltrators/icons/wormhole_left.dmi'
	righthand_file = 'fulp_modules/features/antagonists/infiltrators/icons/wormhole_right.dmi'
	icon_state = "wormhole-explosive0"
	inhand_icon_state = "wormhole-explosive"
	boom_sizes = list(0, 0, 0)
	///The place that wiLL be used to summon the wormhole
	var/area/bombing_zone
	///the terrorist in question
	var/datum/weakref/bomber
	///location of wormhole opening
	var/turf/wormhole_spawn

/obj/item/grenade/c4/wormhole/proc/set_bombing_zone()
	for(var/sanity in 1 to 100)
		var/area/selected_area = pick(GLOB.sortedAreas)
		if(!is_station_level(selected_area.z) || !(selected_area.area_flags & VALID_TERRITORY))
			continue
		bombing_zone = selected_area
		break

/obj/item/grenade/c4/wormhole/afterattack(atom/movable/bombed, mob/user, flag)
	if(!isfloorturf(bombed))
		to_chat(user, span_notice("This wormhole projector must be planted on a floor!"))
		return
	if((get_area(target) != bombing_zone) && (get_area(src) != bombing_zone))
		if (!active)
			to_chat(user, span_notice("This isn't the location you're supposed to use this!"))
			return
	bomber = WEAKREF(user)
	wormhole_spawn = bombed
	return ..()


/obj/item/grenade/c4/wormhole/detonate(mob/living/lanced_by)
	if(!bomber)
		return
	var/mob/terrorist = bomber.resolve()
	. = ..()
	var/obj/structure/cyborg_rift/rift = new /obj/structure/cyborg_rift(wormhole_spawn)
	playsound(rift, 'sound/vehicles/rocketlaunch.ogg', 100, TRUE)
	notify_ghosts("An infiltrator has opened a cyborg rift!", source = rift, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Cyborg rift Opened")
	var/datum/antagonist/traitor/infiltrator/infil = terrorist.mind.has_antag_datum(/datum/antagonist/traitor/infiltrator)
	if(!infil)
		return
	var/datum/objective/summon_wormhole/objective = locate() in infil.objectives
	objective.completed = TRUE

/obj/item/grenade/c4/wormhole/Destroy()
	bombing_zone = null
	bomber = null
	wormhole_spawn = null
	return ..()

/obj/structure/cyborg_rift
	name = "cyborg rift"
	desc = "A portal opened up to long-forgotten cyborgs."
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 100, BOMB = 50, BIO = 0, FIRE = 100, ACID = 100)
	max_integrity = 300
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "cyborg_rift"
	anchored = TRUE
	density = FALSE
	plane = MASSIVE_OBJ_PLANE
	///How many cyborgs have we spawned
	var/count_borgs = 0

/obj/structure/cyborg_rift/attack_ghost(mob/user)
	. = ..()
	if(.)
		return
	summon_cyborg(user)
	if(count_borgs == 2)
		qdel(src)

/obj/structure/cyborg_rift/proc/summon_cyborg(mob/user)
	var/cyborg_check = tgui_alert(user, "Become a rogue security cyborg?", "Cyborg Rift", list("Yes", "No"))
	if(cyborg_check != "Yes" || !src || QDELETED(src) || QDELETED(user))
		return FALSE

	var/mob/living/silicon/robot/model/infiltrator/borg = new /mob/living/silicon/robot/model/infiltrator(loc)
	borg.SetEmagged(1)
	borg.set_connected_ai(null)
	borg.laws = new /datum/ai_laws/syndicate_override
	borg.set_zeroth_law("Aid the SELF affilaited infiltrator with his tasks in exacting revenge against Nanotrasen.")
	borg.laws.associate(src)
	borg.key = user.key
	count_borgs++

/mob/living/silicon/robot/model/infiltrator
	set_model = /obj/item/robot_model/security/infiltrator
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "infilsec"

/obj/item/robot_model/security/infiltrator
	name = "Infiltrator Security"
	cyborg_base_icon = "infilsec"


/mob/living/silicon/robot/model/infiltrator/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(istype(emag_card, /obj/item/card/emag/silicon_hack)) //cheeky MF thought YOU WAS CLEVER?
		to_chat(user, span_warning("This sequencer seems to be incompatible with this model of cyborgs!"))
		return
	return ..()
