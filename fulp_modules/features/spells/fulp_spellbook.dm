////////////////////
////// SPELLS //////
////////////////////

/datum/spellbook_entry/dance_floor
	name = "Summon Dance Floor"
	desc = "When what a Devil really needs is funk."
	spell_type = /datum/action/cooldown/spell/summon_dancefloor
	category = "Assistance"
	cost = 1


/datum/spellbook_entry/direct_cateor
	name = "Direct Cat Meteor"
	desc = "Summon a lesser 'feline-ification' meteor and direct it at a target with this long-range spell. \n\
	(Metamagical scope modifier included.)"
	spell_type = /datum/action/cooldown/spell/conjure_item/infinite_guns/direct_cateor
	category = "Offensive"
	cost = 2

///////////////////
///// RITUALS /////
///////////////////

/datum/spellbook_entry/summon/cateor_storm
	name = "Summon Cat Meteor Storm"
	desc = "Summon a volley of magical cat energy directed at the station. \n\
	The energy itself will do minimal structural damage, but it will cat-ify any living \n\
	or robotic entity it hits. Humanoids hit by it will also explode, but only by a bit. \n\
	This ritual has a cooldown of two minutes between uses, with an overall limit of five casts."
	limit = 5
	cost = 1

	//Whether or not the entry is on cooldown. Necessary since this ritual probably shouldn't be spammed.
	var/on_cooldown = FALSE

	//How long the cooldown is between each purchase of the ritual.
	var/cooldown_time = 2 MINUTES

/datum/spellbook_entry/summon/cateor_storm/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	if(on_cooldown)
		user.balloon_alert(user, "on cooldown!")
		return FALSE

	var/datum/round_event_control/meteor_wave/cateor_storm/new_cateor_storm = new /datum/round_event_control/meteor_wave/cateor_storm
	new_cateor_storm.run_event(event_cause = "a wizard ritual bought by [user]")
	playsound(get_turf(user), 'sound/effects/meow1.ogg', 75, TRUE, -1, pressure_affected = FALSE)

	on_cooldown = TRUE
	addtimer(VARSET_CALLBACK(src, on_cooldown, FALSE), cooldown_time, TIMER_UNIQUE|TIMER_DELETE_ME)
