## Title: Bloodsuckers

MODULE ID: BLOODSUCKERS

### Description:

Adds the Bloodsucker, Vassal and Monster Hunter antagonists to the game, with all code, sprites and sounds necessary.

### TG files changed:

- code/__DEFINES/atom_hud.dm | code/_onclick/hud/human.dm | code/datums/hud.dm > Added Bloodsucker huds
- code/__DEFINES/role_preferences.dm > Added Bloodsuckers/Monster Hunters as Antags
- code/game/objects/items/implants/implant_mindshield.dm > Makes Mindshields remove Vassalization
- code/game/objects/items/devices/scanners.dm > Falsifies health analyzers if you're on Masquerade
- code/modules/clothing/neck/_neck.dm > Added a NOPULSE check to scanning a heart
- code/modules/fields/timestop.dm > Bloodsucker Holoparasite code edit
- code/modules/mining/lavaland/necropolis_chests.dm > Prevents Bloodsuckers from using a Memento Mori
- code/modules/mob/living/blood.dm > Kicks Bloodsuckers out of blood.dm
- code/modules/mob/living/carbon/human/species_types/jellypeople.dm > Prevents Slimesuckers from getting Toxin/Several body bonuses
- code/modules/mob/living/carbon/life.dm > Kicks Bloodsuckers out of body temperature
- code/modules/mob/mob_movement.dm > Prevents running while on Fortitude
- code/modules/reagents/chemistry/reagents/alcohol_reagents.dm > Gives Bloodsuckers blood for drinking Bloody Mary
- code/modules/surgery/organs/tongue.dm > Added Vampiric language

### Credits:

Skyrat - .md template
Fulpstation/TheSwain - Original Bloodsuckers
John Willard - Coding
Citadel - Help with some coding

## NOTES:

- bloodsucker_objects.dm >> Once Combat mode is merged, add Help intent to Blood bag's drinking
- vassal.dm >> Once New Traits is merged, swap REMOVE_TRAIT(owner.current, TRAIT_MINDSHIELD, "implant") -> REMOVE_TRAIT(owner.current, TRAIT_MINDSHIELD, IMPLANT_TRAIT)
