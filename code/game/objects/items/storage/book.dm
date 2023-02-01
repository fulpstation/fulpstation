/obj/item/storage/book
	name = "hollowed book"
	desc = "I guess someone didn't like it."
	icon = 'icons/obj/library.dmi'
	icon_state ="book"
	worn_icon_state = "book"
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FLAMMABLE
	var/title = "book"

/obj/item/storage/book/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 1

/obj/item/storage/book/attack_self(mob/user)
	balloon_alert(user, "pages cut out!")

GLOBAL_LIST_INIT(biblenames, list("Bible", "Quran", "Scrapbook", "Burning Bible", "Clown Bible", "Banana Bible", "Creeper Bible", "White Bible", "Holy Light", "The God Delusion", "Tome", "The King in Yellow", "Ithaqua", "Scientology", "Melted Bible", "Necronomicon", "Insulationism", "Guru Granth Sahib", "Kojiki"))
//If you get these two lists not matching in size, there will be runtimes and I will hurt you in ways you couldn't even begin to imagine
// if your bible has no custom itemstate, use one of the existing ones
GLOBAL_LIST_INIT(biblestates, list("bible", "koran", "scrapbook", "burning", "honk1", "honk2", "creeper", "white", "holylight", "atheist", "tome", "kingyellow", "ithaqua", "scientology", "melted", "necronomicon", "insuls", "gurugranthsahib", "kojiki"))
GLOBAL_LIST_INIT(bibleitemstates, list("bible", "koran", "scrapbook", "burning", "honk1", "honk2", "creeper", "white", "holylight", "atheist", "tome", "kingyellow", "ithaqua", "scientology", "melted", "necronomicon", "kingyellow", "gurugranthsahib", "kojiki"))

/obj/item/storage/book/bible
	name = "bible"
	desc = "Apply to head repeatedly."
	icon = 'icons/obj/storage/book.dmi'
	icon_state = "bible"
	inhand_icon_state = "bible"
	worn_icon_state = "bible"
	lefthand_file = 'icons/mob/inhands/items/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/books_righthand.dmi'
	var/mob/affecting = null
	var/deity_name = "Christ"
	force_string = "holy"

/obj/item/storage/book/bible/examine(mob/user)
	. = ..()
	if(user?.mind?.holy_role)
		if(GLOB.chaplain_altars.len)
			. += span_notice("[src] has an expansion pack to replace any broken Altar.")
		else
			. += span_notice("[src] can be unpacked by hitting the floor of a holy area with it.")

/obj/item/storage/book/bible/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	AddComponent(/datum/component/anti_magic, MAGIC_RESISTANCE_HOLY)

/obj/item/storage/book/bible/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is offering [user.p_them()]self to [deity_name]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return BRUTELOSS

/obj/item/storage/book/bible/attack_self(mob/living/carbon/human/user)
	if(GLOB.bible_icon_state)
		return FALSE
	if(user?.mind?.holy_role != HOLY_ROLE_HIGHPRIEST)
		return FALSE

	var/list/skins = list()
	for(var/i in 1 to GLOB.biblestates.len)
		var/image/bible_image = image(icon = 'icons/obj/storage/book.dmi', icon_state = GLOB.biblestates[i])
		skins += list("[GLOB.biblenames[i]]" = bible_image)

	var/choice = show_radial_menu(user, src, skins, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 40, require_near = TRUE)
	if(!choice)
		return FALSE
	var/bible_index = GLOB.biblenames.Find(choice)
	if(!bible_index)
		return FALSE
	icon_state = GLOB.biblestates[bible_index]
	inhand_icon_state = GLOB.bibleitemstates[bible_index]

	switch(icon_state)
		if("honk1")
			user.dna.add_mutation(/datum/mutation/human/clumsy)
			user.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/clown_hat(user), ITEM_SLOT_MASK)
		if("honk2")
			user.dna.add_mutation(/datum/mutation/human/clumsy)
			user.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/clown_hat(user), ITEM_SLOT_MASK)
		if("insuls")
			var/obj/item/clothing/gloves/color/fyellow/insuls = new
			insuls.name = "insuls"
			insuls.desc = "A mere copy of the true insuls."
			insuls.siemens_coefficient = 0.99999
			user.equip_to_slot(insuls, ITEM_SLOT_GLOVES)
	GLOB.bible_icon_state = icon_state
	GLOB.bible_inhand_icon_state = inhand_icon_state
	SSblackbox.record_feedback("text", "religion_book", 1, "[choice]")

