////////////////////////
//// PORTED HELPERS ////
////////////////////////

/proc/hsv(hue, sat, val, alpha)
	if(hue < 0 || hue >= 1536)
		hue %= 1536
	if(hue < 0)
		hue += 1536
	if((hue & 0xFF) == 0xFF)
		++hue
		if(hue >= 1536)
			hue = 0
	if(sat < 0)
		sat = 0
	if(sat > 255)
		sat = 255
	if(val < 0)
		val = 0
	if(val > 255)
		val = 255
	. = "#"
	. += TO_HEX_DIGIT(hue >> 8)
	. += TO_HEX_DIGIT(hue >> 4)
	. += TO_HEX_DIGIT(hue)
	. += TO_HEX_DIGIT(sat >> 4)
	. += TO_HEX_DIGIT(sat)
	. += TO_HEX_DIGIT(val >> 4)
	. += TO_HEX_DIGIT(val)
	if(!isnull(alpha))
		if(alpha < 0)
			alpha = 0
		if(alpha > 255)
			alpha = 255
		. += TO_HEX_DIGIT(alpha >> 4)
		. += TO_HEX_DIGIT(alpha)

/proc/ReadHSV(hsv)
	if(!hsv)
		return

	// interpret the HSV or HSVA value
	var/i=1,start=1
	if(text2ascii(hsv) == 35)
		++start // skip opening #
	var/ch,which=0,hue=0,sat=0,val=0,alpha=0,usealpha
	var/digits=0
	for(i=start, i <= length(hsv), ++i)
		ch = text2ascii(hsv, i)
		if(ch < 48 || (ch > 57 && ch < 65) || (ch > 70 && ch < 97) || ch > 102)
			break
		++digits
		if(digits == 9)
			break
	if(digits > 7)
		usealpha = 1
	if(digits <= 4)
		++which
	if(digits <= 2)
		++which
	for(i=start, digits>0, ++i)
		ch = text2ascii(hsv, i)
		if(ch >= 48 && ch <= 57)
			ch -= 48
		else if(ch >= 65 && ch <= 70)
			ch -= 55
		else if(ch >= 97 && ch <= 102)
			ch -= 87
		else
			break
		--digits
		switch(which)
			if(0)
				hue = (hue << 4) | ch
				if(digits == (usealpha ? 6 : 4))
					++which
			if(1)
				sat = (sat << 4) | ch
				if(digits == (usealpha ? 4 : 2))
					++which
			if(2)
				val = (val << 4) | ch
				if(digits == (usealpha ? 2 : 0))
					++which
			if(3)
				alpha = (alpha << 4) | ch

	. = list(hue, sat, val)
	if(usealpha)
		. += alpha

/proc/ReadRGB(rgb)
	if(!rgb)
		return

	// interpret the HSV or HSVA value
	var/i=1,start=1
	if(text2ascii(rgb) == 35) ++start // skip opening #
	var/ch,which=0,r=0,g=0,b=0,alpha=0,usealpha
	var/digits=0
	for(i=start, i <= length(rgb), ++i)
		ch = text2ascii(rgb, i)
		if(ch < 48 || (ch > 57 && ch < 65) || (ch > 70 && ch < 97) || ch > 102)
			break
		++digits
		if(digits == 8)
			break

	var/single = digits < 6
	if(digits != 3 && digits != 4 && digits != 6 && digits != 8)
		return
	if(digits == 4 || digits == 8)
		usealpha = 1
	for(i=start, digits>0, ++i)
		ch = text2ascii(rgb, i)
		if(ch >= 48 && ch <= 57)
			ch -= 48
		else if(ch >= 65 && ch <= 70)
			ch -= 55
		else if(ch >= 97 && ch <= 102)
			ch -= 87
		else
			break
		--digits
		switch(which)
			if(0)
				r = (r << 4) | ch
				if(single)
					r |= r << 4
					++which
				else if(!(digits & 1))
					++which
			if(1)
				g = (g << 4) | ch
				if(single)
					g |= g << 4
					++which
				else if(!(digits & 1))
					++which
			if(2)
				b = (b << 4) | ch
				if(single)
					b |= b << 4
					++which
				else if(!(digits & 1))
					++which
			if(3)
				alpha = (alpha << 4) | ch
				if(single)
					alpha |= alpha << 4

	. = list(r, g, b)
	if(usealpha)
		. += alpha

