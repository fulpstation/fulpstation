/// Removes CAS entirely. Further removal code may be found in
/// 'fulp_modules\Z_edits\inititalize_edits\vendor_init.dm'
/obj/item/toy/cards/deck/cas/Initialize(mapload)
	. = ..()
	// Replace with a random deck to make absence less noticeable.
	new /obj/effect/spawner/random/entertainment/deck(src.loc)
	return INITIALIZE_HINT_QDEL
