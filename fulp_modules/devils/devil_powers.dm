/// Summon Pitchfork
/obj/effect/proc_holder/spell/targeted/conjure_item/summon_pitchfork
	name = "Summon Pitchfork"
	desc = "A devil's weapon of choice.  Use this to summon/unsummon your pitchfork."
	invocation_type = "none"
	include_user = TRUE
	range = -1
	clothes_req = FALSE
	item_type = /obj/item/pitchfork/demonic
	school = "conjuration"
	charge_max = 150
	cooldown_min = 10
	action_icon = 'fulp_modules/devils/devil_icon/devil_icons.dmi'
	action_icon_state = "pitchfork"
	action_background_icon_state = "bg_demon"

/obj/item/pitchfork/demonic
	name = "demonic pitchfork"
	desc = "A red pitchfork, it looks like the work of the devil."
	lefthand_file = 'fulp_modules/devils/devil_icon/devils_lefthand.dmi'
	righthand_file = 'fulp_modules/devils/devil_icon/devils_righthand.dmi'
	force = 19
	throwforce = 24
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_power = 6
	light_color = COLOR_SOFT_RED

/obj/item/pitchfork/demonic/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=19, force_wielded=25)

/obj/item/pitchfork/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] repeatedly stabs [user.p_them()]selves in [user.p_their()] abdomen with [src]! It looks like [user.p_theyre()] trying to send themselves to Hell!</span>")
	playsound(loc, 'sound/hallucinations/veryfar_noise.ogg', 50, TRUE, -1)
	sleep(20)
	for(var/obj/item/W in user)
		user.dropItemToGround(W)
	user.dust()
	return OXYLOSS

/obj/item/pitchfork/demonic/ascended/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !wielded)
		return
	if(iswallturf(target))
		var/turf/closed/wall/W = target
		user.visible_message("<span class='danger'>[user] blasts \the [target] with \the [src]!</span>")
		playsound(target, 'sound/magic/disintegrate.ogg', 100, TRUE)
		W.break_wall()
		W.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		return


/// Summon Violin
/obj/effect/proc_holder/spell/targeted/conjure_item/violin
	item_type = /obj/item/instrument/violin/golden/devil
	desc = "A devil's instrument of choice.  Use this to summon/unsummon your golden violin."
	invocation_type = INVOCATION_WHISPER
	invocation = "I ain't had this much fun since Georgia."
	action_icon_state = "golden_violin"
	name = "Summon golden violin"
	action_icon = 'fulp_modules/devils/devil_icon/devil_icons.dmi'
	action_background_icon_state = "bg_demon"

/obj/item/instrument/violin/golden/devil
	name = "golden violin"
	desc = "A golden musical instrument with four strings and a bow. \"The devil went down to space, he was looking for an assistant to grief.\""
	icon = 'fulp_modules/devils/devil_icon/violin.dmi'
	lefthand_file = 'fulp_modules/devils/devil_icon/devils_lefthand.dmi'
	righthand_file = 'fulp_modules/devils/devil_icon/devils_righthand.dmi'
	icon_state = "golden_violin"
	inhand_icon_state = "golden_violin"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/// Summon Fireball
/obj/effect/proc_holder/spell/aimed/fireball/hellish
	name = "Hellfire"
	desc = "This spell launches hellfire at the target."
	school = "evocation"
	charge_max = 80
	clothes_req = FALSE
	invocation = "Your very soul will catch fire!"
	invocation_type = INVOCATION_SHOUT
	range = 2
	projectile_type = /obj/projectile/magic/aoe/fireball/infernal
	action_background_icon_state = "bg_demon"

/obj/projectile/magic/aoe/fireball/infernal
	name = "infernal fireball"
	exp_heavy = -1
	exp_light = -1
	exp_flash = 4
	exp_fire= 5

/obj/projectile/magic/aoe/fireball/infernal/on_hit(target)
	. = ..()
	var/turf/T = get_turf(target)
	for(var/i=0, i<50, i+=10)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/explosion, T, -1, exp_heavy, exp_light, exp_flash, FALSE, FALSE, exp_fire), i)


/// Summon Dancefloor
/obj/effect/proc_holder/spell/targeted/summon_dancefloor
	name = "Summon Dancefloor"
	desc = "When what a Devil really needs is funk."
	include_user = TRUE
	range = -1
	clothes_req = FALSE

	school = "conjuration"
	charge_max = 10
	cooldown_min = 50 //5 seconds, so the smoke can't be spammed
	action_icon = 'fulp_modules/devils/devil_icon/devil_icons.dmi'
	action_icon_state = "funk"
	action_background_icon_state = "bg_demon"

	var/list/dancefloor_turfs
	var/list/dancefloor_turfs_types
	var/dancefloor_exists = FALSE
	var/datum/effect_system/smoke_spread/transparent/dancefloor_devil/smoke

/obj/effect/proc_holder/spell/targeted/summon_dancefloor/cast(list/targets, mob/user = usr)
	LAZYINITLIST(dancefloor_turfs)
	LAZYINITLIST(dancefloor_turfs_types)

	if(!smoke)
		smoke = new()
	smoke.set_up(0, get_turf(user))
	smoke.start()

	if(dancefloor_exists)
		dancefloor_exists = FALSE
		for(var/i in 1 to dancefloor_turfs.len)
			var/turf/T = dancefloor_turfs[i]
			T.ChangeTurf(dancefloor_turfs_types[i], flags = CHANGETURF_INHERIT_AIR)
	else
		var/list/funky_turfs = RANGE_TURFS(1, user)
		for(var/turf/closed/solid in funky_turfs)
			to_chat(user, "<span class='warning'>You're too close to a wall.</span>")
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
	effect_type = /obj/effect/particle_effect/smoke/transparent/dancefloor_devil

/obj/effect/particle_effect/smoke/transparent/dancefloor_devil
	lifetime = 2
