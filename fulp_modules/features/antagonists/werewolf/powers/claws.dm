/datum/component/mutant_hands/werewolf

/datum/component/mutant_hands/werewolf/Initialize(obj/item/mutant_hand_path = /obj/item/mutant_hand)
	src.mutant_hand_path = mutant_hand_path

/datum/action/cooldown/spell/werewolf_claws
	name = "Claws"
	desc = "Drop whatever you're holding to be able to attack with your sharp claws."
	spell_requirements = NONE

	var/claws_out = FALSE
	var/datum/component/mutant_hands/claws_datum


/datum/action/cooldown/spell/werewolf_claws/Remove()
	retract()
	return ..()

/datum/action/cooldown/spell/werewolf_claws/proc/extend()
	claws_datum = owner.AddComponent(/datum/component/mutant_hands/werewolf, mutant_hand_path = /obj/item/mutant_hand/werewolf)
	claws_out = TRUE

/datum/action/cooldown/spell/werewolf_claws/proc/retract()
	qdel(claws_datum)
	claws_out = FALSE

/datum/action/cooldown/spell/werewolf_claws/cast(mob/living/carbon/caster)
	. = ..()
	if(claws_out)
		retract()
	else
		extend()
