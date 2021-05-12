/datum/martial_art/northstar
	name = "South Star"
	id = "south star"
	allow_temp_override = FALSE

/datum/martial_art/northstar/harm_act(mob/living/A, mob/living/D)

	var/mob/living/carbon/human/attacker_human = A
	var/datum/species/species = attacker_human.dna.species

	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)

	D.visible_message("<span class='danger'>[A] punches [D]!</span>", \
					"<span class='userdanger'>You're punched by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You punch [D]!</span>")

	playsound(D.loc, species.attack_sound, 25, TRUE, -1)

	log_combat(A, D, "punched (South Star) ")
	return TRUE
