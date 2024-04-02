## Old Fulp

This is my attempt to bring TheSwain/Fulpstation (2020 April Fulp code) to work on modern day BYOND, mostly just for fun.
This is meant to work without config because I don't want there to have a ton of Admin work to do.
You can see changes by searching 'OLD FULP'

This has the ported React TGUI rather than the old Inferno, which requires a bit more work to maintain but it was needed for the build to work properly.

This works on the latest version of 514, and clients can connect from 515, however there is a massive issue when compiling with 515;
Overlays don't seem to work at all. Canisters, Tables, Windows, Closets, your own HUD, just doesn't exist.
Canisters specifically will have ERROR signs on them.
You also won't be able to click on anything.

Just be aware of this when trying to build, stick to 514, and know that I tried, man.
