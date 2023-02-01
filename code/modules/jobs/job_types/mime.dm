/datum/job/mime
	title = JOB_MIME
	description = "..."
	department_head = list(JOB_HEAD_OF_PERSONNEL)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_HOP
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "MIME"

	outfit = /datum/outfit/job/mime
	plasmaman_outfit = /datum/outfit/plasmaman/mime

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_MIME
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/food/baguette)

	mail_goodies = list(
		/obj/item/food/baguette = 15,
		/obj/item/food/cheese/wheel = 10,
		/obj/item/reagent_containers/cup/glass/bottle/bottleofnothing = 10,
		/obj/item/book/mimery = 1,
	)
	rpg_title = "Fool"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

	voice_of_god_power = 0.5 //Why are you speaking
	voice_of_god_silence_power = 3

	job_tone = "silence"


/datum/job/mime/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(!ishuman(spawned))
		return
	spawned.apply_pref_name(/datum/preference/name/mime, player_client)


/datum/outfit/job/mime
	name = "Mime"
	jobtype = /datum/job/mime

	id_trim = /datum/id_trim/job/mime
	uniform = /obj/item/clothing/under/rank/civilian/mime
	suit = /obj/item/clothing/suit/toggle/suspenders
	backpack_contents = list(
		/obj/item/book/mimery = 1,
		/obj/item/reagent_containers/cup/glass/bottle/bottleofnothing = 1,
		/obj/item/stamp/mime = 1,
		)
	belt = /obj/item/modular_computer/pda/mime
	ears = /obj/item/radio/headset/headset_srv
	gloves = /obj/item/clothing/gloves/color/white
	head = /obj/item/clothing/head/frenchberet
	mask = /obj/item/clothing/mask/gas/mime
	shoes = /obj/item/clothing/shoes/laceup

	backpack = /obj/item/storage/backpack/mime
	satchel = /obj/item/storage/backpack/mime

	box = /obj/item/storage/box/survival/hug/black
	chameleon_extras = /obj/item/stamp/mime

/datum/outfit/job/mime/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	// Start our mime out with a vow of silence and the ability to break (or make) it
	if(H.mind)
		var/datum/action/cooldown/spell/vow_of_silence/vow = new(H.mind)
		vow.Grant(H)

	var/datum/atom_hud/fan = GLOB.huds[DATA_HUD_FAN]
	fan.show_to(H)

/obj/item/book/mimery
	name = "Guide to Dank Mimery"
	desc = "Teaches one of three classic pantomime routines, allowing a practiced mime to conjure invisible objects into corporeal existence. One use only."
	icon_state = "bookmime"
	starting_title = "Guide to Dank Mimery"

/obj/item/book/mimery/attack_self(mob/user)
	. = ..()
	if(.)
		return

	var/list/spell_icons = list(
		"Invisible Wall" = image(icon = 'icons/mob/actions/actions_mime.dmi', icon_state = "invisible_wall"),
		"Invisible Chair" = image(icon = 'icons/mob/actions/actions_mime.dmi', icon_state = "invisible_chair"),
		"Invisible Box" = image(icon = 'icons/mob/actions/actions_mime.dmi', icon_state = "invisible_box")
		)
	var/picked_spell = show_radial_menu(user, src, spell_icons, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	var/datum/action/cooldown/spell/picked_spell_type
	switch(picked_spell)
		if("Invisible Wall")
			picked_spell_type = /datum/action/cooldown/spell/conjure/invisible_wall

		if("Invisible Chair")
			picked_spell_type = /datum/action/cooldown/spell/conjure/invisible_chair

		if("Invisible Box")
			picked_spell_type = /datum/action/cooldown/spell/conjure_item/invisible_box

	if(ispath(picked_spell_type))
		// Gives the user a vow ability too, if they don't already have one
		var/datum/action/cooldown/spell/vow_of_silence/vow = locate() in user.actions
		if(!vow && user.mind)
			vow = new(user.mind)
			vow.Grant(user)

		picked_spell_type = new picked_spell_type(user.mind || user)
		picked_spell_type.Grant(user)

		to_chat(user, span_warning("The book disappears into thin air."))
		qdel(src)

	return TRUE

/**
 * Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The human mob interacting with the menu
 */
/obj/item/book/mimery/proc/check_menu(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE
	if(!user.is_holding(src))
		return FALSE
	if(user.incapacitated())
		return FALSE
	if(!user.mind)
		return FALSE
	return TRUE
