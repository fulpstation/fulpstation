/mob/living/simple_animal/hostile/devil
	name = "True Devil"
	desc = "A pile of infernal energy, taking a vaguely humanoid form."
	icon = 'fulp_modules/features/mobs/32x64.dmi'
	icon_state = "true_devil"
	gender = NEUTER
	health = 200
	maxHealth = 200
	obj_damage = 60
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	speak_emote = list("hisses")
	combat_mode = TRUE
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	del_on_death = TRUE

/mob/living/simple_animal/hostile/devil/arch_devil
	name = "Arch Devil"
	desc = "A pile of infernal energy, taking a goatlike form."
	icon_state = "arch_devil"
	health = 350
	maxHealth = 350
