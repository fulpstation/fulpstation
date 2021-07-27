# Fulpstation Codebase


## Modular Code/Modularity

Modular, as we use it, is described as "Doesn't touch TG files". 
While adding new files to TG folders fits this description, many would not consider it to be "Modular", so it is best to avoid doing so, this is why the Fulp modules folder exists.

## Fulp Modules

### What is Fulp Modules?

This file contains near-all the code exclusive to Fulpstation.
Due to how maintaining a downstream codebase works, since we must frequently update to latest TG, making sure most our code is as Modular as it can be, is the best way to keep us up-to-date without requiring days worth of effort for every update.

We are incredibly strict in modularity, and Pull Requests can (and will) be quickly denied and closed if they are unable to be modular. Exceptions are granted to this, such as if we are already touching said file, as numbers of lines edited is irrelevant once there's at least one line changed.

### Readme & TG edits

Any Pull Request that touches a TG file, or uses TG sprites/sounds, MUST include a readme.MD page in it's folder to explain such.
Additionally, edits to TG files MUST be documented in tg_edits.md - This is because it is the primary file Contributors will look at to ensure all Fulp code persists through TGUs.

## Contribute to TG or Fulp?

As we are a TG downstream, any PR that they merge, will eventually trickle down to us. We highly encourage contributors to PR to TG, rather than Fulp, as it will help us both in the long run.
- <https://github.com/tgstation/tgstation>

This is a very important thing to know before contributing to Fulpstation. We rebased to rid ourselves of the old grudgecode, we do not wish to re-become it.

NOTE: If you plan on Contributing to Fulpstation, you may want to instead read the guide, located here;
- <https://wiki.fulp.gg/en/GuideToContributing>

![image](https://i.imgur.com/4p3iTRx.jpg)

### Workflows

Due to Fulpstation handling workflows themselves, and due to TG handing us their workflows, to not get flooded with emails, you should disable your Fork's workflows (except Cl Suite and Generate Documentation). To do this, go onto your fork of the Repository, go to the Actions tab, then go to each workflow and click the ... at the right, then manually disable them. It should end up looking like this.

![image](https://i.imgur.com/J8BaqtN.png)

While this isn't required, Fulpstation and your own fork has different workflows, so yours won't affect ours, it will prevent you from getting flooded with emails telling you they've failed.

## Outside of Fulp modules

### Defines

Due to defines requiring to be defined before the code itself, they must be read before anything else.
Because of this, we have fulp_defines.dm to host ALL Fulp defines, which is the only Fulpstation code-related file to not be in the Fulp modules folder.

### TGUI

Due to how TG handles TGUI, there is currently no known way to make this hosted in the Fulp modules folder, therefore they are put in TG's TGUI folder instead. This isn't much of a problem (for now), so it's fine to ignore it not being "modular".

## TGU

TGU (TG Update) is when a Contributor updates our repository to the latest version of TG Code (<https://github.com/tgstation/tgstation/>)
We do NOT have a mirror bot, so things must be manually done with GitBash (<https://gitforwindows.org/>) by setting tgstation/tgstation as your remote upstream. If you do not know how, you can ask in the Discord for help.

- When a Contributor does a TGU;
1) They must merge ALL of TG into Fulpstation, not cherry pick commits/PRs they want/dont want. This is to ensure best safety for bugs and other terrible things that come with falling behind on updates.
2) They must ensure that no Fulpstation edits or files are being deleted, done by solving its conflicts manually and reverting deletions. (This is done easiest using the tg_edits.dm file, listing ALL our edits, though it does not list new files, so you will have to manually ensure no Fulp files are being deleted, such as the Fulpstation defines, maps, and TGUIs files.)
3) Once the TGU is complete and ready for testmerging, you should ensure the tgstation.dme isnt commenting out any Fulp files.

At most, a TGU should be about once every 2 months.

**Template for a readme - Open this file to copy paste it**

# Folder: 
<!-- Name of the older, simple stuff. -->

## Description:

<!-- Basic description of the Pull Request -->

## TG edits:

<!-- Any TG files this folder might be touching. -->

## TG sounds/sprites used:

<!-- Any TG sprites/sounds this folder might using. -->

## Notes/Credits:

<!-- Credits for said PR, if it's a port of something, link the original PR. -->
