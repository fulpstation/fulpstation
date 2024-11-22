/datum/uplink_item/role_restricted/velvetfu
	name = "Velvet-Fu VHS tape"
	desc = "Velvet-Fu is a knock-off Hollywood Martial Art.\n\
			Has a notice, 'Removes the ability to Grab/Push'.\n\
			Has been modified to beam its knowledge directly into your eyes, removing the need for a TV."
	item = /obj/item/book/granter/martial/velvetfu
	cost = 8
	restricted_roles = list(JOB_JANITOR)

/obj/item/book/granter/martial/velvetfu
	martial = /datum/martial_art/velvetfu
	name = "Hollywood VHS tape"
	martial_name = "velvet-fu"
	uses = 1
	desc = "A VHS tape labelled 'Grand-Master's Course'. This seems modified, causing it to beam the content straight into your eyes."
	icon = 'fulp_modules/icons/lisa/casette.dmi'
	icon_state = "velvet"
	greet = "You've finished watching the Velvet-Fu VHS tape."
	remarks = list(
		"Smooth as Velvet...",
		"Show me your stance!",
		"Left Jab!",
		"Right Jab!",
		"Kick, kick!",
		"Ah, so fast...",
		"Now forget the basics!",
		"...But remember the style!",
	)

/obj/item/book/granter/martial/velvetfu/on_reading_finished(mob/living/carbon/user)
	. = ..()
	if(uses <= 0)
		desc = "A VHS tape labelled 'Grand-Master's Course'. The film seems ripped out, and can't be put back in."
		name = "Broken VHS tape"
		icon_state = "velvet_used"
