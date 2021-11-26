//This file contains all Lavaland megafauna loot. Does not include crusher trophies.


//Hierophant: Hierophant Club

#define HIEROPHANT_BLINK_RANGE 5
#define HIEROPHANT_BLINK_COOLDOWN 15 SECONDS

/datum/action/innate/dash/hierophant
	current_charges = 1
	max_charges = 1
	charge_rate = HIEROPHANT_BLINK_COOLDOWN
	recharge_sound = null
	phasein = /obj/effect/temp_visual/hierophant/blast/visual
	phaseout = /obj/effect/temp_visual/hierophant/blast/visual
	// It's a simple purple beam, works well enough for the purple hiero effects.
	beam_effect = "plasmabeam"

/datum/action/innate/dash/hierophant/teleport(mob/user, atom/target)
	var/dist = get_dist(user, target)
	if(dist > HIEROPHANT_BLINK_RANGE)
		user.balloon_alert(user, "destination out of range!")
		return
	var/turf/target_turf = get_turf(target)
	if(target_turf.is_blocked_turf_ignore_climbable())
		user.balloon_alert(user, "destination blocked!")
		return
	. = ..()
	if(!current_charges)
		var/obj/item/hierophant_club/club = src.target
		if(istype(club))
			club.blink_charged = FALSE
			club.update_appearance()

/datum/action/innate/dash/hierophant/charge()
	var/obj/item/hierophant_club/club = target
	if(istype(club))
		club.blink_charged = TRUE
		club.update_appearance()

	current_charges = clamp(current_charges + 1, 0, max_charges)

	if(recharge_sound)
		playsound(dashing_item, recharge_sound, 50, TRUE)

	if(!owner)
		return
	owner.update_action_buttons_icon()
	to_chat(owner, span_notice("[src] now has [current_charges]/[max_charges] charges."))

/obj/item/hierophant_club
	name = "hierophant club"
	desc = "The strange technology of this large club allows various nigh-magical teleportation feats. It used to beat you, but now you can set the beat."
	icon_state = "hierophant_club_ready_beacon"
	inhand_icon_state = "hierophant_club_ready_beacon"
	icon = 'icons/obj/lavaland/artefacts.dmi'
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	force = 15
	attack_verb_continuous = list("clubs", "beats", "pummels")
	attack_verb_simple = list("club", "beat", "pummel")
	hitsound = 'sound/weapons/sonic_jackhammer.ogg'
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	actions_types = list(/datum/action/item_action/vortex_recall)
	/// Linked teleport beacon for the group teleport functionality.
	var/obj/effect/hierophant/beacon
	/// TRUE if currently doing a teleport to the beacon, FALSE otherwise.
	var/teleporting = FALSE //if we ARE teleporting
	/// Action enabling the blink-dash functionality.
	var/datum/action/innate/dash/hierophant/blink
	/// Whether the blink ability is activated. IF TRUE, left clicking a location will blink to it. If FALSE, this is disabled.
	var/blink_activated = TRUE
	/// Whether the blink is charged. Set and unset by the blink action. Used as part of setting the appropriate icon states.
	var/blink_charged = TRUE

/obj/item/hierophant_club/Initialize(mapload)
	. = ..()
	blink = new(src)

/obj/item/hierophant_club/Destroy()
	. = ..()
	QDEL_NULL(blink)

/obj/item/hierophant_club/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/hierophant_club/examine(mob/user)
	. = ..()
	. += span_hierophant_warning("The[beacon ? " beacon is not currently":"re is a beacon"] attached.")

/obj/item/hierophant_club/suicide_act(mob/living/user)
	say("Xverwpsgexmrk...", forced = "hierophant club suicide")
	user.visible_message(span_suicide("[user] holds [src] into the air! It looks like [user.p_theyre()] trying to commit suicide!"))
	new/obj/effect/temp_visual/hierophant/telegraph(get_turf(user))
	playsound(user,'sound/machines/airlockopen.ogg', 75, TRUE)
	user.visible_message(span_hierophant_warning("[user] fades out, leaving [user.p_their()] belongings behind!"))
	for(var/obj/item/I in user)
		if(I != src)
			user.dropItemToGround(I)
	for(var/turf/T in RANGE_TURFS(1, user))
		new /obj/effect/temp_visual/hierophant/blast/visual(T, user, TRUE)
	user.dropItemToGround(src) //Drop us last, so it goes on top of their stuff
	qdel(user)

/obj/item/hierophant_club/attack_self(mob/user)
	blink_activated = !blink_activated
	to_chat(user, span_notice("You [blink_activated ? "enable" : "disable"] the blink function on [src]."))

/obj/item/hierophant_club/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	// If our target is the beacon and the hierostaff is next to the beacon, we're trying to pick it up.
	if((target == beacon) && target.Adjacent(src))
		return
	if(blink_activated)
		blink.teleport(user, target)

/obj/item/hierophant_club/update_icon_state()
	icon_state = inhand_icon_state = "hierophant_club[blink_charged ? "_ready":""][(!QDELETED(beacon)) ? "":"_beacon"]"
	return ..()

