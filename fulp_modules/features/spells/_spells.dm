/datum/action/cooldown/spell/summon_dancefloor
	name = "Summon Dancefloor"
	desc = "When what a Devil really needs is funk."

	spell_requirements = NONE
	school = SCHOOL_EVOCATION
	cooldown_time = 5 SECONDS //5 seconds, so the smoke can't be spammed

	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "funk"

	var/list/dancefloor_turfs
	var/list/dancefloor_turfs_types
	var/dancefloor_exists = FALSE
	var/datum/effect_system/smoke_spread/transparent/dancefloor_devil/smoke

/datum/action/cooldown/spell/summon_dancefloor/cast(atom/victim)
	. = ..()
	LAZYINITLIST(dancefloor_turfs)
	LAZYINITLIST(dancefloor_turfs_types)

	if(!smoke)
		smoke = new()
	smoke.set_up(0, get_turf(owner))
	smoke.start()

	if(dancefloor_exists)
		dancefloor_exists = FALSE
		for(var/i in 1 to dancefloor_turfs.len)
			var/turf/T = dancefloor_turfs[i]
			T.ChangeTurf(dancefloor_turfs_types[i], flags = CHANGETURF_INHERIT_AIR)
	else
		var/list/funky_turfs = RANGE_TURFS(1, owner)
		for(var/turf/closed/solid in funky_turfs)
			to_chat(owner, "<span class='warning'>You're too close to a wall.</span>")
			return
		dancefloor_exists = TRUE
		var/i = 1
		dancefloor_turfs.len = funky_turfs.len
		dancefloor_turfs_types.len = funky_turfs.len
		for(var/t in funky_turfs)
			var/turf/T = t
			dancefloor_turfs[i] = T
			dancefloor_turfs_types[i] = T.type
			T.ChangeTurf((i % 2 == 0) ? /turf/open/floor/light/colour_cycle/dancefloor_a : /turf/open/floor/light/colour_cycle/dancefloor_b, flags = CHANGETURF_INHERIT_AIR)
			i++

/datum/effect_system/smoke_spread/transparent/dancefloor_devil
	effect_type = /obj/effect/particle_effect/fluid/smoke/transparent/dancefloor_devil

/obj/effect/particle_effect/fluid/smoke/transparent/dancefloor_devil
	lifetime = 2


//Blight: Infects nearby humans and in general messes living stuff up.
/datum/action/cooldown/spell/aoe/blight
	name = "Blight"
	desc = "Causes nearby living things to waste away."
	icon_icon = 'icons/mob/actions/actions_revenant.dmi'
	button_icon_state = "blight"
	cooldown_time = 20 SECONDS
	aoe_radius = 3

/datum/action/cooldown/spell/aoe/blight/cast_on_thing_in_aoe(turf/victim, mob/living/caster)
	for(var/mob/living/mob in victim)
		if(mob == caster)
			continue
		if(mob.can_block_magic(antimagic_flags))
			to_chat(caster, span_warning("The spell had no effect on [mob]!"))
			continue
		new /obj/effect/temp_visual/revenant(mob.loc)
		if(iscarbon(mob))
			if(ishuman(mob))
				if(mob.has_reagent(/datum/reagent/consumable/ethanol/irishcarbomb))
					to_chat(caster, span_warning("The spirit of Ireland protects [mob] from your blight!"))
					continue
				var/mob/living/carbon/human/H = mob
				H.set_haircolor("#1d2953", override = TRUE) //will be reset when blight is cured
				var/blightfound = FALSE
				for(var/datum/disease/revblight/blight in H.diseases)
					blightfound = TRUE
					if(blight.stage < 5)
						blight.stage++
				if(!blightfound)
					H.ForceContractDisease(new /datum/disease/revblight(), FALSE, TRUE)
					to_chat(H, span_notice("You feel [pick("suddenly sick", "a surge of nausea", "like your teeth are <i>wrong</i>")]."))
			else
				if(mob.reagents)
					mob.reagents.add_reagent(/datum/reagent/toxin/plasma, 5)
		else
			mob.adjustToxLoss(5)
	for(var/obj/structure/spacevine/vine in victim) //Fucking with botanists, the ability.
		vine.add_atom_colour("#823abb", TEMPORARY_COLOUR_PRIORITY)
		new /obj/effect/temp_visual/revenant(vine.loc)
		QDEL_IN(vine, 10)
	for(var/obj/structure/glowshroom/shroom in victim)
		shroom.add_atom_colour("#823abb", TEMPORARY_COLOUR_PRIORITY)
		new /obj/effect/temp_visual/revenant(shroom.loc)
		QDEL_IN(shroom, 10)
	for(var/obj/machinery/hydroponics/tray in victim)
		new /obj/effect/temp_visual/revenant(tray.loc)
		tray.set_pestlevel(rand(8, 10))
		tray.set_weedlevel(rand(8, 10))
		tray.set_toxic(rand(45, 55))