/proc/RGBtoHSV(rgb)
	if(!rgb)
		return "#0000000"
	var/list/RGB = ReadRGB(rgb)
	if(!RGB)
		return "#0000000"

	var/r = RGB[1]
	var/g = RGB[2]
	var/b = RGB[3]
	var/hi = max(r,g,b)
	var/lo = min(r,g,b)

	var/val = hi
	var/sat = hi ? round((hi-lo) * 255 / hi, 1) : 0
	var/hue = 0

	if(sat)
		var/dir
		var/mid
		if(hi == r)
			if(lo == b) {hue=0; dir=1; mid=g}
			else {hue=1535; dir=-1; mid=b}
		else if(hi == g)
			if(lo == r) {hue=512; dir=1; mid=b}
			else {hue=511; dir=-1; mid=r}
		else if(hi == b)
			if(lo == g) {hue=1024; dir=1; mid=r}
			else {hue=1023; dir=-1; mid=g}
		hue += dir * round((mid-lo) * 255 / (hi-lo), 1)

	return hsv(hue, sat, val, (RGB.len>3 ? RGB[4] : null))

/proc/HSVtoRGB(hsv)
	if(!hsv)
		return "#000000"
	var/list/HSV = ReadHSV(hsv)
	if(!HSV)
		return "#000000"

	var/hue = HSV[1]
	var/sat = HSV[2]
	var/val = HSV[3]

	// Compress hue into easier-to-manage range
	hue -= hue >> 8
	if(hue >= 0x5fa)
		hue -= 0x5fa

	var/hi,mid,lo,r,g,b
	hi = val
	lo = round((255 - sat) * val / 255, 1)
	mid = lo + round(abs(round(hue, 510) - hue) * (hi - lo) / 255, 1)
	if(hue >= 765)
		if(hue >= 1275) {r=hi;  g=lo;  b=mid}
		else if(hue >= 1020) {r=mid; g=lo;  b=hi }
		else {r=lo;  g=mid; b=hi }
	else
		if(hue >= 510) {r=lo;  g=hi;  b=mid}
		else if(hue >= 255) {r=mid; g=hi;  b=lo }
		else {r=hi;  g=mid; b=lo }

	return (HSV.len > 3) ? rgb(r,g,b,HSV[4]) : rgb(r,g,b)

//////////////////////////
//// ACTUAL COMPONENT ////
//////////////////////////

/datum/component/after_image
	dupe_mode =	 COMPONENT_DUPE_UNIQUE_PASSARGS
	var/rest_time
	var/list/obj/effect/after_image/after_images
	//cycles colors
	var/color_cycle = FALSE
	var/list/hsv

/datum/component/after_image/Initialize(count = 4, rest_time = 1, color_cycle = FALSE)
	..()
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	src.rest_time = rest_time
	src.after_images = list()
	src.color_cycle = color_cycle
	if(count > 1)
		for(var/number = 1 to count)
			var/obj/effect/after_image/added_image = new /obj/effect/after_image(null)
			added_image.finalized_alpha = 200 - 100 * (number - 1) / (count - 1)
			after_images += added_image
	else
		var/obj/effect/after_image/added_image = new /obj/effect/after_image(null)
		added_image.finalized_alpha = 100
		after_images |= added_image

	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(move))
	RegisterSignal(parent, COMSIG_ATOM_DIR_CHANGE, PROC_REF(change_dir))
	RegisterSignal(parent, COMSIG_MOVABLE_THROW_LANDED, PROC_REF(throw_landed))

/datum/component/after_image/RegisterWithParent()
	for(var/obj/effect/after_image/listed_image in src.after_images)
		listed_image.active = TRUE
	src.sync_after_images()

