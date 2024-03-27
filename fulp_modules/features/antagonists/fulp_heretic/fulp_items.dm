//beef blade for path of fool
/obj/item/melee/sickly_blade/beef
	name = "\improper beefy blade"
	desc = "It's a rag-tag patchwork of beef crudely arranged in the shape of a sickle. \
		You will definitely catch many illnesses if you take a bite..."
	icon_state = "rust_blade"
	inhand_icon_state = "rust_blade"
	after_use_message = "Tom Fulp hears your call..."

	hitsound = 'sound/effects/meatslap.ogg'
	attack_verb_continuous = list("beefs")
	attack_verb_simple = list("beef")

	icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/items.dmi'
	icon_state = "blade"
	inhand_icon_state = "blade"
	lefthand_file = 'fulp_modules/features/antagonists/fulp_heretic/icons/blade_lefthand.dmi'
	righthand_file = 'fulp_modules/features/antagonists/fulp_heretic/icons/blade_righthand.dmi'

	//to slice the cake you get when ascending
	tool_behaviour = TOOL_KNIFE

/obj/item/melee/sickly_blade/beef/attack(mob/living/M, mob/living/user)
	var/lived = !CAN_SUCCUMB(M)

	. = ..()

	//our attack made them horizontal
	if(lived && CAN_SUCCUMB(M))
		say("I am a quick learner when it comes to throwing and strangling people I see.")

/obj/item/melee/sickly_blade/beef/attack_self(mob/user)
	to_chat(user, span_warning("[src] is too squishy to shatter with hands! Try taking a bite..."))

/obj/item/melee/sickly_blade/beef/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/edible, initial_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/eldritch = 5), foodtypes = MEAT | GROSS, after_eat = CALLBACK(src, PROC_REF(took_bite)))

//the same thing normal blades do on use in hand
/obj/item/melee/sickly_blade/beef/proc/took_bite(mob/eater, mob/feeder)
	var/turf/safe_turf = find_safe_turf(zlevels = z, extended_safety_checks = TRUE)
	if(do_teleport(eater, safe_turf, channel = TELEPORT_CHANNEL_MAGIC))
		if(eater == feeder)
			to_chat(eater, span_warning("As you take a bite of [src], you feel a gust of energy flow through your body. [after_use_message]"))
			say("This server is out to get me")
		else
			to_chat(eater, span_warning("As you take a bite of [src], you feel a gust of energy flow through your body. Unknown forces grasp you and you wind up somewhere completely different..."))
			say("GEY AWAY FROM ME YOU GREIFING PRICK!!!!!")
	else
		to_chat(eater, span_warning("You take a bite of [src], but your plea goes unanswered."))

	playsound(src, 'sound/effects/meatslap.ogg', 70, TRUE)


//the breakfast you get for finishing the knowledge ritual, instead of knowledge points
/obj/item/food/salad/eldritch
	name = "4 point pops balanced breakfast"
	desc = "Crunchy, sweetened, eyeball-shaped corn cereal! Best served with bacon, eggs, and orange juice. A balanced breakfast straight from the depths of Mansus, all organically sourced from the Wood."
	icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/items.dmi'
	icon_state = "breakfast"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/protein = 5, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/eldritch = 5)
	tastes = list("milk" = 1, "cereal" = 1, "bacon" = 1, "egg" = 1, "orange juice" = 1, "Ag'hsj'saje'sh" = 1)
	foodtypes = DAIRY | SUGAR | GRAIN | BREAKFAST | MEAT | ORANGES | FRIED | SUGAR | FRUIT

/obj/item/food/salad/eldritch/examine(mob/user)
	. = ..()
	if(!IS_HERETIC_OR_MONSTER(user))
		return

	. += span_hypnophrase("I was promised four knowledge points, and all I got was this cereal.")


//magic staff for fool heretics
/obj/item/gun/magic/staff/charged_batong
	name = "charged batong"
	desc = "It has reached its true potential."
	fire_sound = 'sound/voice/beepsky/freeze.ogg'
	icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/items.dmi'
	icon_state = "batong"
	worn_icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/batong_worn.dmi'
	worn_icon_state = "batong"
	lefthand_file = 'fulp_modules/features/antagonists/fulp_heretic/icons/batong_lefthand.dmi'
	righthand_file = 'fulp_modules/features/antagonists/fulp_heretic/icons/batong_righthand.dmi'
	inhand_icon_state = "batong"
	max_charges = 1
	school = SCHOOL_FORBIDDEN
	w_class = WEIGHT_CLASS_NORMAL

	ammo_type = /obj/item/ammo_casing/magic/batong

/obj/item/gun/magic/staff/charged_batong/is_wizard_or_friend(mob/user)
	return IS_HERETIC_OR_MONSTER(user)

/obj/item/gun/magic/staff/charged_batong/on_intruder_use(mob/living/user, atom/target)
	to_chat(user, span_hypnophrase("The [src] is not yours to command!"))
	process_fire(user,user)

/obj/item/ammo_casing/magic/batong
	projectile_type = /obj/projectile/magic/batong

/obj/projectile/magic/batong
	name = "battery charge"
	icon_state = "secbot-c"
	icon = 'icons/mob/silicon/aibots.dmi'

/obj/projectile/magic/batong/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()

	if(!iscarbon(target))
		return FALSE

	var/mob/living/carbon/carb_target = target

	if(IS_HERETIC_OR_MONSTER(carb_target))
		return FALSE

	for(var/obj/item/implant/mindshield/implant in carb_target.implants)
		implant.removed(carb_target)
		do_sparks(5,FALSE,carb_target)
		return TRUE

	carb_target.electrocute_act(5,src,flags = SHOCK_NOSTUN)
	carb_target.gain_trauma(/datum/brain_trauma/special/beepsky, TRAUMA_RESILIENCE_BASIC)

	var/datum/record/crew/record = find_record(carb_target.name)
	if(record)
		record.wanted_status = WANTED_ARREST
		update_matching_security_huds(carb_target.name)


//reward for ascending
/obj/item/food/cake/fulp_ascension
	name = "ascension cake"
	desc = "Congratulations! We knew you can do it!"
	icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/items.dmi'
	icon_state = "cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/sprinkles = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/eldritch = 50,
	)
	tastes = list("cake" = 5, "sweetness" = 1, "victory" = 5)
	//do note that if you get to eat this you are almost certainly a beefman, and they find this disgusting. I will not fix it.
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	slice_type = /obj/item/food/cakeslice/fulp_ascension
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/cake/fulp_ascension/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_TOOL_ACT(TOOL_KNIFE), PROC_REF(scream))

/obj/item/food/cake/fulp_ascension/Destroy()
	. = ..()
	UnregisterSignal(src, list(COMSIG_ATOM_TOOL_ACT(TOOL_KNIFE)))

//this is funny I think
/obj/item/food/cake/fulp_ascension/proc/scream(datum/source, mob/living/user, obj/item/I, list/mutable_recipes)
	SIGNAL_HANDLER

	manual_emote("screams")

/obj/item/food/cakeslice/fulp_ascension
	name = "ascension cake slice"
	desc = "Share the taste of godhood with your heretic friends, or minions, or whatever you have."
	icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/items.dmi'
	icon_state = "cake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/eldritch = 10,
	)
	tastes = list("cake" = 5, "sweetness" = 1, "victory" = 5)
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_5
