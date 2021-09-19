
/datum/ai_controller/haunted
	movement_delay = 0.4 SECONDS
	blackboard = list(BB_TO_HAUNT_LIST = list(),
	BB_HAUNT_TARGET,
	BB_HAUNTED_THROW_ATTEMPT_COUNT)
	planning_subtrees = list(/datum/ai_planning_subtree/haunted)

/datum/ai_controller/haunted/TryPossessPawn(atom/new_pawn)
	if(!isitem(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE
	RegisterSignal(new_pawn, COMSIG_ITEM_EQUIPPED, .proc/on_equip)
	return ..() //Run parent at end

/datum/ai_controller/haunted/UnpossessPawn()
	UnregisterSignal(pawn, COMSIG_ITEM_EQUIPPED)
	return ..() //Run parent at end

/datum/ai_controller/haunted/PerformIdleBehavior(delta_time)
	var/obj/item/item_pawn = pawn
	if(ismob(item_pawn.loc)) //Being held. dont teleport
		return
	if(DT_PROB(HAUNTED_ITEM_TELEPORT_CHANCE, delta_time))
		playsound(item_pawn.loc, 'sound/items/haunted/ghostitemattack.ogg', 100, TRUE)
		do_teleport(pawn, get_turf(pawn), 4, channel = TELEPORT_CHANNEL_MAGIC)

///Signal response for when the item is picked up; stops listening for follow up equips, just waits for a drop.
/datum/ai_controller/haunted/proc/on_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	UnregisterSignal(pawn, COMSIG_ITEM_EQUIPPED)
	var/list/hauntee_list = blackboard[BB_TO_HAUNT_LIST]
	hauntee_list[equipper] = hauntee_list[equipper] + HAUNTED_ITEM_AGGRO_ADDITION //You have now become one of the victims of the HAAAAUNTTIIIINNGGG OOOOOO~~~
	RegisterSignal(pawn, COMSIG_ITEM_DROPPED, .proc/on_dropped)
	SIGNAL_HANDLER

///Flip it so we listen for equip again but not for drop.
/datum/ai_controller/haunted/proc/on_dropped(datum/source, mob/user)
	SIGNAL_HANDLER
	RegisterSignal(pawn, COMSIG_ITEM_EQUIPPED, .proc/on_equip)
	UnregisterSignal(pawn, COMSIG_ITEM_DROPPED)
