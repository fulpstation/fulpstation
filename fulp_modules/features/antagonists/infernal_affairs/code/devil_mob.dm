/mob/living/basic/devil
	name = "True Devil"
	desc = "A pile of infernal energy, taking a vaguely humanoid form."
	icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/32x64.dmi'
	icon_state = "true_devil"
	gender = NEUTER
	health = 200
	maxHealth = 200
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	speak_emote = list("hisses")
	combat_mode = TRUE
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	basic_mob_flags = DEL_ON_DEATH

/mob/living/basic/devil/Initialize()
	. = ..()
	grant_all_languages()
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP), ROUNDSTART_TRAIT)
	AddElement(/datum/element/wall_tearer, allow_reinforced = FALSE)
	AddElement(/datum/element/dextrous)
	AddComponent(/datum/component/personal_crafting)
	AddComponent(/datum/component/basic_inhands, y_offset = -1)

/mob/living/basic/devil/arch_devil
	name = "Arch Devil"
	desc = "A pile of infernal energy, taking a goatlike form."
	icon_state = "arch_devil"
	health = 350
	maxHealth = 350