/*
/datum/action/cooldown/spell/touch/soul_drain
	name = "Syphon Vim"
	desc = "Drain the life energy of a living victim to extend your reign."
	cooldown_time = 10 SECONDS
	var/draining = FALSE
	var/essence_drained = 0

/datum/action/cooldown/spell/touch/soul_drain/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	if(draining)
		to_chat(src, span_warning("You are already siphoning the essence of a soul!"))
		return
	if(!victim.stat)
		to_chat(src, span_notice("[victim.p_their(TRUE)] soul is too strong to harvest."))
		if(prob(10))
			to_chat(victim, span_notice("You feel as if you are being watched."))
		return
	log_combat(src, victim, "started to harvest")
	face_atom(victim)
	draining = TRUE
	essence_drained += rand(15, 20)
	to_chat(src, span_notice("You search for the soul of [victim]."))
	if(do_after(src, rand(10, 20), victim, timed_action_flags = IGNORE_HELD_ITEM)) //did they get deleted in that second?
		if(victim.ckey)
			to_chat(src, span_notice("[victim.p_their(TRUE)] soul burns with intelligence."))
			essence_drained += rand(20, 30)
		if(victim.stat != DEAD && !HAS_TRAIT(victim, TRAIT_WEAK_SOUL))
			to_chat(src, span_notice("[victim.p_their(TRUE)] soul blazes with life!"))
			essence_drained += rand(40, 50)
		if(HAS_TRAIT(victim, TRAIT_WEAK_SOUL) && !victim.ckey)
			to_chat(src, span_notice("[victim.p_their(TRUE)] soul is weak and underdeveloped. They won't be worth very much."))
			essence_drained = 5
		else
			to_chat(src, span_notice("[victim.p_their(TRUE)] soul is weak and faltering."))
		if(do_after(src, rand(15, 20), victim, timed_action_flags = IGNORE_HELD_ITEM)) //did they get deleted NOW?
			switch(essence_drained)
				if(1 to 30)
					to_chat(src, span_notice("[victim] will not yield much essence. Still, every bit counts."))
				if(30 to 70)
					to_chat(src, span_notice("[victim] will yield an average amount of essence."))
				if(70 to 90)
					to_chat(src, span_boldnotice("Such a feast! [victim] will yield much essence to you."))
				if(90 to INFINITY)
					to_chat(src, span_bignotice("Ah, the perfect soul. [victim] will yield massive amounts of essence to you."))
			if(do_after(src, rand(15, 25), victim, timed_action_flags = IGNORE_HELD_ITEM)) //how about now
				if(!victim.stat)
					to_chat(src, span_warning("[victim.p_theyre(TRUE)] now powerful enough to fight off your draining."))
					to_chat(victim, span_boldannounce("You feel something tugging across your body before subsiding."))
					draining = 0
					essence_drained = 0
					return //hey, wait a minute...
				to_chat(src, span_notice("You begin siphoning essence from [victim]'s soul."))
				if(victim.stat != DEAD)
					to_chat(victim, span_warning("You feel a horribly unpleasant draining sensation as your grip on life weakens..."))
				if(victim.stat == SOFT_CRIT)
					victim.Stun(46)
				reveal(46)
				stun(46)
				victim.visible_message(span_warning("[victim] suddenly rises slightly into the air, [victim.p_their()] skin turning an ashy gray."))
				if(victim.can_block_magic(MAGIC_RESISTANCE_HOLY))
					to_chat(src, span_notice("Something's wrong! [victim] seems to be resisting the siphoning, leaving you vulnerable!"))
					victim.visible_message(span_warning("[victim] slumps onto the ground."), \
					span_warning("Violet lights, dancing in your vision, receding--"))
					draining = FALSE
					return
				var/datum/beam/B = Beam(victim,icon_state="drain_life")
				if(do_after(src, 46, victim, timed_action_flags = IGNORE_HELD_ITEM)) //As one cannot prove the existance of ghosts, ghosts cannot prove the existance of the victim they were draining.
					change_essence_amount(essence_drained, FALSE, victim)
					if(essence_drained <= 90 && victim.stat != DEAD && !HAS_TRAIT(victim, TRAIT_WEAK_SOUL))
						essence_regen_cap += 5
						to_chat(src, span_boldnotice("The absorption of [victim]'s living soul has increased your maximum essence level. Your new maximum essence is [essence_regen_cap]."))
					if(essence_drained > 90)
						essence_regen_cap += 15
						perfectsouls++
						to_chat(src, span_boldnotice("The perfection of [victim]'s soul has increased your maximum essence level. Your new maximum essence is [essence_regen_cap]."))
					to_chat(src, span_notice("[victim]'s soul has been considerably weakened and will yield no more essence for the time being."))
					victim.visible_message(span_warning("[victim] slumps onto the ground."), \
										   span_warning("Violets lights, dancing in your vision, getting clo--"))
					drained_mobs += REF(victim)
					victim.death(0)
				else
					to_chat(src, span_warning("[victim ? "[victim] has":"[victim.p_theyve(TRUE)]"] been drawn out of your grasp. The link has been broken."))
					if(victim) //Wait, victim is WHERE NOW?
						victim.visible_message(span_warning("[victim] slumps onto the ground."), \
											   span_warning("Violets lights, dancing in your vision, receding--"))
				qdel(B)
			else
				to_chat(src, span_warning("You are not close enough to siphon [victim ? "[victim]'s":"[victim.p_their()]"] soul. The link has been broken."))
	draining = FALSE
	var/overall_damage = H.getBruteLoss() + H.getFireLoss() + H.getToxLoss() + H.getOxyLoss()
	H.adjustOxyLoss((essence_drained*0.25) * (H.getOxyLoss() / overall_damage), 0)
	H.adjustToxLoss((essence_drained*0.25) * (H.getToxLoss() / overall_damage), 0)
	H.adjustFireLoss((essence_drained*0.25) * (H.getFireLoss() / overall_damage), 0)
	H.adjustBruteLoss((essence_drained*0.25) * (H.getBruteLoss() / overall_damage), 0)
	H.updatehealth()
	playsound(get_turf(H), 'sound/magic/staff_healing.ogg', 25)
	essence_drained = 0
/*
