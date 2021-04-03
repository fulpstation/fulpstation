//3-Way Manifold

/obj/machinery/atmospherics/pipe/manifold
	icon = 'icons/obj/atmospherics/pipes/manifold.dmi'
	icon_state = "manifold-3"

	name = "pipe manifold"
	desc = "A manifold composed of regular pipes."

	dir = SOUTH
	initialize_directions = EAST|NORTH|WEST

	device_type = TRINARY

	construction_type = /obj/item/pipe/trinary
	pipe_state = "manifold"

	///List of cached overlays of the middle part indexed by piping layer
	var/static/list/mutable_appearance/center_cache = list()

/* We use New() instead of Initialize() because these values are used in update_icon()
 * in the mapping subsystem init before Initialize() is called in the atoms subsystem init.
 * This is true for the other manifolds (the 4 ways and the heat exchanges) too.
 */
/obj/machinery/atmospherics/pipe/manifold/New()
	icon_state = ""
	return ..()

/obj/machinery/atmospherics/pipe/manifold/SetInitDirections()
	initialize_directions = ALL_CARDINALS
	initialize_directions &= ~dir

/obj/machinery/atmospherics/pipe/manifold/update_overlays()
	. = ..()
	var/mutable_appearance/center = center_cache["[piping_layer]"]
	if(!center)
		center = mutable_appearance(icon, "manifold_center")
		PIPING_LAYER_DOUBLE_SHIFT(center, piping_layer)
		center_cache["[piping_layer]"] = center
	. += center

	//Add non-broken pieces
	for(var/i in 1 to device_type)
		if(nodes[i])
			. += getpipeimage(icon, "pipe-[piping_layer]", get_dir(src, nodes[i]))
	update_layer()
