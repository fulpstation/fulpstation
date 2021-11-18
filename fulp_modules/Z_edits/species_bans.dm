/// Case 1: Mob Login. Species are set before mobs are given a mind so we cant just use on_species_gain()
/mob/sync_mind()
	. = ..()
	if(ishuman(src))
		var/mob/living/carbon/human/user = src
		user?.dna?.species.check_banned(user)

/// Case 2: Species Change. People can change their species midgame so we have to add this check aswell. sync_mind() only happens on login
/datum/species/on_species_gain(mob/living/carbon/user, datum/species/old_species, pref_load)
	. = ..()
	INVOKE_ASYNC(src, .proc/check_banned, user)

/datum/species/proc/check_banned(mob/living/carbon/user)
	if(!user.ckey) // Checking for the value instead of using C?.ckey since it's immediately sent to a proc
		return

	if(is_banned_from(user.ckey, id))
		addtimer(CALLBACK(user, /mob/living/carbon.proc/banned_species_revert), 10 SECONDS)

/// Made into an individual proc to ensure that the to_chat message would always show to users. Sometimes it would not appear during roundstart as it would be sent too soon.
/mob/living/carbon/proc/banned_species_revert()
	to_chat(src, span_alert("You are currently banned from playing this race. Please review any ban messages you have received, and contact admins if you believe this is a mistake."))
	set_species(/datum/species/human)

/// Okay so this just overrides set_content for a browser datum so we can intercept banpanel content and just plop in what we need. God help us.
/datum/browser/set_content(ncontent)
	if(window_id == "banpanel") // Intercept ONLY the ban panel
		if(findtext(ncontent, "Mirror edits to matching bans")) // Make sure we aren't intercepting the EDIT ban panel by finding the text. We sadly cannot access the href list that the old proc uses.
			return ..()
		var/list/output = list() // Variable that holds all the changes we make so we can add them all at once
		var/break_counter = 0 // Variable used to insert a break if a category has more than 10 or so entries

		// Literally copypasted code from sql_ban_system.dm apart from removing one variable that can't be noted. This has the side effect of not telling admins if someone is
		// already banned from a fulp ban (I assume)
		for(var/department in GLOB.fulp_ban_list) // For each list within the list...
			var/tgui_fancy = usr.client.prefs.read_preference(/datum/preference/toggle/tgui_fancy)
			output += "<div class='column'><label class='rolegroup [ckey(department)]'>[tgui_fancy ? "<input type='checkbox' name='[department]' class='hidden' onClick='header_click_all_checkboxes(this)'>" : ""][department]</label><div class='content'>"
			break_counter = 0
			for(var/job in GLOB.fulp_ban_list[department]) // Go to each element and add it with a little checkbox underneath the relevant "Department"
				if(break_counter > 0 && (break_counter % 10 == 0))
					output += "<br>"
				output += {"<label class='inputlabel checkbox'>[job]
							<input type='checkbox' name='[job]' class='[department]' value='1'>
							<div class='inputbox'></div></label>
				"}
				break_counter++
			output += "</div></div>"
		output += "</div>"
		output += "</form>"

		var/closing_form_index = findlasttext(ncontent, "</form>") // We need to put our content before the closing /form so that it's a part of the form

		ncontent = splicetext(ncontent, closing_form_index, 0, jointext(output, ""))
	. = ..()