/datum/component/after_image/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_DIR_CHANGE, COMSIG_MOVABLE_THROW_LANDED))
	for(var/obj/effect/after_image/listed_image in src.after_images)
		listed_image.active = FALSE
		qdel(listed_image)
	. = ..()

/datum/component/after_image/Destroy()
	if(length(src.after_images))
		for(var/obj/effect/after_image/listed_image in src.after_images)
			qdel(listed_image)
		src.after_images.Cut()
		src.after_images = null
	. = ..()

/datum/component/after_image/proc/change_dir(atom/movable/AM, new_dir, old_dir)
	src.sync_after_images(new_dir)

/datum/component/after_image/proc/set_loc(atom/movable/AM, atom/last_loc)
	return src.move(AM, last_loc, AM.dir)

/datum/component/after_image/proc/move(atom/movable/AM, turf/last_turf, direct)
	src.sync_after_images()

/datum/component/after_image/proc/throw_landed(atom/movable/AM, datum/thrownthing/thing)
	src.sync_after_images() // necessary to fix pixel_x and pixel_y

/datum/component/after_image/proc/sync_after_images(dir_override=null)
	set waitfor = FALSE

	var/obj/effect/after_image/targeted_image = new(null)
	targeted_image.active = TRUE
	targeted_image.sync_with_parent(parent)
	targeted_image.loc = null

	if(color_cycle)
		if(!hsv)
			hsv = RGBtoHSV(rgb(255, 0, 0))
		hsv = RotateHue(hsv, world.time - rest_time * 15)
		targeted_image.color = HSVtoRGB(hsv)

	if(!isnull(dir_override))
		targeted_image.setDir(dir_override)

	var/atom/movable/parent_am = parent
	var/atom/target_loc = parent_am.loc
	for(var/obj/effect/after_image/listed_image in src.after_images)
		sleep(rest_time)
		listed_image.sync_with_parent(targeted_image, target_loc)
	qdel(targeted_image)

/obj/effect/after_image
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE
	var/finalized_alpha = 100
	var/active = FALSE
	var/last_appearance_ref

/obj/effect/after_image/New(_loc, min_x = -3, max_x = 3, min_y = -3, max_y = 3, time_a = 0.5 SECONDS, time_b = 3 SECONDS, finalized_alpha = 100)
	. = ..()
	src.finalized_alpha = finalized_alpha
	animate(src, pixel_x = 0, time = 1, loop = -1)
	var/count = rand(5, 10)
	for(var/number = 1 to count)
		var/time = time_a + rand() * time_b
		var/pixel_x = number == count ? 0 : rand(min_x, max_y)
		var/pixel_y = number == count ? 0 : rand(min_y, max_y)
		animate(time = time, easing = pick(LINEAR_EASING, SINE_EASING, CIRCULAR_EASING, CUBIC_EASING), pixel_x = pixel_x, pixel_y = pixel_y, loop = -1)

/obj/effect/after_image/Destroy()
	last_appearance_ref = null
	active = FALSE
	return ..()

/obj/effect/after_image/proc/sync_with_parent(atom/movable/parent, loc_override = null, actual_loc = TRUE, dir_override = null)
	if(!active)
		return
	set_glide_size(parent.glide_size)
	var/parent_appearance_ref = ref(parent.appearance)
	if(last_appearance_ref != parent_appearance_ref)
		last_appearance_ref = parent_appearance_ref
		appearance = copy_appearance_filter_overlays(parent.appearance)
		name = ""
		mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		transform = matrix()
		alpha = (alpha / 255.0) * finalized_alpha
		SET_PLANE_EXPLICIT(src, initial(parent.plane), parent)
	var/atom/target_loc = loc_override ? loc_override : parent.loc
	if(target_loc != loc && actual_loc)
		loc = target_loc
	var/target_dir = isnull(dir_override) ? parent.dir : dir_override
	if(dir != target_dir)//this is kinda important since otherwise it gets marked as demo dirty which is annoying
		setDir(target_dir)
