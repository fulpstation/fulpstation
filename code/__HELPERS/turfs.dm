///Returns location. Returns null if no location was found.
/proc/get_teleport_loc(turf/location,mob/target,distance = 1, density = FALSE, errorx = 0, errory = 0, eoffsetx = 0, eoffsety = 0)
/*
Location where the teleport begins, target that will teleport, distance to go, density checking 0/1(yes/no).
Random error in tile placement x, error in tile placement y, and block offset.
Block offset tells the proc how to place the box. Behind teleport location, relative to starting location, forward, etc.
Negative values for offset are accepted, think of it in relation to North, -x is west, -y is south. Error defaults to positive.
Turf and target are separate in case you want to teleport some distance from a turf the target is not standing on or something.
*/

	var/dirx = 0//Generic location finding variable.
	var/diry = 0

	var/xoffset = 0//Generic counter for offset location.
	var/yoffset = 0

	var/b1xerror = 0//Generic placing for point A in box. The lower left.
	var/b1yerror = 0
	var/b2xerror = 0//Generic placing for point B in box. The upper right.
	var/b2yerror = 0

	errorx = abs(errorx)//Error should never be negative.
	errory = abs(errory)

	switch(target.dir)//This can be done through equations but switch is the simpler method. And works fast to boot.
	//Directs on what values need modifying.
		if(1)//North
			diry += distance
			yoffset += eoffsety
			xoffset += eoffsetx
			b1xerror -= errorx
			b1yerror -= errory
			b2xerror += errorx
			b2yerror += errory
		if(2)//South
			diry -= distance
			yoffset -= eoffsety
			xoffset += eoffsetx
			b1xerror -= errorx
			b1yerror -= errory
			b2xerror += errorx
			b2yerror += errory
		if(4)//East
			dirx += distance
			yoffset += eoffsetx//Flipped.
			xoffset += eoffsety
			b1xerror -= errory//Flipped.
			b1yerror -= errorx
			b2xerror += errory
			b2yerror += errorx
		if(8)//West
			dirx -= distance
			yoffset -= eoffsetx//Flipped.
			xoffset += eoffsety
			b1xerror -= errory//Flipped.
			b1yerror -= errorx
			b2xerror += errory
			b2yerror += errorx

	var/turf/destination = locate(location.x+dirx,location.y+diry,location.z)

	if(!destination)//If there isn't a destination.
		return

	if(!errorx && !errory)//If errorx or y were not specified.
		if(density&&destination.density)
			return
		if(destination.x>world.maxx || destination.x<1)
			return
		if(destination.y>world.maxy || destination.y<1)
			return

	var/destination_list[] = list()//To add turfs to list.
	//destination_list = new()
	/*This will draw a block around the target turf, given what the error is.
	Specifying the values above will basically draw a different sort of block.
	If the values are the same, it will be a square. If they are different, it will be a rectengle.
	In either case, it will center based on offset. Offset is position from center.
	Offset always calculates in relation to direction faced. In other words, depending on the direction of the teleport,
	the offset should remain positioned in relation to destination.*/

	var/turf/center = locate((destination.x + xoffset), (destination.y + yoffset), location.z)//So now, find the new center.

	//Now to find a box from center location and make that our destination.
	for(var/turf/current_turf in block(locate(center.x + b1xerror, center.y + b1yerror, location.z), locate(center.x + b2xerror, center.y + b2yerror, location.z)))
		if(density && current_turf.density)
			continue//If density was specified.
		if(current_turf.x > world.maxx || current_turf.x < 1)
			continue//Don't want them to teleport off the map.
		if(current_turf.y > world.maxy || current_turf.y < 1)
			continue
		destination_list += current_turf

	if(!destination_list.len)
		return

	destination = pick(destination_list)
	return destination

