/datum/job/chaplain
	title = "Chaplain"
	department_head = list("Head of Personnel")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#bbe291"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/chaplain
	plasmaman_outfit = /datum/outfit/plasmaman/chaplain

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_CHAPLAIN
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/toy/windup_toolbox, /obj/item/reagent_containers/food/drinks/bottle/holywater)

	mail_goodies = list(
		/obj/item/reagent_containers/food/drinks/bottle/holywater = 30,
		/obj/item/toy/plush/awakenedplushie = 10,
		/obj/item/grenade/chem_grenade/holy = 5,
		/obj/item/toy/plush/narplush = 2,
		/obj/item/toy/plush/ratplush = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

	voice_of_god_power = 2 //Chaplains are very good at speaking with the voice of god


/datum/job/chaplain/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(!ishuman(spawned))
		return
	var/mob/living/carbon/human/H = spawned
	var/obj/item/storage/book/bible/booze/B = new

	if(GLOB.religion)
		if(H.mind)
			H.mind.holy_role = HOLY_ROLE_PRIEST
		B.deity_name = GLOB.deity
		B.name = GLOB.bible_name
		// These checks are important as there's no guarantee the "HOLY_ROLE_HIGHPRIEST" chaplain has selected a bible skin.
		if(GLOB.bible_icon_state)
			B.icon_state = GLOB.bible_icon_state
		if(GLOB.bible_inhand_icon_state)
			B.inhand_icon_state = GLOB.bible_inhand_icon_state
		to_chat(H, span_boldnotice("There is already an established religion onboard the station. You are an acolyte of [GLOB.deity]. Defer to the Chaplain."))
		H.equip_to_slot_or_del(B, ITEM_SLOT_BACKPACK)
		var/nrt = GLOB.holy_weapon_type || /obj/item/nullrod
		var/obj/item/nullrod/N = new nrt(H)
		H.put_in_hands(N)
		if(GLOB.religious_sect)
			GLOB.religious_sect.on_conversion(H)
		return
	if(H.mind)
		H.mind.holy_role = HOLY_ROLE_HIGHPRIEST

	var/new_religion = DEFAULT_RELIGION
	if(player_client?.prefs.custom_names["religion"])
		new_religion = player_client.prefs.custom_names["religion"]

	var/new_deity = DEFAULT_DEITY
	if(player_client?.prefs.custom_names["deity"])
		new_deity = player_client.prefs.custom_names["deity"]

	B.deity_name = new_deity

	var/new_bible = DEFAULT_BIBLE
	if(player_client?.prefs.custom_names["bible"])
		new_bible = player_client.prefs.custom_names["bible"]

	switch(lowertext(new_religion))
		if("homosexuality", "gay", "penis", "ass", "cock", "cocks")
			new_bible = pick("Guys Gone Wild","Coming Out of The Closet","War of Cocks")
			switch(new_bible)
				if("War of Cocks")
					B.deity_name = pick("Dick Powers", "King Cock")
				else
					B.deity_name = pick("Gay Space Jesus", "Gandalf", "Dumbledore")
			H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100) // starts off brain damaged as fuck
		if("lol", "wtf", "poo", "badmin", "shitmin", "deadmin", "meme", "memes")
			new_bible = pick("Woody's Got Wood: The Aftermath", "Sweet Bro and Hella Jeff: Expanded Edition","F.A.T.A.L. Rulebook")
			switch(new_bible)
				if("Woody's Got Wood: The Aftermath")
					B.deity_name = pick("Woody", "Andy", "Cherry Flavored Lube")
				if("Sweet Bro and Hella Jeff: Expanded Edition")
					B.deity_name = pick("Sweet Bro", "Hella Jeff", "Stairs", "AH")
				if("F.A.T.A.L. Rulebook")
					B.deity_name = "Twenty Ten-Sided Dice"
			H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100) // also starts off brain damaged as fuck
		if("servicianism", "partying")
			B.desc = "Happy, Full, Clean. Live it and give it."
		if("weeaboo","kawaii")
			new_bible = pick("Fanfiction Compendium","Japanese for Dummies","The Manganomicon","Establishing Your O.T.P")
			B.deity_name = "Anime"
		else
			if(new_bible == DEFAULT_BIBLE)
				new_bible = "The Holy Book of [new_religion]"

	B.name = new_bible

	GLOB.religion = new_religion
	GLOB.bible_name = new_bible
	GLOB.deity = B.deity_name

	H.equip_to_slot_or_del(B, ITEM_SLOT_BACKPACK)

	SSblackbox.record_feedback("text", "religion_name", 1, "[new_religion]", 1)
	SSblackbox.record_feedback("text", "religion_deity", 1, "[new_deity]", 1)
	SSblackbox.record_feedback("text", "religion_bible", 1, "[new_bible]", 1)

/datum/outfit/job/chaplain
	name = "Chaplain"
	jobtype = /datum/job/chaplain

	belt = /obj/item/pda/chaplain
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/chaplain
	backpack_contents = list(
		/obj/item/stamp/chap = 1,
		/obj/item/camera/spooky = 1
		)

	skillchips = list(/obj/item/skillchip/entrails_reader)

	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack

	chameleon_extras = /obj/item/stamp/chap

	id_trim = /datum/id_trim/job/chaplain
