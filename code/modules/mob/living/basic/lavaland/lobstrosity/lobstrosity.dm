/// Cowardly mob with a charging attack
/mob/living/basic/mining/lobstrosity
	name = "arctic lobstrosity"
	desc = "These hairy crustaceans creep and multiply in underground lakes deep below the ice. They have a particular taste for fingers."
	icon = 'icons/mob/simple/icemoon/icemoon_monsters.dmi'
	icon_state = "arctic_lobstrosity"
	icon_living = "arctic_lobstrosity"
	icon_dead = "arctic_lobstrosity_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	friendly_verb_continuous = "chitters at"
	friendly_verb_simple = "chitters at"
	speak_emote = list("chitters")
	maxHealth = 150
	health = 150
	obj_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 19
	attack_verb_continuous = "snips"
	attack_verb_simple = "snip"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE // Closer than a scratch to a crustacean pinching effect
	butcher_results = list(
		/obj/item/food/meat/crab = 2,
		/obj/item/stack/sheet/bone = 2,
		/obj/item/organ/internal/monster_core/rush_gland = 1,
	)
	crusher_loot = /obj/item/crusher_trophy/lobster_claw
	ai_controller = /datum/ai_controller/basic_controller/lobstrosity
	/// Charging ability
	var/datum/action/cooldown/mob_cooldown/charge/basic_charge/lobster/charge
	/// Limbs we will cut off an unconscious man
	var/static/list/target_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	/// Things we will eat if we see them (arms, chiefly)
	var/static/list/target_foods = list(/obj/item/bodypart/arm)

/mob/living/basic/mining/lobstrosity/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SNOWSTORM_IMMUNE, INNATE_TRAIT)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)
	AddElement(/datum/element/basic_eating, food_types = target_foods)
	AddElement(\
		/datum/element/amputating_limbs,\
		surgery_verb = "snipping",\
		target_zones = target_limbs,\
	)
	charge = new(src)
	charge.Grant(src)
	ai_controller.set_blackboard_key(BB_TARGETTED_ACTION, charge)

/mob/living/basic/mining/lobstrosity/Destroy()
	QDEL_NULL(charge)
	return ..()

/mob/living/basic/mining/lobstrosity/ranged_secondary_attack(atom/atom_target, modifiers)
	charge.Trigger(target = atom_target)

/// Lavaland lobster variant, it basically just looks different
/mob/living/basic/mining/lobstrosity/lava
	name = "chasm lobstrosity"
	desc = "Twitching crustaceans boiled red by the sulfurous fumes of the chasms in which they lurk. They have a particular taste for fingers."
	icon_state = "lobstrosity"
	icon_living = "lobstrosity"
	icon_dead = "lobstrosity_dead"

/// Charge a long way, knock down for longer, and perform an instant melee attack
/datum/action/cooldown/mob_cooldown/charge/basic_charge/lobster
	charge_distance = 8
	knockdown_duration = 2.5 SECONDS

/datum/action/cooldown/mob_cooldown/charge/basic_charge/lobster/hit_target(atom/movable/source, atom/target, damage_dealt)
	. = ..()
	if(!isliving(target) || !isbasicmob(source))
		return
	var/mob/living/basic/basic_source = source
	var/mob/living/living_target = target
	basic_source.melee_attack(living_target)
	basic_source.ai_controller?.set_blackboard_key(BB_BASIC_MOB_FLEEING, FALSE)
	basic_source.start_pulling(living_target)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/lobster/do_charge(atom/movable/charger, atom/target_atom, delay, past)
	. = ..()
	if(!isliving(charger))
		return
	var/mob/living/living_charger = charger
	living_charger.apply_status_effect(/datum/status_effect/tired_post_charge)