/obj/item/hierophant_club/ui_action_click(mob/user, action)
	if(!user.is_holding(src)) //you need to hold the staff to teleport
		to_chat(user, span_warning("You need to hold the club in your hands to [beacon ? "teleport with it":"detach the beacon"]!"))
		return
	if(!beacon || QDELETED(beacon))
		if(isturf(user.loc))
			user.visible_message(span_hierophant_warning("[user] starts fiddling with [src]'s pommel..."), \
			span_notice("You start detaching the hierophant beacon..."))
			if(do_after(user, 50, target = user) && !beacon)
				var/turf/T = get_turf(user)
				playsound(T,'sound/magic/blind.ogg', 200, TRUE, -4)
				new /obj/effect/temp_visual/hierophant/telegraph/teleport(T, user)
				beacon = new/obj/effect/hierophant(T)
				user.update_action_buttons_icon()
				user.visible_message(span_hierophant_warning("[user] places a strange machine beneath [user.p_their()] feet!"), \
				"[span_hierophant("You detach the hierophant beacon, allowing you to teleport yourself and any allies to it at any time!")]\n\
				[span_notice("You can remove the beacon to place it again by striking it with the club.")]")
		else
			to_chat(user, span_warning("You need to be on solid ground to detach the beacon!"))
		return
	if(get_dist(user, beacon) <= 2) //beacon too close abort
		to_chat(user, span_warning("You are too close to the beacon to teleport to it!"))
		return
	var/turf/beacon_turf = get_turf(beacon)
	if(beacon_turf?.is_blocked_turf(TRUE))
		to_chat(user, span_warning("The beacon is blocked by something, preventing teleportation!"))
		return
	if(!isturf(user.loc))
		to_chat(user, span_warning("You don't have enough space to teleport from here!"))
		return
	teleporting = TRUE //start channel
	user.update_action_buttons_icon()
	user.visible_message(span_hierophant_warning("[user] starts to glow faintly..."))
	beacon.icon_state = "hierophant_tele_on"
	var/obj/effect/temp_visual/hierophant/telegraph/edge/TE1 = new /obj/effect/temp_visual/hierophant/telegraph/edge(user.loc)
	var/obj/effect/temp_visual/hierophant/telegraph/edge/TE2 = new /obj/effect/temp_visual/hierophant/telegraph/edge(beacon.loc)
	if(do_after(user, 40, target = user) && user && beacon)
		var/turf/T = get_turf(beacon)
		var/turf/source = get_turf(user)
		if(T.is_blocked_turf(TRUE))
			teleporting = FALSE
			to_chat(user, span_warning("The beacon is blocked by something, preventing teleportation!"))
			user.update_action_buttons_icon()
			beacon.icon_state = "hierophant_tele_off"
			return
		new /obj/effect/temp_visual/hierophant/telegraph(T, user)
		new /obj/effect/temp_visual/hierophant/telegraph(source, user)
		playsound(T,'sound/magic/wand_teleport.ogg', 200, TRUE)
		playsound(source,'sound/machines/airlockopen.ogg', 200, TRUE)
		if(!do_after(user, 3, target = user) || !user || !beacon || QDELETED(beacon)) //no walking away shitlord
			teleporting = FALSE
			if(user)
				user.update_action_buttons_icon()
			if(beacon)
				beacon.icon_state = "hierophant_tele_off"
			return
		if(T.is_blocked_turf(TRUE))
			teleporting = FALSE
			to_chat(user, span_warning("The beacon is blocked by something, preventing teleportation!"))
			user.update_action_buttons_icon()
			beacon.icon_state = "hierophant_tele_off"
			return
		user.log_message("teleported self from [AREACOORD(source)] to [beacon]", LOG_GAME)
		new /obj/effect/temp_visual/hierophant/telegraph/teleport(T, user)
		new /obj/effect/temp_visual/hierophant/telegraph/teleport(source, user)
		for(var/t in RANGE_TURFS(1, T))
			new /obj/effect/temp_visual/hierophant/blast/visual(t, user, TRUE)
		for(var/t in RANGE_TURFS(1, source))
			new /obj/effect/temp_visual/hierophant/blast/visual(t, user, TRUE)
		for(var/mob/living/L in range(1, source))
			INVOKE_ASYNC(src, .proc/teleport_mob, source, L, T, user)
		sleep(6) //at this point the blasts detonate
		if(beacon)
			beacon.icon_state = "hierophant_tele_off"
	else
		qdel(TE1)
		qdel(TE2)
	if(beacon)
		beacon.icon_state = "hierophant_tele_off"
	teleporting = FALSE
	if(user)
		user.update_action_buttons_icon()

/obj/item/hierophant_club/proc/teleport_mob(turf/source, mob/teleporting, turf/target, mob/user)
	var/turf/turf_to_teleport_to = get_step(target, get_dir(source, teleporting)) //get position relative to caster
	if(!turf_to_teleport_to || turf_to_teleport_to.is_blocked_turf(TRUE))
		return
	animate(teleporting, alpha = 0, time = 2, easing = EASE_OUT) //fade out
	sleep(1)
	if(!teleporting)
		return
	teleporting.visible_message(span_hierophant_warning("[teleporting] fades out!"))
	sleep(2)
	if(!teleporting)
		return
	var/success = do_teleport(teleporting, turf_to_teleport_to, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
	sleep(1)
	if(!teleporting)
		return
	animate(teleporting, alpha = 255, time = 2, easing = EASE_IN) //fade IN
	sleep(1)
	if(!teleporting)
		return
	teleporting.visible_message(span_hierophant_warning("[teleporting] fades in!"))
	if(user != teleporting && success)
		log_combat(user, teleporting, "teleported", null, "from [AREACOORD(source)]")

/obj/item/hierophant_club/pickup(mob/living/user)
	. = ..()
	blink.Grant(user, src)
	user.update_icons()

/obj/item/hierophant_club/dropped(mob/user)
	. = ..()
	blink.Remove(user)
	user.update_icons()

#undef HIEROPHANT_BLINK_RANGE
#undef HIEROPHANT_BLINK_COOLDOWN

//Bubblegum: Mayhem in a Bottle, H.E.C.K. Suit, Soulscythe

/obj/item/mayhem
	name = "mayhem in a bottle"
	desc = "A magically infused bottle of blood, the scent of which will drive anyone nearby into a murderous frenzy."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"

/obj/item/mayhem/attack_self(mob/user)
	for(var/mob/living/carbon/human/target in range(7,user))
		target.apply_status_effect(STATUS_EFFECT_MAYHEM)
	to_chat(user, span_notice("You shatter the bottle!"))
	playsound(user.loc, 'sound/effects/glassbr1.ogg', 100, TRUE)
	message_admins(span_adminnotice("[ADMIN_LOOKUPFLW(user)] has activated a bottle of mayhem!"))
	user.log_message("activated a bottle of mayhem", LOG_ATTACK)
	qdel(src)

/obj/item/clothing/suit/space/hardsuit/hostile_environment
	name = "H.E.C.K. suit"
	desc = "Hostile Environment Cross-Kinetic Suit: A suit designed to withstand the wide variety of hazards from Lavaland. It wasn't enough for its last owner."
	icon_state = "hostile_env"
	inhand_icon_state = "hostile_env"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/hostile_environment
	slowdown = 0
	armor = list(MELEE = 70, BULLET = 40, LASER = 10, ENERGY = 20, BOMB = 50, BIO = 100, FIRE = 100, ACID = 100)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe)

