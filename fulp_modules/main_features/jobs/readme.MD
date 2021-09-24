# Folder: Jobs

## Description:

	Adds the Brig Physician and Deputy jobs to the game.

## TG edits:

- None

## TG proc overwrites:

- sec_hud_set_ID() (code/game/data_huds.dm) > Assigns HUD Overlays for Fulp jobs.
- setup_job_lists() (code/controllers/subsystem/job.dm) > Adds Fulp jobs to the list of all jobs
- /datum/crewmonitor/var/list/jobs (code/game/machinery/computer/crew.dm) > Adds Fulp jobs to the Crew monitor

## TG sounds/sprites used:

- None

## Notes/Credits:

- Skyrat - Original plasmaman envirosuit sprites (https://github.com/Skyrat-SS13/Skyrat13/pull/933)
- HomingPenguins - Armored labcoat sprites
- MaltVinegar - Brig Physician HUD/Card sprites
- Mithrandalf - Original Deputies (https://github.com/TheSwain/Fulpstation/pull/108)
- Horatio22 - Deputy Plasmamen sprites
