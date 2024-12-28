//////////////////////////////
//////// Cateor Storm ////////
//////////////////////////////

//A special type of meteor storm that can be triggered by wizards through a certain ritual.

//Cateor storm meteor weighted probability list (it's just cateors.)
GLOBAL_LIST_INIT(meteors_cateors, list(/obj/effect/meteor/cateor=1))

//Should generally only be triggered by wizards or admemes.
//If Fulp ever gets more than 255 players then this event will act a bit silly (and may need to be changed.)
/datum/round_event_control/meteor_wave/cateor_storm
	name = "Cateor Storm"
	typepath = /datum/round_event/meteor_wave/cateor_storm
	weight = 100
	min_players = 255 //Shouldn't occur outside of special circumstances-- Fulp having 255 players is a special circumstance.
	max_occurrences = 5
	earliest_start = 1 SECONDS
	category = EVENT_CATEGORY_SPACE
	description = "A barrage of magical cat energy assails the station, causing extreme silliness."
	map_flags = NONE //Magical cat energy isn't entirely bound by physical laws, it can appear on planets.
	min_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS //Never triggered by wizards*
	max_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS //*THROUGH GRAND RITUALS

/datum/round_event/meteor_wave/cateor_storm
	wave_name = "cateor"
	//The original alert level we revert back to at the end of the event
	//(Throughout the event the station should be on alert level "deltaww")
	var/original_alert_level

/datum/round_event/meteor_wave/cateor_storm/determine_wave_type()
	wave_type = GLOB.meteors_cateors

/datum/round_event/meteor_wave/cateor_storm/announce(fake)
	//No parent call since that forces an unnecessary meteor announcement (we have Deltaww already)
	original_alert_level = SSsecurity_level.get_current_level_as_number()
	if(original_alert_level != SEC_LEVEL_DELTAWW)
		SSsecurity_level.set_level(SEC_LEVEL_DELTAWW)

/datum/round_event/meteor_wave/cateor_storm/end()
	. = ..()
	if(original_alert_level != SEC_LEVEL_DELTAWW)
		SSsecurity_level.set_level(original_alert_level)
	else
		SSsecurity_level.set_level(SEC_LEVEL_BLUE)