/obj/item/clothing/suit/space/hardsuit/hostile_environment/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/radiation_protected_clothing)

/obj/item/clothing/suit/space/hardsuit/hostile_environment/process(delta_time)
	. = ..()
	var/mob/living/carbon/wearer = loc
	if(istype(wearer) && DT_PROB(1, delta_time)) //cursed by bubblegum
		if(DT_PROB(7.5, delta_time))
			new /datum/hallucination/oh_yeah(wearer)
			to_chat(wearer, span_colossus("<b>[pick("I AM IMMORTAL.","I SHALL TAKE BACK WHAT'S MINE.","I SEE YOU.","YOU CANNOT ESCAPE ME FOREVER.","DEATH CANNOT HOLD ME.")]</b>"))
		else
			to_chat(wearer, span_warning("[pick("You hear faint whispers.","You smell ash.","You feel hot.","You hear a roar in the distance.")]"))

/obj/item/clothing/head/helmet/space/hardsuit/hostile_environment
	name = "H.E.C.K. helmet"
	desc = "Hostile Environiment Cross-Kinetic Helmet: A helmet designed to withstand the wide variety of hazards from Lavaland. It wasn't enough for its last owner."
	icon_state = "hardsuit0-heck"
	inhand_icon_state = "hostile_env"
	hardsuit_type = "heck"
	w_class = WEIGHT_CLASS_NORMAL
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = list(MELEE = 70, BULLET = 40, LASER = 10, ENERGY = 20, BOMB = 50, BIO = 100, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF
	actions_types = list()

/obj/item/clothing/head/helmet/space/hardsuit/hostile_environment/Initialize(mapload)
	. = ..()
	update_appearance()
	AddComponent(/datum/component/butchering, 5, 150, null, null, null, TRUE, CALLBACK(src, .proc/consume))
	AddElement(/datum/element/radiation_protected_clothing)

/obj/item/clothing/head/helmet/space/hardsuit/hostile_environment/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, .proc/butcher_target)
	var/datum/component/butchering/butchering = GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = TRUE
	to_chat(user, span_notice("You feel a bloodlust. You can now butcher corpses with your bare arms."))

/obj/item/clothing/head/helmet/space/hardsuit/hostile_environment/dropped(mob/user, silent = FALSE)
	. = ..()
	UnregisterSignal(user, COMSIG_HUMAN_EARLY_UNARMED_ATTACK)
	var/datum/component/butchering/butchering = GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = FALSE
	to_chat(user, span_notice("You lose your bloodlust."))

/obj/item/clothing/head/helmet/space/hardsuit/hostile_environment/proc/butcher_target(mob/user, atom/target, proximity)
	SIGNAL_HANDLER
	if(!isliving(target))
		return
	return SEND_SIGNAL(src, COMSIG_ITEM_ATTACK, target, user)

/obj/item/clothing/head/helmet/space/hardsuit/hostile_environment/proc/consume(mob/living/user, mob/living/butchered)
	if(butchered.mob_biotypes & (MOB_ROBOTIC | MOB_SPIRIT))
		return
	var/health_consumed = butchered.maxHealth * 0.1
	user.heal_ordered_damage(health_consumed, list(BRUTE, BURN, TOX))
	to_chat(user, span_notice("You heal from the corpse of [butchered]."))
	var/datum/client_colour/color = user.add_client_colour(/datum/client_colour/bloodlust)
	QDEL_IN(color, 1 SECONDS)

/obj/item/clothing/head/helmet/space/hardsuit/hostile_environment/update_overlays()
	. = ..()
	var/mutable_appearance/glass_overlay = mutable_appearance(icon, "hostile_env_glass")
	glass_overlay.appearance_flags = RESET_COLOR
	. += glass_overlay

/obj/item/clothing/head/helmet/space/hardsuit/hostile_environment/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/glass_overlay = mutable_appearance('icons/mob/clothing/head.dmi', "hostile_env_glass")
		glass_overlay.appearance_flags = RESET_COLOR
		. += glass_overlay

#define MAX_BLOOD_LEVEL 100

/obj/item/soulscythe
	name = "soulscythe"
	desc = "An old relic of hell created by devils to establish themselves as the leadership of hell over the demons. It grows stronger while it possesses a powerful soul."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "soulscythe"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	attack_verb_continuous = list("chops", "slices", "cuts", "reaps")
	attack_verb_simple = list("chop", "slice", "cut", "reap")
	hitsound = 'sound/weapons/bladeslice.ogg'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	force = 20
	throwforce = 17
	armour_penetration = 50
	sharpness = SHARP_EDGED
	bare_wound_bonus = 10
	layer = MOB_LAYER
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	/// Soulscythe mob in the scythe
	var/mob/living/simple_animal/soulscythe/soul
	/// Are we grabbing a spirit?
	var/using = FALSE
	/// Currently charging?
	var/charging = FALSE
	/// Cooldown between moves
	COOLDOWN_DECLARE(move_cooldown)
	/// Cooldown between attacks
	COOLDOWN_DECLARE(attack_cooldown)

/obj/item/soulscythe/Initialize(mapload)
	. = ..()
	soul = new(src)
	RegisterSignal(soul, COMSIG_LIVING_RESIST, .proc/on_resist)
	RegisterSignal(soul, COMSIG_MOB_ATTACK_RANGED, .proc/on_attack)
	RegisterSignal(soul, COMSIG_MOB_ATTACK_RANGED_SECONDARY, .proc/on_secondary_attack)
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, .proc/on_integrity_change)

/obj/item/soulscythe/examine(mob/user)
	. = ..()
	. += soul.ckey ? span_nicegreen("There is a soul inhabiting it.") : span_danger("It's dormant.")

/obj/item/soulscythe/attack(mob/living/attacked, mob/living/user, params)
	. = ..()
	if(attacked.stat != DEAD)
		give_blood(10)

/obj/item/soulscythe/attack_hand(mob/user, list/modifiers)
	if(soul.ckey && !soul.faction_check_mob(user))
		to_chat(user, span_warning("You can't pick up [src]!"))
		return
	return ..()

/obj/item/soulscythe/pickup(mob/user)
	. = ..()
	if(soul.ckey)
		animate(src) //stop spinnage

/obj/item/soulscythe/dropped(mob/user, silent)
	. = ..()
	if(soul.ckey)
		reset_spin() //resume spinnage

/obj/item/soulscythe/attack_self(mob/user, modifiers)
	if(using || soul.ckey || soul.stat)
		return
	if(!(GLOB.ghost_role_flags & GHOSTROLE_STATION_SENTIENCE))
		balloon_alert(user, "you can't awaken the scythe!")
		return
	using = TRUE
	balloon_alert(user, "you hold the scythe up...")
	ADD_TRAIT(src, TRAIT_NODROP, type)
	var/list/mob/dead/observer/candidates = poll_ghost_candidates("Do you want to play as [user.real_name]'s soulscythe?", ROLE_PAI, FALSE, 100, POLL_IGNORE_POSSESSED_BLADE)
	if(LAZYLEN(candidates))
		var/mob/dead/observer/picked_ghost = pick(candidates)
		soul.ckey = picked_ghost.ckey
		soul.copy_languages(user, LANGUAGE_MASTER) //Make sure the sword can understand and communicate with the user.
		soul.update_atom_languages()
		soul.faction = list("[REF(user)]")
		balloon_alert(user, "the scythe glows up")
		add_overlay("soulscythe_gem")
		density = TRUE
		if(!ismob(loc))
			reset_spin()
	else
		balloon_alert(user, "the scythe is dormant!")
	REMOVE_TRAIT(src, TRAIT_NODROP, type)
	using = FALSE

/obj/item/soulscythe/relaymove(mob/living/user, direction)
	if(!COOLDOWN_FINISHED(src, move_cooldown) || charging)
		return
	if(!isturf(loc))
		balloon_alert(user, "resist out!")
		COOLDOWN_START(src, move_cooldown, 1 SECONDS)
		return
	if(!use_blood(1, FALSE))
		return
	if(pixel_x != base_pixel_x || pixel_y != base_pixel_y)
		animate(src, 0.2 SECONDS, pixel_x = base_pixel_y, pixel_y = base_pixel_y, flags = ANIMATION_PARALLEL)
	Move(get_step(src, direction), direction)
	COOLDOWN_START(src, move_cooldown, (direction in GLOB.cardinals) ? 0.1 SECONDS : 0.2 SECONDS)

/obj/item/soulscythe/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!charging)
		return
	charging = FALSE
	throwforce *= 0.5
	reset_spin()
	if(ismineralturf(hit_atom))
		var/turf/closed/mineral/hit_rock = hit_atom
		hit_rock.gets_drilled()
	if(isliving(hit_atom))
		var/mob/living/hit_mob = hit_atom
		if(hit_mob.stat != DEAD)
			give_blood(15)

