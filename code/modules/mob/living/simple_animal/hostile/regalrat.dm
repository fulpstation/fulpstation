/mob/living/simple_animal/hostile/regalrat
	name = "feral regal rat"
	desc = "An evolved rat, created through some strange science. It leads nearby rats with deadly efficiency to protect its kingdom. Not technically a king."
	icon_state = "regalrat"
	icon_living = "regalrat"
	icon_dead = "regalrat_dead"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 5
	maxHealth = 70
	health = 70
	see_in_dark = 5
	obj_damage = 10
	butcher_results = list(/obj/item/clothing/head/crown = 1,)
	response_help_continuous = "glares at"
	response_help_simple = "glare at"
	response_disarm_continuous = "skoffs at"
	response_disarm_simple = "skoff at"
	response_harm_continuous = "slashes"
	response_harm_simple = "slash"
	melee_damage_lower = 13
	melee_damage_upper = 15
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	unique_name = TRUE
	faction = list("rat")
	///The spell that the rat uses to generate miasma
	var/datum/action/cooldown/domain
	///The Spell that the rat uses to recruit/convert more rats.
	var/datum/action/cooldown/riot

/mob/living/simple_animal/hostile/regalrat/Initialize()
	. = ..()
	domain = new /datum/action/cooldown/domain
	riot = new /datum/action/cooldown/riot
	domain.Grant(src)
	riot.Grant(src)
	AddElement(/datum/element/waddling)

	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/regalrat/Destroy()
	. = ..()
	QDEL_NULL(domain)
	QDEL_NULL(riot)