/**
 * Returns the atom sitting on the turf.
 * For example, using this on a disk, which is in a bag, on a mob, will return the mob because it's on the turf.
 * Optional arg 'type' to stop once it reaches a specific type instead of a turf.
**/
/proc/get_atom_on_turf(atom/movable/atom_on_turf, stop_type)
	var/atom/turf_to_check = atom_on_turf
	while(turf_to_check?.loc && !isturf(turf_to_check.loc))
		turf_to_check = turf_to_check.loc
		if(stop_type && istype(turf_to_check, stop_type))
			break
	return turf_to_check

///Returns a list of all locations (except the area) the movable is within.
/proc/get_nested_locs(atom/movable/atom_on_location, include_turf = FALSE)
	. = list()
	var/atom/location = atom_on_location.loc
	var/turf/turf = get_turf(atom_on_location)
	while(location && location != turf)
		. += location
		location = location.loc
	if(location && include_turf) //At this point, only the turf is left, provided it exists.
		. += location


///Returns the turf located at the map edge in the specified direction relative to target_atom used for mass driver
/proc/get_edge_target_turf(atom/target_atom, direction)
	var/turf/target = locate(target_atom.x, target_atom.y, target_atom.z)
	if(!target_atom || !target)
		return 0
		//since NORTHEAST == NORTH|EAST, etc, doing it this way allows for diagonal mass drivers in the future
		//and isn't really any more complicated

	var/x = target_atom.x
	var/y = target_atom.y
	if(direction & NORTH)
		y = world.maxy
	else if(direction & SOUTH) //you should not have both NORTH and SOUTH in the provided direction
		y = 1
	if(direction & EAST)
		x = world.maxx
	else if(direction & WEST)
		x = 1
	if(ISDIAGONALDIR(direction)) //let's make sure it's accurately-placed for diagonals
		var/lowest_distance_to_map_edge = min(abs(x - target_atom.x), abs(y - target_atom.y))
		return get_ranged_target_turf(target_atom, direction, lowest_distance_to_map_edge)
	return locate(x,y,target_atom.z)

// returns turf relative to target_atom in given direction at set range
// result is bounded to map size
// note range is non-pythagorean
// used for disposal system
/proc/get_ranged_target_turf(atom/target_atom, direction, range)

	var/x = target_atom.x
	var/y = target_atom.y
	if(direction & NORTH)
		y = min(world.maxy, y + range)
	else if(direction & SOUTH)
		y = max(1, y - range)
	if(direction & EAST)
		x = min(world.maxx, x + range)
	else if(direction & WEST) //if you have both EAST and WEST in the provided direction, then you're gonna have issues
		x = max(1, x - range)

	return locate(x,y,target_atom.z)

/**
 * Get ranged target turf, but with direct targets as opposed to directions
 *
 * Starts at atom starting_atom and gets the exact angle between starting_atom and target
 * Moves from starting_atom with that angle, Range amount of times, until it stops, bound to map size
 * Arguments:
 * * starting_atom - Initial Firer / Position
 * * target - Target to aim towards
 * * range - Distance of returned target turf from starting_atom
 * * offset - Angle offset, 180 input would make the returned target turf be in the opposite direction
 */
/proc/get_ranged_target_turf_direct(atom/starting_atom, atom/target, range, offset)
	var/angle = ATAN2(target.x - starting_atom.x, target.y - starting_atom.y)
	if(offset)
		angle += offset
	var/turf/starting_turf = get_turf(starting_atom)
	for(var/i in 1 to range)
		var/turf/check = locate(starting_atom.x + cos(angle) * i, starting_atom.y + sin(angle) * i, starting_atom.z)
		if(!check)
			break
		starting_turf = check

	return starting_turf


/// returns turf relative to target_atom offset in dx and dy tiles, bound to map limits
/proc/get_offset_target_turf(atom/target_atom, dx, dy)
	var/x = min(world.maxx, max(1, target_atom.x + dx))
	var/y = min(world.maxy, max(1, target_atom.y + dy))
	return locate(x, y, target_atom.z)

