if("internal_all") // This button needs to be put in the TGUI/packages/tgui/interfaces/secrets.js panel and pushed into the pull request. I am unsure of how to do this as I am a shit newbie coder.
			if(!is_funmin) //funmin defines if runner has perms to access this code
				return
			if(SSticker.current_state > GAME_STATE_PREGAME) // Imported code from triple AI. Checks if its pregame. The reason it works with that is because it is checking if it can open extra job slots for AI ( i believe ) so I would like to find out how I can turn that into something for antags.
				to_chat(usr, "This option is currently only usable during pregame. This may change at a later date.", confidential = TRUE) // DMs runner info about option.
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("IAA All")) // Logs admin shenanigans in the logs.
			for(var/mob/living/H in GLOB.player_list) // Checks player list for H. H is players.
				if(!(ishuman(H)||istype(H, /mob/living/silicon/))) // Makes the code not stall if it detects silicons.
					continue
				if(H.stat == DEAD || !H.mind || ispAI(H)) // Makes the code not stall if it detects dead or pAIs
					continue
				if(is_special_character(H)) // Makes the code not stall if it detects antagonists.
					continue 
				var/datum/antagonist/traitor/IAA = new() // All code involving this I believe doesnt work with pregame.
				IAA.give_objectives = TRUE // Originally false on the traitor all code so they can set all objectives. Setting to true makes it automatically set the objectives. Hopefully. 
				H.mind.add_antag_datum(IAA) // I dont know what this does. 
				// Most of this code ^^^^ doesn't merge well because of the conflicting nature of the buttons im trying to paste together. Really needs to be rewritten fully but
				// my limited experience is holding back how well I can do that. Should ask contributorbuddys about it and put this in the project section fulpstation/fulpstation then
				// merge to TG when it works. Also, I need to put this the secrets.dm folder when its done. Its just here for posterity right now.
			message_admins("<span class='adminnotice'>[key_name_admin(holder)] used everyone is an Internals Affairs Agent secret.") // This works!
			log_admin("[key_name(holder)] used everyone is a Internals Affairs Agent secret.") // This works!

/client/proc/triple_ai() // Use as reference for pregame shenanigans. Works using SSjob.GetJob, need to find a way to define what antag you will be before the round begins and make similar code to that.
	set category = "Admin.Events" // Is this code TGUI?? Maybe make PR merging this into secrets panel to learn TGUI if its not.
	set name = "Toggle AI Triumvirate"

	if(SSticker.current_state > GAME_STATE_PREGAME)
		to_chat(usr, "This option is currently only usable during pregame. This may change at a later date.", confidential = TRUE)
		return

	var/datum/job/job = SSjob.GetJob("AI") // SSantag.GetAntag("IAA") When??? When You Code It.
	if(!job)
		to_chat(usr, "Unable to locate the AI job", confidential = TRUE) // Disables button if no candidaates.
		return
	SSticker.triai = !SSticker.triai // What the fuck is SSticker.trial
	to_chat(usr, "There will [SSticker.triai ? "" : "not"] be an AI Triumvirate at round start.")
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] has toggled [SSticker.triai ? "on" : "off"] triple AIs at round start.</span>")

		if("traitor_all") // Pretty sure the indentation on this copy-paste is fucked. Whatever.
			if(!is_funmin)
				return
			if(!SSticker.HasRoundStarted())
				alert("The game hasn't started yet!")
				return
			var/objective = stripped_input(holder, "Enter an objective") // traitor all works because the game doesnt really need to use any resources to generate regular objectives
																		// Its all done by the admins with a simple objective that ( should ) autocomplete on round end. This is a big problem for the IAA code.
			if(!objective)
				return
			SSblackbox.record_feedback("nested tally", "admin_secrets_fun_used", 1, list("Traitor All", "[objective]")) // Logs it
			for(var/mob/living/H in GLOB.player_list)
				if(!(ishuman(H)||istype(H, /mob/living/silicon/))) // Traitor midround is supported and even easier with custom admin objectives so no pregame check needed.
					continue
				if(H.stat == DEAD || !H.mind || ispAI(H))
					continue
				if(is_special_character(H))
					continue
				var/datum/antagonist/traitor/T = new()
				T.give_objectives = FALSE // Pretty sure this disables the game from giving regular objectives to the IAA. Might want to edit and set to true in IAA code? Or just leave it out? Maybe im wrong.
				var/datum/objective/new_objective = new
				new_objective.owner = H
				new_objective.explanation_text = objective
				T.add_objective(new_objective)
				H.mind.add_antag_datum(T) // What is this...
			message_admins("<span class='adminnotice'>[key_name_admin(holder)] used everyone is a traitor secret. Objective is [objective]</span>")
			log_admin("[key_name(holder)] used everyone is a traitor secret. Objective is [objective]")

