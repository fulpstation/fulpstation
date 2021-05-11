# Folder: Fulp Config

## Description:

	All files related to the Config that are meant to be Fulp-only. readme is for TG edit purposes.

## TG edits:

- code/controllers/subsystem/ticker.dm > Adds pick_round_end_sound() to the round_end_song
- code/modules/mob/dead/new_player/new_player.dm > Plays ApproachingFulp instead of ApproachingTG

## TG proc overwrites:

- /datum/emote/living/kiss/run_emote > kiss_overwrite.dm
- /world/New() > fulp_world.dm
- /world/proc/update_status() > fulp_world.dm
