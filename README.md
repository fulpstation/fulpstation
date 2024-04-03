## Old Fulp

This is my attempt to bring TheSwain/Fulpstation (2020 April Fulp code) to work on modern day BYOND, mostly just for fun.
This is meant to work without config because I don't want there to have a ton of Admin work to do.
You can see changes by searching 'OLD FULP'

This has the ported React TGUI rather than the old Inferno, which required a lot of work to maintain (basically I ported all of TGUI then reverted UIs I didn't want and then re-worked to work with react), but was necessary for build stuff so TGS can compile. Because of this, there's a ton of TGUI files that just go unused, and that's because it's just from (at-the-time) TGstation master, that I didn't care enough to put my time into manually deleting each one.

This works on BYOND versions 514 and 515. 513 is entirely untested and you'd have to change different instances where BYOND version is checked, however I assume it would totally be possible.

### Game-breaking bug

For some reason, in some places (like ``get_rad_contents``, ``iconstate2appearance``, and ``icon2appearance``), using ``var/static/thing = new`` resulted in said static thing to never be made. I have no idea why this happens, and it's caused issues for me with the SM and basically all icons in the game. I fixed it by removing the new and adding a check if it exists, making a new one if it doesn't. If you run into something that uses static thing it itself makes, try that.
This doesn't seem to be a bug in some other places, like ``antag_weight_probabilities``, which just makes this whole thing even weirder to me.

