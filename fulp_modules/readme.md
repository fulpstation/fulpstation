# Fulp Modules



# Contribute to TG or Fulp?

As we are a TG downstream, any PR that they merge, will eventually trickle down to us. We highly encourage contributors to PR to TG, rather than Fulp, as it will help us both in the long run.
- <https://github.com/tgstation/tgstation>

This is a very important thing to know before contributing to Fulpstation. We rebased to rid ourselves of the old grudgecode, we do not wish to re-become it.


## What is Fulp Modules?

This file contains near-all the code exclusive to Fulpstation.
Due to how maintaining a downstream codebase works, since we must frequently update to latest TG, making sure as little code as possible touches TG is the most optimal way in going about this.

We are incredibly strict in modularity, and PRs will be denied if they cannot be made modular, very few exceptions are granted.

Any PR that touches or uses TG files, sprites or sounds, must include a readme.MD page to explain such.

# Defines Folder

Becaues of how Defines are dealt with, they must be one of the first things in the tgstation.dme
Due to this, we have fulp_defines.dm to host them all, the only Fulp file not to be in the Fulp modules folder.

# Notes

During TG Updates, the person updating must go over all the files to make sure it isnt deleting/conflicting with and Fulp edits.
We do NOT have a mirror bot, so things must be manually done with GitBash by setting tgstation/tgstation as your remote upstream.

If you plan on Contributing to Fulpstation, you may want to instead read the guide, located here;
- <https://wiki.fulp.gg/en/GuideToContributing>

**Template for a readme:**

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
