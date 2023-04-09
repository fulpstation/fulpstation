/datum/antagonist/magic_servant
	name = "\improper Magic Servant"
	show_in_roundend = FALSE
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE

/datum/antagonist/magic_servant/proc/setup_master(mob/M)
	var/datum/objective/O = new("Serve [M.real_name].")
	O.owner = owner
	objectives |= O

/datum/antagonist/magic_servant/greet()
	. = ..()
	owner.announce_objectives()
