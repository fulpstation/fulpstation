/mob/living/simple_animal/hostile/gorilla/albino
	name = "albino gorilla"
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/gorilla.dmi'
	maxHealth = 170
	health = 170


/mob/living/simple_animal/hostile/gorilla/albino/Initialize(mapload)
	var/datum/action/cooldown/mob_cooldown/charge/gorilla/tackle = new(src)
	tackle.Grant(src)
	var/datum/action/cooldown/spell/pointed/projectile/gorilla_dung/poop = new(src)
	poop.Grant(src)
	return ..()


/datum/action/cooldown/mob_cooldown/charge/gorilla
	destroy_objects = FALSE
	charge_past = 0
	cooldown_time = 8 SECONDS


/datum/action/cooldown/mob_cooldown/charge/do_charge_indicator(atom/charger, atom/charge_target)
	return

/datum/action/cooldown/mob_cooldown/charge/Activate(atom/target_atom)
	playsound(owner, 'sound/creatures/gorilla.ogg', 200, 1)
	return ..()

/obj/projectile/gorilla_dung
	name = "dung pie"
	damage = 10
	damage_type = BRUTE
	nodamage = FALSE
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "gorilla_dung"

/obj/projectile/gorilla_dung/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/mob_target = target
		mob_target.Paralyze(6 SECONDS)
		mob_target.adjust_blurriness(5)
		mob_target.visible_message(span_warning("[mob_target] is dunged by [src]!"), span_userdanger("You've been dunged by [src]!"))
		playsound(mob_target, SFX_DESECRATION, 50, TRUE)
		if(ishuman(mob_target))
			target.AddComponent(/datum/component/creamed/gorilla, src)

/datum/action/cooldown/spell/pointed/projectile/gorilla_dung
	name = "dung pie"
	desc = "Weaponize your faeces."
	cooldown_time = 40 SECONDS
	spell_requirements = NONE
	antimagic_flags = NONE
	active_msg = "You hold one in."
	deactive_msg = "You relax."
	projectile_type = /obj/projectile/gorilla_dung
	icon_icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	button_icon_state = "gorilla_dung"


/datum/component/creamed/gorilla

/datum/component/creamed/gorilla/Initialize()
	SEND_SIGNAL(parent, COMSIG_MOB_CREAMED)
	creamface = mutable_appearance('fulp_modules/features/antagonists/infiltrators/icons/infils.dmi')

	var/mob/living/carbon/human/man = parent
	if(man.dna.species.bodytype & BODYTYPE_SNOUTED)
		creamface.icon_state = "dunged_lizard"
	else if(man.dna.species.bodytype & BODYTYPE_MONKEY)
		creamface.icon_state = "dunged_monkey"
	else
		creamface.icon_state = "dunged_human"

	var/atom/atom = parent
	atom.add_overlay(creamface)