/obj/item/soulscythe/AllowClick()
	return TRUE

/obj/item/soulscythe/proc/use_blood(amount = 0, message = TRUE)
	if(amount > soul.blood_level)
		if(message)
			to_chat(soul, span_warning("Not enough blood!"))
		return FALSE
	soul.blood_level -= amount
	return TRUE

/obj/item/soulscythe/proc/give_blood(amount)
	soul.blood_level = min(MAX_BLOOD_LEVEL, soul.blood_level + amount)

/obj/item/soulscythe/proc/on_resist(mob/living/user)
	SIGNAL_HANDLER

	if(isturf(loc))
		return
	INVOKE_ASYNC(src, .proc/break_out)

/obj/item/soulscythe/proc/break_out()
	if(!use_blood(10))
		return
	balloon_alert(soul, "you resist...")
	if(!do_after(soul, 5 SECONDS, target = src, timed_action_flags = IGNORE_TARGET_LOC_CHANGE))
		balloon_alert(soul, "interrupted!")
		return
	balloon_alert(soul, "you break out")
	if(ismob(loc))
		var/mob/holder = loc
		holder.temporarilyRemoveItemFromInventory(src)
	forceMove(drop_location())

/obj/item/soulscythe/proc/on_integrity_change(datum/source, old_value, new_value)
	SIGNAL_HANDLER

	soul.set_health(new_value)

