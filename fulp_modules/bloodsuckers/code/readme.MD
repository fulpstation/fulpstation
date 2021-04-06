# Folder: Bloodsuckers

## Description:

	Adds Bloodsucker, Monster Hunter and Vassal Antagonists to the game.

## TG edits:

- code/__DEFINES/atom_hud.dm | code/datums/hud.dm > Added Bloodsucker huds (These are DISGUSTINGLY NON-MODULAR)
- code/__DEFINES/role_preferences.dm > Added Bloodsuckers/Monster Hunters as antagonist preference options
- code/game/objects/items/devices/scanners.dm > Falsifies health analyzers if you're on Masquerade
- code/game/objects/items/implants/implant_mindshield.dm > Makes Mindshields remove Vassalization
- code/modules/mob/living/carbon/human/examine.dm > Added Bloodsucker examine text

## TG proc overwrites:

- /obj/item/clothing/neck/necklace/memento_mori/memento() - Prevents Bloodsuckers from getting complete immunity
- /datum/species/jelly/slime/spec_life() - Prevents Bloodsuckers from abusing Slimepeople
- /datum/species/jelly/spec_life() - Prevents Bloodsuckers from abusing Slimepeople

## Notes/Credits:

- TheSwain - Original Bloodsuckers (https://github.com/TheSwain/Fulpstation/tree/master/code/modules/antagonists/bloodsucker)
- Citadel - Remastered Bloodsuckers (https://github.com/Citadel-Station-13/Citadel-Station-13/tree/master/code/modules/antagonists/bloodsucker)
