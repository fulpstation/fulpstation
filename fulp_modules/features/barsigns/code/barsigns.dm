/**
 * So what exactly is going on here?
 *
 * Barsign unit testing requires a .dmi file has all icon states, and the icon checked for these icon states is the bar sign's icon
 * Because of this, we either add our signs to TG's file, or add TG's signs to ours, then use our dmi file.
 * The problem with this is if TG changes how their signs look, we wouldn't update.
 * Therefore, we keep the old system that will keep using TG's dmi for TG barsigns, therefore we only use our version of said signs for Ci
 * Knowing they exist, then swapping to TG's anyways.
 *
 * Of course, none of this would be needed if it weren't for TG hardcoding everything, and it would mean Ci actually matters. Sucks to suck.
 */
/obj/machinery/barsign
	icon = 'fulp_modules/icons/barsigns/barsigns.dmi' //'icons/obj/machines/barsigns.dmi'

/// Redirect our barsigns to use OUR .dmi file instead.
/obj/machinery/barsign/set_sign(datum/barsign/sign)
	. = ..()
	icon = sign.fulpbarsign ? 'fulp_modules/icons/barsigns/barsigns.dmi' : 'icons/obj/machines/barsigns.dmi'

/// Adds the var to change the .dmi file used for barsigns.
/datum/barsign
	///Boolean, if true then we'll use the Fulp barsign DMI file.
	var/fulpbarsign = FALSE

/// Barsigns!
/datum/barsign/fulp
	fulpbarsign = TRUE
	hidden = FALSE
	name = "Bass Pro Shots"
	icon_state = "bassproshots"
	desc = "When the Nuke Ops all come down all they really wanna see is the bar by the kitchen down in Space Station 13."

/datum/barsign/fulp/franksmeatshop
	name = "Franks Meat Shop"
	icon_state = "franksmeatshop"
	desc = "Home to the valid salad"

/datum/barsign/fulp/thefulpmoment
	name = "The Fulp Moment"
	icon_state = "thefulpmoment"
	desc = "The Problems of the Future, Today!"

/datum/barsign/fulp/thebluespacediner
	name = "The Blue Space Diner"
	icon_state = "thebluespacediner"
	desc = "Don't slip on the blue banana!"

/datum/barsign/fulp/thegoldroom
	name = "The Gold Room"
	icon_state = "thegoldroom"
	desc = "The finest rum in the galaxy."

/datum/barsign/fulp/theeldritchhorror
	name = "The Eldritch Horror"
	icon_state = "theeldritchhorror"
	desc = "This bar is praised for reasons far beyond your mortal understanding, but hey, the drinks are insane."

/datum/barsign/fulp/thecrimsonchalice
	name = "The Crimson Chalice"
	icon_state = "thecrimsonchalice"
	desc = "A hive of unbridled hedonism. A roiling apiary where instinct and impulse can be indulged with wild abandon."

