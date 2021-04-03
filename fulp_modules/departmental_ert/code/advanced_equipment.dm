//
// DEPARTMENTAL ERT EXCLUSIVE BELTS
//

/obj/item/storage/belt/medical/advanced/PopulateContents()
	new /obj/item/surgical_drapes(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/scalpel/advanced(src)
	new /obj/item/retractor/advanced(src)
	new /obj/item/cautery/advanced(src)
	new /obj/item/bonesetter(src)
	new /obj/item/stack/medical/gauze/twelve(src)
	update_icon()

/obj/item/storage/belt/security/webbing/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new	/obj/item/holosign_creator/security(src)
	new /obj/item/melee/baton/loaded(src)
	update_icon()

/obj/item/storage/belt/medical/alien/PopulateContents()
	new /obj/item/surgical_drapes(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/scalpel/alien(src)
	new /obj/item/retractor/alien(src)
	new /obj/item/hemostat/alien(src)
	new /obj/item/circular_saw/alien(src)
	new /obj/item/cautery/alien(src)
	update_icon()


/obj/item/clothing/gloves/combat/nitrile
	name = "insulated nitrile gloves"
	desc = "Very pricy specialized combat gloves, thicker than latex. Transfers intimate paramedic knowledge into the user via nanochips, along with providing insulation."
	icon_state = "nitrile"
	inhand_icon_state = "nitrilegloves"
