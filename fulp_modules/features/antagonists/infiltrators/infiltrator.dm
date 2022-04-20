/datum/antagonist/traitor/infiltrator
	name = "Infiltrator"
	antagpanel_category = "Infiltrator"
	job_rank = ROLE_INFILTRATOR
	antag_hud_name = "traitor"
	hijack_speed = 1
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	antag_moodlet = /datum/mood_event/focused
	preview_outfit = /datum/outfit/infiltrator
	var/give_equipment = TRUE

/datum/job/infiltrator
	title = ROLE_INFILTRATOR

/datum/antagonist/traitor/infiltrator/proc/equip_infiltrator(mob/living/carbon/human/infiltrator = owner.current)
	switch(employer)
		if("Corporate Climber")
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/cc)
		if("Animal Rights Consortium")
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/arc)
		if("Gorlex Marauders")
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/gm)


/datum/antagonist/traitor/infiltrator/on_gain()
	..()
	if(give_equipment)
		equip_infiltrator(owner.current)
	owner.current.mind.set_assigned_role(SSjob.GetJobType(/datum/job/infiltrator))
	owner.current.mind.special_role = ROLE_INFILTRATOR
	uplink_handler.has_progression = FALSE
	uplink_handler.has_objectives = FALSE

/datum/antagonist/traitor/infiltrator/pick_employer(faction)
	faction = prob(67) ? FACTION_SYNDICATE : FACTION_NANOTRASEN
	if(faction == FACTION_NANOTRASEN)
		employer = "Corporate Climber"
	else
		employer = pick("Animal Rights Consortium","Gorlex Marauders")
	forge_traitor_objectives()
	traitor_flavor = strings(TRAITOR_FLAVOR_FILE, employer)

/datum/outfit/infiltrator
	name = "Infiltrator"
	uniform = /obj/item/clothing/under/chameleon
	suit = /obj/item/clothing/suit/space/syndicate
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	head = /obj/item/clothing/head/helmet/space/syndicate
	ears = /obj/item/radio/headset
	back = /obj/item/storage/backpack/old
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/knife/combat/survival = 1,
	)
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/chameleon/operative
	l_hand = /obj/item/tank/jetpack
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/combat
	r_pocket = /obj/item/tank/internals/emergency_oxygen
	internals_slot = ITEM_SLOT_RPOCKET

/datum/outfit/infiltrator/cc
	name = "Corporate Climber Infiltrator"
	suit = /obj/item/clothing/suit/space/syndicate/blue
	head = /obj/item/clothing/head/helmet/space/syndicate/blue
	r_hand = /obj/item/adv_mulligan

/datum/outfit/infiltrator/arc
	name = "Animal Rights Consortium Infiltrator"
	suit = /obj/item/clothing/suit/space/syndicate/green
	head = /obj/item/clothing/head/helmet/space/syndicate/green
	r_hand = /obj/item/dnainjector/h2m

/datum/outfit/infiltrator/gm
	name = "Gorlex Marauders Infiltrator"
	suit = /obj/item/clothing/suit/space/syndicate/orange
	head = /obj/item/clothing/head/helmet/space/syndicate/orange
	r_hand = /obj/item/card/emag

//adv mulligan

/obj/item/adv_mulligan
	name = "advanced mulligan"
	desc = "Toxin that permanently changes your DNA into the one of last injected person."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "dnainjector0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/used = FALSE
	var/mob/living/carbon/human/stored

/obj/item/adv_mulligan/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	return

/obj/item/adv_mulligan/afterattack(atom/movable/AM, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(user))
		return
	if(used)
		to_chat(user, "<span class='warning'>[src] has been already used, you can't activate it again!</span>")
		return
	if(ishuman(AM))
		var/mob/living/carbon/human/target = AM
		if(user.real_name != target.dna.real_name)
			stored = target
			to_chat(user, "<span class='notice'>You stealthly stab [target.name] with [src].</span>")
			desc = "Toxin that permanently changes your DNA into the one of last injected person. It has DNA of <span class='blue'>[stored.dna.real_name]</span> inside."
			icon_state = "dnainjector"
		else
			if(stored)
				mutate(user)
			else
				to_chat(user, "<span class='warning'>You can't stab yourself with [src]!</span>")

/obj/item/adv_mulligan/attack_self(mob/living/carbon/user)
	mutate(user)

/obj/item/adv_mulligan/proc/mutate(mob/living/carbon/user)
	if(used)
		to_chat(user, "<span class='warning'>[src] has been already used, you can't activate it again!</span>")
		return
	if(!stored)
		to_chat(user, "<span class='warning'>[src] doesn't have any DNA loaded in it!</span>")
		return

		user.visible_message("<span class='warning'>[user.name] shivers in pain and soon transform into [stored.dna.real_name]!</span>", \
	"<span class='notice'>You inject yourself with [src] and suddenly become a copy of [stored.dna.real_name].</span>")

	user.real_name = stored.real_name
	stored.dna.transfer_identity(user, transfer_SE=1)
	user.updateappearance(mutcolor_update=1)
	user.domutcheck()
	used = TRUE

	icon_state = "dnainjector0"
	desc = "Toxin that permanently changes your DNA into the one of last injected person. This one is used up."

