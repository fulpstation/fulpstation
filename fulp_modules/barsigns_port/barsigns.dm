/// Adds the var to change the .dmi file used for barsigns.
/datum/barsign
	var/fulpbarsign

/// Redirect our barsigns to use OUR .dmi file instead.
/obj/structure/sign/barsign/set_sign(datum/barsign/sign)
	. = ..()
	icon = sign.fulpbarsign ? 'fulp_modules/barsigns_port/barsigns.dmi' : 'icons/obj/barsigns.dmi'

/// Barsigns!
/datum/barsign/bassproshots
	fulpbarsign = 'fulp_modules/barsigns_port/barsigns.dmi'
	name = "Bass Pro Shots"
	icon = "bassproshots"
	desc = "When the Nuke Ops all come down all they really wanna see is the bar by the kitchen down in Space Station 13."
	hidden = FALSE

/datum/barsign/franksmeatshop
	fulpbarsign = 'fulp_modules/barsigns_port/barsigns.dmi'
	name = "Franks Meat Shop"
	icon = "franksmeatshop"
	desc = "Home to the valid salad"
	hidden = FALSE

/datum/barsign/thefulpmoment
	fulpbarsign = 'fulp_modules/barsigns_port/barsigns.dmi'
	name = "The Fulp Moment"
	icon = "thefulpmoment"
	desc = "The Problems of the Future, Today!"
	hidden = FALSE

/datum/barsign/thebluespacediner
	fulpbarsign = 'fulp_modules/barsigns_port/barsigns.dmi'
	name = "The Blue Space Diner"
	icon = "thebluespacediner"
	desc = "Don't slip on the blue banana!"
	hidden = FALSE

/datum/barsign/thegoldroom
	fulpbarsign = 'fulp_modules/barsigns_port/barsigns.dmi'
	name = "The Gold Room"
	icon = "thegoldroom"
	desc = "The finest rum in the galaxy."
	hidden = FALSE

/datum/barsign/theeldritchhorror
	fulpbarsign = 'fulp_modules/barsigns_port/barsigns.dmi'
	name = "The Eldritch Horror"
	icon = "theeldritchhorror"
	desc = "This bar is praised for reasons far beyond your mortal understanding, but hey, the drinks are insane."
	hidden = FALSE
