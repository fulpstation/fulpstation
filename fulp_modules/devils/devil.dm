#define DEVIL_BODYPART "devil"
#define DEVIL_HANDS_LAYER 1
#define DEVIL_HEAD_LAYER 2
#define DEVIL_TOTAL_LAYERS 2

/mob/living/carbon/true_devil
	name = "True Devil"
	desc = "A pile of infernal energy, taking a vaguely humanoid form."
	icon = 'fulp_modules/devils/devil_icon/devils.dmi'
	icon_state = "true_devil"
	gender = NEUTER
	health = 350
	maxHealth = 350
	ventcrawler = VENTCRAWLER_NONE
	density = TRUE
	pass_flags =  0
	sight = (SEE_TURFS | SEE_OBJS)
	status_flags = CANPUSH
	mob_size = MOB_SIZE_LARGE
	held_items = list(null, null)
	bodyparts = list(
		/obj/item/bodypart/chest/devil,
		/obj/item/bodypart/head/devil,
		/obj/item/bodypart/l_arm/devil,
		/obj/item/bodypart/r_arm/devil,
		/obj/item/bodypart/r_leg/devil,
		/obj/item/bodypart/l_leg/devil,
		)
	hud_type = /datum/hud/devil
	var/ascended = FALSE
	var/mob/living/oldform
	var/list/devil_overlays[DEVIL_TOTAL_LAYERS]

/// Arch devil
/mob/living/carbon/true_devil/arch_devil
	health = 500
	maxHealth = 500
	ascended = TRUE
	icon_state = "arch_devil"

/mob/living/carbon/true_devil/Initialize()
	create_bodyparts()
	create_internal_organs()
	grant_all_languages()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_ADVANCEDTOOLUSER, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_NOBREATH, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_NEVER_WOUNDED, INNATE_TRAIT)
	AddSpell(new /obj/effect/proc_holder/spell/targeted/conjure_item/summon_pitchfork(null))
	AddSpell(new /obj/effect/proc_holder/spell/targeted/conjure_item/violin(null))
	AddSpell(new /obj/effect/proc_holder/spell/aimed/fireball/hellish(null))
	AddSpell(new /obj/effect/proc_holder/spell/targeted/summon_dancefloor(null))

/mob/living/carbon/true_devil/create_internal_organs()
	internal_organs += new /obj/item/organ/brain
	internal_organs += new /obj/item/organ/tongue
	internal_organs += new /obj/item/organ/eyes
	internal_organs += new /obj/item/organ/ears/invincible //Prevents hearing loss from poorly aimed fireballs.
	..()

/mob/living/carbon/true_devil/death(gibbed)
	set_stat(DEAD)
	..(gibbed)
	drop_all_held_items()

/mob/living/carbon/true_devil/examine(mob/user)
	. = list("<span class='info'>*---------*\nThis is [icon2html(src, user)] <b>[src]</b>!")

	for(var/obj/item/I in held_items) // Left hand items
		if(!(I.item_flags & ABSTRACT))
			. += "It is holding [I.get_examine_string(user)] in its [get_held_index_name(get_held_index_of_item(I))]."

	if(!client && stat != DEAD) // Braindead
		. += "The devil seems to be in deep contemplation."

	if(stat == DEAD) // Damaged
		. += "<span class='deadsay'>The hellfire seems to have been extinguished, for now at least.</span>"
	else if(health < (maxHealth/10))
		. += "<span class='warning'>You can see hellfire inside its gaping wounds.</span>"
	else if(health < (maxHealth/2))
		. += "<span class='warning'>You can see hellfire inside its wounds.</span>"
	. += "*---------*</span>"

/mob/living/carbon/true_devil/resist_buckle()
	if(buckled)
		buckled.user_unbuckle_mob(src,src)
		visible_message("<span class='warning'>[src] easily breaks out of [p_their()] handcuffs!</span>", \
					"<span class='notice'>With just a thought your handcuffs fall off.</span>")

