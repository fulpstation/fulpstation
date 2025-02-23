// Obscure joke curator mail gift that (while semi-satricial and not explicit itself)
// references explicit material.
/obj/item/book/granter/action/spell/blind/wgw/Initialize(mapload)
	. = ..()
	// We replace it with 100 CR to make its absence less noticeable as a mail drop.
	new /obj/item/stack/spacecash/c100(src.loc)
	return INITIALIZE_HINT_QDEL
