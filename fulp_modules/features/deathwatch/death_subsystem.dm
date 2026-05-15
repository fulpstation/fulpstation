SUBSYSTEM_DEF(death_photos)
	name = "Death Photos"
	can_fire = FALSE
	///The camera we use to take photos of dead people with.
	var/obj/item/camera/death_camera/death_camera
	var/list/mob/living/mobs_to_photograph = list()

/datum/controller/subsystem/death_photos/Initialize()
	death_camera = new(null) //created in nullspace.
	return SS_INIT_SUCCESS

/datum/controller/subsystem/death_photos/Recover()
	if(!isnull(death_camera))
		QDEL_NULL(death_camera)
	death_camera = new(null)
	mobs_to_photograph = SSdeath_photos.mobs_to_photograph
	if(length(mobs_to_photograph))
		can_fire = TRUE

/datum/controller/subsystem/death_photos/fire(resumed)
	if(death_camera.blending) //If we're still making a photo, we'll pass for now and come back later.
		return
	while(length(mobs_to_photograph))
		var/mob/living/photo_taking = mobs_to_photograph[length(mobs_to_photograph)]
		death_camera.attempt_picture(photo_taking, photo_taking)
		mobs_to_photograph.len--
		return
	//we went through everyone
	can_fire = FALSE

/datum/controller/subsystem/death_photos/proc/take_death_photo(mob/living/dead)
	if(QDELETED(dead) || (!iscarbon(dead) && !is_station_level(dead.z)))
		return
	mobs_to_photograph |= dead
	can_fire = TRUE


///The camera we use to take photos of people's death, a 3x3 monochrome picture that won't print, but
///sets the user's death photo in after_picture.
/obj/item/camera/death_camera
	picture_size_x = 3
	picture_size_y = 3
	print_monochrome = TRUE
	cooldown = 0
	//we don't actually print pictures but idk i dont have any reason for this.
	pictures_max = 100
	pictures_left = 100
	print_picture_on_snap = FALSE

/obj/item/camera/death_camera/after_picture(mob/living/user, datum/picture/picture)
	. = ..()
	user.death_photo = picture
