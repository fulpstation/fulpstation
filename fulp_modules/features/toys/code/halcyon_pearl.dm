/// An instrument that spawns in the AI satellite on lowpop (reference to Rain World: Downpour)
/// Hardcoded to only play a rough version of "Halcyon Memories"
/// (https://www.youtube.com/watch?v=z04shakaUcE)

/obj/item/instrument/halcyon_pearl
	name = "Strange Pearl"
	desc = "A purple pearl that resonates with subtle warmth."
	force = 1
	max_integrity = 200
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'fulp_modules/icons/toys/instruments.dmi'
	icon_state = "halcyon_pearl"
	inhand_icon_state = "harmonica"
	allowed_instrument_ids = "sine"
	hitsound = 'sound/effects/rock/rocktap1.ogg'

/obj/item/instrument/halcyon_pearl/Initialize(mapload)
	. = ..()
	if(!at_lowpop())
		return INITIALIZE_HINT_QDEL

	var/song_lines = HALCYON_SONG
	song.note_shift = 12
	song.ParseSong(new_song = song_lines)
	// So it can float when active.
	AddElement(/datum/element/movetype_handler)

	register_context()
	RegisterSignal(src, COMSIG_INSTRUMENT_START, PROC_REF(on_instrument_start))
	RegisterSignal(src, COMSIG_INSTRUMENT_END, PROC_REF(on_instrument_end))

/obj/item/instrument/halcyon_pearl/Destroy()
	. = ..()
	UnregisterSignal(src, list(COMSIG_INSTRUMENT_START, COMSIG_INSTRUMENT_END))

/obj/item/instrument/halcyon_pearl/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!isAI(user))
		return

	if(in_range(src, user))
		context[SCREENTIP_CONTEXT_CTRL_LMB] = "Toggle [song.playing ? "Off" : "On"]"
		context[SCREENTIP_CONTEXT_SHIFT_LMB] = "Maximize Song Duration"
	else
		context[SCREENTIP_CONTEXT_CTRL_LMB] = "ERR% TARGET OUT OF RANGE"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/instrument/halcyon_pearl/examine(mob/user)
	. = ..()
	if(!isAI(user))
		. += span_notice("It looks vaguely electronic— an <b>AI</b> might be able to interface with it.")
	else
		. += span_notice("This is an exotic data storage device that you could probably manipulate at close-range.")

/obj/item/instrument/halcyon_pearl/ui_interact(mob/user, datum/tgui/ui)
	if(isliving(user))
		to_chat(user, span_notice("You're not sure how to operate it..."))

/obj/item/instrument/halcyon_pearl/AICtrlClick(mob/living/silicon/ai/user)
	. = ..()
	if(song.playing)
		song.stop_playing()
	else
		song.start_playing(user)

/obj/item/instrument/halcyon_pearl/AIShiftClick(mob/living/silicon/ai/user)
	. = ..()
	song.repeat = 10

/obj/item/instrument/halcyon_pearl/proc/on_instrument_start()
	SIGNAL_HANDLER

	ADD_TRAIT(src, TRAIT_MOVE_FLOATING, TRAIT_GENERIC)
	icon_state = "halcyon_pearl_active"
	update_appearance()

/obj/item/instrument/halcyon_pearl/proc/on_instrument_end()
	SIGNAL_HANDLER

	REMOVE_TRAIT(src, TRAIT_MOVE_FLOATING, TRAIT_GENERIC)
	icon_state = "halcyon_pearl"
	update_appearance()

//////////////////////////////////////////////////////////////////
///      "OVERRIDES" SO THAT THE PEARL ACTUALLY SPAWNS IN      ///
//////////////////////////////////////////////////////////////////

/// Overriding 'Initialize()' causes the spawn turf location logic to become faulty for some reason,
/// so we'll just "override" the preexisting 'after_round_start()' proc with itself and then append
/// the necessary code.
/obj/effect/landmark/start/ai/after_round_start()
	. = ..()
	if(!primary_ai)
		return

	// If at lowpop then find a turf to spawn a halcyon pearl at.
	// This turf should always be directly above or below the AI start landmark.
	// (If it's to the left or right then it'll pan/sound weird; if it's not right next to them then
	// they can't use it.)
	if(at_lowpop())
		// The landmark's turf.
		var/turf/source_turf = get_turf(src)
		// The turf we'll ultimately end up spawning the pearl at.
		// Defaults to our 'source_turf' just in case we can't find a better alternative.
		var/turf/open/target_turf = source_turf

		for(var/turf/open/open_turf in orange(1, source_turf))
			if(open_turf == source_turf)
				continue
			if(open_turf.x == src.loc.x)
				target_turf = open_turf
				break

		new /obj/item/instrument/halcyon_pearl(target_turf)
