/datum/antagonist/traitor/finalize_traitor()
	. = ..()
	switch(traitor_kind)
		if(TRAITOR_AI)
			tips = MALF_TIPS
		if(TRAITOR_HUMAN)
			tips = TRAITOR_TIPS

/datum/antagonist/traitor/internal_affairs/finalize_traitor()
	. = ..()
	switch(traitor_kind)
		if(TRAITOR_AI)
			tips = IAA_AI_TIPS
		if(TRAITOR_HUMAN)
			tips = IAA_TIPS
/datum/antagonist/nukeop
	tips = NUKIE_TIPS

/datum/antagonist/changeling
	tips = CHANGELING_TIPS

/datum/antagonist/cult
	tips = CULTIST_TIPS

/datum/antagonist/heretic
	tips = HERETIC_TIPS

/datum/antagonist/wizard
	tips = WIZARD_TIPS

/datum/antagonist/abductor
	tips = ABDUCTOR_TIPS
