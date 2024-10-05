//Summon Dancefloor
/datum/action/cooldown/spell/summon_dancefloor
	name = "Summon Dancefloor"
	desc = "When what a Devil really needs is funk."

	spell_requirements = NONE
	school = SCHOOL_EVOCATION
	cooldown_time = 5 SECONDS //5 seconds, so the smoke can't be spammed

	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "funk"

	var/list/dancefloor_turfs
	var/list/dancefloor_turfs_types
	var/dancefloor_exists = FALSE
	var/datum/effect_system/smoke_spread/transparent/dancefloor_devil/smoke

/datum/action/cooldown/spell/summon_dancefloor/cast(atom/target)
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
			to_chat(owner, span_warning("You're too close to a wall."))
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


//Direct Cat Meteor
/datum/action/cooldown/spell/conjure_item/infinite_guns/direct_cateor
	name = "Direct Cat Meteor"
	desc = "Channel a locus of meteorized cat energy into the palm of your hand and direct it at a target. \n\
	(<b>Right-click</b> to activate metamagical scope modifier.)"

	button_icon = 'fulp_modules/features/events/icons/event_icons.dmi'
	button_icon_state = "cateor"

	spell_requirements = SPELL_REQUIRES_WIZARD_GARB
	school = SCHOOL_FORBIDDEN
	cooldown_time = 60 SECONDS
	cooldown_reduction_per_rank = 12 SECONDS

	invocation_type = INVOCATION_WHISPER
	invocation = "O' woe, cole 'awnthre..."
	sparks_amt = 1 //It's practically a  meteor, channeling it into reality should reasonably cause sparks.

	item_type = /obj/item/gun/magic/wand/directable_cat_meteor

//Inhand gun item used temporarily in "Direct Cat Meteor"
//Made by referencing "arcane barrage."
//Most spell sprites (aside from the cateor itself,) are altered arcane barrage sprites.
/obj/item/gun/magic/wand/directable_cat_meteor
	name = "directable cat meteor"
	desc = "Mew Mew Mew."
	fire_sound = 'fulp_modules/sounds/effects/ow-awuh.ogg'
	icon = 'fulp_modules/features/spells/Icons/fulp_spell_icons.dmi'
	icon_state = "directable_cat_meteor"
	inhand_icon_state = "directable_cat_meteor"
	base_icon_state = "directable_cat_meteor"
	lefthand_file = 'fulp_modules/features/spells/Icons/Inhands/fulp_spells_lefthand.dmi'
	righthand_file = 'fulp_modules/features/spells/Icons/Inhands/fulp_spells_righthand.dmi'
	slot_flags = null
	item_flags = DROPDEL | ABSTRACT | NOBLUDGEON
	flags_1 = NONE
	weapon_weight = WEAPON_LIGHT
	max_charges = 1
	ammo_type = /obj/item/ammo_casing/energy/directed_cateor

/obj/item/gun/magic/wand/directable_cat_meteor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope/magic)
	register_context()

/obj/item/gun/magic/wand/directable_cat_meteor/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	. = ..()
	if(!HAS_TRAIT(user, TRAIT_USER_SCOPED))
		context[SCREENTIP_CONTEXT_RMB] = "Toggle Scope"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/gun/magic/wand/directable_cat_meteor/examine(mob/user)
	. = ..()
	desc += span_notice("<b>Right-click</b> to activate metamagical scope modifier.")