/obj/item/soulscythe/proc/on_attack(mob/living/source, atom/attacked_atom, modifiers)
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, attack_cooldown) || !isturf(loc))
		return
	if(get_dist(source, attacked_atom) > 1)
		INVOKE_ASYNC(src, .proc/shoot_target, attacked_atom)
	else
		INVOKE_ASYNC(src, .proc/slash_target, attacked_atom)

/obj/item/soulscythe/proc/on_secondary_attack(mob/living/source, atom/attacked_atom, modifiers)
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, attack_cooldown) || !isturf(loc))
		return
	INVOKE_ASYNC(src, .proc/charge_target, attacked_atom)

/obj/item/soulscythe/proc/shoot_target(atom/attacked_atom)
	if(!use_blood(15))
		return
	COOLDOWN_START(src, attack_cooldown, 3 SECONDS)
	var/obj/projectile/projectile = new /obj/projectile/soulscythe(get_turf(src))
	projectile.preparePixelProjectile(attacked_atom, src)
	projectile.firer = src
	projectile.fire(null, attacked_atom)
	visible_message(span_danger("[src] fires at [attacked_atom]!"), span_notice("You fire at [attacked_atom]!"))
	playsound(src, 'sound/magic/fireball.ogg', 50, TRUE)

/obj/item/soulscythe/proc/slash_target(atom/attacked_atom)
	if(isliving(attacked_atom) && use_blood(10))
		var/mob/living/attacked_mob = attacked_atom
		if(attacked_mob.stat != DEAD)
			give_blood(15)
		attacked_mob.apply_damage(damage = force * (ishostile(attacked_mob) ? 2 : 1), sharpness = SHARP_EDGED, bare_wound_bonus = 5)
		to_chat(attacked_mob, span_userdanger("You're slashed by [src]!"))
	else if((ismachinery(attacked_atom) || isstructure(attacked_atom)) && use_blood(5))
		var/obj/attacked_obj = attacked_atom
		attacked_obj.take_damage(force, BRUTE, MELEE, FALSE)
	else
		return
	COOLDOWN_START(src, attack_cooldown, 1 SECONDS)
	animate(src)
	SpinAnimation(5)
	addtimer(CALLBACK(src, .proc/reset_spin), 1 SECONDS)
	visible_message(span_danger("[src] slashes [attacked_atom]!"), span_notice("You slash [attacked_atom]!"))
	playsound(src, 'sound/weapons/bladeslice.ogg', 50, TRUE)
	do_attack_animation(attacked_atom, ATTACK_EFFECT_SLASH)

/obj/item/soulscythe/proc/charge_target(atom/attacked_atom)
	if(charging || !use_blood(30))
		return
	COOLDOWN_START(src, attack_cooldown, 5 SECONDS)
	animate(src)
	charging = TRUE
	visible_message(span_danger("[src] starts charging..."))
	balloon_alert(soul, "you start charging...")
	if(!do_after(soul, 2 SECONDS, target = src, timed_action_flags = IGNORE_TARGET_LOC_CHANGE))
		balloon_alert(soul, "interrupted!")
		return
	visible_message(span_danger("[src] charges at [attacked_atom]!"), span_notice("You charge at [attacked_atom]!"))
	new /obj/effect/temp_visual/mook_dust(get_turf(src))
	playsound(src, 'sound/weapons/thudswoosh.ogg', 50, TRUE)
	SpinAnimation(1)
	throwforce *= 2
	throw_at(attacked_atom, 10, 3, soul, FALSE)

/obj/item/soulscythe/proc/reset_spin()
	animate(src)
	SpinAnimation(15)

/mob/living/simple_animal/soulscythe
	name = "mysterious spirit"
	maxHealth = 200
	health = 200
	gender = NEUTER
	mob_biotypes = MOB_SPIRIT
	faction = list()
	/// Blood level, used for movement and abilities in a soulscythe
	var/blood_level = MAX_BLOOD_LEVEL

/mob/living/simple_animal/soulscythe/get_status_tab_items()
	. = ..()
	. += "Blood: [blood_level]/[MAX_BLOOD_LEVEL]"

/mob/living/simple_animal/soulscythe/Life(delta_time, times_fired)
	. = ..()
	if(!stat)
		blood_level = min(MAX_BLOOD_LEVEL, blood_level + round(1 * delta_time))

/obj/projectile/soulscythe
	name = "soulslash"
	icon_state = "soulslash"
	flag = MELEE //jokair
	damage = 15
	light_range = 1
	light_power = 1
	light_color = LIGHT_COLOR_BLOOD_MAGIC

/obj/projectile/soulscythe/on_hit(atom/target, blocked = FALSE)
	if(ishostile(target))
		damage *= 2
	return ..()

#undef MAX_BLOOD_LEVEL

//Ash Drake: Spectral Blade, Lava Staff, Dragon's Blood

/obj/item/melee/ghost_sword
	name = "\improper spectral blade"
	desc = "A rusted and dulled blade. It doesn't look like it'd do much damage. It glows weakly."
	icon_state = "spectral"
	inhand_icon_state = "spectral"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_BULKY
	force = 1
	throwforce = 1
	hitsound = 'sound/effects/ghost2.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "rends")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "rend")
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/summon_cooldown = 0
	var/list/mob/dead/observer/spirits

/obj/item/melee/ghost_sword/Initialize(mapload)
	. = ..()
	spirits = list()
	START_PROCESSING(SSobj, src)
	SSpoints_of_interest.make_point_of_interest(src)
	AddComponent(/datum/component/butchering, 150, 90)

