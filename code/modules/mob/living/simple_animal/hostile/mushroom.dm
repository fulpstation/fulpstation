/mob/living/simple_animal/hostile/mushroom
	name = "walking mushroom"
	desc = "It's a massive mushroom... with legs?"
	icon_state = "mushroom_color"
	icon_living = "mushroom_color"
	icon_dead = "mushroom_dead"
	mob_biotypes = MOB_ORGANIC | MOB_PLANT
	speak_chance = 0
	turns_per_move = 1
	maxHealth = 10
	health = 10
	butcher_results = list(/obj/item/food/hugemushroomslice = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "whacks"
	response_harm_simple = "whack"
	harm_intent_damage = 5
	obj_damage = 0
	melee_damage_lower = 1
	melee_damage_upper = 1
	attack_same = 2
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomp"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	faction = list("mushroom")
	environment_smash = ENVIRONMENT_SMASH_NONE
	stat_attack = DEAD
	mouse_opacity = MOUSE_OPACITY_ICON
	speed = 1
	robust_searching = 1
	unique_name = 1
	speak_emote = list("squeaks")
	deathmessage = "fainted."
	var/cap_color = "#ffffff"
	var/powerlevel = 0 //Tracks our general strength level gained from eating other shrooms
	var/bruised = 0 //If someone tries to cheat the system by attacking a shroom to lower its health, punish them so that it won't award levels to shrooms that eat it
	var/recovery_cooldown = 0 //So you can't repeatedly revive it during a fight
	var/faint_ticker = 0 //If we hit three, another mushroom's gonna eat us
	var/static/mutable_appearance/cap_living //Where we store our cap icons so we dont generate them constantly to update our icon
	var/static/mutable_appearance/cap_dead

/mob/living/simple_animal/hostile/mushroom/examine(mob/user)
	. = ..()
	if(health >= maxHealth)
		. += span_info("It looks healthy.")
	else
		. += span_info("It looks like it's been roughed up.")

/mob/living/simple_animal/hostile/mushroom/Life(delta_time = SSMOBS_DT, times_fired)
	..()
	if(!stat)//Mushrooms slowly regenerate if conscious, for people who want to save them from being eaten
		adjustBruteLoss(-1 * delta_time)

/mob/living/simple_animal/hostile/mushroom/Initialize(mapload)//Makes every shroom a little unique
	melee_damage_lower += rand(3, 5)
	melee_damage_upper += rand(10,20)
	maxHealth += rand(40,60)
	move_to_delay = rand(3,11)
	cap_living = cap_living || mutable_appearance(icon, "mushroom_cap")
	cap_dead = cap_dead || mutable_appearance(icon, "mushroom_cap_dead")

	cap_color = rgb(rand(0, 255), rand(0, 255), rand(0, 255))
	UpdateMushroomCap()
	health = maxHealth
	add_cell_sample()
	. = ..()

	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/mushroom/CanAttack(atom/the_target) // Mushroom-specific version of CanAttack to handle stupid attack_same = 2 crap so we don't have to do it for literally every single simple_animal/hostile because this shit never gets spawned
	if(!the_target || isturf(the_target))
		return FALSE

	if(see_invisible < the_target.invisibility)//Target's invisible to us, forget it
		return FALSE

	if(isliving(the_target))
		var/mob/living/L = the_target

		if (!faction_check_mob(L) && attack_same == 2)
			return FALSE
		if(L.stat > stat_attack)
			return FALSE

		return TRUE

	return FALSE

/mob/living/simple_animal/hostile/mushroom/adjustHealth(amount, updating_health = TRUE, forced = FALSE) //Possibility to flee from a fight just to make it more visually interesting
	if(!retreat_distance && prob(33))
		retreat_distance = 5
		addtimer(CALLBACK(src, .proc/stop_retreat), 30)
	. = ..()

/mob/living/simple_animal/hostile/mushroom/proc/stop_retreat()
	retreat_distance = null

/mob/living/simple_animal/hostile/mushroom/attack_animal(mob/living/user, list/modifiers)
	if(istype(user, /mob/living/simple_animal/hostile/mushroom) && stat == DEAD)
		var/mob/living/simple_animal/hostile/mushroom/shroom = user
		if(faint_ticker < 2)
			shroom.visible_message(span_notice("[shroom] chews a bit on [src]."))
			faint_ticker++
			return TRUE
		shroom.visible_message(span_warning("[shroom] devours [src]!"))
		var/level_gain = (powerlevel - shroom.powerlevel)
		if(level_gain >= -1 && !bruised && !shroom.ckey)//Player shrooms can't level up to become robust gods.
			if(level_gain < 1)//So we still gain a level if two mushrooms were the same level
				level_gain = 1
			shroom.LevelUp(level_gain)
		shroom.adjustBruteLoss(-shroom.maxHealth)
		qdel(src)
		return TRUE
	return ..()

/mob/living/simple_animal/hostile/mushroom/revive(full_heal = FALSE, admin_revive = FALSE)
	if(..())
		icon_state = "mushroom_color"
		UpdateMushroomCap()
		. = 1

/mob/living/simple_animal/hostile/mushroom/death(gibbed)
	..(gibbed)
	UpdateMushroomCap()

/mob/living/simple_animal/hostile/mushroom/proc/UpdateMushroomCap()
	cut_overlays()
	cap_living.color = cap_color
	cap_dead.color = cap_color
	if(health == 0)
		add_overlay(cap_dead)
	else
		add_overlay(cap_living)

/mob/living/simple_animal/hostile/mushroom/proc/Recover()
	visible_message(span_notice("[src] slowly begins to recover."))
	faint_ticker = 0
	revive(full_heal = TRUE, admin_revive = FALSE)
	UpdateMushroomCap()
	recovery_cooldown = 1
	addtimer(CALLBACK(src, .proc/recovery_recharge), 300)

/mob/living/simple_animal/hostile/mushroom/proc/recovery_recharge()
	recovery_cooldown = 0

/mob/living/simple_animal/hostile/mushroom/proc/LevelUp(level_gain)
	if(powerlevel <= 9)
		powerlevel += level_gain
		if(prob(25))
			melee_damage_lower += (level_gain * rand(1,5))
		else
			melee_damage_upper += (level_gain * rand(1,5))
		maxHealth += (level_gain * rand(1,5))
	adjustBruteLoss(-maxHealth) //They'll always heal, even if they don't gain a level, in case you want to keep this shroom around instead of harvesting it

/mob/living/simple_animal/hostile/mushroom/proc/Bruise()
	if(!bruised && !stat)
		src.visible_message(span_notice("The [src.name] is bruised!"))
		bruised = 1

/mob/living/simple_animal/hostile/mushroom/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/food/grown/mushroom))
		if(stat == DEAD && !recovery_cooldown)
			Recover()
			qdel(I)
		else
			to_chat(user, span_warning("[src] won't eat it!"))
		return
	if(I.force)
		Bruise()
	..()

/mob/living/simple_animal/hostile/mushroom/attack_hand(mob/living/carbon/human/user, list/modifiers)
	..()
	if(user.combat_mode)
		Bruise()

/mob/living/simple_animal/hostile/mushroom/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	..()
	if(istype(AM, /obj/item))
		var/obj/item/T = AM
		if(T.throwforce)
			Bruise()

/mob/living/simple_animal/hostile/mushroom/bullet_act(obj/projectile/P)
	. = ..()
	if(P.nodamage)
		Bruise()

/mob/living/simple_animal/hostile/mushroom/harvest()
	var/counter
	for(counter=0, counter<=powerlevel, counter++)
		var/obj/item/food/hugemushroomslice/S = new /obj/item/food/hugemushroomslice(src.loc)
		S.reagents.add_reagent(/datum/reagent/drug/mushroomhallucinogen, powerlevel)
		S.reagents.add_reagent(/datum/reagent/medicine/omnizine, powerlevel)
		S.reagents.add_reagent(/datum/reagent/medicine/synaptizine, powerlevel)

/mob/living/simple_animal/hostile/mushroom/add_cell_sample()
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_WALKING_MUSHROOM, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
