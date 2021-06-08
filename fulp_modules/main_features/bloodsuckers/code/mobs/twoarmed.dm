/mob/living/simple_animal/hostile/retaliate/tzimisce/twoarmed
	name = "two-armed abomination"
	icon_state = "tarantula"
	icon_living = "tarantula"
	icon_dead = "tarantula_dead"
	maxHealth = 50
	health = 50
	melee_damage_lower = 15
	melee_damage_upper = 20
	speed = 0
	mob_size = MOB_SIZE_SMALL
	damage_coeff = list(BRUTE = 0.4, BURN = 0.7, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 1)
	tzimisce_examinestring = "This type of creature is relatively fast and able to be mass-produced, and can ventcrawl. \
	They're able to lunge at people to knock them down, and their claws deal burn damage."
	observer_examinestring = "This is a two-armed monster created by a Tzimisce Bloodsucker. \
	It claws at its victims, can ventcrawl and lunge at people."

	var/lunge_time = 0
	var/lunge_cooldown = 15 SECONDS

/mob/living/simple_animal/hostile/retaliate/tzimisce/twoarmed/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/retaliate/tzimisce/twoarmed/RightClickOn(atom/target)
	if(!isliving(target))
		return ..()

	if(!Adjacent(target))
		to_chat(src, "<span class='warning'>You are too far away to lunge [target] to the ground, get on point-blank range!</span>")
		return

	if(lunge_time + lunge_cooldown > world.time)
		to_chat(src, "<span class='warning'>Your lunge ability is still on cooldown!</span>")
		return

	face_atom(target)
	var/mob/living/victim = target
	victim.take_bodypart_damage(burn = 15)
	visible_message("<span class='danger'>[src] lunges [victim] to the ground!</span>", "<span class='danger'>You lunge towards [victim]!</span>", ignored_mobs = victim)
	to_chat(victim, "<span class='userdanger'>[src] knocks you to the ground!</span>")
	victim.Knockdown(5 SECONDS)
	victim.adjustStaminaLoss(35)
	lunge_cooldown = world.time
	log_combat(src, victim, "two-armed lunged")
