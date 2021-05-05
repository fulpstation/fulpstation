# Folder: Bloodsuckers

## Description:

	Adds Bloodsucker, Monster Hunter and Vassal Antagonists to the game.

## TG edits:

- code/modules/admin/sql_ban_system.dm > Added Bloodsuckers and Monster hunters as bannable antagonists.
- code/__DEFINES/atom_hud.dm | code/datums/hud.dm > Added Bloodsucker huds (These are DISGUSTINGLY NON-MODULAR)
- code/__DEFINES/role_preferences.dm > Added Bloodsuckers/Monster Hunters as antagonist preference options
- code/game/gamemodes/objective.dm > Added Bloodsucker objectives to the list of objectives Admins can make
- code/game/objects/items/devices/scanners.dm > Falsifies health analyzers if you're on Masquerade
- code/modules/mob/living/carbon/human/examine.dm > Added Bloodsucker examine text

## TG proc overwrites:

- /obj/item/clothing/neck/necklace/memento_mori/memento() - Prevents Bloodsuckers from getting complete immunity
- /datum/species/jelly/slime/spec_life() - Prevents Bloodsuckers from abusing Slimepeople
- /datum/species/jelly/spec_life() - Prevents Bloodsuckers from abusing Slimepeople
- /mob/living/carbon/natural_bodytemperature_stabilization() - Makes Bloodsucker's blood cold

## TG sounds/sprites used:

- 'sound/effects/pope_entry.ogg' > Played when a Bloodsucker reaches Rank 4
- 'sound/effects/his_grace_ascend.ogg' > Monster hunter's on_gain sound
- 'sound/magic/mutate.ogg' > Vassal's greet
- 'sound/effects/footstep/slime1.ogg' > Meat coffin sounds
- 'sound/machines/door_locked.ogg' > When attempting to open a closed coffin
- 'sound/effects/explosion_distant.ogg' > Vassalization sound
- 'sound/effects/singlebeat.ogg' > Vassalization sound / Bloodsucker Life sound
- 'sound/effects/alert.ogg' > Bloodsucker daylight warning sound
- 'sound/ambience/ambimystery.ogg' > Bloodsucker daylight warning sound
- 'sound/spookoween/ghosty_wind.ogg' > Bloodsucker daylight warning sound
- 'sound/effects/tendril_destroyed.ogg' > Bloodsucker's FinalDeath
- 'sound/items/drink.ogg' > Bloodbag drinking
- 'sound/weapons/bladeslice.ogg' > Stake sound effect / Hunter-Fu
- 'sound/magic/Demon_consume.ogg' > When you begin to stake someone
- 'sound/effects/splat.ogg' > Staking someone's sound effect / Feed
- 'sound/effects/grillehit.ogg' > Brawn
- 'sound/magic/summon_karp.ogg' > Go home / Trespass
- 'sound/weapons/punchmiss.ogg' > Haste
- 'sound/magic/smoke.ogg' > Veil
- 'sound/weapons/slam.ogg' > Hunter-Fu
- 'sound/effects/snap.ogg' > Hunter-Fu
- 'sound/weapons/slash.ogg' > Hunter-Fu
- 'sound/weapons/punch1.ogg' > Hunter-Fu

## Notes/Credits:

- TheSwain - Original Bloodsuckers (https://github.com/TheSwain/Fulpstation/tree/master/code/modules/antagonists/bloodsucker)
- Citadel - Remastered Bloodsuckers (https://github.com/Citadel-Station-13/Citadel-Station-13/tree/master/code/modules/antagonists/bloodsucker)
