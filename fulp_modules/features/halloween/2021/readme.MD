# How to add a Halloween Costume

## Step one: Make the costume

If needed, TGstation has a guide on Spriting here: <https://tgstation13.org/wiki/Guide_to_spriting>

## Step two: Choose between adding it yourself or having a Contributor do it

### Option 1: Send to Contributors

If you don't want to learn how to actually do anything, you can send the .dmi's in the Fulpstation's #coder-cafe channel, pinging the <b>@Halloween Helper</b> role to ensure it is seen. We will let you know when we take it and will deal with it.

### Option 2: Add it yourself to the Halloween fork

Due to conflicts between the .dme and files, during Halloween, only one Pull Request will get Testmerged/Merged. If you want to add a Halloween costume, you will have to make your pull request to their branch, rather than make your own Pull Request.

First: Open GitHub Desktop - <https://desktop.github.com/>
Additionally, make sure you have the Fulpstation Repository cloned - <https://github.com/fulpstation/fulpstation>

Second: Go on their Pull Request's Branch

![image](https://i.imgur.com/oFBDTTC.png)

Third: Create a new Branch

![image](https://i.imgur.com/fnAsut5.png)

Fourth: Build off of their branch rather than master

![image](https://i.imgur.com/wdPDy7e.png)

Lastly: Once you are done all your work, make sure you open the Pull Request to their branch!

![image](https://i.imgur.com/Dt9Pi4X.png)

## Writing the code

### Folder

<b>Make sure you have a separate folder for your code's .dm file alone. This will make it easier for us to compile all together. Importantly, do not do this with your sprites.</b>

If you want an easy way out, you can copy off of another suit from another year and fill in the blanks.
If you want to do it yourself, then;

### The clothes

[1] 'name' is what the item is called in game, <b>the first letter shouldn't be capitalized unless it's a name</b>

[2] 'desc' is the text that comes up when you examine the suit. This should be a small description related to the item itself.

[2.1] If your costume is more complex and should explain more in the description, you can add it to /examine_more(mob/user) - Look at 'features/clothing/body_cameras/body_camera.dm' for an example.

#### Jumpsuits

Jumpsuits (/obj/item/clothing/suit) may need additional measures

[1] 'can_adjust' is if you can move the jumpsuit's sleeves, you might not want this, and if so, add 'an_adjust = FALSE'

[2] 'fitted' is for alternative clothing for women, saying how much the game can safely "take off" the uniform without it looking weird. The options are:
1 - NO_FEMALE_UNIFORM
2 - FEMALE_UNIFORM_FULL
3 - FEMALE_UNIFORM_TOP_ONLY

#### Hardhats

Hardhats are used for hats you want to have an alternate icon to, that you can switch on/off (replacing the hardhat's helmet button).

[1] This comes at the cost of not being able to set it as a subtype of /costume_2021/, so you will have to copy paste the 'icon' and 'icon_worn' on that individual hardhat's code.

### icon, icon_state & worn_icon

[1] 'icon' is the .dmi file being read to find a certain sprite

[2] 'icon_state' is the picture within that .dmi file

[3] 'worn_icon' is the sprites that will be shown while wearing a sprite

- 'icon_state' is used in both 'icon' and 'worn_icon', so make sure they are called the same for all files!

- <b>Make sure your .dmi file has a unique name. If it is a moth cape, name it 'moth_cape' instead of 'cape'.</b>

- When adding a new sprite, make sure it is a subtype of /costume_2021 if it exists, all of which can be seen at the start of 'fulp_modules/features/halloween/2021/costumes.dm'. This is because all clothes that are under /costume_2021 are automatically set to use our primary 2021 .dmi file, meaning you will not have to set 'icon' or 'worn_icon', and 'icon_state' will be the only thing to worry about.

[4] To Add your sprites to the main .dmi file, go to Graphic > Import > Find your old .dmi file, and use it.

![image](https://i.imgur.com/iLsLsOO.png)


### Costume box

Each kit you make will require a box to contain it, you will name it like this:
/obj/item/storage/box/halloween/edition_20/[Your_name_here]

There are three things to keep note of: Name, Illustration and costume_contents.

[1] Name is what it will be called when ordering your costume from a Halloween beacon (the ones purchased at Cargo)

[2] Illustration is the image on the box, if you want to see all illustrations you can use (or want to add more, in which case you will have to talk with @Halloween Helper's on Discord), check 'fulp_modules/features/halloween/box.dmi' for all icon states.

[3] costume_contents is all the items that will be in the box, this is the easiest way to add something, just put the path of the clothing you've made there, and it'll appear in game when ordering that box.

Example of how it should be done:

![image](https://i.imgur.com/mer5u4N.png)

[3.1] If you want to add a randomly selected item from a pool, you will have to do the following:
Add this line of code to your costume
/obj/item/storage/box/halloween/edition_21/[Your_name_here]/PopulateContents()
	costume_contents += pick(
		[This will have all the items you can choose, just like costume_contents]
	)
	. = ..()

Example of how it should be done:

![image](https://i.imgur.com/CElF63L.png)

This will add your randomly chosen item into the kit when being purchased.

[3.2] If you want to add a 'Random' option to a list of kits you've added
This is a rare enough thing to see, and it shouldn't generally happen, but if you need to, refer to 'fulp_modules/features/halloween/2021/power_rangers.dm' and 'fulp_modules/features/halloween/2021/onesies.dm' to see how it's done.

I am not explaining it here as I do not want to encourage that type of behavior. Each costume should be unique.

## The .dme

All new .dm files have to be put in tgstation.dme, in order of which it appears.
If you are using vscode and have all the BYOND plugins, this is done automatically for you as you create new files.