/**
 * Lets the turf this atom's *ICON* appears to inhabit
 * it takes into account:
 * Pixel_x/y
 * Matrix x/y
 * NOTE: if your atom has non-standard bounds then this proc
 * will handle it, but:
 * if the bounds are even, then there are an even amount of "middle" turfs, the one to the EAST, NORTH, or BOTH is picked
 * this may seem bad, but you're atleast as close to the center of the atom as possible, better than byond's default loc being all the way off)
 * if the bounds are odd, the true middle turf of the atom is returned
**/
/proc/get_turf_pixel(atom/checked_atom)
	if(!istype(checked_atom))
		return

	//Find checked_atom's matrix so we can use it's X/Y pixel shifts
	var/matrix/atom_matrix = matrix(checked_atom.transform)

	var/pixel_x_offset = checked_atom.pixel_x + atom_matrix.get_x_shift()
	var/pixel_y_offset = checked_atom.pixel_y + atom_matrix.get_y_shift()

	//Irregular objects
	var/icon/checked_atom_icon = icon(checked_atom.icon, checked_atom.icon_state)
	var/checked_atom_icon_height = checked_atom_icon.Height()
	var/checked_atom_icon_width = checked_atom_icon.Width()
	if(checked_atom_icon_height != world.icon_size || checked_atom_icon_width != world.icon_size)
		pixel_x_offset += ((checked_atom_icon_width / world.icon_size) - 1) * (world.icon_size * 0.5)
		pixel_y_offset += ((checked_atom_icon_height / world.icon_size) - 1) * (world.icon_size * 0.5)

	//DY and DX
	var/rough_x = round(round(pixel_x_offset, world.icon_size) / world.icon_size)
	var/rough_y = round(round(pixel_y_offset, world.icon_size) / world.icon_size)

	//Find coordinates
	var/turf/atom_turf = get_turf(checked_atom) //use checked_atom's turfs, as it's coords are the same as checked_atom's AND checked_atom's coords are lost if it is inside another atom
	if(!atom_turf)
		return null
	var/final_x = atom_turf.x + rough_x
	var/final_y = atom_turf.y + rough_y

	if(final_x || final_y)
		return locate(final_x, final_y, atom_turf.z)

///Returns a turf based on text inputs, original turf and viewing client
/proc/params_to_turf(scr_loc, turf/origin, client/viewing_client)
	if(!scr_loc)
		return null
	var/tX = splittext(scr_loc, ",")
	var/tY = splittext(tX[2], ":")
	var/tZ = origin.z
	tY = tY[1]
	tX = splittext(tX[1], ":")
	tX = tX[1]
	var/list/actual_view = getviewsize(viewing_client ? viewing_client.view : world.view)
	tX = clamp(origin.x + text2num(tX) - round(actual_view[1] / 2) - 1, 1, world.maxx)
	tY = clamp(origin.y + text2num(tY) - round(actual_view[2] / 2) - 1, 1, world.maxy)
	return locate(tX, tY, tZ)

///Almost identical to the params_to_turf(), but unused (remove?)
/proc/screen_loc_to_turf(text, turf/origin, client/C)
	if(!text)
		return null
	var/tZ = splittext(text, ",")
	var/tX = splittext(tZ[1], "-")
	var/tY = text2num(tX[2])
	tX = splittext(tZ[2], "-")
	tX = text2num(tX[2])
	tZ = origin.z
	var/list/actual_view = getviewsize(C ? C.view : world.view)
	tX = clamp(origin.x + round(actual_view[1] / 2) - tX, 1, world.maxx)
	tY = clamp(origin.y + round(actual_view[2] / 2) - tY, 1, world.maxy)
	return locate(tX, tY, tZ)

