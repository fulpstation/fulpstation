/obj/item/reagent_containers/blood/attack(mob/M, mob/user, def_zone)
	if(user.a_intent == INTENT_HELP && reagents.total_volume > 0)
		if (user != M)
			user.visible_message("<span class='userdanger'>[user] forces [M] to drink from the [src].</span>", \
							  	"<span class='notice'>You put the [src] up to [M]'s mouth.</span>")
			if (!do_mob(user, M, 50))
				return
		else
			if (!do_mob(user, M, 10))
				return
			user.visible_message("<span class='notice'>[user] puts the [src] up to their mouth.</span>", \
		  		"<span class='notice'>You take a sip from the [src].</span>")
		// Safety: In case you spam clicked the blood bag on yourself, and it is now empty (below will divide by zero)
		if (reagents.total_volume <= 0)
			return
		// Taken from drinks.dm
		var/transfer_amount = 5
		reagents.trans_to(transfer_amount, method = INGEST, show_message = FALSE)
		playsound(M.loc,'sound/items/drink.ogg', rand(10,50), 1)
	..()
