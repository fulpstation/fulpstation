/mob/living/simple_animal/hostile/gorilla/albino
	name = "albino gorilla"
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/gorilla.dmi'
	maxHealth = 170
	health = 170


/mob/living/simple_animal/hostile/gorilla/albino/Initialize(mapload)
	var/datum/action/cooldown/mob_cooldown/charge/gorilla/tackle = new(src)
	tackle.Grant(src)
	var/datum/action/cooldown/spell/conjure/banana/trap = new(src)
	trap.Grant(src)
	return ..()


/datum/action/cooldown/mob_cooldown/charge/gorilla
	destroy_objects = FALSE
	charge_past = 0
	cooldown_time = 8 SECONDS


/datum/action/cooldown/mob_cooldown/charge/gorilla/do_charge_indicator(atom/charger, atom/charge_target)
	return

/datum/action/cooldown/mob_cooldown/charge/gorilla/Activate(atom/target_atom)
	playsound(owner, 'sound/creatures/gorilla.ogg', 200, 1)
	return ..()

/datum/action/cooldown/spell/conjure/banana
	name = "Monke Spin"
	desc = "Throw slippery traps all around you."
	sound = 'sound/creatures/gorilla.ogg'

	school = SCHOOL_CONJURATION
	cooldown_time = 30 SECONDS

	invocation = "OOO OOO AHH AHH"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE

	summon_radius = 2
	summon_type = list(/obj/item/grown/bananapeel)
	summon_amount = 10
	icon_icon = 'icons/obj/hydroponics/harvest.dmi'
	button_icon_state = "banana_peel"

/datum/action/cooldown/spell/conjure/banana/cast(atom/cast_on)
	owner.spin(10, 1)
	owner.balloon_alert_to_viewers("throws bananas all around!", "you throw bananas!")
	..()
