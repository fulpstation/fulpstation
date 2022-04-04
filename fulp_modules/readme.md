# Fulpstation Codebase

## Contribute to TG or Fulp?

As we are a TG downstream, any PR that they merge, will eventually trickle down to us. We highly encourage contributors to PR to TG, rather than Fulp, as it will help us both in the long run.
- <https://github.com/tgstation/tgstation>

This is a very important thing to know before contributing to Fulpstation. We rebased to rid ourselves of the old grudgecode, we do not wish to re-become it.

NOTE: If you plan on Contributing to Fulpstation, you may want to instead read the guide, located here;
- <https://wiki.fulp.gg/en/GuideToContributing>

## Modular Code/Modularity

Modular, as we use it, is described as "Doesn't touch Core TG files/folders". 

### What is a TG file and why does it matter?

- a TG file is a file that we share with our upstream, TGstation. Every time we update, all our files get updated to whatever TG has them set to. 
- To counter this, we have our a fulp_modules folder, containing all the fulp files.
- There is one exception, our TGUI files, which is placed in the same folder as TG's. It is placed there because of some dumb tgui stuff who cares no one really knows, it just does. Ok?

### What is a TG edit?

- a TG edit is when Fulp code is inserted into a TG core file/folder.
- An obvious example of this are maps and our tgui files, but they are also used for patches/edits we make, that can't be overwriten instead.

## Fulp Modules

### What is Fulp Modules?

This file contains near-all the code exclusive to Fulpstation.
Due to how maintaining a downstream codebase works, since we must frequently update to latest TG, making sure most our code is as Modular as it can be, is the best way to keep us up-to-date without requiring days worth of effort for every update.

We are incredibly strict in modularity, and Pull Requests can (and will) be quickly denied and closed if they are unable to be modular. Exceptions are granted to this, such as if we are already touching said file, as numbers of lines edited is irrelevant once there's at least one line changed.

## Readme & TG edits

Any Pull Request that touches a TG file, or uses TG sprites/sounds, MUST include a readme.MD page in it's folder to explain such.
Additionally, edits to TG files MUST be documented in tg_edits.md - This is because it is the primary file Contributors will look at to ensure all Fulp code persists through TGUs.

![image](https://i.imgur.com/4p3iTRx.jpg)

# Workflows

Due to Fulpstation handling workflows themselves, and due to TG handing us their workflows, to not get flooded with emails, you should disable your Fork's workflows (except Cl Suite and Generate Documentation). To do this, go onto your fork of the Repository, go to the Actions tab, then go to each workflow and click the ... at the right, then manually disable them. It should end up looking like this.

![image](https://i.imgur.com/J8BaqtN.png)

While this isn't required, Fulpstation and your own fork has different workflows, so yours won't affect ours, it will prevent you from getting flooded with emails telling you they've failed.

## Outside of Fulp modules

### TGUI

Due to how TG handles TGUI, there is currently no known way to make this hosted in the Fulp modules folder, therefore they are put in TG's TGUI folder instead. While this is an annoyance, we don't have any better alternative for now, so you can ignore it lacking modularity.

## TGU

TGU (TG Update) is when a Contributor updates our repository to the latest version of TG Code (<https://github.com/tgstation/tgstation/>)
We do NOT have a mirror bot, so things must be manually done with GitBash (<https://gitforwindows.org/>) by setting tgstation/tgstation as your remote upstream. If you do not know how, you can ask in the Discord for help.

When a Contributor does a TGU, there are a few things to make sure functions properly:
1) No Fulpstation edits or files are being deleted. You can use our tg_edits.md file to help guide you through this, as it lists all our edits.
2) The tgstation.dme file isn't commenting out any Fulp files and is fully up-to-date.

Just as a note, A TGU should occur maximum every 2 months, as to not weight too much work on maintaining our own code to match our upstream's.
