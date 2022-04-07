///Never loses power
/obj/machinery/prisongate/permabrig/power_change()
	return

///Allows anyone with an ID to traverse through
/obj/machinery/prisongate/permabrig/CanAllowThrough(atom/movable/gate_toucher, border_dir)
	. = ..()
	if(!iscarbon(gate_toucher))
		return FALSE
	var/mob/living/carbon/the_toucher = gate_toucher
	for(var/obj/item/card/id/regular_id in the_toucher.get_all_contents())
		return TRUE
	return FALSE