/mob/living/simple_animal/hostile/regalrat/proc/get_player()
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you want to play as the Royal Rat, cheesey be his crown?", ROLE_SENTIENCE, FALSE, 100, POLL_IGNORE_SENTIENCE_POTION)
	if(LAZYLEN(candidates) && !mind)
		var/mob/dead/observer/C = pick(candidates)
		key = C.key
		notify_ghosts("All rise for the rat king, ascendant to the throne in \the [get_area(src)].", source = src, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Sentient Rat Created")
	to_chat(src, span_notice("You are an independent, invasive force on the station! Horde coins, trash, cheese, and the like from the safety of darkness!"))

/mob/living/simple_animal/hostile/regalrat/handle_automated_action()
	if(prob(20))
		riot.Trigger()
	else if(prob(50))
		domain.Trigger()
	return ..()

/mob/living/simple_animal/hostile/regalrat/CanAttack(atom/the_target)
	if(istype(the_target,/mob/living/simple_animal))
		var/mob/living/A = the_target
		if(istype(the_target, /mob/living/simple_animal/hostile/regalrat) && A.stat == CONSCIOUS)
			return TRUE
		if(istype(the_target, /mob/living/simple_animal/hostile/rat) && A.stat == CONSCIOUS)
			var/mob/living/simple_animal/hostile/rat/R = the_target
			if(R.faction_check_mob(src, TRUE))
				return FALSE
			else
				return TRUE
		return ..()

/mob/living/simple_animal/hostile/regalrat/examine(mob/user)
	. = ..()
	if(istype(user,/mob/living/simple_animal/hostile/rat))
		var/mob/living/simple_animal/hostile/rat/ratself = user
		if(ratself.faction_check_mob(src, TRUE))
			. += span_notice("This is your king. Long live his majesty!")
		else
			. += span_warning("This is a false king! Strike him down!")
	else if(user != src && istype(user,/mob/living/simple_animal/hostile/regalrat))
		. += span_warning("Who is this foolish false king? This will not stand!")

/mob/living/simple_animal/hostile/regalrat/handle_environment(datum/gas_mixture/environment)
	. = ..()
	if(stat == DEAD || !environment || !environment.gases[/datum/gas/miasma])
		return
	var/miasma_percentage = environment.gases[/datum/gas/miasma][MOLES] / environment.total_moles()
	if(miasma_percentage>=0.25)
		heal_bodypart_damage(1)

/mob/living/simple_animal/hostile/regalrat/AttackingTarget()
	if (DOING_INTERACTION(src, "regalrat"))
		return

	. = ..()

	if (QDELETED(target))
		return

	if (target.reagents && target.is_injectable(src, allowmobs = TRUE))
		src.visible_message(span_warning("[src] starts licking [target] passionately!"),span_notice("You start licking [target]..."))
		if (do_mob(src, target, 2 SECONDS, interaction_key = "regalrat"))
			target.reagents.add_reagent(/datum/reagent/rat_spit,rand(1,3),no_react = TRUE)
			to_chat(src, span_notice("You finish licking [target]."))
	else
		SEND_SIGNAL(target, COMSIG_RAT_INTERACT, src)

/**
 * Conditionally "eat" cheese object and heal, if injured.
 *
 * A private proc for sending a message to the mob's chat about them
 * eating some sort of cheese, then healing them, then deleting the cheese.
 * The "eating" is only conditional on the mob being injured in the first
 * place.
 */
/mob/living/simple_animal/hostile/regalrat/proc/cheese_heal(obj/item/target, amount, message)
	if(health < maxHealth)
		to_chat(src, message)
		heal_bodypart_damage(amount)
		qdel(target)
	else
		to_chat(src, span_warning("You feel fine, no need to eat anything!"))

/mob/living/simple_animal/hostile/regalrat/controlled/Initialize()
	. = ..()
	INVOKE_ASYNC(src, .proc/get_player)
	var/kingdom = pick("Plague","Miasma","Maintenance","Trash","Garbage","Rat","Vermin","Cheese")
	var/title = pick("King","Lord","Prince","Emperor","Supreme","Overlord","Master","Shogun","Bojar","Tsar")
	name = "[kingdom] [title]"


/**
 *Increase the rat king's domain
 */

/datum/action/cooldown/domain
	name = "Rat King's Domain"
	desc = "Corrupts this area to be more suitable for your rat army."
	cooldown_time = 60
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	background_icon_state = "bg_clock"
	button_icon_state = "coffer"

/datum/action/cooldown/domain/Trigger()
	. = ..()
	var/turf/T = get_turf(owner)
	T.atmos_spawn_air("miasma=4;TEMP=[T20C]")
	switch (rand(1,10))
		if (8)
			new /obj/effect/decal/cleanable/vomit(T)
		if (9)
			new /obj/effect/decal/cleanable/vomit/old(T)
		if (10)
			new /obj/effect/decal/cleanable/oil/slippery(T)
		else
			new /obj/effect/decal/cleanable/dirt(T)
	StartCooldown()

/**
 *This action checks all nearby mice, and converts them into hostile rats. If no mice are nearby, creates a new one.
 */

/datum/action/cooldown/riot
	name = "Raise Army"
	desc = "Raise an army out of the hordes of mice and pests crawling around the maintenance shafts."
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "riot"
	background_icon_state = "bg_clock"
	cooldown_time = 80
	///Checks to see if there are any nearby mice. Does not count Rats.

/datum/action/cooldown/riot/Trigger()
	. = ..()
	if(!.)
		return
	var/cap = CONFIG_GET(number/ratcap)
	var/something_from_nothing = FALSE
	for(var/mob/living/simple_animal/mouse/M in oview(owner, 5))
		var/mob/living/simple_animal/hostile/rat/new_rat = new(get_turf(M))
		something_from_nothing = TRUE
		if(M.mind && M.stat == CONSCIOUS)
			M.mind.transfer_to(new_rat)
		if(istype(owner,/mob/living/simple_animal/hostile/regalrat))
			var/mob/living/simple_animal/hostile/regalrat/giantrat = owner
			new_rat.faction = giantrat.faction
		qdel(M)
	if(!something_from_nothing)
		if(LAZYLEN(SSmobs.cheeserats) >= cap)
			to_chat(owner,span_warning("There's too many mice on this station to beckon a new one! Find them first!"))
			return
		new /mob/living/simple_animal/mouse(owner.loc)
		owner.visible_message(span_warning("[owner] commands a mouse to its side!"))
	else
		owner.visible_message(span_warning("[owner] commands its army to action, mutating them into rats!"))
	StartCooldown()

/mob/living/simple_animal/hostile/rat
	name = "rat"
	desc = "It's a nasty, ugly, evil, disease-ridden rodent with anger issues."
	icon_state = "mouse_gray"
	icon_living = "mouse_gray"
	icon_dead = "mouse_gray_dead"
	speak = list("Skree!","SKREEE!","Squeak?")
	speak_emote = list("squeaks")
	emote_hear = list("Hisses.")
	emote_see = list("runs in a circle.", "stands on its hind legs.")
	melee_damage_lower = 3
	melee_damage_upper = 5
	obj_damage = 5
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	maxHealth = 15
	health = 15
	butcher_results = list(/obj/item/food/meat/slab/mouse = 1)
	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	faction = list("rat")

/mob/living/simple_animal/hostile/rat/Initialize()
	. = ..()
	SSmobs.cheeserats += src

	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/rat/Destroy()
	SSmobs.cheeserats -= src
	return ..()

/mob/living/simple_animal/hostile/rat/death(gibbed)
	if(!ckey)
		..(TRUE)
		if(!gibbed)
			var/obj/item/food/deadmouse/mouse = new(loc)
			mouse.icon_state = icon_dead
			mouse.name = name
	SSmobs.cheeserats -= src // remove rats on death
	return ..()

/mob/living/simple_animal/hostile/rat/revive(full_heal = FALSE, admin_revive = FALSE)
	var/cap = CONFIG_GET(number/ratcap)
	if(!admin_revive && !ckey && LAZYLEN(SSmobs.cheeserats) >= cap)
		visible_message(span_warning("[src] twitched but does not continue moving due to the overwhelming rodent population on the station!"))
		return FALSE
	. = ..()
	if(.)
		SSmobs.cheeserats += src

/mob/living/simple_animal/hostile/rat/examine(mob/user)
	. = ..()
	if(istype(user,/mob/living/simple_animal/hostile/rat))
		var/mob/living/simple_animal/hostile/rat/ratself = user
		if(ratself.faction_check_mob(src, TRUE))
			. += span_notice("You both serve the same king.")
		else
			. += span_warning("This fool serves a different king!")
	else if(istype(user,/mob/living/simple_animal/hostile/regalrat))
		var/mob/living/simple_animal/hostile/regalrat/ratking = user
		if(ratking.faction_check_mob(src, TRUE))
			. += span_notice("This rat serves under you.")
		else
			. += span_warning("This peasant serves a different king! Strike him down!")

/mob/living/simple_animal/hostile/rat/CanAttack(atom/the_target)
	if(istype(the_target,/mob/living/simple_animal))
		var/mob/living/A = the_target
		if(istype(the_target, /mob/living/simple_animal/hostile/regalrat) && A.stat == CONSCIOUS)
			var/mob/living/simple_animal/hostile/regalrat/ratking = the_target
			if(ratking.faction_check_mob(src, TRUE))
				return FALSE
			else
				return TRUE
		if(istype(the_target, /mob/living/simple_animal/hostile/rat) && A.stat == CONSCIOUS)
			var/mob/living/simple_animal/hostile/rat/R = the_target
			if(R.faction_check_mob(src, TRUE))
				return FALSE
			else
				return TRUE
	return ..()

/mob/living/simple_animal/hostile/rat/handle_automated_action()
	. = ..()
	if(prob(40))
		var/turf/open/floor/F = get_turf(src)
		if(istype(F) && !F.intact)
			var/obj/structure/cable/C = locate() in F
			if(C && prob(15))
				if(C.avail())
					visible_message(span_warning("[src] chews through the [C]. It's toast!"))
					playsound(src, 'sound/effects/sparks2.ogg', 100, TRUE)
					C.deconstruct()
					death()
			else if(C?.avail())
				visible_message(span_warning("[src] chews through the [C]. It looks unharmed!"))
				playsound(src, 'sound/effects/sparks2.ogg', 100, TRUE)
				C.deconstruct()

/mob/living/simple_animal/hostile/rat/AttackingTarget()
	. = ..()
	if(istype(target, /obj/item/food/cheese))
		if (health >= maxHealth)
			to_chat(src, span_warning("You feel fine, no need to eat anything!"))
			return
		to_chat(src, span_green("You eat \the [src], restoring some health."))
		heal_bodypart_damage(maxHealth)
		qdel(target)


/**
 *Spittle; harmless reagent that is added by rat king, and makes you disgusted.
 */

/datum/reagent/rat_spit
	name = "Rat Spit"
	description = "Something coming from a rat. Dear god! Who knows where it's been!"
	reagent_state = LIQUID
	color = "#C8C8C8"
	metabolization_rate = 0.03 * REAGENTS_METABOLISM
	taste_description = "something funny"
	overdose_threshold = 20

/datum/reagent/rat_spit/on_mob_metabolize(mob/living/L)
	..()
	if(HAS_TRAIT(L, TRAIT_AGEUSIA))
		return
	to_chat(L, span_notice("This food has a funny taste!"))

/datum/reagent/rat_spit/overdose_start(mob/living/M)
	..()
	var/mob/living/carbon/victim = M
	if (istype(victim))
		to_chat(victim, span_userdanger("With this last sip, you feel your body convulsing horribly from the contents you've ingested. As you contemplate your actions, you sense an awakened kinship with rat-kind and their newly risen leader!"))
		victim.faction |= "rat"
		victim.vomit()
	metabolization_rate = 10 * REAGENTS_METABOLISM

/datum/reagent/rat_spit/on_mob_life(mob/living/carbon/C)
	if(prob(15))
		to_chat(C, span_notice("You feel queasy!"))
		C.adjust_disgust(3)
	else if(prob(10))
		to_chat(C, span_warning("That food does not sit up well!"))
		C.adjust_disgust(5)
	else if(prob(5))
		C.vomit()
	..()
