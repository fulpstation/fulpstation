///Bloodsuckers spawning a Guardian will get the Bloodsucker one instead.
/obj/item/guardiancreator/spawn_guardian(mob/living/user, mob/dead/candidate)
	var/list/guardians = user.hasparasites()
	if(guardians.len && !allowmultiple)
		to_chat(user, span_holoparasite("You already have a [mob_name]!"))
		used = FALSE
		return
	if(IS_BLOODSUCKER(user))
		var/pickedtype = /mob/living/simple_animal/hostile/guardian/punch/timestop
		var/mob/living/simple_animal/hostile/guardian/punch/timestop/bloodsucker_guardian = new pickedtype(user, theme)
		bloodsucker_guardian.name = mob_name
		bloodsucker_guardian.summoner = user
		bloodsucker_guardian.key = candidate.key
		bloodsucker_guardian.mind.enslave_mind_to_creator(user)
		log_game("[key_name(user)] has summoned [key_name(bloodsucker_guardian)], a Timestop holoparasite.")
		add_verb(user, list(
			/mob/living/proc/guardian_comm,
			/mob/living/proc/guardian_recall,
			/mob/living/proc/guardian_reset,
		))
		to_chat(user, "[bloodsucker_guardian.magic_fluff_string]")
		to_chat(user, span_holoparasite("<b>[bloodsucker_guardian.real_name]</b> has been summoned!"))
		bloodsucker_guardian?.client.init_verbs()
		return

	// Call parent to deal with everyone else
	. = ..()

///The Guardian
/mob/living/simple_animal/hostile/guardian/punch/timestop
	melee_damage_lower = 15
	melee_damage_upper = 20
	// Like Bloodsuckers do, you will take more damage to Burn and less to Brute
	damage_coeff = list(BRUTE = 0.5, BURN = 2.5, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	obj_damage = 80
	//Slightly faster - Used to be -1, why??
	speed = -0.2
	//Attacks 20% faster using the power of TIME MANIPULATION
	next_move_modifier = 0.8

	//None of these shouldn't appear in game outside of admin intervention
	playstyle_string = "<span class='holoparasite'>As a <b>time manipulation</b> type you can stop time and you have a damage multiplier instead of armor as-well as powerful melee attacks capable of smashing through walls.</span>"
	magic_fluff_string = "<span class='holoparasite'>...And draw... The World, through sheer luck or perhaps destiny, maybe even your own physiology. Manipulator of time, a guardian powerful enough to control THE WORLD!.</span>"
	tech_fluff_string = "<span class='holoparasite'>ERROR... T$M3 M4N!PULA%I0N modules loaded. Holoparasite swarm online.</span>"
	carp_fluff_string = "<span class='holoparasite'>CARP CARP CARP! You caught one! It's imbued with the power of Carp'Sie herself. Time to rule THE WORLD!.</span>"
	miner_fluff_string = "<span class='holoparasite'>You encounter... The World, the controller of time and space.</span>"

/mob/living/simple_animal/hostile/guardian/punch/timestop/Initialize(mapload, theme)
	//Wizard Holoparasite theme, just to be more visibly stronger than regular ones
	theme = "magic"
	. = ..()
	var/obj/effect/proc_holder/spell/aoe_turf/timestop/guardian/timestop_ability = new
	AddSpell(timestop_ability)

///Guardian Timestop ability
/obj/effect/proc_holder/spell/aoe_turf/timestop/guardian
	name = "Stop Time"
	desc = "This spell stops time for everyone except for you and your master, allowing you to move freely while your enemies and even projectiles are frozen."
	charge_max = 600
	clothes_req = FALSE
	invocation = "none"
	invocation_type = "none"
	cooldown_min = 150
	var/list/safe_people = list()

///Timestop + Adding protected_summoner to the list of protected people
/obj/effect/proc_holder/spell/aoe_turf/timestop/guardian/cast(list/targets, mob/user = usr)
	if(!(user in safe_people))
		var/mob/living/simple_animal/hostile/guardian/punch/timestop/bloodsucker_guardian = user
		safe_people += bloodsucker_guardian.summoner
		safe_people += user

	new /obj/effect/timestop/magic(get_turf(user), timestop_range, timestop_duration, safe_people)
