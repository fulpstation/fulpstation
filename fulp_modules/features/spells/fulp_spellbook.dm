/datum/spellbook_entry/dance_floor
	name = "Summon Dance Floor"
	desc = "When what a Devil really needs is funk."
	spell_type = /datum/action/cooldown/spell/summon_dancefloor
	category = "Assistance"
	cost = 1

/datum/spellbook_entry/summon/cateor_storm
	name = "Summon Cat Meteor Storm"
	desc = "Summon a volley of magical cat energy directed at the station. \n\
	The energy itself will do minimal structural damage, but it will cat-ify any living \n\
	or robotic entity it hits. Humanoids hit by it will also be exploded, but only by a bit."
	limit = 5
	cost = 1

/datum/spellbook_entry/summon/cateor_storm/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	SSevents.TriggerEvent(/datum/round_event/meteor_wave/cateor_storm)
	playsound(get_turf(user), 'sound/effects/meow1.ogg', 75, TRUE, -1, pressure_affected = FALSE)