/**
 * Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The mob interacting with the menu
 */
/obj/item/storage/book/bible/proc/check_menu(mob/living/carbon/human/user)
	if(GLOB.bible_icon_state)
		return FALSE
	if(!istype(user) || !user.is_holding(src))
		return FALSE
	if(user.incapacitated())
		return FALSE
	if(user.mind?.holy_role != HOLY_ROLE_HIGHPRIEST)
		return FALSE
	return TRUE

/obj/item/storage/book/bible/proc/make_new_altar(atom/bible_smacked, mob/user)
	var/new_altar_area = get_turf(bible_smacked)

	balloon_alert(user, "unpacking bible...")
	if(!do_after(user, 15 SECONDS, new_altar_area))
		return
	new /obj/structure/altar_of_gods(new_altar_area)
	qdel(src)

/obj/item/storage/book/bible/proc/bless(mob/living/L, mob/living/user)
	if(GLOB.religious_sect)
		return GLOB.religious_sect.sect_bless(L,user)
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/H = L
	for(var/obj/item/bodypart/bodypart as anything in H.bodyparts)
		if(!IS_ORGANIC_LIMB(bodypart))
			balloon_alert(user, "can't heal metal!")
			return 0

	var/heal_amt = 10
	var/list/hurt_limbs = H.get_damaged_bodyparts(1, 1, BODYTYPE_ORGANIC)

	if(hurt_limbs.len)
		for(var/X in hurt_limbs)
			var/obj/item/bodypart/affecting = X
			if(affecting.heal_damage(heal_amt, heal_amt, BODYTYPE_ORGANIC))
				H.update_damage_overlays()
		H.visible_message(span_notice("[user] heals [H] with the power of [deity_name]!"))
		to_chat(H, span_boldnotice("May the power of [deity_name] compel you to be healed!"))
		playsound(src.loc, SFX_PUNCH, 25, TRUE, -1)
		H.add_mood_event("blessing", /datum/mood_event/blessing)
	return TRUE

/obj/item/storage/book/bible/attack(mob/living/M, mob/living/carbon/human/user, heal_mode = TRUE)

	if (!ISADVANCEDTOOLUSER(user))
		balloon_alert(user, "not dextrous enough!")
		return

	if (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		to_chat(user, span_danger("[src] slips out of your hand and hits your head."))
		user.take_bodypart_damage(10)
		user.Unconscious(40 SECONDS)
		return

	if (!user.mind || !user.mind.holy_role)
		to_chat(user, span_danger("The book sizzles in your hands."))
		user.take_bodypart_damage(0, 10)
		return

	if (!heal_mode)
		return ..()

	if (M.stat == DEAD)
		M.visible_message(span_danger("[user] smacks [M]'s lifeless corpse with [src]."))
		playsound(src.loc, SFX_PUNCH, 25, TRUE, -1)
		return

	if(user == M)
		balloon_alert(user, "can't heal yourself!")
		return

	var/smack = TRUE

	if(prob(60) && bless(M, user))
		smack = FALSE
	else if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(!istype(C.head, /obj/item/clothing/head/helmet))
			C.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5, 60)
			C.balloon_alert(C, "you feel dumber")

	if(smack)
		M.visible_message(span_danger("[user] beats [M] over the head with [src]!"), \
				span_userdanger("[user] beats [M] over the head with [src]!"))
		playsound(src.loc, SFX_PUNCH, 25, TRUE, -1)
		log_combat(user, M, "attacked", src)

