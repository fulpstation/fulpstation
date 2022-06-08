## List of all TG edits:

- _maps/_basemap.dm > Adds our maps to the list of playable maps

- code/__DEFINES/role_preferences.dm > Bloodsuckers/Monster Hunters as antagonist preference options

- code/__HELPERS/roundend.dm > Plays our roundend music instead

- code/game/area/areas/shuttles.dm > Plays ApproachingFulp instead of ApproachingTG
- code/game/gamemodes/objective.dm > Added Bloodsucker and Infiltrator objectives to the list of objectives Admins can make
- code/game/objects/items/devices/scanners/health_analyzer.dm > Falsifies health analyzers if you're on Masquerade

- code/modules/mob/living/carbon/human/examine.dm > Changes examine text for Beefmen || Added examining Bloodsuckers/Vassals || adds ShowAsPaleExamine()
- code/modules/mob/living/carbon/human/species.dm > Beefmen customization/preferences

- tools/build/build.js > Adds our folder to be read for changes when compiling.

- tgui/packages/tgui/routes.js > Add custom routing so fulp-specific interfaces can be found and loaded
- tgui/yarn.lock > Our lockfile is slightly different - we have an additional workspace package, "fulpui-patches"

- tgui/packages/fulpui_patches > Adds all Fulp TGUI files

## All Fulp files not contained within /fulp_modules/

### Maps

- _maps/map_files/Heliostation.dmm
- _maps/heliostation.json
- _maps/map_files/SeleneStation.dmm
- _maps/Selenestation.json
- _maps/map_files/PubbyStation.dmm
- _maps/pubbystation.json

### TGUI
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/bloodsucker.ts
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/bloodsuckerbreakout.ts
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/monsterhunter.ts
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/vampiricaccident.ts
- tgui/packages/tgui/interfaces/PreferencesMenu/preferences/features/beefman_features.tsx
- tgui/packages/tgui/interfaces/PreferencesMenu/preferences/features/character_preferences/antag_tips.tsx
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/ghostinfiltrator.ts
