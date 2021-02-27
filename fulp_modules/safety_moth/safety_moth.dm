/datum/ert/safety_moth
    mobtype = /mob/living/carbon/human/species/moth
    leader_role = /datum/antagonist/ert/safety_moth
    enforce_human = FALSE
    roles = /datum/antagonist/ert/safety_moth
    mission = "ensure that proper safety protocols are being followed by the crew."
    teamsize = 1
    polldesc = "an experienced Nanotrasen engineering expert"
    opendoors = FALSE


/datum/antagonist/ert/safety_moth
    name = "Safety Moth"
    outfit = /datum/outfit/centcom/ert/engineer/safety_moth
    role = "Safety Moth"
    show_in_antagpanel = TRUE
    show_to_ghosts = TRUE
    antag_moodlet = /datum/mood_event/focused

/datum/antagonist/ert/safety_moth/on_gain()
    forge_objectives()
    . = ..()
    equip_official()
    ADD_TRAIT(owner.current, TRAIT_PACIFISM, JOB_TRAIT)

/datum/antagonist/ert/safety_moth/greet()

    to_chat(owner, "<B><font size=3 color=green>You are the [name].</font></B>")
    to_chat(owner, "You are being sent on a mission to [station_name()] by Nanotrasen's Operational Safety Department. Ensure the crew is following all proper safety protocols. Board the shuttle when your team is ready.")


/datum/antagonist/ert/safety_moth/proc/equip_official()
    var/mob/living/carbon/human/H = owner.current
    if(!istype(H))
        return
    H.equipOutfit(/datum/outfit/centcom/centcom_official)
    H.set_species(/datum/species/moth)

/datum/antagonist/ert/safety_moth/create_team(datum/team/new_team)
    if(istype(new_team))
        ert_team = new_team

/datum/outfit/centcom/ert/engineer/safety_moth
	name = "Safety Moth Engineer"
	suit_store = /obj/item/melee/baton/loaded
	mask = /obj/item/clothing/mask/gas
	r_hand = /obj/item/clipboard
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/construction/rcd/loaded/upgraded=1,\
		/obj/item/toy/plush/moth=1,\
		/obj/item/pipe_dispenser=1)