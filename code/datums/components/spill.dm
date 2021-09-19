// This component is for forcing strange things into your pocket that fall out if you fall down
// Yes this exists purely for the spaghetti meme

/datum/component/spill
	can_transfer = TRUE
	var/preexisting_slot_flags

	var/list/droptext
	var/list/dropsound
	var/drop_memory

// droptext is an arglist for visible_message
// dropsound is a list of potential sounds that gets picked from
/datum/component/spill/Initialize(list/_droptext, list/_dropsound, _drop_memory)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	if(_droptext && !islist(_droptext))
		_droptext = list(_droptext)
	droptext = _droptext

	if(_dropsound && !islist(_dropsound))
		_dropsound = list(_dropsound)

	dropsound = _dropsound
	drop_memory = _drop_memory

/datum/component/spill/PostTransfer()
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/spill/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/equip_react)
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, .proc/drop_react)
	var/obj/item/master = parent
	preexisting_slot_flags = master.slot_flags
	master.slot_flags |= ITEM_SLOT_POCKETS

/datum/component/spill/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
	var/obj/item/master = parent
	if(!(preexisting_slot_flags & ITEM_SLOT_POCKETS))
		master.slot_flags &= ~ITEM_SLOT_POCKETS

/datum/component/spill/proc/equip_react(obj/item/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(slot == ITEM_SLOT_LPOCKET || slot == ITEM_SLOT_RPOCKET)
		RegisterSignal(equipper, COMSIG_LIVING_STATUS_KNOCKDOWN, .proc/knockdown_react, TRUE)
	else
		UnregisterSignal(equipper, COMSIG_LIVING_STATUS_KNOCKDOWN)

/datum/component/spill/proc/drop_react(obj/item/source, mob/dropper)
	SIGNAL_HANDLER

	UnregisterSignal(dropper, COMSIG_LIVING_STATUS_KNOCKDOWN)

/datum/component/spill/proc/knockdown_react(mob/living/fool, amount)
	SIGNAL_HANDLER

	if(amount <= 0)
		return

	var/obj/item/master = parent
	fool.dropItemToGround(master)
	if(droptext)
		fool.visible_message(arglist(droptext))
	if(dropsound)
		playsound(master, pick(dropsound), 30)
	if(drop_memory)
		fool.mind?.add_memory(MEMORY_SPAGHETTI_SPILL, list(DETAIL_PROTAGONIST = fool), story_value = STORY_VALUE_OKAY)
