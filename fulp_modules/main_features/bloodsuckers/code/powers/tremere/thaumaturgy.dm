/*
 *	# Thaumaturgy
 *
 *	Level 1 - One shot bloodbeam spell
 *	Level 2 - Bloodbeam spell - Gives them a Blood shield until they use Bloodbeam
 *	Level 3 - Bloodbeam spell that breaks open lockers/doors - Gives them a Blood shield until they use Bloodbeam
 *	Level 4 - Bloodbeam spell that breaks open lockers/doors + double damage to victims - Gives them a Blood shield until they use Bloodbeam
 *	Level 5 - Bloodbeam spell that breaks open lockers/doors + double damage & steals blood - Gives them a Blood shield until they use Bloodbeam
 */

/datum/action/bloodsucker/targeted/tremere/thaumaturgy
	name = "Level 1: Thaumaturgy"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/thaumaturgy/two
	desc = "Fire a blood bolt at your enemy, dealing Burn damage."
	tremere_level = 1
	button_icon_state = "power_thaumaturgy"
	power_explanation = "<b>Thaumaturgy</b>:\n\
		Gives you a one shot blood bolt spell, firing it at a person deals 20 Burn damage"
	must_be_capacitated = TRUE
	bloodcost = 20
	cooldown = 60
	must_be_concious = FALSE
	message_Trigger = "Click where you wish to fire"
	///The shield this Power gives
	var/obj/item/shield/bloodsucker/blood_shield

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/two
	name = "Level 2: Thaumaturgy"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/thaumaturgy/three
	desc = "Create a Blood shield and fire a blood bolt at your enemy, dealing Burn damage."
	tremere_level = 2
	power_explanation = "<b>Thaumaturgy</b>:\n\
		Activating Thaumaturgy will temporarily give you a Blood Shield,\n\
		The blood shield has a 75% block chance, but costs 15 Blood per hit to maintain.\n\
		You will also have the ability to fire a Blood beam, ending the Power.\n\
		If the Blood beam hits a person, it will deal 20 Burn damage."
	message_Trigger = "Click where you wish to fire (using your power removes blood shield)"
	bloodcost = 40
	cooldown = 40

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/three
	name = "Level 3: Thaumaturgy"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/thaumaturgy/advanced
	desc = "Create a Blood shield and fire a blood bolt, dealing Burn damage and opening doors/lockers."
	tremere_level = 3
	power_explanation = "<b>Thaumaturgy</b>:\n\
		Activating Thaumaturgy will temporarily give you a Blood Shield,\n\
		The blood shield has a 75% block chance, but costs 15 Blood per hit to maintain.\n\
		You will also have the ability to fire a Blood beam, ending the Power.\n\
		If the Blood beam hits a person, it will deal 20 Burn damage. If it hits a locker or door, it will break it open."
	bloodcost = 50
	cooldown = 60

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/advanced
	name = "Level 4: Blood Strike"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/thaumaturgy/advanced/two
	desc = "Create a Blood shield and fire a blood bolt, dealing Burn damage and opening doors/lockers."
	tremere_level = 4
	power_explanation = "<b>Thaumaturgy</b>:\n\
		Activating Thaumaturgy will temporarily give you a Blood Shield,\n\
		The blood shield has a 75% block chance, but costs 15 Blood per hit to maintain.\n\
		You will also have the ability to fire a Blood beam, ending the Power.\n\
		If the Blood beam hits a person, it will deal 40 Burn damage.\n\
		If it hits a locker or door, it will break it open."
	background_icon_state = "tremere_power_gold_off"
	background_icon_state_on = "tremere_power_gold_on"
	background_icon_state_off = "tremere_power_gold_off"
	message_Trigger = "Click where you wish to fire (using your power removes blood shield)"
	bloodcost = 60
	cooldown = 60

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/advanced/two
	name = "Level 5: Blood Strike"
	upgraded_power = null
	desc = "Create a Blood shield and fire a blood bolt, dealing Burn damage, stealing Blood and opening doors/lockers."
	tremere_level = 5
	power_explanation = "<b>Thaumaturgy</b>:\n\
		Activating Thaumaturgy will temporarily give you a Blood Shield,\n\
		The blood shield has a 75% block chance, but costs 15 Blood per hit to maintain.\n\
		You will also have the ability to fire a Blood beam, ending the Power.\n\
		If the Blood beam hits a person, it will deal 40 Burn damage and steal blood to feed yourself.\n\
		If it hits a locker or door, it will break it open."
	bloodcost = 80
	cooldown = 80


