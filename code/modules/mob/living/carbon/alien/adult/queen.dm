/mob/living/carbon/alien/adult/royal
	//Common stuffs for Praetorian and Queen
	icon = 'icons/mob/nonhuman-player/alienqueen.dmi'
	status_flags = 0
	pixel_x = -16
	base_pixel_x = -16
	maptext_height = 64
	maptext_width = 64
	bubble_icon = "alienroyal"
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles
	pressure_resistance = 200 //Because big, stompy xenos should not be blown around like paper.
	butcher_results = list(/obj/item/food/meat/slab/xeno = 20, /obj/item/stack/sheet/animalhide/xeno = 3)

	var/alt_inhands_file = 'icons/mob/nonhuman-player/alienqueen.dmi'

/mob/living/carbon/alien/adult/royal/Initialize(mapload)
	. = ..()
	// as a wise man once wrote: "pull over that ass too fat"
	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	// that'd be a too cheeky shield bashing strat
	ADD_TRAIT(src, TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, INNATE_TRAIT)
	AddComponent(/datum/component/seethrough_mob)

/mob/living/carbon/alien/adult/royal/on_lying_down(new_lying_angle)
	. = ..()
	layer = LYING_MOB_LAYER

/mob/living/carbon/alien/adult/royal/on_standing_up(new_lying_angle)
	. = ..()
	layer = initial(layer)

/mob/living/carbon/alien/adult/royal/can_inject(mob/user, target_zone, injection_flags)
	return FALSE

/mob/living/carbon/alien/adult/royal/queen
	name = "alien queen"
	caste = "q"
	maxHealth = 500
	health = 500
	icon_state = "alienq"
	melee_damage_lower = 50
	melee_damage_upper = 50
	alien_speed = 2

	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_XENO_HIVENODE = /obj/item/organ/alien/hivenode,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel/large/queen,
		ORGAN_SLOT_XENO_RESINSPINNER = /obj/item/organ/alien/resinspinner,
		ORGAN_SLOT_XENO_ACIDGLAND = /obj/item/organ/alien/acid,
		ORGAN_SLOT_XENO_NEUROTOXINGLAND = /obj/item/organ/alien/neurotoxin,
		ORGAN_SLOT_XENO_EGGSAC = /obj/item/organ/alien/eggsac,
	)

/mob/living/carbon/alien/adult/royal/queen/Initialize(mapload)
	var/static/list/innate_actions = list(
		/datum/action/cooldown/alien/promote,
		/datum/action/cooldown/spell/aoe/repulse/xeno,
	)
	grant_actions_by_list(innate_actions)

	return ..()

/mob/living/carbon/alien/adult/royal/queen/set_name()
	if(get_alien_type(/mob/living/carbon/alien/adult/royal/queen, ignored = src))
		name = "alien princess"
	return ..()

//Queen verbs
/datum/action/cooldown/alien/make_structure/lay_egg
	name = "Lay Egg"
	desc = "Lay an egg to produce huggers to impregnate prey with."
	button_icon_state = "alien_egg"
	plasma_cost = 75
	made_structure_type = /obj/structure/alien/egg

/datum/action/cooldown/alien/make_structure/lay_egg/Activate(atom/target)
	. = ..()
	owner.visible_message(span_alertalien("[owner] lays an egg!"))

//Button to let queen choose her praetorian.
/datum/action/cooldown/alien/promote
	name = "Create Royal Parasite"
	desc = "Produce a royal parasite to grant one of your children the honor of being your Praetorian."
	button_icon_state = "alien_queen_promote"
	/// The promotion only takes plasma when completed, not on activation.
	var/promotion_plasma_cost = 500

/datum/action/cooldown/alien/promote/set_statpanel_format()
	. = ..()
	if(!islist(.))
		return

	.[PANEL_DISPLAY_STATUS] = "PLASMA - [promotion_plasma_cost]"

/datum/action/cooldown/alien/promote/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/carbon_owner = owner
	if(carbon_owner.getPlasma() < promotion_plasma_cost)
		return FALSE

	if(get_alien_type(/mob/living/carbon/alien/adult/royal/praetorian))
		return FALSE

	return TRUE

/datum/action/cooldown/alien/promote/Activate(atom/target)
	var/obj/item/queen_promotion/existing_promotion = locate() in owner.held_items
	if(existing_promotion)
		to_chat(owner, span_noticealien("You discard [existing_promotion]."))
		owner.temporarilyRemoveItemFromInventory(existing_promotion)
		qdel(existing_promotion)
		return TRUE

	if(!owner.get_empty_held_indexes())
		to_chat(owner, span_warning("You must have an empty hand before preparing the parasite."))
		return FALSE

	var/obj/item/queen_promotion/new_promotion = new(owner.loc)
	if(!owner.put_in_hands(new_promotion, del_on_fail = TRUE))
		to_chat(owner, span_noticealien("You fail to prepare a parasite."))
		return FALSE

	to_chat(owner, span_noticealien("Use [new_promotion] on one of your children to promote her to a Praetorian!"))
	return TRUE

/obj/item/queen_promotion
	name = "\improper royal parasite"
	desc = "Inject this into one of your grown children to promote her to a Praetorian!"
	icon_state = "alien_medal"
	item_flags = NOBLUDGEON | ABSTRACT | DROPDEL
	icon = 'icons/mob/nonhuman-player/alien.dmi'

/obj/item/queen_promotion/attack(mob/living/to_promote, mob/living/carbon/alien/adult/queen)
	. = ..()
	if(.)
		return

	var/datum/action/cooldown/alien/promote/promotion = locate() in queen.actions
	if(!promotion)
		CRASH("[type] was created and handled by a mob ([queen]) that didn't have a promotion action associated.")

	if(!isalienadult(to_promote) || isalienroyal(to_promote))
		to_chat(queen, span_noticealien("You may only use this with your adult, non-royal children!"))
		return

	if(!promotion.IsAvailable())
		to_chat(queen, span_noticealien("You cannot promote a child right now!"))
		return

	if(to_promote.stat != CONSCIOUS || !to_promote.mind || !to_promote.key)
		return

	queen.adjustPlasma(-promotion.promotion_plasma_cost)

	to_chat(queen, span_noticealien("You have promoted [to_promote] to a Praetorian!"))
	to_promote.visible_message(
		span_alertalien("[to_promote] begins to expand, twist and contort!"),
		span_noticealien("The queen has granted you a promotion to Praetorian!"),
	)

	var/mob/living/carbon/alien/lucky_winner = to_promote
	var/mob/living/carbon/alien/adult/royal/praetorian/new_prae = new(lucky_winner.loc)
	lucky_winner.alien_evolve(new_prae)
	qdel(src)
	return TRUE

/obj/item/queen_promotion/attack_self(mob/user)
	to_chat(user, span_noticealien("You discard [src]."))
	qdel(src)

/obj/item/queen_promotion/dropped(mob/user, silent)
	if(!silent)
		to_chat(user, span_noticealien("You discard [src]."))
	return ..()