/obj/item/storage/book/bible/afterattack(atom/bible_smacked, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(SEND_SIGNAL(bible_smacked, COMSIG_BIBLE_SMACKED, user, proximity) & COMSIG_END_BIBLE_CHAIN)
		return . | AFTERATTACK_PROCESSED_ITEM
	if(isfloorturf(bible_smacked))
		if(user.mind && (user.mind.holy_role))
			var/area/current_area = get_area(bible_smacked)
			if(!GLOB.chaplain_altars.len && istype(current_area, /area/station/service/chapel))
				make_new_altar(bible_smacked, user)
				return
			for(var/obj/effect/rune/nearby_runes in orange(2,user))
				nearby_runes.invisibility = 0
		bible_smacked.balloon_alert(user, "floor smacked")

	if(user?.mind?.holy_role)
		if(bible_smacked.reagents && bible_smacked.reagents.has_reagent(/datum/reagent/water)) // blesses all the water in the holder
			. |= AFTERATTACK_PROCESSED_ITEM
			bible_smacked.balloon_alert(user, "blessed")
			var/water2holy = bible_smacked.reagents.get_reagent_amount(/datum/reagent/water)
			bible_smacked.reagents.del_reagent(/datum/reagent/water)
			bible_smacked.reagents.add_reagent(/datum/reagent/water/holywater,water2holy)
		if(bible_smacked.reagents && bible_smacked.reagents.has_reagent(/datum/reagent/fuel/unholywater)) // yeah yeah, copy pasted code - sue me
			. |= AFTERATTACK_PROCESSED_ITEM
			bible_smacked.balloon_alert(user, "purified")
			var/unholy2clean = bible_smacked.reagents.get_reagent_amount(/datum/reagent/fuel/unholywater)
			bible_smacked.reagents.del_reagent(/datum/reagent/fuel/unholywater)
			bible_smacked.reagents.add_reagent(/datum/reagent/water/holywater,unholy2clean)
		if(istype(bible_smacked, /obj/item/storage/book/bible) && !istype(bible_smacked, /obj/item/storage/book/bible/syndicate))
			. |= AFTERATTACK_PROCESSED_ITEM
			bible_smacked.balloon_alert(user, "converted")
			var/obj/item/storage/book/bible/B = bible_smacked
			B.name = name
			B.icon_state = icon_state
			B.inhand_icon_state = inhand_icon_state

	if(istype(bible_smacked, /obj/item/cult_bastard) && !IS_CULTIST(user))
		. |= AFTERATTACK_PROCESSED_ITEM
		var/obj/item/cult_bastard/sword = bible_smacked
		bible_smacked.balloon_alert(user, "exorcising...")
		playsound(src,'sound/hallucinations/veryfar_noise.ogg',40,TRUE)
		if(do_after(user, 40, target = sword))
			playsound(src,'sound/effects/pray_chaplain.ogg',60,TRUE)
			for(var/obj/item/soulstone/SS in sword.contents)
				SS.required_role = null
				for(var/mob/living/simple_animal/shade/EX in SS)
					var/datum/antagonist/cult/cultist = EX.mind.has_antag_datum(/datum/antagonist/cult)
					if (cultist)
						cultist.silent = TRUE
						cultist.on_removal()

					EX.icon_state = "shade_holy"
					EX.name = "Purified [EX.name]"
				SS.release_shades(user)
				qdel(SS)
			new /obj/item/nullrod/claymore(get_turf(sword))
			user.visible_message(span_notice("[user] purifies [sword]!"))
			qdel(sword)

/obj/item/storage/book/bible/booze
	desc = "To be applied to the head repeatedly."

/obj/item/storage/book/bible/booze/PopulateContents()
	new /obj/item/reagent_containers/cup/glass/bottle/whiskey(src)

/obj/item/storage/book/bible/syndicate
	icon_state ="ebook"
	deity_name = "The Syndicate"
	throw_speed = 2
	throwforce = 18
	throw_range = 7
	force = 18
	hitsound = 'sound/weapons/sear.ogg'
	damtype = BURN
	name = "Syndicate Tome"
	attack_verb_continuous = list("attacks", "burns", "blesses", "damns", "scorches")
	attack_verb_simple = list("attack", "burn", "bless", "damn", "scorch")
	item_flags = NO_BLOOD_ON_ITEM
	var/uses = 1
	var/ownername

/obj/item/storage/book/bible/syndicate/attack_self(mob/living/carbon/human/H)
	if (uses)
		H.mind.holy_role = HOLY_ROLE_PRIEST
		uses -= 1
		to_chat(H, span_userdanger("You try to open the book AND IT BITES YOU!"))
		playsound(src.loc, 'sound/effects/snap.ogg', 50, TRUE)
		H.apply_damage(5, BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		to_chat(H, span_notice("Your name appears on the inside cover, in blood."))
		ownername = H.real_name

/obj/item/storage/book/bible/syndicate/examine(mob/user)
	. = ..()
	if(ownername)
		. += span_warning("The name [ownername] is written in blood inside the cover.")

/obj/item/storage/book/bible/syndicate/attack(mob/living/M, mob/living/carbon/human/user, heal_mode = TRUE)
	if (!user.combat_mode)
		return ..()
	else
		return ..(M,user,heal_mode = FALSE)