/obj/item/melee/ghost_sword/Destroy()
	for(var/mob/dead/observer/G in spirits)
		G.invisibility = GLOB.observer_default_invisibility
	spirits.Cut()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/melee/ghost_sword/attack_self(mob/user)
	if(summon_cooldown > world.time)
		to_chat(user, span_warning("You just recently called out for aid. You don't want to annoy the spirits!"))
		return
	to_chat(user, span_notice("You call out for aid, attempting to summon spirits to your side."))

	notify_ghosts("[user] is raising [user.p_their()] [name], calling for your help!",
		enter_link="<a href=?src=[REF(src)];orbit=1>(Click to help)</a>",
		source = user, ignore_key = POLL_IGNORE_SPECTRAL_BLADE, header = "Spectral blade")

	summon_cooldown = world.time + 600

/obj/item/melee/ghost_sword/Topic(href, href_list)
	if(href_list["orbit"])
		var/mob/dead/observer/ghost = usr
		if(istype(ghost))
			ghost.ManualFollow(src)

/obj/item/melee/ghost_sword/process()
	ghost_check()

/obj/item/melee/ghost_sword/proc/ghost_check()
	var/ghost_counter = 0
	var/turf/T = get_turf(src)
	var/list/contents = T.get_all_contents()
	var/mob/dead/observer/current_spirits = list()
	for(var/thing in contents)
		var/atom/A = thing
		A.transfer_observers_to(src)
	for(var/i in orbiters?.orbiter_list)
		if(!isobserver(i))
			continue
		var/mob/dead/observer/G = i
		ghost_counter++
		G.invisibility = 0
		current_spirits |= G
	for(var/mob/dead/observer/G in spirits - current_spirits)
		G.invisibility = GLOB.observer_default_invisibility
	spirits = current_spirits
	return ghost_counter

/obj/item/melee/ghost_sword/attack(mob/living/target, mob/living/carbon/human/user)
	force = 0
	var/ghost_counter = ghost_check()
	force = clamp((ghost_counter * 4), 0, 75)
	user.visible_message(span_danger("[user] strikes with the force of [ghost_counter] vengeful spirits!"))
	..()

/obj/item/melee/ghost_sword/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/ghost_counter = ghost_check()
	final_block_chance += clamp((ghost_counter * 5), 0, 75)
	owner.visible_message(span_danger("[owner] is protected by a ring of [ghost_counter] ghosts!"))
	return ..()

/obj/item/dragons_blood
	name = "bottle of dragons blood"
	desc = "You're not actually going to drink this, are you?"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"

/obj/item/dragons_blood/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return

	var/mob/living/carbon/human/consumer = user
	var/random = rand(1,4)

	switch(random)
		if(1)
			to_chat(user, span_danger("Your appearance morphs to that of a very small humanoid ash dragon! You get to look like a freak without the cool abilities."))
			consumer.dna.features = list("mcolor" = "#A02720", "tail_lizard" = "Dark Tiger", "tail_human" = "None", "snout" = "Sharp", "horns" = "Curled", "ears" = "None", "wings" = "None", "frills" = "None", "spines" = "Long", "body_markings" = "Dark Tiger Body", "legs" = "Digitigrade Legs")
			consumer.eye_color = "#FEE5A3"
			consumer.set_species(/datum/species/lizard)
		if(2)
			to_chat(user, span_danger("Your flesh begins to melt! Miraculously, you seem fine otherwise."))
			consumer.set_species(/datum/species/skeleton)
		if(3)
			to_chat(user, span_danger("Power courses through you! You can now shift your form at will."))
			if(user.mind)
				var/obj/effect/proc_holder/spell/targeted/shapeshift/dragon/dragon_shapeshift = new
				user.mind.AddSpell(dragon_shapeshift)
		if(4)
			to_chat(user, span_danger("You feel like you could walk straight through lava now."))
			ADD_TRAIT(user, TRAIT_LAVA_IMMUNE, type)

	playsound(user,'sound/items/drink.ogg', 30, TRUE)
	qdel(src)

/obj/item/lava_staff
	name = "staff of lava"
	desc = "The ability to fill the emergency shuttle with lava. What more could you want out of life?"
	icon_state = "lavastaff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon = 'icons/obj/guns/magic.dmi'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	force = 18
	damtype = BURN
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	attack_verb_continuous = list("sears", "clubs", "burn")
	attack_verb_simple = list("sear", "club", "burn")
	hitsound = 'sound/weapons/sear.ogg'
	var/turf_type = /turf/open/lava/smooth/weak
	var/transform_string = "lava"
	var/reset_turf_type = /turf/open/floor/plating/asteroid/basalt
	var/reset_string = "basalt"
	var/create_cooldown = 10 SECONDS
	var/create_delay = 3 SECONDS
	var/reset_cooldown = 5 SECONDS
	var/timer = 0
	var/static/list/banned_turfs = typecacheof(list(/turf/open/space/transit, /turf/closed))

/obj/item/lava_staff/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(timer > world.time)
		return
	if(is_type_in_typecache(target, banned_turfs))
		return
	if(target in view(user.client.view, get_turf(user)))
		var/turf/open/T = get_turf(target)
		if(!istype(T))
			return
		if(!istype(T, /turf/open/lava))
			var/obj/effect/temp_visual/lavastaff/L = new /obj/effect/temp_visual/lavastaff(T)
			L.alpha = 0
			animate(L, alpha = 255, time = create_delay)
			user.visible_message(span_danger("[user] points [src] at [T]!"))
			timer = world.time + create_delay + 1
			if(do_after(user, create_delay, target = T))
				var/old_name = T.name
				if(T.TerraformTurf(turf_type, flags = CHANGETURF_INHERIT_AIR))
					user.visible_message(span_danger("[user] turns \the [old_name] into [transform_string]!"))
					message_admins("[ADMIN_LOOKUPFLW(user)] fired the lava staff at [ADMIN_VERBOSEJMP(T)]")
					log_game("[key_name(user)] fired the lava staff at [AREACOORD(T)].")
					timer = world.time + create_cooldown
					playsound(T,'sound/magic/fireball.ogg', 200, TRUE)
			else
				timer = world.time
			qdel(L)
		else
			var/old_name = T.name
			if(T.TerraformTurf(reset_turf_type, flags = CHANGETURF_INHERIT_AIR))
				user.visible_message(span_danger("[user] turns \the [old_name] into [reset_string]!"))
				timer = world.time + reset_cooldown
				playsound(T,'sound/magic/fireball.ogg', 200, TRUE)

