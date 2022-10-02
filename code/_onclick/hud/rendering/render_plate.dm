/*!
 * Custom rendering solution to allow for advanced effects
 * We (ab)use plane masters and render source/target to cheaply render 2+ planes as 1
 * if you want to read more read the _render_readme.md
 */


/**
 * Render relay object assigned to a plane master to be able to relay it's render onto other planes that are not it's own
 */
/atom/movable/render_plane_relay
	screen_loc = "CENTER"
	layer = -1
	plane = 0
	appearance_flags = PASS_MOUSE | NO_CLIENT_COLOR | KEEP_TOGETHER

/**
 * ## Rendering plate
 *
 * Acts like a plane master, but for plane masters
 * Renders other planes onto this plane, through the use of render objects
 * Any effects applied onto this plane will act on the unified plane
 * IE a bulge filter will apply as if the world was one object
 * remember that once planes are unified on a render plate you cant change the layering of them!
 */
/atom/movable/screen/plane_master/rendering_plate
	name = "Default rendering plate"
	multiz_scaled = FALSE

///this plate renders the final screen to show to the player
/atom/movable/screen/plane_master/rendering_plate/master
	name = "Master rendering plate"
	documentation = "The endpoint of all plane masters, you can think of this as the final \"view\" we draw.\
		<br>If offset is not 0 this will be drawn to the transparent plane of the floor above, but otherwise this is drawn to nothing, or shown to the player."
	plane = RENDER_PLANE_MASTER
	render_relay_planes = list()

/atom/movable/screen/plane_master/rendering_plate/master/show_to(mob/mymob)
	. = ..()
	if(!.)
		return
	if(offset == 0)
		return
	// Non 0 offset render plates will relay up to the transparent plane above them, assuming they're not on the same z level as their target of course
	var/datum/hud/hud = home.our_hud
	if(hud)
		RegisterSignal(hud, COMSIG_HUD_OFFSET_CHANGED, .proc/on_offset_change)
	offset_change(hud.current_plane_offset)

/atom/movable/screen/plane_master/rendering_plate/master/hide_from(mob/oldmob)
	. = ..()
	if(offset == 0)
		return
	var/datum/hud/hud = home.our_hud
	if(hud)
		UnregisterSignal(hud, COMSIG_HUD_OFFSET_CHANGED, .proc/on_offset_change)

/atom/movable/screen/plane_master/rendering_plate/master/proc/on_offset_change(datum/source, old_offset, new_offset)
	SIGNAL_HANDLER
	offset_change(new_offset)

/atom/movable/screen/plane_master/rendering_plate/master/proc/offset_change(new_offset)
	if(new_offset == offset) // If we're on our own z layer, relay to nothing, just draw
		remove_relay_from(GET_NEW_PLANE(RENDER_PLANE_TRANSPARENT, offset - 1))
	else // Otherwise, regenerate the relay
		add_relay_to(GET_NEW_PLANE(RENDER_PLANE_TRANSPARENT, offset - 1))

///renders general in charachter game objects
/atom/movable/screen/plane_master/rendering_plate/game_plate
	name = "Game rendering plate"
	documentation = "Holds all objects that are ahhh, in character? is maybe the best way to describe it.\
		<br>We apply a displacement effect from the gravity pulse plane too, so we can warp the game world."
	plane = RENDER_PLANE_GAME
	render_relay_planes = list(RENDER_PLANE_MASTER)

/atom/movable/screen/plane_master/rendering_plate/game_plate/Initialize(mapload)
	. = ..()
	add_filter("displacer", 1, displacement_map_filter(render_source = OFFSET_RENDER_TARGET(GRAVITY_PULSE_RENDER_TARGET, offset), size = 10))

/atom/movable/screen/plane_master/rendering_plate/transparent
	name = "Transparent plate"
	documentation = "The master rendering plate from the offset below ours will be mirrored onto this plane. That way we achive a \"stack\" effect.\
		<br>This plane exists to uplayer the master rendering plate to the correct spot in our z layer's rendering order"
	plane = RENDER_PLANE_TRANSPARENT
	appearance_flags = PLANE_MASTER

/atom/movable/screen/plane_master/rendering_plate/transparent/Initialize(mapload, datum/plane_master_group/home, offset)
	. = ..()
	// Don't display us if we're below everything else yeah?
	AddComponent(/datum/component/plane_hide_highest_offset)
	color = list(0.9,0,0,0, 0,0.9,0,0, 0,0,0.9,0, 0,0,0,1, 0,0,0,0)

