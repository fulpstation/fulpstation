/obj/item/paper/fluff/map/helio_asteroid
	name = "important-looking note"
	desc = "This note is well written, and seems to have been put here so you'd find it."
	default_raw_text = "This place is not a place of honor. No highly esteemed dead is commemorated here. Nothing valued is here. What is here was dangerous and repulsive to us. This message is a warning about danger. The danger is still present, in your time, as it was in ours.  The danger is to the body, and it can kill.  The form of the danger is an emanation of energy.  The danger is unleashed only if you substantially disturb this place physically. This place is best shunned and left uninhabited."

/obj/structure/closet/crate/grave/filled/helio
	name = "lone burial mound"
	desc = "A lone grave on a far-flung asteroid. You get the feeling you shouldn't touch it."
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "grave"
	lead_tomb = TRUE
	first_open = TRUE

/obj/structure/closet/crate/grave/filled/helio/PopulateContents()  //ADVANCED GRAVEROBBING
	..()
	new /obj/item/circuitboard/machine/circulator(src)
	new /obj/item/circuitboard/machine/circulator(src)
	new /obj/item/circuitboard/machine/generator(src)
