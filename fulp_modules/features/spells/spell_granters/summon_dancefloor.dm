/obj/item/book/granter/action/spell/fulp/summon_dancefloor
	granted_action = /datum/action/cooldown/spell/summon_dancefloor
	action_name = "summon dancefloor"
	icon_state ="summon_dancefloor"
	desc = "This book's mildly chromatic surface leaves emphasis on any color surrounding it."
	remarks = list(
		"Most of the letters are flashing in multiple colors...",
		"The book briefly covers the controversial option of not dancing while you cast this...",
		"Disco balls are only a valid substitute for scrying orbs under specific circumstances...",
		"This spell once saved the life of a certain \"Magus DuBois\"...",
		"Legends speak of a disco ball the size of a planet which travels between sectors...",
		"Mages with a history of epileptic seizure are advised to cast this with caution..."
	)

	/// Boolean indicating whether or not the book is currently in the process of recoiling on someone.
	/// Necessary to prevent people from spamming the recoil while actively being recoiled.
	var/recoil_active = FALSE

/obj/item/book/granter/action/spell/fulp/summon_dancefloor/recoil(mob/living/user)
	if(recoil_active)
		return FALSE

	. = ..()
	recoil_active = TRUE
	addtimer(VARSET_CALLBACK(src, recoil_active, FALSE), 6 SECONDS)

	to_chat(user, span_warning("You feel compelled to try out an epic dance move!"))
	user.Immobilize(6 SECONDS)
	playsound(get_turf(user), 'sound/effects/magic/blind.ogg', 37, frequency = -1)
	user.emote("flip")
	user.emote("spin")
	user.emote("snap")
	addtimer(CALLBACK(src, PROC_REF(comedic_premonition), user), 4 SECONDS)

/obj/item/book/granter/action/spell/fulp/summon_dancefloor/proc/comedic_premonition(mob/living/user)
	to_chat(user, span_bolddanger("You might've just broken something..."))
	playsound(get_turf(user), 'sound/effects/wounds/crack1.ogg', 37, frequency = -1)
	addtimer(CALLBACK(src, PROC_REF(dance_injury), user), 2 SECONDS)

/obj/item/book/granter/action/spell/fulp/summon_dancefloor/proc/dance_injury(mob/living/user)
	user.emote("scream")
	user.Paralyze(4 SECONDS)
	user.apply_damage(25, BRUTE, BODY_ZONE_CHEST)


