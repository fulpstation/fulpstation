/// Adds crack overlays to an object when integrity gets low
/datum/element/crackable
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	id_arg_index = 2
	var/list/icon/crack_icons
	/// The level at which the object starts showing cracks, 1 being at full health and 0.5 being at half health
	var/crack_integrity = 1

/datum/element/crackable/Attach(datum/target, icon/crack_icon, list/crack_states, crack_integrity)
	. = ..()
	if(!isobj(target))
		return ELEMENT_INCOMPATIBLE
	src.crack_integrity = crack_integrity || src.crack_integrity
	if(!crack_icons) // This is the first attachment and we need to do first time setup
		crack_icons = list()
		for(var/state in crack_states)
			for(var/i in 1 to 36)
				var/icon/new_crack_icon = icon(crack_icon, state)
				new_crack_icon.Turn(i * 10)
				crack_icons += new_crack_icon
	RegisterSignal(target, COMSIG_OBJ_INTEGRITY_CHANGED, .proc/IntegrityChanged)

/datum/element/crackable/proc/IntegrityChanged(obj/source, old_value, new_value)
	SIGNAL_HANDLER
	if(new_value >= source.max_integrity * crack_integrity)
		return
	source.AddComponent(/datum/component/cracked, crack_icons, crack_integrity)