/mob/living/carbon/true_devil/canUseTopic(atom/movable/M, be_close=FALSE, no_dexterity=FALSE, no_tk=FALSE)
	if(incapacitated())
		to_chat(src, "<span class='warning'>You can't do that right now!</span>")
		return FALSE
	if(be_close && !in_range(M, src))
		to_chat(src, "<span class='warning'>You are too far away!</span>")
		return FALSE
	return TRUE

/mob/living/carbon/true_devil/assess_threat(judgement_criteria, lasercolor = "", datum/callback/weaponcheck=null)
	return 666

/mob/living/carbon/true_devil/soundbang_act()
	return FALSE

/mob/living/carbon/true_devil/get_ear_protection()
	return 2

/mob/living/carbon/true_devil/attacked_by(obj/item/I, mob/living/user, def_zone)
	apply_damage(I.force, I.damtype, def_zone)
	var/message_verb = ""
	if(length(I.attack_verb_continuous))
		message_verb = "[pick(I.attack_verb_continuous)]"
	else if(I.force)
		message_verb = "attacked"

	var/attack_message = "[src] has been [message_verb] with [I]."
	if(user)
		user.do_attack_animation(src)
		if(user in viewers(src, null))
			attack_message = "[user] has [message_verb] [src] with [I]!"
	if(message_verb)
		visible_message("<span class='danger'>[attack_message]</span>",
		"<span class='userdanger'>[attack_message]</span>", null, COMBAT_MESSAGE_RANGE)
	return TRUE

/mob/living/carbon/true_devil/can_be_revived()
	return 1

/// They're immune to fire.
/mob/living/carbon/true_devil/resist()
	set name = "Resist"
	set category = "IC"

	if(!can_resist())
		return
	changeNext_move(CLICK_CD_RESIST)

	SEND_SIGNAL(src, COMSIG_LIVING_RESIST, src)
	if(!HAS_TRAIT(src, TRAIT_RESTRAINED) && pulledby) // Resisting Grabs
		log_combat(src, pulledby, "resisted grab")
		resist_grab()
		return

	if(on_fire)
		resist_fire() // Resisting out of Fires

/mob/living/carbon/true_devil/attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(.)
		switch(M.a_intent)
			if("harm")
				var/damage = rand(1, 5)
				playsound(loc, "punch", 25, TRUE, -1)
				visible_message("<span class='danger'>[M] punches [src]!</span>", \
						"<span class='userdanger'>[M] punches you!</span>")
				adjustBruteLoss(damage)
				log_combat(M, src, "attacked")
				updatehealth()
			if("disarm")
				if(!(mobility_flags & MOBILITY_STAND) && !ascended) //No stealing the arch devil's pitchfork.
					if(prob(5))
						Unconscious(40)
						playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
						log_combat(M, src, "pushed")
						visible_message("<span class='danger'>[M] pushes [src] down!</span>", \
							"<span class='userdanger'>[M] pushes you down!</span>")
					else
						if(prob(25))
							dropItemToGround(get_active_held_item())
							playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
							visible_message("<span class='danger'>[M] disarms [src]!</span>", \
							"<span class='userdanger'>[M] disarms you!</span>")
						else
							playsound(loc, 'sound/weapons/punchmiss.ogg', 25, TRUE, -1)
							visible_message("<span class='danger'>[M] fails to disarm [src]!</span>", \
							"<span class='userdanger'>[M] fails to disarm you!</span>")

/mob/living/carbon/true_devil/is_literate()
	return TRUE

/mob/living/carbon/true_devil/ex_act(severity, ex_target)
	if(!ascended)
		var/b_loss
		switch(severity)
			if(EXPLODE_DEVASTATE)
				b_loss = 500
			if(EXPLODE_HEAVY)
				b_loss = 150
			if(EXPLODE_LIGHT)
				b_loss = 30
		adjustBruteLoss(b_loss)
	return ..()

/mob/living/carbon/true_devil/UnarmedAttack(atom/A, proximity)
	A.attack_hand(src)

/// We don't use the bodyparts layer for devils
/mob/living/carbon/true_devil/update_body()
	return

/mob/living/carbon/true_devil/update_body_parts()
	return

/// Devils don't have damage overlays
/mob/living/carbon/true_devil/update_damage_overlays()
	return

/////////////////////
///   INVENTORY   ///
/////////////////////

