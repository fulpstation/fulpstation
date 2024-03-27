/datum/action/cooldown/spell/pointed/antagroll
	name = "Rolling of the Antagonist"
	desc = "Call on the forbidden magicks of the Mansus to roll over, crushing anyone in your way."
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/spells.dmi'
	button_icon_state = "jaunt"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 5 SECONDS

	invocation = "I wanna antagroll"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE

	active_msg = span_notice("We prepare to antagroll.")
	deactive_msg = span_notice("Not now, when They might be watching...")

	var/rolling_speed = 0.25 SECONDS

//this is mostly copied from malf AI's tipping spell, adapted slightly
/datum/action/cooldown/spell/pointed/antagroll/cast(atom/cast_on)
	. = ..()

	if(!isturf(owner.loc))
		return FALSE

	if(isliving(owner))
		var/mob/living/living_owner = owner
		if(living_owner.body_position == LYING_DOWN)
			return FALSE

	var/turf/target = get_turf(cast_on)
	if (isnull(target))
		return FALSE

	if (target == owner.loc)
		target.balloon_alert(owner, "can't roll on yourself!")
		return FALSE

	var/picked_dir = get_dir(owner, target)
	if (!picked_dir)
		return FALSE
	var/turf/temp_target = get_step(owner, picked_dir) // we can move during the timer so we cant just pass the ref

	new /obj/effect/temp_visual/telegraphing/vending_machine_tilt(temp_target, rolling_speed)
	owner.balloon_alert_to_viewers("rolling...")
	addtimer(CALLBACK(src, PROC_REF(do_roll_over), picked_dir), rolling_speed)

/datum/action/cooldown/spell/pointed/antagroll/proc/do_roll_over(picked_dir)
	if(!isturf(owner.loc))
		return

	if(isliving(owner))
		var/mob/living/living_owner = owner
		if(living_owner.body_position == LYING_DOWN)
			return

	var/turf/target = get_step(owner, picked_dir) // in case we moved we pass the dir not the target turf

	if (isnull(target))
		return

	. = owner.fall_and_crush(target, 25, 10, null, 5 SECONDS, picked_dir, rotation = 0)

	if(isliving(owner))
		var/mob/living/living_owner = owner
		living_owner.Paralyze(2 SECONDS)

	return


/datum/action/cooldown/spell/pointed/ascend_door
	name = "Unhinging Glare"
	desc = "Grants any airlock sentience."
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/spells.dmi'
	button_icon_state = "unhinge"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 15 SECONDS

	invocation = "L'T ME 'N"
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

/datum/action/cooldown/spell/pointed/ascend_door/is_valid_target(atom/cast_on)
	if(HAS_TRAIT(cast_on,TRAIT_UNHINGED_SEARCHING))
		to_chat(owner,span_warning("The airlock is still searching for its spirit!"))
		return FALSE
	if(HAS_TRAIT(cast_on,TRAIT_UNHINGED))
		to_chat(owner,span_warning("The airlock already has a spirit!"))
		return FALSE
	if(istype(cast_on,/obj/machinery/door/airlock))
		return TRUE
	to_chat(owner, span_warning("You may only cast [src] on an airlock!"))
	return FALSE

/datum/action/cooldown/spell/pointed/ascend_door/cast(atom/cast_on)
	. = ..()

	//following section based on spirit holding component's awakening (since we can't use an airlock in hand)
	if(!(GLOB.ghost_role_flags & GHOSTROLE_STATION_SENTIENCE))
		cast_on.balloon_alert(owner, "spirits are unwilling!")
		to_chat(owner, span_warning("Anomalous otherworldly energies block you from awakening [cast_on]!"))
		return

	cast_on.balloon_alert(owner, "channeling a spirit...")
	var/datum/component/spirit_holding/unhinged_door/added_component = cast_on.AddComponent(/datum/component/spirit_holding/unhinged_door)
	ADD_TRAIT(cast_on,TRAIT_UNHINGED_SEARCHING,added_component)
	var/datum/callback/to_call = CALLBACK(added_component, TYPE_PROC_REF(/datum/component/spirit_holding/unhinged_door, affix_spirit), owner)
	cast_on.AddComponent(/datum/component/orbit_poll, \
		ignore_key = POLL_IGNORE_HERETIC_MONSTER, \
		job_bans = ROLE_PAI, \
		to_call = to_call, \
		title = "Spirit of [cast_on] at [get_area_name(get_area(cast_on))]", \
		timeout = 5 SECONDS, \
	)


