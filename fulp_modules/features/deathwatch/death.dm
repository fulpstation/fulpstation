///Takes a photo of your dead body, for future referencing.
/mob/living/proc/take_death_photo()
	death_photo = take_photo(
		target = src,
		user = src,
		size_x = 3,
		size_y = 3,
		see_ghosts = TRUE,
		monochrome = TRUE,
	) || null
