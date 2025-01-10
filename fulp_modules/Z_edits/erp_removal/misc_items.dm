// Obscure joke curator mail gift that (while semi-satricial and not explicit itself)
// references explicit material.
/obj/item/book/granter/action/spell/blind/wgw/Initialize(mapload)
	. = ..()
	// We replace it with 100 CR to make its absence less noticeable as a mail drop.
	new /obj/item/stack/spacecash/c100(src.loc)
	// *Just to be safe* we'll try to destroy this thing every second of its existence.
	START_PROCESSING(SSobj, src)
	qdel(src)

/obj/item/book/granter/action/spell/blind/wgw/Destroy(force)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/book/granter/action/spell/blind/wgw/process(seconds_per_tick)
	. = ..()
	qdel(src)
