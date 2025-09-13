/// Catification smite
/// Allows an admin to spawn a cat meteor at a target's location and instantly hit them with it.
/datum/smite/catify
	name = "Cateorize"

/datum/smite/catify/effect(client/user, mob/living/target)
	. = ..()
	var/obj/effect/meteor/cateor/new_cateor = new /obj/effect/meteor/cateor(get_turf(target), NONE)
	new_cateor.Bump(target)