/datum/action/bloodsucker/targeted/tremere/thaumaturgy/CheckValidTarget(atom/A)
	return TRUE

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/CheckCanUse(display_error)
	if(!..())
		return
	if(!active) // Only do this when first activating.
		var/mob/living/user = owner
		if(tremere_level >= 2) // Only if we're at least level 2.
			blood_shield = new
			if(!user.put_in_inactive_hand(blood_shield))
				owner.balloon_alert(owner, "off hand is full!")
				to_chat(user, span_notice("Blood shield couldn't be activated as your off hand is full."))
				return FALSE
			user.visible_message(span_warning("[user]\'s hands begins to bleed and forms into some form of a shield!"), span_warning("We activate our Blood shield!"), span_hear("You hear liquids forming together."))
		to_chat(user, span_notice("You prepare Thaumaturgy."))
	return TRUE

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/DeactivatePower()
	if(blood_shield)
		qdel(blood_shield)
	return ..()

/datum/action/bloodsucker/targeted/tremere/thaumaturgy/FireTargetedPower(atom/A)
	. = ..()

	var/mob/living/user = owner
	owner.balloon_alert(owner, "you fire a blood bolt!")
	to_chat(user, span_warning("You fire a blood bolt!"))
	user.changeNext_move(CLICK_CD_RANGE)
	user.newtonian_move(get_dir(A, user))
	var/obj/projectile/magic/arcane_barrage/bloodsucker/LE = new(user.loc)
	LE.bloodsucker_power = src
	LE.firer = user
	LE.def_zone = ran_zone(user.zone_selected)
	LE.preparePixelProjectile(A, user)
	INVOKE_ASYNC(LE, /obj/projectile.proc/fire)
	playsound(user, 'sound/magic/wand_teleport.ogg', 60, TRUE)

/*
 *	# Blood Bolt
 *
 *	This is the projectile this Power will fire.
 */

/obj/projectile/magic/arcane_barrage/bloodsucker
	name = "blood bolt"
	icon_state = "mini_leaper"
	damage = 20
	var/datum/action/bloodsucker/targeted/tremere/thaumaturgy/bloodsucker_power

/obj/projectile/magic/arcane_barrage/bloodsucker/on_hit(target)
	if(istype(target, /obj/structure/closet) && bloodsucker_power.tremere_level >= 3)
		var/obj/structure/closet/C = target
		if(C)
			C.welded = FALSE
			C.locked = FALSE
			C.broken = TRUE
			C.update_appearance()
			qdel(src)
			return BULLET_ACT_HIT
	else if(istype(target, /obj/machinery/door) && bloodsucker_power.tremere_level >= 3)
		var/obj/machinery/door/D = target
		D.open(2)
		qdel(src)
		return BULLET_ACT_HIT
	else if(ismob(target))
		if(bloodsucker_power.tremere_level >= 4)
			damage = 40
		if(bloodsucker_power.tremere_level >= 5)
			var/mob/living/user = bloodsucker_power.owner
			var/mob/living/person_hit = target
			person_hit.blood_volume -= 100
			user.blood_volume += 100
		qdel(src)
		return BULLET_ACT_HIT
	. = ..()

/*
 *	# Blood Shield
 *
 *	The shield spawned when using Thaumaturgy when strong enough.
 *	Copied mostly from '/obj/item/shield/changeling'
 */

/obj/item/shield/bloodsucker
	name = "bloodshield"
	desc = "A shield made out of blood, requiring blood to sustain hits."
	item_flags = ABSTRACT | DROPDEL
	icon = 'fulp_modules/main_features/bloodsuckers/icons/vamp_obj.dmi'
	icon_state = "blood_shield"
	lefthand_file = 'fulp_modules/main_features/bloodsuckers/icons/bs_leftinhand.dmi'
	righthand_file = 'fulp_modules/main_features/bloodsuckers/icons/bs_rightinhand.dmi'
	block_chance = 75

/obj/item/shield/bloodsucker/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, BLOODSUCKER_TRAIT)

/obj/item/shield/bloodsucker/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(bloodsuckerdatum)
		bloodsuckerdatum.AddBloodVolume(-15)
	return ..()
