// This is just so we can add our own ambience music without touching the /tg/ files. Here's how to do it, just add the
// GLOB.nameoftheambience_ambience += 'the/music/you/want/to/add.ogg'
// Should also work with a list, if you want to add multiple.

// Using setup_available_channels() proc as it's a setup proc of the sound subsystem.
/datum/controller/subsystem/sounds/setup_available_channels()
	..()
	//Space-ambience music addition.
	GLOB.space_ambience += 'fulp_modules/fulp_exclusive_sounds/sound/spacepad.ogg'