/datum/action/cooldown/spell/lag_spike
	name = "Fulp Moment"
	desc = "Momentarily freezes time for all heathens."
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/spells.dmi'
	button_icon_state = "fulp_moment"

	school = SCHOOL_FORBIDDEN
	//too annoying to have a short cooldown I imagine
	cooldown_time = 2 MINUTES

	invocation = "!ST'T'S"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE

	//we need Him to cast this spell
	var/obj/tom_fulp/nexus

	var/list/moment_lines = list(
		"I DO NOT RESPOND TO THIS CHANNEL!",
		"THIS IS MY MOMENT!",
		"TOO MANY ACTIONS IN A MINUTE!",
		"DREAMDAEMON HAS MISSED 3 HEARTBEATS!",
		"HAMSTER DIED",
		"I HAVE COME TO CLAIM THESE NEW GROUNDS",
	)

	var/list/frozen

/datum/action/cooldown/spell/lag_spike/Destroy()
	. = ..()
	unfreeze()

/datum/action/cooldown/spell/lag_spike/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE

	if(QDELETED(nexus))
		if(feedback)
			owner.balloon_alert("Cannot cast this spell without Tom Fulp!")
		return FALSE

	var/turf/loc = get_turf(owner)
	if(!is_station_level(loc.z))
		if(feedback)
			owner.balloon_alert("Must be on the station!")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/lag_spike/cast(/mob/living/cast_on)
	. = ..()

	if(QDELETED(nexus))
		return FALSE

	do_teleport(nexus, get_turf(owner), no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC, forced = TRUE)
	send_to_playing_players(span_narsie(pick(moment_lines)))
	sound_to_playing_players('sound/magic/timeparadox2.ogg')

	frozen = list()
	for (var/mob/living/carbon/player in GLOB.player_list)
		if(IS_HERETIC_OR_MONSTER(player))
			continue

		if(player.can_block_magic(antimagic_flags))
			player.visible_message(
				span_danger("[player] stumbles, but regains balance."),
				span_danger("You briefly lose balance, as you feel the rest of the world has stopped moving!")
			)
			continue

		player.Stun(5 SECONDS, ignore_canstun = TRUE)
		player.add_traits(list(TRAIT_MUTE, TRAIT_EMOTEMUTE), TIMESTOP_TRAIT)
		frozen += player

	addtimer(CALLBACK(src, PROC_REF(unfreeze)), 5 SECONDS)

/datum/action/cooldown/spell/lag_spike/proc/unfreeze()
	for(var/mob/living/carbon/player in frozen)
		if(QDELETED(player))
			continue
		player.remove_traits(list(TRAIT_MUTE, TRAIT_EMOTEMUTE), TIMESTOP_TRAIT)



//pony versions of wizard spells

/datum/action/cooldown/spell/pointed/barnyardcurse/pony
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	spell_requirements = NONE

/datum/action/cooldown/spell/pointed/projectile/lightningbolt/pony
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	spell_requirements = NONE

/datum/action/cooldown/spell/aoe/knock/pony
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	spell_requirements = NONE

/datum/action/cooldown/spell/conjure/bee/pony
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	spell_requirements = NONE

/datum/action/cooldown/spell/emp/disable_tech/pony
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	spell_requirements = NONE

/datum/action/cooldown/spell/aoe/magic_missile/pony
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	spell_requirements = NONE

/datum/action/cooldown/spell/teleport/area_teleport/wizard/pony
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	spell_requirements = NONE

/datum/action/cooldown/spell/summon_dancefloor/pony
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	spell_requirements = NONE

/datum/action/cooldown/spell/timestop/pony
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"

	school = SCHOOL_FORBIDDEN
	spell_requirements = NONE

