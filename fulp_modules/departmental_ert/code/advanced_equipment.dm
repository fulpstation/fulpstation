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

/obj/item/storage/belt/utility/advanced/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/inducer(src)
	update_icon()

/obj/item/storage/belt/mining/advanced/PopulateContents()
	new /obj/item/reagent_containers/hypospray/medipen/survival/luxury(src)
	new /obj/item/reagent_containers/hypospray/medipen/survival/luxury(src)
	new /obj/item/reagent_containers/hypospray/medipen/survival/luxury(src)
	new /obj/item/organ/regenerative_core/legion(src)
	new /obj/item/organ/regenerative_core/legion(src)
	new /obj/item/organ/regenerative_core/legion(src)
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

/obj/item/clothing/shoes/bhop/combat
	name = "combat jump boots"
	desc = "A specialized pair of protective combat boots with a built-in propulsion system for rapid foward movement."
	permeability_coefficient = 0.01
	strip_delay = 60
	clothing_flags = NOSLIP
	armor = list("melee" = 40, "bullet" = 20, "laser" = 15, "energy" = 15, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 90, "acid" = 50)

/obj/item/storage/box/ka_mods
	name = "kinetic accelerator upgrades box"
	desc = "It's a box commonly given to Mining Emergency Response Team Units, filled with upgrades for their Kinetic Accelerators."

/obj/item/storage/box/ka_mods/PopulateContents()
	new /obj/item/borg/upgrade/modkit/damage(src)
	new /obj/item/borg/upgrade/modkit/damage(src)
	new /obj/item/borg/upgrade/modkit/range(src)
	new /obj/item/borg/upgrade/modkit/range(src)
	new /obj/item/borg/upgrade/modkit/cooldown(src)
	new /obj/item/borg/upgrade/modkit/cooldown(src)
	new /obj/item/borg/upgrade/modkit/chassis_mod(src)

/obj/item/storage/box/kc_mods
	name = "kinetic crusher trophy box"
	desc = "It's a box, given to a mining commander to outfit their kinetic crusher."

/obj/item/storage/box/kc_mods/PopulateContents()
	new	/obj/item/crusher_trophy/goliath_tentacle(src)
	new	/obj/item/crusher_trophy/watcher_wing(src)
	new	/obj/item/crusher_trophy/legion_skull(src)
	new	/obj/item/crusher_trophy/miner_eye(src)
	new	/obj/item/crusher_trophy/demon_claws(src)
	new /obj/item/crusher_trophy/vortex_talisman(src)