/mob/living/carbon/true_devil/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	. = ..()
	if(.)
		update_inv_hands()

/mob/living/carbon/true_devil/update_inv_hands()
	remove_overlay(DEVIL_HANDS_LAYER)
	var/list/hands_overlays = list()
	var/obj/item/l_hand = get_item_for_held_index(1) // Hardcoded 2-hands only, for now.
	var/obj/item/r_hand = get_item_for_held_index(2)

	if(r_hand)
		var/mutable_appearance/r_hand_overlay = r_hand.build_worn_icon(default_layer = DEVIL_HANDS_LAYER, default_icon_file = r_hand.righthand_file, isinhands = TRUE)

		hands_overlays += r_hand_overlay

		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			r_hand.layer = ABOVE_HUD_LAYER
			r_hand.plane = ABOVE_HUD_PLANE
			r_hand.screen_loc = ui_hand_position(get_held_index_of_item(r_hand))
			client.screen |= r_hand

	if(l_hand)
		var/mutable_appearance/l_hand_overlay = l_hand.build_worn_icon(default_layer = DEVIL_HANDS_LAYER, default_icon_file = l_hand.lefthand_file, isinhands = TRUE)

		hands_overlays += l_hand_overlay

		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			l_hand.layer = ABOVE_HUD_LAYER
			l_hand.plane = ABOVE_HUD_PLANE
			l_hand.screen_loc = ui_hand_position(get_held_index_of_item(l_hand))
			client.screen |= l_hand

	if(hands_overlays.len)
		devil_overlays[DEVIL_HANDS_LAYER] = hands_overlays
	apply_overlay(DEVIL_HANDS_LAYER)

/mob/living/carbon/true_devil/remove_overlay(cache_index)
	var/I = devil_overlays[cache_index]
	if(I)
		cut_overlay(I)
		devil_overlays[cache_index] = null

/mob/living/carbon/true_devil/apply_overlay(cache_index)
	if((. = devil_overlays[cache_index]))
		add_overlay(.)

/////////////////////
///     LIMBS     ///
/////////////////////

///HEAD
/obj/item/bodypart/head/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

///CHEST
/obj/item/bodypart/chest/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

///LEFT ARM
/obj/item/bodypart/l_arm/devil
	dismemberable = FALSE
	can_be_disabled = FALSE
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

///RIGHT ARM
/obj/item/bodypart/r_arm/devil
	dismemberable = FALSE
	can_be_disabled = FALSE
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

///LEFT LEG
/obj/item/bodypart/l_leg/devil
	dismemberable = FALSE
	can_be_disabled = FALSE
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

///RIGHT LEG
/obj/item/bodypart/r_leg/devil
	dismemberable = FALSE
	can_be_disabled = FALSE
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/////////////////////
///     HUDS      ///
/////////////////////

/datum/hud/devil/New(mob/owner)
	. = ..()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_drone_drop
	using.hud = src
	static_inventory += using

	pull_icon = new /atom/movable/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.update_icon()
	pull_icon.screen_loc = ui_drone_pull
	pull_icon.hud = src
	static_inventory += pull_icon

	build_hand_slots()

	using = new /atom/movable/screen/inventory()
	using.name = "hand"
	using.icon = ui_style
	using.icon_state = "swap_1_m"
	using.screen_loc = ui_swaphand_position(owner,1)
	using.layer = HUD_LAYER
	using.plane = HUD_PLANE
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/inventory()
	using.name = "hand"
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	using.layer = HUD_LAYER
	using.plane = HUD_PLANE
	using.hud = src
	static_inventory += using

	zone_select = new /atom/movable/screen/zone_sel()
	zone_select.icon = ui_style
	zone_select.hud = src
	zone_select.update_icon()


/datum/hud/devil/persistent_inventory_update()
	if(!mymob)
		return
	var/mob/living/carbon/true_devil/D = mymob

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in D.held_items)
			I.screen_loc = ui_hand_position(D.get_held_index_of_item(I))
			D.client.screen += I
	else
		for(var/obj/item/I in D.held_items)
			I.screen_loc = null
			D.client.screen -= I
