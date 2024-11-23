// The implant that will give us special sounds
/obj/item/implant/sad_trombone/knockout_bell
	name = "boxing bell implant"

/obj/item/implant/sad_trombone/knockout_bell/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(.)
		RegisterSignal(target, COMSIG_MOB_EMOTED("deathgasp"), PROC_REF(on_deathgasp))
		RegisterSignal(target, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_hit))
		RegisterSignal(target, COMSIG_LIVING_ENTER_STAMCRIT, PROC_REF(on_stamcrit))

/obj/item/implant/sad_trombone/knockout_bell/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(.)
		UnregisterSignal(target, COMSIG_MOB_EMOTED("deathgasp"))
		UnregisterSignal(target, COMSIG_LIVING_UNARMED_ATTACK)

/obj/item/implant/sad_trombone/knockout_bell/on_deathgasp(mob/source)
	playsound(loc, 'fulp_modules/sounds/effects/boxing/Bell.ogg', 70, FALSE)

/obj/item/implant/sad_trombone/knockout_bell/proc/on_hit(mob/source, atom/target)
	SIGNAL_HANDLER
	if(isliving(target))
		playsound(loc, 'fulp_modules/sounds/effects/boxing/Hit_Spring.ogg', 70, FALSE)

/obj/item/implant/sad_trombone/knockout_bell/proc/on_stamcrit(mob/source)
	SIGNAL_HANDLER
	playsound(loc, 'fulp_modules/sounds/effects/boxing/Zoieieieieeep.ogg', 70, FALSE)
