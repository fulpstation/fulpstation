/mob/living/simple_animal/hostile/devil
	name = "True Devil"
	desc = "A pile of infernal energy, taking a vaguely humanoid form."
	icon = 'icons/mob/32x64.dmi'
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

/mob/living/simple_animal/hostile/devil/death()
    src.visible_message(span_danger("[src] turns into a pile of ash!"))
    for(var/i in 1 to rand(3,5))
        new /obj/effect/decal/cleanable/ash(get_turf(src))
    qdel(src)

/mob/living/simple_animal/hostile/devil/arch_devil
	name = "Arch Devil"
	desc = "A pile of infernal energy, taking a goatlike form."
	icon_state = "arch_devil"
	health = 350
	maxHealth = 350

/mob/living/simple_animal/hostile/devil/imp
	name = "imp"
	desc = "A large, menacing creature covered in armored black scales."
	icon = 'icons/mob/mob.dmi'
	icon_state = "imp"
	icon_living = "imp"
	speak_emote = list("cackles")
	health = 150
	maxHealth = 150
	obj_damage = 15
	melee_damage_lower = 10
	melee_damage_upper = 15
