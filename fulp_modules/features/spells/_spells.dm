//Summon Dancefloor
/datum/action/cooldown/spell/summon_dancefloor
	name = "Summon Dancefloor"
	desc = "When what a Devil really needs is funk."

	spell_requirements = NONE
	school = SCHOOL_EVOCATION
	cooldown_time = 20 SECONDS //20 seconds, so the effects can't be spammed
	invocation_type = INVOCATION_SHOUT
	invocation = "DR'P TH' B'T!!!"

	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "funk"

	var/list/funky_turfs

	var/list/dancefloor_turfs
	var/list/dancefloor_turfs_types
	var/dancefloor_exists = FALSE

	/// List of brief song snippets that are later associated with visual effects on cast.
	/// All effects and associated vars/procs copied over from dance machine code with minor adjustments.
	var/list/dancefloor_flare = list(
		'fulp_modules/sounds/effects/summon_dance_floor/title0_shortened.ogg',
		'fulp_modules/sounds/effects/summon_dance_floor/title2_shortened.ogg',
		'fulp_modules/sounds/effects/summon_dance_floor/title3_shortened.ogg',
	)
	/// Spotlight effects being played
	VAR_PRIVATE/list/obj/item/flashlight/spotlight/spotlights = list()
	/// Sparkle effects being played
	VAR_PRIVATE/list/obj/effect/overlay/sparkles/sparkles = list()

/datum/action/cooldown/spell/summon_dancefloor/before_cast(atom/cast_on)
	. = ..()
	funky_turfs = RANGE_TURFS(1, owner)
	for(var/turf/closed/solid in funky_turfs)
		to_chat(owner, span_warning("You're too close to a wall."))
		return SPELL_CANCEL_CAST

/datum/action/cooldown/spell/summon_dancefloor/cast(atom/target)
	. = ..()
	owner.emote("scream") //DISCO, HECK YEAH!!!

	if(dancefloor_exists)
		delete_dancefloor()

	LAZYINITLIST(dancefloor_turfs)
	LAZYINITLIST(dancefloor_turfs_types)

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

	var/desired_effect = pick(dancefloor_flare)
	playsound(get_turf(owner), desired_effect, 100, extrarange = 10, ignore_walls = TRUE)
	StartCooldown()
	switch(desired_effect)
		if('fulp_modules/sounds/effects/summon_dance_floor/title0_shortened.ogg')
			hierofunk()
		if('fulp_modules/sounds/effects/summon_dance_floor/title2_shortened.ogg')
			dance_setup()
			while(dancefloor_exists)
				rainbow_lights()
		if('fulp_modules/sounds/effects/summon_dance_floor/title3_shortened.ogg')
			lights_spin()

/datum/action/cooldown/spell/summon_dancefloor/Remove()
	. = ..()
	if(dancefloor_exists)
		delete_dancefloor()

/datum/action/cooldown/spell/summon_dancefloor/proc/delete_dancefloor()
	dancefloor_exists = FALSE
	QDEL_LIST(spotlights)
	QDEL_LIST(sparkles)
	for(var/i in 1 to dancefloor_turfs.len)
		var/turf/T = dancefloor_turfs[i]
		T.ChangeTurf(dancefloor_turfs_types[i], flags = CHANGETURF_INHERIT_AIR)

//////////////////////////////////////////////////////////////////////////////////////////////////////
// ALL "Summon Dancefloor" CODE AFTER THIS POINT HAS BEEN COPIED/READAPTED FROM DANCE MACHINE CODE. //
//////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/action/cooldown/spell/summon_dancefloor/proc/hierofunk()
	var/turf/target_turf = get_turf(owner)
	for(var/i in 1 to 15)
		spawn_atom_to_turf(/obj/effect/temp_visual/hierophant/telegraph/edge, target_turf, 1, FALSE)
		sleep(0.75 SECONDS)

/datum/action/cooldown/spell/summon_dancefloor/proc/lights_spin()
	var/turf/target_turf = get_turf(owner)
	//All sparkles (except the first sparkle) orbit the first sparkle.
	//This is necessary to prevent them from bugging out if the tile they're orbitting is destroyed.
	var/obj/effect/overlay/sparkles/central_sparkle
	for(var/i in 1 to 25)
		if(i == 1)
			central_sparkle = new /obj/effect/overlay/sparkles(target_turf)
		var/obj/effect/overlay/sparkles/S = new /obj/effect/overlay/sparkles(target_turf)
		sparkles += S
		switch(i)
			if(2 to 9)
				S.orbit(central_sparkle, 30, TRUE, 60, 36, TRUE)
			if(10 to 16)
				S.orbit(central_sparkle, 62, TRUE, 60, 36, TRUE)
			if(17)
				S.orbit(central_sparkle, 62, TRUE, 60, 36, TRUE)
				playsound(target_turf, 'sound/effects/magic/blind.ogg', 37, frequency = -1)
				for(var/mob/living/M in viewers(target_turf))
					M.emote("spin")
					M.emote("flip")
					M.emote("snap")
			if(18 to 25)
				S.orbit(central_sparkle, 95, TRUE, 60, 36, TRUE)
		sleep(0.7 SECONDS)

