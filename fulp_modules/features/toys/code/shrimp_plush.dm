///////    = MOOD EVENT =    ///////

/// The mood event that shrimp fried rice provides on consumption.
/datum/mood_event/shrimp_rice
	description = "I can't believe a shrimp fried that rice!"
	mood_change = 3
	timeout = 2 MINUTES


///////    = FOOD STATUS EFFECT =    ///////

/// Status effect provided by shrimp fried foods.
/// Gives the consumer crustacean speech.
/datum/status_effect/food/speech/shrimp_speech
	alert_type = /atom/movable/screen/alert/status_effect/shrimp_speech
	on_remove_on_mob_delete = TRUE
	duration = 10 MINUTES
	remove_on_fullheal = TRUE

	/// Ref to the component so we can clear it
	var/datum/component/speechmod

/datum/status_effect/food/speech/shrimp_speech/on_apply()
	speechmod = owner.AddComponent(/datum/component/speechmod, replacements = strings("crustacean_replacement.json", "crustacean"))
	return ..()

/datum/status_effect/food/speech/shrimp_speech/on_remove()
	. = ..()
	QDEL_NULL(speechmod)

/atom/movable/screen/alert/status_effect/shrimp_speech
	name = "Shrimp Speech"
	desc = "That meal has synchronized my psyche with the grand oceanic lexicon."
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "shrimp_status_effect"


///////    = "SHRIMP FRIED" COMPONENT =    ///////

/// Turns fried rice into shrimp fried rice and makes it
/// give a positive mood event and speech modifier when eaten.
/datum/component/shrimp_fried/Initialize(...)
	. = ..()
	if(!istype(parent, /obj/item/food))
		return COMPONENT_INCOMPATIBLE

	var/obj/item/food/food_parent = parent
	if(!findtext(initial(food_parent.name), "fried rice"))
		qdel(src)
		stack_trace("Tried to add /datum/component/shrimp_fried to a food item \
			([food_parent])that did not contain \"fried rice\" in its name.")
		return

	food_parent.name = initial(food_parent.name)
	food_parent.name = replacetext(food_parent.name, "fried rice", "shrimp fried rice")

/datum/component/shrimp_fried/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_FOOD_EATEN, PROC_REF(on_eaten))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/shrimp_fried/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_FOOD_EATEN)

/datum/component/shrimp_fried/proc/on_eaten(atom/source, mob/living/eater, mob/feeder, bitecount, bite_consumption)
	SIGNAL_HANDLER
	if(!istype(eater))
		return

	if(bitecount == 0)
		eater.add_mood_event("shrimp_fried_rice", /datum/mood_event/shrimp_rice)

/datum/component/shrimp_fried/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("By the grace of a crustaceous benefactor it has been \
		<b>shrimp fried</b>. It is truly a meal to <b>KRILL</b> for.")

///////    = SHRIMP PLUSH LOGIC =    ///////

/**
 * If we interact with a reagent container that has thirty units of rice then we produce
 * a random "fried rice" item and add the "shrimp fried" component and "shrimp speech"
 * element to it.
 *
 * Made using '/obj/item/food/deadmouse/interact_with_atom()' as a reference.
 **/
/obj/item/toy/plush/shrimp/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(has_fried)
		return NONE

	if(!interacting_with.is_open_container() || !interacting_with.reagents)
		return NONE

	if(iscarbon(interacting_with.loc))
		to_chat(user, span_warning("[src] needs room to work! Try placing [interacting_with] down."))
		return NONE

	var/datum/reagents/target_reagents = interacting_with.reagents
	if(target_reagents.has_reagent(/datum/reagent/consumable/rice, 30))
		to_chat(user, span_notice("[src] produces fried rice from [interacting_with]."))
		var/chosen = pick(fried_rice_types)
		var/obj/item/food/new_rice = new chosen(interacting_with.loc)

		ADD_TRAIT(new_rice, TRAIT_FOOD_CHEF_MADE, user)
		new_rice.crafted_food_buff = /datum/status_effect/food/speech/shrimp_speech
		new_rice.AddComponent(/datum/component/shrimp_fried)

		has_fried = TRUE
		target_reagents.remove_reagent(/datum/reagent/consumable/rice, 30)
		playsound(get_turf(new_rice), 'fulp_modules/sounds/effects/kero.ogg', 75, frequency = 0.5)
		user.do_attack_animation(interacting_with)
		new /obj/effect/temp_visual/shrimp_frying_rice(get_turf(new_rice))
		return ITEM_INTERACT_SUCCESS


///////    = SHRIMP PLUSH RICE FRYING VISUAL EFFECT =    ///////

/obj/effect/temp_visual/shrimp_frying_rice
	icon = 'fulp_modules/icons/toys/toys.dmi'
	icon_state = "shrimp"
	layer = MOB_UPPER_LAYER
	plane = GAME_PLANE
	duration = 1.5 SECONDS
	alpha = 223.125

	var/matrix/effect_matrix = matrix()

/obj/effect/temp_visual/shrimp_frying_rice/Initialize(mapload)
	. = ..()
	//Taken directly from Dream Maker Reference on 'animate()' with minor adjustment.
	animate(src, time = 1.5 SECONDS, alpha = 0, easing = SINE_EASING)
