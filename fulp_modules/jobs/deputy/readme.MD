## Title: Brig Physician

MODULE ID: DEPUTIES

### Description:

Adds Deputies job to the game. This includes all the deputy, landmark, and gamemode overwrites.

### TG Proc Changes:

- code/modules/jobs/jobs.dm > GLOBAL_LIST_INIT(security_positions, list()
- code/modules/jobs/access.dm > /proc/get_all_accesses()

### TG files changed:

- code/modules/mob/living/carbon/human/species_types/plasmamen.dm > Added deputy plasmaman outfit.
- code/game/machinery/crew.dm > Added deputy to the job list datum.

### TG procs overwrites:

- update_overlays() (code/game/objects/items/cards_ids.dm) > Assigns ID Overlays for Fulp jobs.
- sec_hud_set_ID() (code/game/data_huds.dm) > Assigns HUD Overlays for Fulp jobs.

### Additional information:

This adds 100% support for new fulp-exclusive jobs, trying to avoid as much conflicts. For more info on how to (mostly) create a new fulp-exclusive job, contact SgtHunk on the Fulpstation discord.

### Credits:

Skyrat - .md template.
Mithrandalf - Original Deputies PR and sprites (https://github.com/TheSwain/Fulpstation/pull/108)
John Willard - Coding rework