/datum/action/cooldown/spell/summon_dancefloor/proc/dance_setup()
	var/turf/cen = get_turf(owner)
	FOR_DVIEW(var/turf/t, 3, get_turf(owner),INVISIBILITY_LIGHTING)
		if(t.x == cen.x && t.y > cen.y)
			spotlights += new /obj/item/flashlight/spotlight(t, 1 + get_dist(owner, t), 30 - (get_dist(owner, t) * 8), COLOR_SOFT_RED)
			continue
		if(t.x == cen.x && t.y < cen.y)
			spotlights += new /obj/item/flashlight/spotlight(t, 1 + get_dist(owner, t), 30 - (get_dist(owner, t) * 8), LIGHT_COLOR_PURPLE)
			continue
		if(t.x > cen.x && t.y == cen.y)
			spotlights += new /obj/item/flashlight/spotlight(t, 1 + get_dist(owner, t), 30 - (get_dist(owner, t) * 8), LIGHT_COLOR_DIM_YELLOW)
			continue
		if(t.x < cen.x && t.y == cen.y)
			spotlights += new /obj/item/flashlight/spotlight(t, 1 + get_dist(owner, t), 30 - (get_dist(owner, t) * 8), LIGHT_COLOR_GREEN)
			continue
		if((t.x+1 == cen.x && t.y+1 == cen.y) || (t.x+2 == cen.x && t.y+2 == cen.y))
			spotlights += new /obj/item/flashlight/spotlight(t, 1.4 + get_dist(owner, t), 30 - (get_dist(owner, t) * 8), LIGHT_COLOR_ORANGE)
			continue
		if((t.x-1 == cen.x && t.y-1 == cen.y) || (t.x-2 == cen.x && t.y-2 == cen.y))
			spotlights += new /obj/item/flashlight/spotlight(t, 1.4 + get_dist(owner, t), 30 - (get_dist(owner, t) * 8), LIGHT_COLOR_CYAN)
			continue
		if((t.x-1 == cen.x && t.y+1 == cen.y) || (t.x-2 == cen.x && t.y+2 == cen.y))
			spotlights += new /obj/item/flashlight/spotlight(t, 1.4 + get_dist(owner, t), 30 - (get_dist(owner, t) * 8), LIGHT_COLOR_BLUEGREEN)
			continue
		if((t.x+1 == cen.x && t.y-1 == cen.y) || (t.x+2 == cen.x && t.y-2 == cen.y))
			spotlights += new /obj/item/flashlight/spotlight(t, 1.4 + get_dist(owner, t), 30 - (get_dist(owner, t) * 8), LIGHT_COLOR_BLUE)
			continue
		continue
	FOR_DVIEW_END

#define DISCO_INFENO_RANGE (rand(85, 115)*0.01)

