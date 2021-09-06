
/obj/item/camera/siliconcam
	name = "silicon photo camera"
	var/in_camera_mode = FALSE
	var/list/datum/picture/stored = list()

/obj/item/camera/siliconcam/ai_camera
	name = "AI photo camera"
	flash_enabled = FALSE

/obj/item/camera/siliconcam/proc/toggle_camera_mode(mob/user)
	if(in_camera_mode)
		camera_mode_off(user)
	else
		camera_mode_on(user)

/obj/item/camera/siliconcam/proc/camera_mode_off(mob/user)
	in_camera_mode = FALSE
	to_chat(user, "<span class='infoplain'><B>Camera Mode deactivated</B></span>")

/obj/item/camera/siliconcam/proc/camera_mode_on(mob/user)
	in_camera_mode = TRUE
	to_chat(user, "<span class='infoplain'><B>Camera Mode activated</B></span>")

/obj/item/camera/siliconcam/proc/selectpicture(mob/user)
	var/list/nametemp = list()
	var/find
	if(!stored.len)
		to_chat(usr, "<span class='infoplain'><font color=red><b>No images saved</b></font></span>")
		return
	var/list/temp = list()
	for(var/i in stored)
		var/datum/picture/p = i
		nametemp += p.picture_name
		temp[p.picture_name] = p
	find = input(user, "Select image") in nametemp|null
	if(!find)
		return
	return temp[find]

/obj/item/camera/siliconcam/proc/viewpictures(mob/user)
	var/datum/picture/selection = selectpicture(user)
	if(istype(selection))
		show_picture(user, selection)

/obj/item/camera/siliconcam/ai_camera/after_picture(mob/user, datum/picture/picture, proximity_flag)
	var/number = stored.len
	picture.picture_name = "Image [number] (taken by [loc.name])"
	stored[picture] = TRUE
	to_chat(usr, "<span class='infoplain'>[span_unconscious("Image recorded")]</span>")
