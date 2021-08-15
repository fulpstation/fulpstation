## List of all TG edits:

- _maps/_basemap.dm > Adds our maps to the list of playable maps

- code/__DEFINES/atom_hud.dm > Bloodsucker HUDs
- code/__DEFINES/role_preferences.dm > Bloodsuckers/Monster Hunters as antagonist preference options

- code/__HELPERS/global_lists.dm > Beefmen customization/preferences.
- code/__HELPERS/roundend.dm > Plays our roundend music instead

- code/controllers/subsystem/ticker.dm > Adds pick_round_end_sound() to the round_end_song
- code/controllers/subsystem/job.dm > Adds Fulp jobs to the station job list datum. || Replaces var/list/chain_of_command with our own version.

- code/datums/hud.dm > Bloodsucker HUDs

- code/game/area/areas/shuttle.dm > Plays ApproachingFulp instead of ApproachingTG
- code/game/gamemodes/objective.dm > Added Bloodsucker objectives to the list of objectives Admins can make
- code/game/machinery/computer/crew.dm > Adds Fulp jobs to the crew monitor.
- code/game/objects/items/devices/scanners.dm > Falsifies health analyzers if you're on Masquerade

- code/modules/admin/verbs/adminhelp.dm > Button for redirecting people to Mentorhelp
- code/modules/client/client_procs.dm > Gives the mentorhelp verb
- code/modules/client/preferences.dm > Preferences for antag tip enabling/disabling || Beefmen customization/preferences
- code/modules/client/preferences_savefile.dm > Preference saving for antag tips || Beefmen customization/preferences
- code/modules/mob/living/carbon/human/examine.dm > Changes examine text for Beefmen || Added examining Bloodsuckers/Vassals || adds ShowAsPaleExamine()
- code/modules/mob/living/carbon/human/species.dm > Beefmen customization/preferences || Makes Digitigrade shoes fit Digi Lizards.
- code/modules/surgery/bodyparts/_bodyparts.dm > Changes bodypart .dmi files for Beefmen

- tools/build/build.js > Adds our folder to be read for changes when compiling.

## List of all files not withing fulp_modules:

### Maps

- _maps/map_files/Heliostation.dmm
- _maps/heliostation.json
- _maps/map_files/SeleneStation.dmm
- _maps/Selenestation.json
- _maps/map_files/PubbyStation.dmm
- _maps/pubbystation.json

### TGUI
- tgui/packages/tgui/interfaces/KindredArchives.js