/obj/effect/temp_visual/lavastaff
	icon_state = "lavastaff_warn"
	duration = 50

/turf/open/lava/smooth/weak
	lava_damage = 10
	lava_firestacks = 10
	temperature_damage = 2500

//Blood-Drunk Miner: Cleaving Saw


/obj/item/melee/cleaving_saw
	name = "cleaving saw"
	desc = "This saw, effective at drawing the blood of beasts, transforms into a long cleaver that makes use of centrifugal force."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	icon_state = "cleaving_saw"
	worn_icon_state = "cleaving_saw"
	attack_verb_continuous = list("attacks", "saws", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "saw", "slice", "tear", "lacerate", "rip", "dice", "cut")
	force = 12
	throwforce = 20
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/weapons/bladeslice.ogg'
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	/// Whether the saw is open or not
	var/is_open = FALSE
	/// List of factions we deal bonus damage to
	var/list/nemesis_factions = list("mining", "boss")
	/// Amount of damage we deal to the above factions
	var/faction_bonus_force = 30
	/// Whether the cleaver is actively AoE swiping something.
	var/swiping = FALSE
	/// Amount of bleed stacks gained per hit
	var/bleed_stacks_per_hit = 3
	/// Force when the saw is opened.
	var/open_force = 20
	/// Throwforce when the saw is opened.
	var/open_throwforce = 20

/obj/item/melee/cleaving_saw/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/transforming, \
		transform_cooldown_time = (CLICK_CD_MELEE * 0.25), \
		force_on = open_force, \
		throwforce_on = open_throwforce, \
		sharpness_on = sharpness, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		attack_verb_continuous_on = list("cleaves", "swipes", "slashes", "chops"), \
		attack_verb_simple_on = list("cleave", "swipe", "slash", "chop"))
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, .proc/on_transform)

/obj/item/melee/cleaving_saw/examine(mob/user)
	. = ..()
	. += span_notice("It is [is_open ? "open, will cleave enemies in a wide arc and deal additional damage to fauna":"closed, and can be used for rapid consecutive attacks that cause fauna to bleed"].")
	. += span_notice("Both modes will build up existing bleed effects, doing a burst of high damage if the bleed is built up high enough.")
	. += span_notice("Transforming it immediately after an attack causes the next attack to come out faster.")

/obj/item/melee/cleaving_saw/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is [is_open ? "closing [src] on [user.p_their()] neck" : "opening [src] into [user.p_their()] chest"]! It looks like [user.p_theyre()] trying to commit suicide!"))
	attack_self(user)
	return BRUTELOSS

/obj/item/melee/cleaving_saw/melee_attack_chain(mob/user, atom/target, params)
	. = ..()
	if(!is_open)
		user.changeNext_move(CLICK_CD_MELEE * 0.5) //when closed, it attacks very rapidly

/obj/item/melee/cleaving_saw/attack(mob/living/target, mob/living/carbon/human/user)
	if(!is_open || swiping || !target.density || get_turf(target) == get_turf(user))
		if(!is_open)
			faction_bonus_force = 0
		var/is_nemesis_faction = FALSE
		for(var/found_faction in target.faction)
			if(found_faction in nemesis_factions)
				is_nemesis_faction = TRUE
				force += faction_bonus_force
				nemesis_effects(user, target)
				break
		. = ..()
		if(is_nemesis_faction)
			force -= faction_bonus_force
		if(!is_open)
			faction_bonus_force = initial(faction_bonus_force)
	else
		var/turf/user_turf = get_turf(user)
		var/dir_to_target = get_dir(user_turf, get_turf(target))
		swiping = TRUE
		var/static/list/cleaving_saw_cleave_angles = list(0, -45, 45) //so that the animation animates towards the target clicked and not towards a side target
		for(var/i in cleaving_saw_cleave_angles)
			var/turf/turf = get_step(user_turf, turn(dir_to_target, i))
			for(var/mob/living/living_target in turf)
				if(user.Adjacent(living_target) && living_target.body_position != LYING_DOWN)
					melee_attack_chain(user, living_target)
		swiping = FALSE

/*
 * If we're attacking [target]s in our nemesis list, apply unique effects.
 *
 * user - the mob attacking with the saw
 * target - the mob being attacked
 */
/obj/item/melee/cleaving_saw/proc/nemesis_effects(mob/living/user, mob/living/target)
	if(istype(target, /mob/living/simple_animal/hostile/asteroid/elite))
		return
	var/datum/status_effect/stacking/saw_bleed/existing_bleed = target.has_status_effect(STATUS_EFFECT_SAWBLEED)
	if(existing_bleed)
		existing_bleed.add_stacks(bleed_stacks_per_hit)
	else
		target.apply_status_effect(STATUS_EFFECT_SAWBLEED, bleed_stacks_per_hit)

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Gives feedback and makes the nextmove after transforming much quicker.
 */
