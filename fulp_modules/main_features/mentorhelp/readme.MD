# Folder: Mentorhelp

## Description:

	Adds Mentorhelp and Mentors, a way for people to ask questions without ick ocking.

## TG edits:

- code/__DEFINES/admin.dm > Defines MUTE_MENTORHELP
- code/game/world.dm > Loads mentors upon the world loading
- code/modules/admin/admin.dm > Adds the button to mute mentorhelp
- code/modules/admin/verbs/adminhelp.dm > Adds a button for redirecting people to Mentorhelp
- code/modules/admin/verbs/randomverbs.dm > Prevents Mentorhelp-muted people from using Mentorhelp
- code/modules/client/client_procs.dm > Gives the mentorhelp verb

## TG proc overwrites:

None

## Notes/Credits:

- HippieStation - Original Mentorhelp (https://github.com/HippieStation/HippieStation/pull/905)
