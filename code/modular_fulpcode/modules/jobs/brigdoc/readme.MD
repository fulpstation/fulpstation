## Title: Brig Physician

MODULE ID: BRIGDOC

### Description:

Adds the Brig Physician job to the game. This includes all the brig physician items and job descriptors.

### TG Proc Changes:

- code/modules/jobs/jobs.dm > GLOBAL_LIST_INIT(security_positions, list()
- code/modules/jobs/access.dm > /proc/get_all_accesses()

### TG files changed:

- code/modules/mob/living/carbon/human/species_types/plasmamen.dm > Added brig physician plasmaman outfit.
- code/datums/traits/negative.dm > Added brig physician heirloom.
- code/game/machinery/crew.dm > Added brig physician to the job list datum.

### Credits:

Skyrat - .md template, Original plasmaman envirosuit sprites (https://github.com/Skyrat-SS13/Skyrat13/pull/933)
HomingPenguins - Armored labcoat sprites
MaltVinegar - HUD/Card sprites
Mithrandalf - Original jumpsuit and beret sprites (https://github.com/TheSwain/Fulpstation/pull/163 || https://github.com/TheSwain/Fulpstation/pull/108)
SgtHunk - Coding
