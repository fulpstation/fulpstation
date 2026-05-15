///Takes a photo of your dead body, for future referencing.
/mob/living/proc/take_death_photo()
	var/static/obj/item/camera/death_camera/camera_used
	if(isnull(camera_used))
		camera_used = new(null) //created in nullspace.
	camera_used.attempt_picture(src, src)

///The camera we use to take photos of people's death, a 3x3 monochrome picture that won't print, but
///sets the user's death photo in after_picture.
/obj/item/camera/death_camera
	picture_size_x = 3
	picture_size_y = 3
	print_monochrome = TRUE
	print_picture_on_snap = FALSE

/obj/item/camera/death_camera/after_picture(mob/living/user, datum/picture/picture)
	. = ..()
	if(!isliving(user))
		return
	user.death_photo = picture
