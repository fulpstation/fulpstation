/obj/item/seeds/poppy/wolfsbane
	name = "pack of wolf's bane seeds"
	desc = "These seeds grow into wolf's bane"
	product = /obj/item/food/grown/wolfsbane
	// species = "wolfsbane"
	plantname = "Wolf's bane plants"
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05, /datum/reagent/toxin/aconitine = 0.2)
	mutatelist = list()
	yield = 3


/obj/item/food/grown/wolfsbane
	seed = /obj/item/seeds/poppy/wolfsbane
	name = "wolf's bane"
	desc = "A toxic plant with beautiful purple flowers. Werewolves hate this stuff."


/obj/item/food/grown/wolfsbane/Initialize(mapload, obj/item/seeds/new_seed)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ENTERED, PROC_REF(on_step_on))

/obj/item/food/grown/wolfsbane/proc/on_step_on(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER
	if(!iscarbon(arrived))
		return

	var/mob/living/carbon/incoming = arrived
	if(!IS_WEREWOLF_ANTAG(incoming))
		return

	incoming.adjustToxLoss(rand(10, 30))
	to_chat(incoming, span_userdanger("The wolfsbane makes you feel sick!"))

/obj/item/food/grown/wolfsbane/Destroy()
	UnregisterSignal(src, COMSIG_ATOM_ENTERED)
	return ..()


/datum/component/caltrop/wolfsbane
	probability = 100
	flags = CALTROP_BYPASS_SHOES
	min_damage = 10
	max_damage = 30



