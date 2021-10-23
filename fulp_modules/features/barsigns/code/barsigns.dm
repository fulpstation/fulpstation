/// Adds the var to change the .dmi file used for barsigns.
/datum/barsign
	var/fulpbarsign = FALSE

/// Redirect our barsigns to use OUR .dmi file instead.
/obj/structure/sign/barsign/set_sign(datum/barsign/sign)
	. = ..()
	icon = sign.fulpbarsign ? 'fulp_modules/features/barsigns/icons/barsigns.dmi' : 'icons/obj/barsigns.dmi'

/// Barsigns!
/datum/barsign/fulp
	fulpbarsign = TRUE
	name = "Bass Pro Shots"
	icon = "bassproshots"
	desc = "When the Nuke Ops all come down all they really wanna see is the bar by the kitchen down in Space Station 13."
	hidden = FALSE

/datum/barsign/fulp/franksmeatshop
	name = "Franks Meat Shop"
	icon = "franksmeatshop"
	desc = "Home to the valid salad"

/datum/barsign/fulp/thefulpmoment
	name = "The Fulp Moment"
	icon = "thefulpmoment"
	desc = "The Problems of the Future, Today!"

/datum/barsign/fulp/thebluespacediner
	name = "The Blue Space Diner"
	icon = "thebluespacediner"
	desc = "Don't slip on the blue banana!"

/datum/barsign/fulp/thegoldroom
	name = "The Gold Room"
	icon = "thegoldroom"
	desc = "The finest rum in the galaxy."

/datum/barsign/fulp/theeldritchhorror
	name = "The Eldritch Horror"
	icon = "theeldritchhorror"
	desc = "This bar is praised for reasons far beyond your mortal understanding, but hey, the drinks are insane."

/datum/barsign/fulp/thecrimsonchalice
	name = "The Crimson Chalice"
	icon = "thecrimsonchalice"
	desc = "A hive of unbridled hedonism. A roiling apiary where instinct and impulse can be indulged with wild abandon."

