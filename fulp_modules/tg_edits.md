## List of all TG edits:

- code/datums/greyscale/_greyscale_config.dm > Adds our greyscales folder to the sanity check

- code/game/area/areas/shuttles.dm > Plays ApproachingFulp instead of ApproachingTG

- README.md > Replaces it with our own readme

- tgui/packages/tgui/routes.tsx > Add custom routing so fulp-specific interfaces can be found and loaded

- tools/build/build.js > Adds our folder to be read for changes when compiling.

- tgstation.dme > Adds our files to be included when compiling

- several removed objectives from /tg/ have been readded; see 'fulp_modules\Z_edits\antag_edits\traitor'

- tools/pull_request_hooks/autoChangelog.js > Changes changelog folder to fulp_modules/data/html/changelogs, to preserve them across TGUs.

- .github\workflows\compile_changelogs.yml > Same as above.

## All Fulp files not contained within /fulp_modules/

- code/__DEFINES/fulp_defines > Contains all of our defines
- _maps/fulp_maps > Contains all of our non-station maps (Ruins, Deathmatch maps, etc.)
- tgui/packages/fulpui-patches > Adds all Fulp TGUI files

#### Maps & Shuttles
- _maps/map_files/Heliostation/Heliostation.dmm
- _maps/heliostation.json
- _maps/shuttles/arrival_helio.dmm
- _maps/shuttles/cargo_helio.dmm
- _maps/shuttles/emergency_helio.dmm
- _maps/shuttles/labour_helio.dmm
- _maps/map_files/SeleneStation/SeleneStation.dmm
- _maps/selenestation.json
- _maps/shuttles/arrival_selene.dmm
- _maps/shuttles/cargo_selene.dmm
- _maps/shuttles/emergency_selene.dmm
- _maps/shuttles/mining_selene.dmm
- _maps/shuttles/labour_selene.dmm
- _maps/map_files/PubbyStation/PubbyStation.dmm
- _maps/pubbystation.json
- _maps/map_files/TheiaStation/TheiaStation.dmm
- _maps/theiastation.json
- _maps/shuttles/arrival_fulp.dmm
- _maps/shuttles/cargo_fulp.dmm
- _maps/shuttles/emergency_theia.dmm

#### TGUI
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/bloodsucker.ts
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/bloodsuckerbreakout.ts
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/ghostinfiltrator.ts
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/monsterhunter.ts
- tgui/packages/tgui/interfaces/PreferencesMenu/antagonists/antagonists/vampiricaccident.ts
- tgui/packages/tgui/interfaces/PreferencesMenu/preferences/features/game_preferences/antag_tips.tsx
- tgui/packages/tgui/interfaces/PreferencesMenu/preferences/features/fulp_species_features.tsx
