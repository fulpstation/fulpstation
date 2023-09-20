/obj/item/melee/touch_attack/werewolf_bite
	name = "\improper Werewolf bite"
	desc = "Deals significant damage. Use it on a corpse to consume it."
	var/old_effect = NONE

/datum/action/cooldown/spell/touch/werewolf_bite
	name = "Bite"
	desc = "Bite the target"
	invocation = "gnashes"
	invocation_type = "emote"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_CONSCIOUS
	spell_requirements = NONE
	hand_path = /obj/item/melee/touch_attack/werewolf_bite

/datum/action/cooldown/spell/touch/werewolf_bite/is_valid_target(atom/cast_on)
	. = ..()
	var/mob/target = cast_on
	return ismob(target)

/datum/action/cooldown/spell/touch/werewolf_bite/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	. = ..()
	caster.do_attack_animation(victim, ATTACK_EFFECT_BITE)
	to_chat(caster, "bite")

