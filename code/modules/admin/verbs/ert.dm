/// If we spawn an ERT with the "choose experienced leader" option, select the leader from the top X playtimes
#define ERT_EXPERIENCED_LEADER_CHOOSE_TOP 3

// CENTCOM RESPONSE TEAM

/datum/admins/proc/makeERTTemplateModified(list/settings)
	. = settings
	var/datum/ert/newtemplate = settings["mainsettings"]["template"]["value"]
	if (isnull(newtemplate))
		return
	if (!ispath(newtemplate))
		newtemplate = text2path(newtemplate)
	newtemplate = new newtemplate
	.["mainsettings"]["teamsize"]["value"] = newtemplate.teamsize
	.["mainsettings"]["mission"]["value"] = newtemplate.mission
	.["mainsettings"]["polldesc"]["value"] = newtemplate.polldesc
	.["mainsettings"]["open_armory"]["value"] = newtemplate.opendoors ? "Yes" : "No"
	.["mainsettings"]["leader_experience"]["value"] = newtemplate.leader_experience ? "Yes" : "No"
	.["mainsettings"]["random_names"]["value"] = newtemplate.random_names ? "Yes" : "No"
	.["mainsettings"]["spawn_admin"]["value"] = newtemplate.spawn_admin ? "Yes" : "No"


/datum/admins/proc/equipAntagOnDummy(mob/living/carbon/human/dummy/mannequin, datum/antagonist/antag)
	for(var/I in mannequin.get_equipped_items(TRUE))
		qdel(I)
	if (ispath(antag, /datum/antagonist/ert))
		var/datum/antagonist/ert/ert = antag
		mannequin.equipOutfit(initial(ert.outfit), TRUE)

/datum/admins/proc/makeERTPreviewIcon(list/settings)
	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_ADMIN)

	var/prefs = settings["mainsettings"]
	var/datum/ert/template = prefs["template"]["value"]
	if (isnull(template))
		return null
	if (!ispath(template))
		template = text2path(prefs["template"]["value"]) // new text2path ... doesn't compile in 511

	template = new template
	var/datum/antagonist/ert/ert = template.leader_role

	equipAntagOnDummy(mannequin, ert)

	COMPILE_OVERLAYS(mannequin)
	CHECK_TICK
	var/icon/preview_icon = icon('icons/effects/effects.dmi', "nothing")
	preview_icon.Scale(48+32, 16+32)
	CHECK_TICK
	mannequin.setDir(NORTH)
	var/icon/stamp = getFlatIcon(mannequin)
	CHECK_TICK
	preview_icon.Blend(stamp, ICON_OVERLAY, 25, 17)
	CHECK_TICK
	mannequin.setDir(WEST)
	stamp = getFlatIcon(mannequin)
	CHECK_TICK
	preview_icon.Blend(stamp, ICON_OVERLAY, 1, 9)
	CHECK_TICK
	mannequin.setDir(SOUTH)
	stamp = getFlatIcon(mannequin)
	CHECK_TICK
	preview_icon.Blend(stamp, ICON_OVERLAY, 49, 1)
	CHECK_TICK
	preview_icon.Scale(preview_icon.Width() * 2, preview_icon.Height() * 2) // Scaling here to prevent blurring in the browser.
	CHECK_TICK
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_ADMIN)
	return preview_icon

