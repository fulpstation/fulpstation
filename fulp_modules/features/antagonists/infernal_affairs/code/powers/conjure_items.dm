/datum/action/cooldown/spell/conjure_item/summon_pitchfork
	name = "Summon Pitchfork"
	desc = "A devil's weapon of choice. Not actually great at damage, but sets people ablaze."
	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"
	spell_requirements = NONE

	button_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/actions_devil.dmi'
	button_icon_state = "pitchfork"

	school = SCHOOL_CONJURATION
	invocation_type = INVOCATION_NONE

	item_type = /obj/item/pitchfork/demonic

/datum/action/cooldown/spell/conjure_item/violin
	name = "Summon Golden Violin"
	desc = "Play some tunes."
	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"
	spell_requirements = NONE

	button_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/actions_devil.dmi'
	button_icon_state = "golden_violin"

	invocation = "I aint have this much fun since Georgia."
	invocation_type = INVOCATION_WHISPER

	item_type = /obj/item/instrument/violin/golden

/datum/action/cooldown/spell/conjure_item/summon_contract
	name = "Summon Devil Contract"
	desc = "Summon a contract that, when signed, will \
		add someone to the Agent's death loop."

	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"
	spell_requirements = NONE

	button_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/actions_devil.dmi'
	button_icon_state = "spell_default"

	school = SCHOOL_CONJURATION
	cooldown_time = 1 MINUTES

	invocation = "Just sign on the dotted line."
	invocation_type = INVOCATION_WHISPER

	item_type = /obj/item/paper/devil_contract

/datum/action/cooldown/spell/conjure_item/summon_contract/New(Target, original = TRUE)
	. = ..()
	desc += " This will only work [DEVIL_MAX_CONTRACTS] times."

/datum/action/cooldown/spell/conjure_item/summon_contract/make_item(mob/caster)
	var/obj/item/paper/devil_contract/made_contract = ..()
	var/datum/antagonist/devil/devil_datum = IS_DEVIL(caster)
	made_contract.devil_antagonist = devil_datum
	return made_contract

/obj/item/paper/devil_contract
	name = "devil contract"
	desc = "Signing this would be the greatest mistake of your life... or the best."
	color = "#db7c00"
	item_flags = NOBLUDGEON
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	default_raw_text = "<center><B>Contract for infernal power</B></center><BR><BR><BR>I, \[\"____________\"\] of sound mind, \
		do hereby willingly offer my soul to the infernal hells by way of the infernal agent, \
		in exchange for power and physical strength. I understand that upon my demise, my soul shall fall into the infernal hells, \
		and my body may not be resurrected, cloned, or otherwise brought back to life.  \
		I also understand that this will prevent my brain from being used in an MMI.\
		<BR><BR><BR>Signed, \n <i>\[\"____________\"\]</i>"

	///Reference to a devil antagonist that created this contract.
	var/datum/antagonist/devil/devil_antagonist

/obj/item/paper/devil_contract/Destroy()
	. = ..()
	devil_antagonist = null

/obj/item/paper/devil_contract/ui_act(action, params, datum/tgui/ui)
	var/mob/user = ui.user
	var/obj/item/holding = user.get_active_held_item()
	if(action != "add_text" || !user.can_write(holding))
		return ..()
	return sign_paper(user)

/obj/item/paper/devil_contract/attackby(obj/item/possible_pen, mob/user, params)
	if(possible_pen.sharpness == SHARP_POINTY)
		return sign_paper(user)
	return ..()

/obj/item/paper/devil_contract/proc/sign_paper(mob/user)
	if(SSinfernal_affairs.last_one_standing)
		to_chat(user, span_notice("There contract appears to have expired."))
		return FALSE
	if(IS_DEVIL(user))
		to_chat(user, span_notice("There's no point in messing with this, it's your own work."))
		return FALSE
	if(IS_INFERNAL_AGENT(user))
		to_chat(user, span_notice("I know this paper, it serves no use for me anymore."))
		return FALSE
	if(HAS_TRAIT(user.mind, TRAIT_DEVIL_CONTRACT_IMMUNE))
		to_chat(user, span_warning("I've read this before... I'm not signing this shit!"))
		return FALSE
	var/tgui_response = tgui_alert(user, "You are about to give up your soul to the Infernal depths. Do you agree?", "Devil Agent", list("Yes", "NO!!"), timeout = 5 SECONDS)
	if(tgui_response != "Yes")
		user.visible_message(span_notice("[user] puts down \the [src]."))
		return FALSE
	user.mind.add_antag_datum(/datum/antagonist/infernal_affairs)
	to_chat(user, span_alert("You sign your life away. Now only He knows where you're going."))
	devil_antagonist.on_contract_signed()
	qdel(src)
