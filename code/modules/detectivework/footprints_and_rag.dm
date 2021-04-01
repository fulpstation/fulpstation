/obj/item/reagent_containers/glass/rag
	name = "damp rag"
	desc = "For cleaning up messes, you suppose."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/toy.dmi'
	icon_state = "rag"
	item_flags = NOBLUDGEON
	reagent_flags = OPENCONTAINER
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list()
	volume = 5
	spillable = FALSE

/obj/item/reagent_containers/glass/rag/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is smothering [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (OXYLOSS)

/obj/item/reagent_containers/glass/rag/afterattack(atom/A as obj|turf|area, mob/living/user,proximity)
	. = ..()
	if(!proximity)
		return
	if(iscarbon(A) && reagents?.total_volume)
		var/mob/living/carbon/C = A
		var/reagentlist = pretty_string_from_reagent_list(reagents)
		var/log_object = "containing [reagentlist]"
		if(user.combat_mode && !C.is_mouth_covered())
			reagents.trans_to(C, reagents.total_volume, transfered_by = user, methods = INGEST)
			C.visible_message("<span class='danger'>[user] smothers \the [C] with \the [src]!</span>", "<span class='userdanger'>[user] smothers you with \the [src]!</span>", "<span class='hear'>You hear some struggling and muffled cries of surprise.</span>")
			log_combat(user, C, "smothered", src, log_object)
		else
			reagents.expose(C, TOUCH)
			reagents.clear_reagents()
			C.visible_message("<span class='notice'>[user] touches \the [C] with \the [src].</span>")
			log_combat(user, C, "touched", src, log_object)

	else if(istype(A) && (src in user))
		user.visible_message("<span class='notice'>[user] starts to wipe down [A] with [src]!</span>", "<span class='notice'>You start to wipe down [A] with [src]...</span>")
		if(do_after(user,30, target = A))
			user.visible_message("<span class='notice'>[user] finishes wiping off [A]!</span>", "<span class='notice'>You finish wiping off [A].</span>")
			A.wash(CLEAN_SCRUB)
