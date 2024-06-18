GLOBAL_LIST_EMPTY(wonderland_marks)

/datum/map_template/wonderland
	name = "Wonderland"
	mappath = "fulp_modules/_maps/wonderland.dmm"

/obj/effect/mob_spawn/corpse/rabbit
	mob_type = /mob/living/basic/rabbit
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white_dead"


/obj/effect/landmark/wonderland_mark
	name = "Wonderland landmark"
	icon_state = "x"

/obj/effect/landmark/wonderchess_mark
	name = "Wonderchess landmark"
	icon_state = "x"

/obj/effect/landmark/wonderland_mark/Initialize(mapload)
	. = ..()
	GLOB.wonderland_marks[name] = src


/obj/effect/landmark/wonderchess_mark/Initialize(mapload)
	. = ..()
	GLOB.wonderland_marks[name] = src

/obj/effect/landmark/wonderland_mark/Destroy()
	GLOB.wonderland_marks[name] = null
	return ..()

/obj/effect/landmark/wonderchess_mark/Destroy()
	GLOB.wonderland_marks[name] = null
	return ..()

/obj/structure/chess/redqueen
	name = "\improper Red Queen"
	desc = "What is this doing here?"
	icon = 'fulp_modules/features/antagonists/monster_hunter/icons/rabbit.dmi'
	icon_state = "red_queen"

/obj/structure/blood_fountain
	name = "blood fountain"
	desc = "A huge resevoir of thickened blood, perhaps drinking some of it would restore some vigor..."
	icon = 'fulp_modules/features/antagonists/monster_hunter/icons/blood_fountain.dmi'
	icon_state = "blood_fountain"
	plane = ABOVE_GAME_PLANE
	anchored = TRUE
	density = TRUE
	bound_width = 64
	bound_height = 64
	resistance_flags = INDESTRUCTIBLE


/obj/structure/blood_fountain/Initialize(mapload)
	. = ..()
	add_overlay("droplet")


/obj/structure/blood_fountain/attackby(obj/item/bottle, mob/living/user, params)
	if(!istype(bottle, /obj/item/blood_vial))
		balloon_alert(user, "Needs a blood vial!")
		return ..()
	var/obj/item/blood_vial/vial = bottle
	vial.fill_vial(user)

/obj/item/blood_vial
	name = "blood vial"
	desc = "Used to collect samples of blood from the dead-still blood fountain."
	icon = 'fulp_modules/features/antagonists/monster_hunter/icons/weapons.dmi'
	icon_state = "blood_vial_empty"
	inhand_icon_state = "beaker"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	var/filled = FALSE ///does the bottle contain fluid

/obj/item/blood_vial/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("This vial can only be filled at the blood fountain in Wonderland. ")
		. += span_notice("When full this vial can be <b>used in hand</b> to grant its user a short burst of speed and lingering healing.")

/obj/item/blood_vial/proc/fill_vial(mob/living/user)
	if(filled)
		balloon_alert(user, "Vial already full!")
		return
	filled = TRUE
	icon_state = "blood_vial"
	update_appearance()


/obj/item/blood_vial/attack_self(mob/living/user)
	if(!filled)
		balloon_alert(user, "Empty!")
		return
	filled = FALSE
	user.apply_status_effect(/datum/status_effect/cursed_blood)
	icon_state = "blood_vial_empty"
	update_appearance()
	playsound(src, 'fulp_modules/features/antagonists/monster_hunter/sounds/blood_vial_slurp.ogg',50)

/datum/status_effect/cursed_blood
	id = "Blood"
	duration = 20 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/cursed_blood



/atom/movable/screen/alert/status_effect/cursed_blood
	name = "Cursed Blood"
	desc = "Something foreign is coursing through your veins."

/datum/status_effect/cursed_blood/on_apply()
	. = ..()
	to_chat(owner, span_warning("You feel a great power surging through you!"))
	owner.add_movespeed_modifier(/datum/movespeed_modifier/cursed_blood)

	if(iscarbon(owner))
		owner.reagents.add_reagent(/datum/reagent/medicine/blood_vial, 15)

	return TRUE

/datum/status_effect/cursed_blood/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/cursed_blood)



/datum/reagent/medicine/blood_vial
	name = "Blood Vial"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM

/datum/reagent/medicine/blood_vial/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(affected_mob.health < 90 && affected_mob.health > 0)
		affected_mob.adjustOxyLoss(-1 * REM * seconds_per_tick, FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
		affected_mob.adjustToxLoss(-1 * REM * seconds_per_tick, FALSE, required_biotype = affected_biotype)
		affected_mob.adjustBruteLoss(-2 * REM * seconds_per_tick, FALSE, required_bodytype = affected_bodytype)
		affected_mob.adjustFireLoss(-2 * REM * seconds_per_tick, FALSE, required_bodytype = affected_bodytype)

	affected_mob.AdjustAllImmobility(-60  * REM * seconds_per_tick)
	affected_mob.adjustStaminaLoss(-7 * REM * seconds_per_tick, FALSE, required_biotype = affected_biotype)
	..()
	. = TRUE

/datum/movespeed_modifier/cursed_blood
	multiplicative_slowdown = -0.6