/datum/admins/proc/makeEmergencyresponseteam(datum/ert/ertemplate = null)
	if (ertemplate)
		ertemplate = new ertemplate
	else
		ertemplate = new /datum/ert/centcom_official

	var/list/settings = list(
		"preview_callback" = CALLBACK(src, .proc/makeERTPreviewIcon),
		"mainsettings" = list(
		"template" = list("desc" = "Template", "callback" = CALLBACK(src, .proc/makeERTTemplateModified), "type" = "datum", "path" = "/datum/ert", "subtypesonly" = TRUE, "value" = ertemplate.type),
		"teamsize" = list("desc" = "Team Size", "type" = "number", "value" = ertemplate.teamsize),
		"mission" = list("desc" = "Mission", "type" = "string", "value" = ertemplate.mission),
		"polldesc" = list("desc" = "Ghost poll description", "type" = "string", "value" = ertemplate.polldesc),
		"enforce_human" = list("desc" = "Enforce human authority", "type" = "boolean", "value" = "[(CONFIG_GET(flag/enforce_human_authority) ? "Yes" : "No")]"),
		"open_armory" = list("desc" = "Open armory doors", "type" = "boolean", "value" = "[(ertemplate.opendoors ? "Yes" : "No")]"),
		"leader_experience" = list("desc" = "Pick an experienced leader", "type" = "boolean", "value" = "[(ertemplate.leader_experience ? "Yes" : "No")]"),
		"random_names" = list("desc" = "Randomize names", "type" = "boolean", "value" = "[(ertemplate.random_names ? "Yes" : "No")]"),
		"spawn_admin" = list("desc" = "Spawn yourself as briefing officer", "type" = "boolean", "value" = "[(ertemplate.spawn_admin ? "Yes" : "No")]")
		)
	)

	var/list/prefreturn = presentpreflikepicker(usr,"Customize ERT", "Customize ERT", Button1="Ok", width = 600, StealFocus = 1,Timeout = 0, settings=settings)

	if (isnull(prefreturn))
		return FALSE

	if (prefreturn["button"] == 1)
		var/list/prefs = settings["mainsettings"]

		var/templtype = prefs["template"]["value"]
		if (!ispath(prefs["template"]["value"]))
			templtype = text2path(prefs["template"]["value"]) // new text2path ... doesn't compile in 511

		if (ertemplate.type != templtype)
			ertemplate = new templtype

		ertemplate.teamsize = prefs["teamsize"]["value"]
		ertemplate.mission = prefs["mission"]["value"]
		ertemplate.polldesc = prefs["polldesc"]["value"]
		ertemplate.enforce_human = prefs["enforce_human"]["value"] == "Yes" // these next 5 are effectively toggles
		ertemplate.opendoors = prefs["open_armory"]["value"] == "Yes"
		ertemplate.leader_experience = prefs["leader_experience"]["value"] == "Yes"
		ertemplate.random_names = prefs["random_names"]["value"] == "Yes"
		ertemplate.spawn_admin = prefs["spawn_admin"]["value"] == "Yes"

		var/list/spawnpoints = GLOB.emergencyresponseteamspawn
		var/index = 0

		if(ertemplate.spawn_admin)
			if(isobserver(usr))
				var/mob/living/carbon/human/admin_officer = new (spawnpoints[1])
				var/chosen_outfit = usr.client?.prefs?.brief_outfit
				usr.client.prefs.copy_to(admin_officer)
				admin_officer.equipOutfit(chosen_outfit)
				admin_officer.key = usr.key
			else
				to_chat(usr, "<span class='warning'>Could not spawn you in as briefing officer as you are not a ghost!</spawn>")

		var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for [ertemplate.polldesc]?", "deathsquad")
		var/teamSpawned = FALSE

		if(candidates.len == 0)
			return FALSE

		//Pick the (un)lucky players
		var/numagents = min(ertemplate.teamsize,candidates.len)

		//Create team
		var/datum/team/ert/ert_team = new ertemplate.team ()
		if(ertemplate.rename_team)
			ert_team.name = ertemplate.rename_team

		//Assign team objective
		var/datum/objective/missionobj = new ()
		missionobj.team = ert_team
		missionobj.explanation_text = ertemplate.mission
		missionobj.completed = TRUE
		ert_team.objectives += missionobj
		ert_team.mission = missionobj

		var/mob/dead/observer/earmarked_leader
		var/leader_spawned = FALSE // just in case the earmarked leader disconnects or becomes unavailable, we can try giving leader to the last guy to get chosen

		if(ertemplate.leader_experience)
			var/list/candidate_living_exps = list()
			for(var/i in candidates)
				var/mob/dead/observer/potential_leader = i
				candidate_living_exps[potential_leader] = potential_leader.client?.get_exp_living(TRUE)

			candidate_living_exps = sortList(candidate_living_exps, cmp=/proc/cmp_numeric_dsc)
			if(candidate_living_exps.len > ERT_EXPERIENCED_LEADER_CHOOSE_TOP)
				candidate_living_exps = candidate_living_exps.Cut(ERT_EXPERIENCED_LEADER_CHOOSE_TOP+1) // pick from the top ERT_EXPERIENCED_LEADER_CHOOSE_TOP contenders in playtime
			earmarked_leader = pick(candidate_living_exps)
		else
			earmarked_leader = pick(candidates)

		while(numagents && candidates.len)
			var/spawnloc = spawnpoints[index+1]
			//loop through spawnpoints one at a time
			index = (index + 1) % spawnpoints.len
			var/mob/dead/observer/chosen_candidate = earmarked_leader || pick(candidates) // this way we make sure that our leader gets chosen
			candidates -= chosen_candidate
			if(!chosen_candidate?.key)
				continue

			//Spawn the body
			var/mob/living/carbon/human/ert_operative = new ertemplate.mobtype(spawnloc)
			chosen_candidate.client.prefs.copy_to(ert_operative)
			ert_operative.key = chosen_candidate.key

			if(ertemplate.enforce_human || !(ert_operative.dna.species.changesource_flags & ERT_SPAWN)) // Don't want any exploding plasmemes
				ert_operative.set_species(/datum/species/human)

			//Give antag datum
			var/datum/antagonist/ert/ert_antag

			if((chosen_candidate == earmarked_leader) || (numagents == 1 && !leader_spawned))
				ert_antag = new ertemplate.leader_role ()
				earmarked_leader = null
				leader_spawned = TRUE
			else
				ert_antag = ertemplate.roles[WRAP(numagents,1,length(ertemplate.roles) + 1)]
				ert_antag = new ert_antag ()
			ert_antag.random_names = ertemplate.random_names

			ert_operative.mind.add_antag_datum(ert_antag,ert_team)
			ert_operative.mind.assigned_role = ert_antag.name

			//Logging and cleanup
			log_game("[key_name(ert_operative)] has been selected as an [ert_antag.name]")
			numagents--
			teamSpawned++

		if (teamSpawned)
			message_admins("[ertemplate.polldesc] has spawned with the mission: [ertemplate.mission]")

		//Open the Armory doors
		if(ertemplate.opendoors)
			for(var/obj/machinery/door/poddoor/ert/door in GLOB.airlocks)
				door.open()
				CHECK_TICK
		return TRUE

	return

/client/proc/summon_ert()
	set category = "Admin.Fun"
	set name = "Summon ERT"
	set desc = "Summons an emergency response team"

	message_admins("[key_name(usr)] is creating a CentCom response team...")
	if(holder?.makeEmergencyresponseteam())
		message_admins("[key_name(usr)] created a CentCom response team.")
		log_admin("[key_name(usr)] created a CentCom response team.")
	else
		message_admins("[key_name_admin(usr)] tried to create a CentCom response team. Unfortunately, there were not enough candidates available.")
		log_admin("[key_name(usr)] failed to create a CentCom response team.")

#undef ERT_EXPERIENCED_LEADER_CHOOSE_TOP