/obj/item/gun/magic/wand/directable_cat_meteor/process_fire(mob/living/M, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(!.)
		return
	if(!charges)
		user.dropItemToGround(src, TRUE)

//"Ammo casing" and "projectile" for the directable cat meteor spell
/obj/item/ammo_casing/energy/directed_cateor
	projectile_type = /obj/projectile/directed_cateor
	select_name = "It's nyathing to be taken lightwy"

/*
*Ideally this projectile should be as close to an actual cateors as possible.
*As a result, most of this code is directly copied from actual cateors except where
*a simpler solution could be found. This makes me cringe, so if there's a better way to do it
*then by all means please implement it.
*/
/obj/projectile/directed_cateor
	name = "directed high-velocity thaumaturgic cat energy"
	icon = 'fulp_modules/features/events/icons/event_icons.dmi'
	icon_state = "cateor"
	hitsound = NONE //Hitsound handled by Bump() code
	pass_flags = PASSGLASS | PASSGRILLE | PASSBLOB | PASSCLOSEDTURF | PASSTABLE | PASSMACHINE | PASSSTRUCTURE | PASSDOORS | PASSVEHICLE | PASSFLAPS
	light_system = OVERLAY_LIGHT
	light_color = "#F0415F"
	light_range = 2.5
	light_power = 0.625

	damage = 0
	paralyze = 0
	dismemberment = 0
	armour_penetration = 100

	var/matrix/size = matrix() //Used for adjusting cateor size
	var/resize_count = 1.5

/obj/projectile/directed_cateor/Move()
	. = ..()
	if(.)
		new /obj/effect/temp_visual/revenant(get_turf(src))
		if(prob(50))
			playsound(src.loc, 'sound/effects/footstep/meowstep1.ogg', 25)

/*
*Instead of copying the entire 'Bump()' proc for cateors, we'll just spawn a new cateor and make
*it bump the thing we're hitting.
*/
/obj/projectile/directed_cateor/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/obj/effect/meteor/cateor/new_cateor = new /obj/effect/meteor/cateor(get_turf(target), NONE)
	new_cateor.Bump(target)


/atom/movable/screen/fullscreen/cursor_catcher/scope/magic //The subtype scope atom used for the directed cateor spell
	icon = 'fulp_modules/features/spells/Icons/hud/fulp_spell_screen_full.dmi'
	icon_state = "magic_scope"
	range_modifier = 4

/datum/component/scope/magic //The subtype scope component used for the directed cateor spell
	range_modifier = 4

/*
*'zoom()' and 'stop_zooming()' copied from parent under the assumption of necessity.
*If the parent procs of these two ever get arguements implemented for the scope and sfx used
*then please change this.
*/
/datum/component/scope/magic/zoom(mob/user)
	if(isnull(user.client))
		return
	if(HAS_TRAIT(user, TRAIT_USER_SCOPED))
		user.balloon_alert(user, "already zoomed!")
		return
	user.playsound_local(parent, 'sound/effects/portal_travel.ogg', 50, TRUE)
	tracker = user.overlay_fullscreen("scope", /atom/movable/screen/fullscreen/cursor_catcher/scope/magic, isgun(parent))
	tracker.assign_to_mob(user, 4)
	tracker_owner_ckey = user.ckey
	if(user.is_holding(parent))
		RegisterSignals(user, list(COMSIG_MOB_SWAP_HANDS, COMSIG_QDELETING), PROC_REF(stop_zooming))
	START_PROCESSING(SSprojectiles, src)
	ADD_TRAIT(user, TRAIT_USER_SCOPED, REF(src))
	return TRUE

/datum/component/scope/magic/stop_zooming(mob/user)
	if(!HAS_TRAIT(user, TRAIT_USER_SCOPED))
		return

	STOP_PROCESSING(SSprojectiles, src)
	UnregisterSignal(user, list(
		COMSIG_LIVING_STATUS_KNOCKDOWN,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_STUN,
		COMSIG_MOB_SWAP_HANDS,
		COMSIG_QDELETING,
	))
	REMOVE_TRAIT(user, TRAIT_USER_SCOPED, REF(src))

	user.playsound_local(parent, 'sound/effects/portal_travel.ogg', 50, TRUE, -1)
	user.clear_fullscreen("scope")

	var/mob/true_user
	if(user.ckey != tracker_owner_ckey)
		true_user = get_mob_by_ckey(tracker_owner_ckey)

	if(!isnull(true_user))
		user = true_user

	if(user.client)
		animate(user.client, 0.2 SECONDS, pixel_x = 0, pixel_y = 0)
	tracker = null
	tracker_owner_ckey = null
