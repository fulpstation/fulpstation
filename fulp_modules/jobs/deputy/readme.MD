## Title: Deputies

MODULE ID: DEPUTIES

### Description:

Adds Deputies to the game. This includes all code for deputies, skillchips, and gamemode overwrites.

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

This uses code made in the BrigDoc PR to make a new fulp-exclusive job while avoiding as many conflicts as possible.

### Credits:

Skyrat - .md template.
Mithrandalf - Original Deputies PR and original sprites (https://github.com/TheSwain/Fulpstation/pull/108)
John Willard - Coding rework
SgtHunk - Original Brig Doc PR (https://github.com/fulpstation/fulpstation/pull/16) + Answering coding questions
Guillaume H. Prata - New sprites for rolled up Jumpsuits/Jumpskirts + Answering coding questions
Montague Joyce - New sprites for Plasmamen/Beefmen
Sheets - New sprites for their ties
