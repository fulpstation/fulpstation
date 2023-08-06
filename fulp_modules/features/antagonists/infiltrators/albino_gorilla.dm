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
	var/datum/action/cooldown/spell/pointed/projectile/mud/not_poop = new(src)
	not_poop.Grant(src)
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
	button_icon = 'icons/obj/service/hydroponics/harvest.dmi'
	button_icon_state = "banana_peel"

/datum/action/cooldown/spell/conjure/banana/cast(atom/cast_on)
	owner.spin(10, 1)
	owner.balloon_alert_to_viewers("throws bananas all around!", "you throw bananas!")
	..()


/obj/projectile/mud
	name = "Muddied Waters"
	damage = 10
	damage_type = BRUTE
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "trench_mud"


/obj/projectile/mud/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/mob_target = target
		mob_target.Paralyze(10 SECONDS)
		mob_target.set_eye_blur_if_lower(10 SECONDS)
		mob_target.visible_message(span_warning("[mob_target] is muddied by [src]!"), span_userdanger("You've been muddied by [src]!"))
		playsound(mob_target, SFX_DESECRATION, 50, TRUE)
		if(ishuman(mob_target))
			target.AddComponent(/datum/component/creamed/gorilla, src)


/datum/action/cooldown/spell/pointed/projectile/mud
	name = "Mud"
	desc = "Muddied waters from the heart of the Amazon forest."
	cooldown_time = 30 SECONDS
	spell_requirements = NONE
	antimagic_flags = NONE
	active_msg = "You dig the soil up."
	deactive_msg = "You throw the mud."
	projectile_type = /obj/projectile/mud
	button_icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	button_icon_state = "trench_mud"

/datum/component/creamed/gorilla

/datum/component/creamed/gorilla/Initialize()
	SEND_SIGNAL(parent, COMSIG_MOB_CREAMED)
	bodypart_overlay = new /datum/bodypart_overlay/simple/muddied()

	var/mob/living/carbon/human/man = parent
	if(man.bodytype & BODYTYPE_SNOUTED)
		bodypart_overlay.icon_state = "muddied_lizard"
	else if(man.bodytype & BODYTYPE_MONKEY)
		bodypart_overlay.icon_state = "muddied_monkey"
	else
		bodypart_overlay.icon_state = "muddied_human"

	var/atom/atom = parent
	atom.add_overlay(normal_overlay)

/datum/bodypart_overlay/simple/muddied
	icon_state = "muddied_human"
	layers = EXTERNAL_FRONT