///Contains most things in the game world
/atom/movable/screen/plane_master/rendering_plate/game_world
	name = "Game world plate"
	documentation = "Contains most of the objects in the world. Mobs, machines, etc. Note the drop shadow, it gives a very nice depth effect."
	plane = RENDER_PLANE_GAME_WORLD
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/rendering_plate/game_world/show_to(mob/mymob)
	. = ..()
	if(!.)
		return
	remove_filter("AO")
	if(istype(mymob) && mymob.client?.prefs?.read_preference(/datum/preference/toggle/ambient_occlusion))
		add_filter("AO", 1, drop_shadow_filter(x = 0, y = -2, size = 4, color = "#04080FAA"))

///Contains all lighting objects
/atom/movable/screen/plane_master/rendering_plate/lighting
	name = "Lighting plate"
	documentation = "Anything on this plane will be <b>multiplied</b> with the plane it's rendered onto (typically the game plane).\
		<br>That's how lighting functions at base. Because it uses BLEND_MULTIPLY and occasionally color matrixes, it needs a backdrop of blackness.\
		<br>See <a href=\"https://secure.byond.com/forum/?post=2141928\">This byond post</a>\
		<br>Lemme see uh, we're masked by the emissive plane so it can actually function (IE: make things glow in the dark).\
		<br>We're also masked by the overlay lighting plane, which contains all the movable lights in the game. It draws to us and also the game plane.\
		<br>Masks us out so it has the breathing room to apply its effect.\
		<br>Oh and we quite often have our alpha changed to achive night vision effects, or things of that sort."
	plane = RENDER_PLANE_LIGHTING
	blend_mode_override = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/rendering_plate/lighting/show_to(mob/mymob)
	. = ..()
	if(!.)
		return
	// This applies a backdrop to our lighting plane
	// Why do plane masters need a backdrop sometimes? Read https://secure.byond.com/forum/?post=2141928
	// Basically, we need something to brighten
	// unlit is perhaps less needed rn, it exists to provide a fullbright for things that can't see the lighting plane
	// but we don't actually use invisibility to hide the lighting plane anymore, so it's pointless
	mymob.overlay_fullscreen("lighting_backdrop_lit", /atom/movable/screen/fullscreen/lighting_backdrop/lit)
	mymob.overlay_fullscreen("lighting_backdrop_unlit", /atom/movable/screen/fullscreen/lighting_backdrop/unlit)

	// Sorry, this is a bit annoying
	// Basically, we only want the lighting plane we can actually see to attempt to render
	// If we don't our lower plane gets totally overriden by the black void of the upper plane
	var/datum/hud/hud = home.our_hud
	if(hud)
		RegisterSignal(hud, COMSIG_HUD_OFFSET_CHANGED, .proc/on_offset_change)
	offset_change(hud.current_plane_offset)
	set_alpha(mymob.lighting_alpha)


/atom/movable/screen/plane_master/rendering_plate/lighting/hide_from(mob/oldmob)
	. = ..()
	oldmob.clear_fullscreen("lighting_backdrop_lit")
	oldmob.clear_fullscreen("lighting_backdrop_unlit")
	var/datum/hud/hud = home.our_hud
	if(hud)
		UnregisterSignal(hud, COMSIG_HUD_OFFSET_CHANGED, .proc/on_offset_change)

/atom/movable/screen/plane_master/rendering_plate/lighting/proc/on_offset_change(datum/source, old_offset, new_offset)
	SIGNAL_HANDLER
	offset_change(new_offset)

/atom/movable/screen/plane_master/rendering_plate/lighting/proc/offset_change(mob_offset)
	// Offsets stack down remember. This implies that we're above the mob's view plane, and shouldn't render
	if(offset < mob_offset)
		disable_alpha()
	else
		enable_alpha()

/*!
 * This system works by exploiting BYONDs color matrix filter to use layers to handle emissive blockers.
 *
 * Emissive overlays are pasted with an atom color that converts them to be entirely some specific color.
 * Emissive blockers are pasted with an atom color that converts them to be entirely some different color.
 * Emissive overlays and emissive blockers are put onto the same plane.
 * The layers for the emissive overlays and emissive blockers cause them to mask eachother similar to normal BYOND objects.
 * A color matrix filter is applied to the emissive plane to mask out anything that isn't whatever the emissive color is.
 * This is then used to alpha mask the lighting plane.
 */
/atom/movable/screen/plane_master/rendering_plate/lighting/Initialize(mapload)
	. = ..()
	add_filter("emissives", 1, alpha_mask_filter(render_source = OFFSET_RENDER_TARGET(EMISSIVE_RENDER_TARGET, offset), flags = MASK_INVERSE))
	add_filter("object_lighting", 2, alpha_mask_filter(render_source = OFFSET_RENDER_TARGET(O_LIGHTING_VISUAL_RENDER_TARGET, offset), flags = MASK_INVERSE))