///similar function to RANGE_TURFS(), but will search spiralling outwards from the center (like the above, but only turfs)
/proc/spiral_range_turfs(dist = 0, center = usr, orange = FALSE, list/outlist = list(), tick_checked)
	outlist.Cut()
	if(!dist)
		outlist += center
		return outlist

	var/turf/t_center = get_turf(center)
	if(!t_center)
		return outlist

	var/list/turf_list = outlist
	var/turf/checked_turf
	var/y
	var/x
	var/c_dist = 1

	if(!orange)
		turf_list += t_center

	while( c_dist <= dist )
		y = t_center.y + c_dist
		x = t_center.x - c_dist + 1
		for(x in x to t_center.x + c_dist)
			checked_turf = locate(x, y, t_center.z)
			if(checked_turf)
				turf_list += checked_turf

		y = t_center.y + c_dist - 1
		x = t_center.x + c_dist
		for(y in t_center.y - c_dist to y)
			checked_turf = locate(x, y, t_center.z)
			if(checked_turf)
				turf_list += checked_turf

		y = t_center.y - c_dist
		x = t_center.x + c_dist - 1
		for(x in t_center.x - c_dist to x)
			checked_turf = locate(x, y, t_center.z)
			if(checked_turf)
				turf_list += checked_turf

		y = t_center.y - c_dist + 1
		x = t_center.x - c_dist
		for(y in y to t_center.y + c_dist)
			checked_turf = locate(x, y, t_center.z)
			if(checked_turf)
				turf_list += checked_turf
		c_dist++
		if(tick_checked)
			CHECK_TICK

	return turf_list

///Returns a random turf on the station
/proc/get_random_station_turf()
	var/list/turfs = get_area_turfs(pick(GLOB.the_station_areas))
	if (length(turfs))
		return pick(turfs)

///Returns a random turf on the station, excludes dense turfs (like walls) and areas that have valid_territory set to FALSE
/proc/get_safe_random_station_turf(list/areas_to_pick_from = GLOB.the_station_areas)
	for (var/i in 1 to 5)
		var/list/turf_list = get_area_turfs(pick(areas_to_pick_from))
		var/turf/target
		while (turf_list.len && !target)
			var/I = rand(1, turf_list.len)
			var/turf/checked_turf = turf_list[I]
			var/area/turf_area = get_area(checked_turf)
			if(!checked_turf.density && (turf_area.area_flags & VALID_TERRITORY))
				var/clear = TRUE
				for(var/obj/checked_object in checked_turf)
					if(checked_object.density)
						clear = FALSE
						break
				if(clear)
					target = checked_turf
			if (!target)
				turf_list.Cut(I, I + 1)
		if (target)
			return target

/**
 * Checks whether the target turf is in a valid state to accept a directional window
 * or other directional pseudo-dense object such as railings.
 *
 * Returns FALSE if the target turf cannot accept a directional window or railing.
 * Returns TRUE otherwise.
 *
 * Arguments:
 * * dest_turf - The destination turf to check for existing windows and railings
 * * test_dir - The prospective dir of some atom you'd like to put on this turf.
 * * is_fulltile - Whether the thing you're attempting to move to this turf takes up the entire tile or whether it supports multiple movable atoms on its tile.
 */
/proc/valid_window_location(turf/dest_turf, test_dir, is_fulltile = FALSE)
	if(!dest_turf)
		return FALSE
	for(var/obj/turf_content in dest_turf)
		if(istype(turf_content, /obj/machinery/door/window))
			if((turf_content.dir == test_dir) || is_fulltile)
				return FALSE
		if(istype(turf_content, /obj/structure/windoor_assembly))
			var/obj/structure/windoor_assembly/windoor_assembly = turf_content
			if(windoor_assembly.dir == test_dir || is_fulltile)
				return FALSE
		if(istype(turf_content, /obj/structure/window))
			var/obj/structure/window/window_structure = turf_content
			if(window_structure.dir == test_dir || window_structure.fulltile || is_fulltile)
				return FALSE
		if(istype(turf_content, /obj/structure/railing))
			var/obj/structure/railing/rail = turf_content
			if(rail.dir == test_dir || is_fulltile)
				return FALSE
	return TRUE
