/obj/item/wirecutters
	name = "wirecutters"
	desc = "This cuts wires."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters_map"
	worn_icon_state = "cutters"
	inhand_icon_state = "cutters"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'

	greyscale_config = /datum/greyscale_config/wirecutters
	greyscale_config_belt = /datum/greyscale_config/wirecutters_belt_overlay
	greyscale_config_inhand_left = /datum/greyscale_config/wirecutter_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/wirecutter_inhand_right

	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 6
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=80)
	attack_verb_continuous = list("pinches", "nips")
	attack_verb_simple = list("pinch", "nip")
	hitsound = 'sound/items/wirecutter.ogg'
	usesound = 'sound/items/wirecutter.ogg'
	drop_sound = 'sound/items/handling/wirecutter_drop.ogg'
	pickup_sound = 'sound/items/handling/wirecutter_pickup.ogg'
	tool_behaviour = TOOL_WIRECUTTER
	toolspeed = 1
	armor_type = /datum/armor/item_wirecutters
	/// If the item should be assigned a random color
	var/random_color = TRUE
	/// List of possible random colors
	var/static/list/wirecutter_colors = list(
		COLOR_TOOL_BLUE,
		COLOR_TOOL_RED,
		COLOR_TOOL_PINK,
		COLOR_TOOL_BROWN,
		COLOR_TOOL_GREEN,
		COLOR_TOOL_CYAN,
		COLOR_TOOL_YELLOW,
	)

/datum/armor/item_wirecutters
	fire = 50
	acid = 30

/obj/item/wirecutters/Initialize(mapload)
	if(random_color)
		set_greyscale(colors = list(pick(wirecutter_colors)))

	AddElement(/datum/element/falling_hazard, damage = force, wound_bonus = wound_bonus, hardhat_safety = TRUE, crushes = FALSE, impact_sound = hitsound)

	return ..()

/obj/item/wirecutters/attack(mob/living/carbon/attacked_carbon, mob/user)
	if(istype(attacked_carbon) && attacked_carbon.handcuffed && istype(attacked_carbon.handcuffed, /obj/item/restraints/handcuffs/cable))
		user.visible_message(span_notice("[user] cuts [attacked_carbon]'s restraints with [src]!"))
		qdel(attacked_carbon.handcuffed)
		return

	return ..()

/obj/item/wirecutters/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is cutting at [user.p_their()] arteries with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(loc, usesound, 50, TRUE, -1)
	return BRUTELOSS

/obj/item/wirecutters/abductor
	name = "alien wirecutters"
	desc = "Extremely sharp wirecutters, made out of a silvery-green metal."
	icon = 'icons/obj/abductor.dmi'
	custom_materials = list(/datum/material/iron = 5000, /datum/material/silver = 2500, /datum/material/plasma = 1000, /datum/material/titanium = 2000, /datum/material/diamond = 2000)
	icon_state = "cutters"
	toolspeed = 0.1
	random_color = FALSE

/obj/item/wirecutters/cyborg
	name = "powered wirecutters"
	desc = "Cuts wires with the power of ELECTRICITY. Faster than normal wirecutters."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "wirecutters_cyborg"
	worn_icon_state = "cutters"
	toolspeed = 0.5
	random_color = FALSE