///render plate for OOC stuff like ghosts, hud-screen effects, etc
/atom/movable/screen/plane_master/rendering_plate/non_game
	name = "Non-Game rendering plate"
	documentation = "Renders anything that's out of character. Mostly useful as a converse to the game rendering plate."
	plane = RENDER_PLANE_NON_GAME
	render_relay_planes = list(RENDER_PLANE_MASTER)

/**
 * Plane master proc called in Initialize() that creates relay objects, and sets them uo as needed
 * Sets:
 * * layer from plane to avoid z-fighting
 * * planes to relay the render to
 * * render_source so that the plane will render on these objects
 * * mouse opacity to ensure proper mouse hit tracking
 * * name for debugging purposes
 * Other vars such as alpha will automatically be applied with the render source
 */
/atom/movable/screen/plane_master/proc/generate_render_relays()
	var/relay_loc = "CENTER"
	// If we're using a submap (say for a popup window) make sure we draw onto it
	if(home?.map)
		relay_loc = "[home.map]:[relay_loc]"

	var/list/generated_planes = list()
	for(var/atom/movable/render_plane_relay/relay as anything in relays)
		generated_planes += relay.plane

	for(var/relay_plane in (render_relay_planes - generated_planes))
		generate_relay_to(relay_plane, relay_loc)

	if(blend_mode != BLEND_MULTIPLY)
		blend_mode = BLEND_DEFAULT
	relays_generated = TRUE

/// Creates a connection between this plane master and the passed in plane
/// Helper for out of system code, shouldn't be used in this file
/// Build system to differenchiate between generated and non generated render relays
/atom/movable/screen/plane_master/proc/add_relay_to(target_plane, blend_override)
	if(get_relay_to(target_plane))
		return
	render_relay_planes += target_plane
	if(!relays_generated && isnull(blend_override))
		return
	var/client/display_lad = home?.our_hud?.mymob?.client
	generate_relay_to(target_plane, show_to = display_lad, blend_override = blend_override)

/proc/get_plane_master_render_base(name)
	return "*[name]: AUTOGENERATED RENDER TGT"

/atom/movable/screen/plane_master/proc/generate_relay_to(target_plane, relay_loc, client/show_to, blend_override)
	if(!length(relays) && !initial(render_target))
		render_target = OFFSET_RENDER_TARGET(get_plane_master_render_base(name), offset)
	if(!relay_loc)
		relay_loc = "CENTER"
		// If we're using a submap (say for a popup window) make sure we draw onto it
		if(home?.map)
			relay_loc = "[home.map]:[relay_loc]"
	var/blend_to_use = blend_override
	if(isnull(blend_to_use))
		blend_to_use = blend_mode_override || initial(blend_mode)

	var/atom/movable/render_plane_relay/relay = new()
	relay.render_source = render_target
	relay.plane = target_plane
	relay.screen_loc = relay_loc
	// There are two rules here
	// 1: layer needs to be positive (negative layers are treated as float layers)
	// 2: lower planes (including offset ones) need to be layered below higher ones (because otherwise they'll render fucky)
	// By multiplying LOWEST_EVER_PLANE by 30, we give 30 offsets worth of room to planes before they start going negative
	// Bet
	relay.layer = (plane + abs(LOWEST_EVER_PLANE * 30)) //layer must be positive but can be a decimal
	relay.blend_mode = blend_to_use
	relay.mouse_opacity = mouse_opacity
	relay.name = render_target
	relays += relay
	// Relays are sometimes generated early, before huds have a mob to display stuff to
	// That's what this is for
	if(show_to)
		show_to.screen += relay
	return relay

/// Breaks a connection between this plane master, and the passed in place
/atom/movable/screen/plane_master/proc/remove_relay_from(target_plane)
	render_relay_planes -= target_plane
	var/atom/movable/render_plane_relay/existing_relay = get_relay_to(target_plane)
	if(!existing_relay)
		return
	relays -= existing_relay
	if(!length(relays) && !initial(render_target))
		render_target = null
	var/client/lad = home?.our_hud?.mymob?.client
	if(lad)
		lad.screen -= existing_relay

/// Gets the relay atom we're using to connect to the target plane, if one exists
/atom/movable/screen/plane_master/proc/get_relay_to(target_plane)
	for(var/atom/movable/render_plane_relay/relay in relays)
		if(relay.plane == target_plane)
			return relay

	return null

/// Basically, trigger a full hud rebuild so our relays will be added to the screen
/// I hate hud code
/atom/movable/screen/plane_master/proc/rebuild_relays()
	relays = list()
	var/datum/hud/hud = home.our_hud
	hud.show_hud(hud.hud_version)