/obj/item/melee/cleaving_saw/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	is_open = active
	user.changeNext_move(CLICK_CD_MELEE * 0.25)

	balloon_alert(user, "[active ? "opened":"closed"] [src]")
	playsound(user ? user : src, 'sound/magic/clockwork/fellowship_armory.ogg', 35, TRUE, frequency = 90000 - (is_open * 30000))
	return COMPONENT_NO_DEFAULT_MESSAGE

//Legion: Staff of Storms

/obj/item/storm_staff
	name = "staff of storms"
	desc = "An ancient staff retrieved from the remains of Legion. The wind stirs as you move it."
	icon_state = "staffofstorms"
	icon = 'icons/obj/guns/magic.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	force = 20
	damtype = BURN
	hitsound = 'sound/weapons/taserhit.ogg'
	wound_bonus = -30
	bare_wound_bonus = 20
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/max_thunder_charges = 3
	var/thunder_charges = 3
	var/thunder_charge_time = 15 SECONDS
	var/static/list/excluded_areas = list(/area/space)
	var/list/targeted_turfs = list()

/obj/item/storm_staff/examine(mob/user)
	. = ..()
	. += span_notice("It has [thunder_charges] charges remaining.")
	. += span_notice("Use it in hand to dispel storms.")
	. += span_notice("Use it on targets to summon thunderbolts from the sky.")
	. += span_notice("The thunderbolts are boosted if in an area with weather effects.")

/obj/item/storm_staff/attack_self(mob/user)
	var/area/user_area = get_area(user)
	var/turf/user_turf = get_turf(user)
	if(!user_area || !user_turf || (is_type_in_list(user_area, excluded_areas)))
		to_chat(user, span_warning("Something is preventing you from using the staff here."))
		return
	var/datum/weather/affected_weather
	for(var/datum/weather/weather as anything in SSweather.processing)
		if((user_turf.z in weather.impacted_z_levels) && ispath(user_area.type, weather.area_type))
			affected_weather = weather
			break
	if(!affected_weather)
		return
	if(affected_weather.stage == END_STAGE)
		balloon_alert(user, "already ended!")
		return
	if(affected_weather.stage == WIND_DOWN_STAGE)
		balloon_alert(user, "already ending!")
		return
	balloon_alert(user, "you hold the staff up...")
	if(!do_after(user, 3 SECONDS, target = src))
		balloon_alert(user, "interrupted!")
		return
	user.visible_message(span_warning("[user] holds [src] skywards as an orange beam travels into the sky!"), \
	span_notice("You hold [src] skyward, dispelling the storm!"))
	playsound(user, 'sound/magic/staff_change.ogg', 200, FALSE)
	var/old_color = user.color
	user.color = list(340/255, 240/255, 0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0)
	var/old_transform = user.transform
	user.transform *= 1.2
	animate(user, color = old_color, transform = old_transform, time = 1 SECONDS)
	affected_weather.wind_down()
	log_game("[user] ([key_name(user)]) has dispelled a storm at [AREACOORD(user_turf)]")

/obj/item/storm_staff/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!thunder_charges)
		balloon_alert(user, "needs to charge!")
		return
	var/turf/target_turf = get_turf(target)
	var/area/target_area = get_area(target)
	if(!target_turf || !target_area || (is_type_in_list(target_area, excluded_areas)))
		balloon_alert(user, "can't bolt here!")
		return
	if(target_turf in targeted_turfs)
		balloon_alert(user, "already targeted!")
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		balloon_alert(user, "you don't want to harm!")
		return
	var/power_boosted = FALSE
	for(var/datum/weather/weather as anything in SSweather.processing)
		if(weather.stage != MAIN_STAGE)
			continue
		if((target_turf.z in weather.impacted_z_levels) && ispath(target_area.type, weather.area_type))
			power_boosted = TRUE
			break
	playsound(src, 'sound/magic/lightningshock.ogg', 10, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	targeted_turfs += target_turf
	balloon_alert(user, "you aim at [target_turf]...")
	new /obj/effect/temp_visual/telegraphing/thunderbolt(target_turf)
	addtimer(CALLBACK(src, .proc/throw_thunderbolt, target_turf, power_boosted), 1.5 SECONDS)
	thunder_charges--
	addtimer(CALLBACK(src, .proc/recharge), thunder_charge_time)
	log_game("[key_name(user)] fired the staff of storms at [AREACOORD(target_turf)].")

/obj/item/storm_staff/proc/recharge(mob/user)
	thunder_charges = min(thunder_charges + 1, max_thunder_charges)
	playsound(src, 'sound/magic/charge.ogg', 10, TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)

/obj/item/storm_staff/proc/throw_thunderbolt(turf/target, boosted)
	targeted_turfs -= target
	new /obj/effect/temp_visual/thunderbolt(target)
	var/list/affected_turfs = list(target)
	if(boosted)
		for(var/direction in GLOB.alldirs)
			var/turf_to_add = get_step(target, direction)
			if(!turf_to_add)
				continue
			affected_turfs += turf_to_add
	for(var/turf/turf as anything in affected_turfs)
		new /obj/effect/temp_visual/electricity(turf)
		for(var/mob/living/hit_mob in turf)
			to_chat(hit_mob, span_userdanger("You've been struck by lightning!"))
			hit_mob.electrocute_act(15 * (isanimal(hit_mob) ? 3 : 1) * (turf == target ? 2 : 1) * (boosted ? 2 : 1), src, flags = SHOCK_TESLA|SHOCK_NOSTUN)
		for(var/obj/hit_thing in turf)
			hit_thing.take_damage(20, BURN, ENERGY, FALSE)
	playsound(target, 'sound/magic/lightningbolt.ogg', 100, TRUE)
	target.visible_message(span_danger("A thunderbolt strikes [target]!"))
	explosion(target, light_impact_range = (boosted ? 1 : 0), flame_range = (boosted ? 2 : 1), silent = TRUE)
