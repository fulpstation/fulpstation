## List of all TG edits:

- code/__DEFINES/atom_hud.dm > Bloodsucker HUDs
- code/__DEFINES/role_preferences.dm > Bloodsuckers/Monster Hunters as antagonist preference options

- code/__HELPERS/roundend.dm > Plays our roundend music instead
- code/__HELPERS/global_lists.dm > Beefmen customization/preferences.

- code/controllers/subsystem/ticker.dm > Adds pick_round_end_sound() to the round_end_song
- code/controllers/subsystem/job.dm > Adds Fulp jobs to the station job list datum.

- code/datums/hud.dm > Bloodsucker HUDs

- code/game/gamemodes/objective.dm > Added Bloodsucker objectives to the list of objectives Admins can make
- code/game/machinery/computer/crew.dm > Adds Fulp jobs to the crew monitor.
- code/game/objects/items/devices/scanners.dm > Falsifies health analyzers if you're on Masquerade
- code/game/objects/items/implants/implant_mindshield.dm > Mindshielding removes Vassalization

- code/modules/admin/verbs/adminhelp.dm > Button for redirecting people to Mentorhelp
- code/modules/admin/sql_ban_system.dm > Bloodsuckers and Monster hunters as bannable antagonists.
- code/modules/client/preferences.dm > Preferences for antag tip enabling/disabling || Beefmen customization/preferences
- code/modules/client/preferences_savefile.dm > Preference saving for antag tips || Beefmen customization/preferences
- code/modules/client/client_procs.dm > Gives the mentorhelp verb
- code/modules/mob/dead/new_player/new_player.dm > Plays ApproachingFulp instead of ApproachingTG
- code/modules/mob/living/carbon/human/species.dm > Beefmen customization/preferences || Makes Digitigrade shoes fit Digi Lizards.
- code/modules/mob/living/carbon/human/examine.dm > Changes examine text for Beefmen || Added examining Bloodsuckers/Vassals || adds ShowAsPaleExamine()
- code/modules/surgery/bodyparts/_bodyparts.dm > Changes bodypart .dmi files for Beefmen
- code/modules/jobs/jobs.dm > Adds Fulp jobs to GLOBAL_LIST_INIT(security_positions, list() & GLOBAL_LIST_INIT(security_sub_positions, list()
