/mob/living/basic/devil
	name = "True Devil"
	desc = "A pile of infernal energy, taking a vaguely humanoid form."
	icon = 'fulp_modules/icons/mobs/32x64.dmi'
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
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	basic_mob_flags = DEL_ON_DEATH

	///The dancefloor ability we give to the devil.
	var/datum/action/cooldown/spell/summon_dancefloor/dancefloor_ability

/mob/living/basic/devil/Initialize()
	. = ..()
	grant_all_languages()
	dancefloor_ability = new()
	dancefloor_ability.Grant(src)

/mob/living/basic/devil/arch_devil
	name = "Arch Devil"
	desc = "A pile of infernal energy, taking a goatlike form."
	icon_state = "arch_devil"
	health = 350
	maxHealth = 350
