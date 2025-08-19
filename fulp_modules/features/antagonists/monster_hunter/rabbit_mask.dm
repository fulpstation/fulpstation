#define WONDERLAND_TRAIT "wonderland"

/obj/item/clothing/mask/cursed_rabbit
	name = "Damned Rabbit Mask"
	desc = "An eerie visage covered with a light, almost reflective fur."
	icon =  'fulp_modules/icons/antagonists/monster_hunter/weapons.dmi'
	icon_state = "rabbit_mask"
	worn_icon = 'fulp_modules/icons/antagonists/monster_hunter/worn_mask.dmi'
	worn_icon_state = "rabbit_mask"
	clothing_flags = MASKINTERNALS | SNUG_FIT
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	flash_protect = FLASH_PROTECTION_WELDER
	resistance_flags = FIRE_PROOF | ACID_PROOF
	/// The paradox rabbit ability
	var/datum/action/cooldown/monster_hunter/paradox/paradox
	/// The Wonderland teleportation ability
	var/datum/action/cooldown/monster_hunter/wonderland_drop/wonderland
	/// Holder for the "glitched" visual component.
	var/datum/component/glitching_state/wondershift

/obj/item/clothing/mask/cursed_rabbit/Initialize(mapload)
	. = ..()
	generate_abilities()

/obj/item/clothing/mask/cursed_rabbit/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("You can use this mask to teleport to Wonderland for a short period of time.")
		. += span_notice("It can also be used to phase through reality by repeatedly transposing your location with that of a paradox rabbit.")

/obj/item/clothing/mask/cursed_rabbit/proc/generate_abilities()
	var/datum/action/cooldown/monster_hunter/paradox/para = new
	if(!para.landmark || !para.chessmark)
		return
	paradox = para
	var/datum/action/cooldown/monster_hunter/wonderland_drop/drop = new
	if(!drop.landmark)
		return
	wonderland = drop


/obj/item/clothing/mask/cursed_rabbit/equipped(mob/living/carbon/human/user,slot)
	..()
	if(!paradox)
		return
	if(!wonderland)
		return
	if(!(slot & ITEM_SLOT_MASK))
		return
	if(!IS_MONSTERHUNTER(user))
		return
	paradox.Grant(user)
	wonderland.Grant(user)
	wondershift = user.AddComponent(/datum/component/glitching_state)
	user.become_area_sensitive(type)
	RegisterSignal(user, COMSIG_ENTER_AREA, PROC_REF(on_enter_area))
	RegisterSignal(user, COMSIG_EXIT_AREA, PROC_REF(on_exit_area))

/obj/item/clothing/mask/cursed_rabbit/dropped(mob/user)
	. = ..()
	if(!paradox)
		return
	if(paradox.owner != user)
		return
	paradox.Remove(user)
	if(!wonderland)
		return
	if(wonderland.owner != user)
		return
	wonderland.Remove(user)
	QDEL_NULL(wondershift)
	UnregisterSignal(user, list(COMSIG_ENTER_AREA, COMSIG_EXIT_AREA))
	user.lose_area_sensitivity(type)
	REMOVE_TRAIT(src, TRAIT_NODROP, WONDERLAND_TRAIT)

/obj/item/clothing/mask/cursed_rabbit/proc/on_enter_area(mob/living/user, area/new_area)
	SIGNAL_HANDLER
	if(istype(new_area, /area/ruin/space/has_grav/wonderland))
		ADD_TRAIT(src, TRAIT_NODROP, WONDERLAND_TRAIT)

/obj/item/clothing/mask/cursed_rabbit/proc/on_exit_area(mob/living/user, area/old_area)
	SIGNAL_HANDLER
	if(istype(old_area, /area/ruin/space/has_grav/wonderland))
		REMOVE_TRAIT(src, TRAIT_NODROP, WONDERLAND_TRAIT)

#undef WONDERLAND_TRAIT
