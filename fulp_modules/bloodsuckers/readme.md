## Title: Bloodsuckers

MODULE ID: BLOODSUCKERS

### Description:

Adds the Bloodsucker, Vassal and Monster Hunter antagonists to the game, with all code, sprites and sounds necessary.

### TG files changed:

- code/__DEFINES/atom_hud.dm | code/datums/hud.dm > Added Bloodsucker huds (These are DISGUSTINGLY NON-MODULAR)
- code/__DEFINES/role_preferences.dm > Added Bloodsuckers/Monster Hunters as antagonist preference options
- code/game/objects/items/devices/scanners.dm > Falsifies health analyzers if you're on Masquerade
- code/game/objects/items/implants/implant_mindshield.dm > Makes Mindshields remove Vassalization
- code/modules/clothing/neck/_neck.dm > Added a NOPULSE check to scanning a heart
- code/modules/mob/living/carbon/human/examine.dm > Added Bloodsucker examine text (This might be modularizable?)
- code/modules/mob/living/carbon/life.dm > Kicks Bloodsuckers out of body temperature (This might be modularizable?)
- code/modules/surgery/organs/tongue.dm > Added Vampiric language (This might be modularizable?)

### Credits:

Skyrat - .md template
Fulpstation/TheSwain - Original Bloodsuckers
John Willard - Coding
Citadel - Help with some coding
