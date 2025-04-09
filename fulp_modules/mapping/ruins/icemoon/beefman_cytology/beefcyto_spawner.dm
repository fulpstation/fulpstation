// - MAP TEMPLATE DATUM - //
/datum/map_template/ruin/icemoon/underground/fulp/cyto
	name = "Beefman Research Outpost"
	id = "beef cyto"
	description = "A remote research outpost."
	suffix = "beef_cytology.dmm"


// - GHOST ROLE COMPONENT DATUM(S) - //

/// A subtype of the stationstuck component that's primarily intended for use in one ghost role.
/// Turns its (presumably '/mob/living') owner into a slab of meat if they leave the z-level the
/// component is attatched on.
/datum/component/stationstuck/beef_cyto
	punishment = MEATIFICATION

// Copied over from "/datum/smite/objectify/effect()"
// in 'code\modules\admin\smites\become_object.dm'
/datum/component/stationstuck/beef_cyto/punish()
	if(punishment != MEATIFICATION)
		return ..()

	var/mob/living/future_meat = parent
	if(message)
		to_chat(future_meat, span_userdanger("[message]"))

	var/atom/transform_path = /obj/item/food/meat/slab
	var/mutable_appearance/meatified_player = mutable_appearance(initial(transform_path.icon), initial(transform_path.icon_state))
	meatified_player.pixel_x = initial(transform_path.pixel_x)
	meatified_player.pixel_y = initial(transform_path.pixel_y)
	var/mutable_appearance/transform_scanline = mutable_appearance('icons/effects/effects.dmi', "transform_effect")

	var/turf/future_meat_turf = get_turf(future_meat)
	message_admins("[future_meat.real_name] ([future_meat.ckey]) has been turned into meat near [ADMIN_VERBOSEJMP(future_meat_turf)] for attempting to move to a different z_level.")

	future_meat.transformation_animation(meatified_player, 5 SECONDS, transform_scanline.appearance)
	future_meat.Immobilize(5 SECONDS, ignore_canstun = TRUE)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(objectify), future_meat, transform_path), 5 SECONDS)


// - GHOST ROLE SPAWNERS - //
/obj/effect/mob_spawn/ghost_role/human/beefman
	name = "Beefman Cytology Researcher"
	desc = "A cryogenics pod, storing meat for future consumption."
	prompt_name = "a beefman cytologist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/beefman
	you_are_text = "You are a cytological researcher in a remote scientific outpost."
	flavour_text = "You and your fellow researcher are studying cellular biology to better understand the origins of your species. \
	Sample the subjects provided and the surrounding area for testing."
	important_text = "This is meant as a way to learn how to play Cytology! \
		Don't leave the lab's z-level: you'll turn into a slab of meat!"
	outfit = /datum/outfit/russian_beefman
	spawner_job_path = /datum/job/fulp_cytology

// (Implementation of the stationstuck component has been copied over from
// 'fulp_modules\mapping\ruins\space\syndicate_engineer\syndicate_engineer.dm')
/obj/effect/mob_spawn/ghost_role/human/beefman/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.fully_replace_character_name(null, random_unique_beefman_name())
	to_chat(spawned_human, span_warning("You have been implanted with a meatification implant that \
		will activate if you go to any level of the Icemoon except the one you are currently \
		on. Glory to the USSP."))
	spawned_human.AddComponent(/datum/component/stationstuck/beef_cyto, MEATIFICATION, "You have \
		strayed too far from the cytology lab. Your meatification implant has been triggered; \
		you may use the ghost command to leave your body if desired.")


// - JOB DATUMS - //
/datum/job/fulp_cytology
	title = ROLE_BEEFMAN_CYTOLOGY


// - OUTFIT DATUMS - //
/datum/outfit/russian_beefman
	name = "Russian Beefman"
	uniform = /obj/item/clothing/under/bodysash/russia
	shoes = /obj/item/clothing/shoes/winterboots
	back = /obj/item/storage/backpack
	box = /obj/item/storage/box/survival
