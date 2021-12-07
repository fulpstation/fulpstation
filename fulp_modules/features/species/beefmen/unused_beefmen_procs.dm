/**
 * this file is just to show some of the things I plan on deleting, shouldn't be merged.
 */

/mob/living/carbon/proc/ReassignForeignBodyparts()
	var/all_bodyparts = list(
		BODY_ZONE_HEAD,
		BODY_ZONE_CHEST,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)
	for(var/obj/item/bodypart/current_bodyparts as anything in all_bodyparts)
		var/bodypart_checking = "part_default_[current_bodyparts]"
		if(current_bodyparts != bodypart_checking)
			qdel(current_bodyparts)
			var/obj/item/bodypart/limb = new bodypart_checking
			limb.replace_limb(src, TRUE)
