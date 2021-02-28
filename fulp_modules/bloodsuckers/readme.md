## Title: Bloodsuckers

MODULE ID: BLOODSUCKERS

### Description:

Adds Bloodsuckers, vassals and Monster hunter antagonists to the game.

### TG files changed:

- code/__DEFINES/role_preferences.dm > Added Bloodsuckers/Monster hunters as selectable antags.
- code/_onclick/hud/hud.dm // code/datums/hud.dm // code/_onclick/hud/human.dm // code/__DEFINES/atom_hud.dm > Added Bloodsucker huds
- code/game/objects/items/implants/implant_mindshield.dm > Makes mindshielding unvassalize
- code/modules/clothing/neck/_neck.dm > adds a check for NOPULSE
- code/modules/fields/timestop.dm // code/modules/mob/living/simple_animal/guardian/guardian.dm > Bloodsucker timestop guardian	
- code/modules/mob/living/blood.dm > Makes bloodsuckers not affected by usual bleeding
- code/modules/mob/living/carbon/human/species_types/jellypeople.dm > Prevents bloodsucker jellypeople powergaming
- code/modules/mob/living/carbon/life.dm > Makes trait COLDBLOODED make you unnaffected by the cold
- code/modules/mob/mob_movement.dm > Cant run while on Fortitude
- code/modules/surgery/organs/heart.dm > Adds HeartStrengthMessage
- code/modules/surgery/organs/tongue.dm > Adds vampiric language to the tongue
- code/__DEFINES/traits.dm > Adds Bloodsucker traits
- code/modules/mob/living/carbon/life.dm > Proc to handle bloodsucker huds

### Credits:

Skyrat - .md template
TheSwain - Original Bloodsuckers
Citadel - New Bloodsucker code
John Willard - Coding
