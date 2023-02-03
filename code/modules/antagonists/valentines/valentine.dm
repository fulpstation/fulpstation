/datum/antagonist/valentine
	name = "\improper Valentine"
	roundend_category = "valentines" //there's going to be a ton of them so put them in separate category
	show_in_antagpanel = FALSE
	prevent_roundtype_conversion = FALSE
	suicide_cry = "FOR MY LOVE!!"
	var/datum/mind/date
	count_against_dynamic_roll_chance = FALSE

/datum/antagonist/valentine/forge_objectives()
	var/datum/objective/protect/protect_objective = new /datum/objective/protect
	protect_objective.owner = owner
	protect_objective.target = date
	if(!ishuman(date.current))
		protect_objective.human_check = FALSE
	protect_objective.explanation_text = "Protect [date.name], your date."
	objectives += protect_objective

/datum/antagonist/valentine/on_gain()
	forge_objectives()
	if(isliving(owner.current))
		var/mob/living/L = owner.current
		L.apply_status_effect(/datum/status_effect/in_love, date.current)
	. = ..()

/datum/antagonist/valentine/on_removal()
	if(isliving(owner.current))
		var/mob/living/L = owner.current
		L.remove_status_effect(/datum/status_effect/in_love)
	. = ..()

/datum/antagonist/valentine/greet()
	to_chat(owner, span_warning("<B>You're on a date with [date.name]! Protect [date.p_them()] at all costs. This takes priority over all other loyalties.</B>"))

//Squashed up a bit
/datum/antagonist/valentine/roundend_report()
	var/objectives_complete = TRUE
	if(objectives.len)
		for(var/datum/objective/objective in objectives)
			if(!objective.check_completion())
				objectives_complete = FALSE
				break

	if(objectives_complete)
		return "<span class='greentext big'>[owner.name] protected [owner.p_their()] date</span>"
	else
		return "<span class='redtext big'>[owner.name] date failed!</span>"