/datum/action/cooldown/spell/summon_dancefloor/proc/rainbow_lights()
	for(var/g in spotlights)
		var/obj/item/flashlight/spotlight/glow = g
		if(QDELETED(glow))
			stack_trace("[glow?.gc_destroyed ? "Qdeleting glow" : "null entry"] found in [src].[gc_destroyed ? " Source qdeleting at the time." : ""]")
			return
		switch(glow.light_color)
			if(COLOR_SOFT_RED)
				if(glow.even_cycle)
					glow.set_light_on(FALSE)
					glow.set_light_color(LIGHT_COLOR_BLUE)
				else
					glow.set_light_range_power_color(glow.base_light_range * DISCO_INFENO_RANGE, glow.light_power * 1.48, LIGHT_COLOR_BLUE)
					glow.set_light_on(TRUE)
			if(LIGHT_COLOR_BLUE)
				if(glow.even_cycle)
					glow.set_light_range_power_color(glow.base_light_range * DISCO_INFENO_RANGE, glow.light_power * 2, LIGHT_COLOR_GREEN)
					glow.set_light_on(TRUE)
				else
					glow.set_light_on(FALSE)
					glow.set_light_color(LIGHT_COLOR_GREEN)
			if(LIGHT_COLOR_GREEN)
				if(glow.even_cycle)
					glow.set_light_on(FALSE)
					glow.set_light_color(LIGHT_COLOR_ORANGE)
				else
					glow.set_light_range_power_color(glow.base_light_range * DISCO_INFENO_RANGE, glow.light_power * 0.5, LIGHT_COLOR_ORANGE)
					glow.set_light_on(TRUE)
			if(LIGHT_COLOR_ORANGE)
				if(glow.even_cycle)
					glow.set_light_range_power_color(glow.base_light_range * DISCO_INFENO_RANGE, glow.light_power * 2.27, LIGHT_COLOR_PURPLE)
					glow.set_light_on(TRUE)
				else
					glow.set_light_on(FALSE)
					glow.set_light_color(LIGHT_COLOR_PURPLE)
			if(LIGHT_COLOR_PURPLE)
				if(glow.even_cycle)
					glow.set_light_on(FALSE)
					glow.set_light_color(LIGHT_COLOR_BLUEGREEN)
				else
					glow.set_light_range_power_color(glow.base_light_range * DISCO_INFENO_RANGE, glow.light_power * 0.44, LIGHT_COLOR_BLUEGREEN)
					glow.set_light_on(TRUE)
			if(LIGHT_COLOR_BLUEGREEN)
				if(glow.even_cycle)
					glow.set_light_range(glow.base_light_range * DISCO_INFENO_RANGE)
					glow.set_light_color(LIGHT_COLOR_DIM_YELLOW)
					glow.set_light_on(TRUE)
				else
					glow.set_light_on(FALSE)
					glow.set_light_color(LIGHT_COLOR_DIM_YELLOW)
			if(LIGHT_COLOR_DIM_YELLOW)
				if(glow.even_cycle)
					glow.set_light_on(FALSE)
					glow.set_light_color(LIGHT_COLOR_CYAN)
				else
					glow.set_light_range(glow.base_light_range * DISCO_INFENO_RANGE)
					glow.set_light_color(LIGHT_COLOR_CYAN)
					glow.set_light_on(TRUE)
			if(LIGHT_COLOR_CYAN)
				if(glow.even_cycle)
					glow.set_light_range_power_color(glow.base_light_range * DISCO_INFENO_RANGE, glow.light_power * 0.68, COLOR_SOFT_RED)
					glow.set_light_on(TRUE)
				else
					glow.set_light_on(FALSE)
					glow.set_light_color(COLOR_SOFT_RED)
				glow.even_cycle = !glow.even_cycle
	sleep(1 SECONDS)

#undef DISCO_INFENO_RANGE

//Direct Cat Meteor
/datum/action/cooldown/spell/conjure_item/infinite_guns/direct_cateor
	name = "Direct Cat Meteor"
	desc = "Channel a locus of meteorized cat energy into the palm of your hand and direct it at a target. \n\
	(<b>Right-click</b> to activate metamagical scope modifier.)"

	button_icon = 'fulp_modules/icons/events/event_icons.dmi'
	button_icon_state = "cateor"

	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
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
	icon = 'fulp_modules/icons/spells/fulp_spell_icons.dmi'
	icon_state = "directable_cat_meteor"
	inhand_icon_state = "directable_cat_meteor"
	base_icon_state = "directable_cat_meteor"
	lefthand_file = 'fulp_modules/icons/spells/Inhands/fulp_spells_lefthand.dmi'
	righthand_file = 'fulp_modules/icons/spells/Inhands/fulp_spells_righthand.dmi'
	slot_flags = null
	item_flags = DROPDEL | ABSTRACT | NOBLUDGEON
	flags_1 = NONE
	weapon_weight = WEAPON_LIGHT
	max_charges = 1
	ammo_type = /obj/item/ammo_casing/energy/directed_cateor

/obj/item/gun/magic/wand/directable_cat_meteor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope/magic)

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
	icon = 'fulp_modules/icons/events/event_icons.dmi'
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

/obj/projectile/directed_cateor/Initialize(mapload)
	. = ..()
	size.Scale(1.5,1.5)
	src.transform = size

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
	icon = 'fulp_modules/icons/spells/hud/fulp_spell_screen_full.dmi'
	icon_state = "magic_scope"
	range_modifier = 4

//////////////////////////////////////////////////////////////////////////////
// Screentip-related code for the '/datum/component/scope/magic' component  //
// was made by copying and slightly altering code from                      //
// '/datum/component/customizable_reagent_holder'                           //
//////////////////////////////////////////////////////////////////////////////

/datum/component/scope/magic //The subtype scope component used for the directed cateor spell
	range_modifier = 4

/datum/component/scope/magic/Initialize(range_modifier, zoom_method, item_action_type)
	. = ..()
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE
	var/obj/obj_parent = parent

	obj_parent.obj_flags |= ITEM_HAS_CONTEXTUAL_SCREENTIPS

/datum/component/scope/magic/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_REQUESTING_CONTEXT_FOR_TARGET, PROC_REF(add_item_context))


/datum/component/scope/magic/proc/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	SIGNAL_HANDLER

	context[SCREENTIP_CONTEXT_RMB] = "Toggle Scope"
	return CONTEXTUAL_SCREENTIP_SET

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
	user.playsound_local(parent, 'sound/effects/portal/portal_travel.ogg', 50, TRUE)
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

	user.playsound_local(parent, 'sound/effects/portal/portal_travel.ogg', 50, TRUE, -1)
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
