/**
 * # Religious Sects
 *
 * Religious Sects are a way to convert the fun of having an active 'god' (admin) to code-mechanics so you aren't having to press adminwho.
 *
 * Sects are not meant to overwrite the fun of choosing a custom god/religion, but meant to enhance it.
 * The idea is that Space Jesus (or whoever you worship) can be an evil bloodgod who takes the lifeforce out of people, a nature lover, or all things righteous and good. You decide!
 *
 */
/datum/religion_sect
	/// Name of the religious sect
	var/name = "Religious Sect Base Type"
	/// Flavorful quote given about the sect, used in tgui
	var/quote = "Hail Coderbus! Coderbus #1! Fuck the playerbase!"
	/// Opening message when someone gets converted
	var/desc = "Oh My! What Do We Have Here?!!?!?!?"
	/// Tgui icon used by this sect - https://fontawesome.com/icons/
	var/tgui_icon = "bug"
	/// holder for alignments.
	var/alignment = ALIGNMENT_GOOD
	/// Does this require something before being available as an option?
	var/starter = TRUE
	/// species traits that block you from picking
	var/invalidating_qualities = NONE
	/// The Sect's 'Mana'
	var/favor = 0 //MANA!
	/// The max amount of favor the sect can have
	var/max_favor = 1000
	/// The default value for an item that can be sacrificed
	var/default_item_favor = 5
	/// Turns into 'desired_items_typecache', and is optionally assoc'd to sacrifice instructions if needed.
	var/list/desired_items
	/// Autopopulated by `desired_items`
	var/list/desired_items_typecache
	/// Lists of rites by type. Converts itself into a list of rites with "name - desc (favor_cost)" = type
	var/list/rites_list
	/// Changes the Altar of Gods icon
	var/altar_icon
	/// Changes the Altar of Gods icon_state
	var/altar_icon_state
	/// Currently Active (non-deleted) rites
	var/list/active_rites

/datum/religion_sect/New()
	. = ..()
	if(desired_items)
		desired_items_typecache = typecacheof(desired_items)
	on_select()

/// Activates once selected
/datum/religion_sect/proc/on_select()
	SHOULD_CALL_PARENT(TRUE)
	SSblackbox.record_feedback("text", "sect_chosen", 1, name)

/// Activates once selected and on newjoins, oriented around people who become holy.
/datum/religion_sect/proc/on_conversion(mob/living/chap)
	SHOULD_CALL_PARENT(TRUE)
	to_chat(chap, "<span class='bold notice'>\"[quote]\"</span")
	to_chat(chap, "<span class='notice'>[desc]</span")

/// Returns TRUE if the item can be sacrificed. Can be modified to fit item being tested as well as person offering. Returning TRUE will stop the attackby sequence and proceed to on_sacrifice.
/datum/religion_sect/proc/can_sacrifice(obj/item/I, mob/living/chap)
	. = TRUE
	if(chap.mind.holy_role == HOLY_ROLE_DEACON)
		to_chat(chap, "<span class='warning'>You are merely a deacon of [GLOB.deity], and therefore cannot perform rites.")
		return
	if(!is_type_in_typecache(I,desired_items_typecache))
		return FALSE

/// Activates when the sect sacrifices an item. This proc has NO bearing on the attackby sequence of other objects when used in conjunction with the religious_tool component.
/datum/religion_sect/proc/on_sacrifice(obj/item/I, mob/living/chap)
	return adjust_favor(default_item_favor,chap)

/// Returns a description for religious tools
/datum/religion_sect/proc/tool_examine(mob/living/holy_creature)
	return "You are currently at [round(favor)] favor with [GLOB.deity]."

/// Adjust Favor by a certain amount. Can provide optional features based on a user. Returns actual amount added/removed
/datum/religion_sect/proc/adjust_favor(amount = 0, mob/living/chap)
	. = amount
	if(favor + amount < 0)
		. = favor //if favor = 5 and we want to subtract 10, we'll only be able to subtract 5
	if((favor + amount > max_favor))
		. = (max_favor-favor) //if favor = 5 and we want to add 10 with a max of 10, we'll only be able to add 5
	favor = clamp(0,max_favor, favor+amount)

/// Sets favor to a specific amount. Can provide optional features based on a user.
/datum/religion_sect/proc/set_favor(amount = 0, mob/living/chap)
	favor = clamp(0,max_favor,amount)
	return favor

/// Activates when an individual uses a rite. Can provide different/additional benefits depending on the user.
/datum/religion_sect/proc/on_riteuse(mob/living/user, atom/religious_tool)

/// Replaces the bible's bless mechanic. Return TRUE if you want to not do the brain hit.
/datum/religion_sect/proc/sect_bless(mob/living/target, mob/living/chap)
	if(!ishuman(target))
		return FALSE
	var/mob/living/carbon/human/blessed = target
	for(var/X in blessed.bodyparts)
		var/obj/item/bodypart/bodypart = X
		if(bodypart.status == BODYPART_ROBOTIC)
			to_chat(chap, span_warning("[GLOB.deity] refuses to heal this metallic taint!"))
			return TRUE

	var/heal_amt = 10
	var/list/hurt_limbs = blessed.get_damaged_bodyparts(1, 1, null, BODYPART_ORGANIC)

	if(hurt_limbs.len)
		for(var/X in hurt_limbs)
			var/obj/item/bodypart/affecting = X
			if(affecting.heal_damage(heal_amt, heal_amt, null, BODYPART_ORGANIC))
				blessed.update_damage_overlays()
		blessed.visible_message(span_notice("[chap] heals [blessed] with the power of [GLOB.deity]!"))
		to_chat(blessed, span_boldnotice("May the power of [GLOB.deity] compel you to be healed!"))
		playsound(chap, "punch", 25, TRUE, -1)
		SEND_SIGNAL(blessed, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
	return TRUE

/**** Nanotrasen Approved God ****/

/datum/religion_sect/puritanism
	name = "Nanotrasen Approved God"
	desc = "Your run-of-the-mill sect, there are no benefits or boons associated."
	quote = "Nanotrasen Recommends!"
	tgui_icon = "bible"

/**** Mechanical God ****/

/datum/religion_sect/mechanical
	name = "Mechanical God"
	quote = "May you find peace in a metal shell."
	desc = "Bibles now recharge cyborgs and heal robotic limbs if targeted, but they \
	do not heal organic limbs. You can now sacrifice cells, with favor depending on their charge."
	tgui_icon = "robot"
	alignment = ALIGNMENT_NEUT
	desired_items = list(/obj/item/stock_parts/cell = "with battery charge")
	rites_list = list(/datum/religion_rites/synthconversion, /datum/religion_rites/machine_blessing)
	altar_icon_state = "convertaltar-blue"
	max_favor = 2500

/datum/religion_sect/mechanical/sect_bless(mob/living/target, mob/living/chap)
	if(iscyborg(target))
		var/mob/living/silicon/robot/R = target
		var/charge_amt = 50
		if(target.mind?.holy_role == HOLY_ROLE_HIGHPRIEST)
			charge_amt *= 2
		R.cell?.charge += charge_amt
		R.visible_message(span_notice("[chap] charges [R] with the power of [GLOB.deity]!"))
		to_chat(R, span_boldnotice("You are charged by the power of [GLOB.deity]!"))
		SEND_SIGNAL(R, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
		playsound(chap, 'sound/effects/bang.ogg', 25, TRUE, -1)
		return TRUE
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/blessed = target

	//first we determine if we can charge them
	var/did_we_charge = FALSE
	var/obj/item/organ/stomach/ethereal/eth_stomach = blessed.getorganslot(ORGAN_SLOT_STOMACH)
	if(istype(eth_stomach))
		eth_stomach.adjust_charge(60)
		did_we_charge = TRUE

	//if we're not targetting a robot part we stop early
	var/obj/item/bodypart/bodypart = blessed.get_bodypart(chap.zone_selected)
	if(bodypart.status != BODYPART_ROBOTIC)
		if(!did_we_charge)
			to_chat(chap, span_warning("[GLOB.deity] scoffs at the idea of healing such fleshy matter!"))
		else
			blessed.visible_message(span_notice("[chap] charges [blessed] with the power of [GLOB.deity]!"))
			to_chat(blessed, span_boldnotice("You feel charged by the power of [GLOB.deity]!"))
			SEND_SIGNAL(blessed, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
			playsound(chap, 'sound/machines/synth_yes.ogg', 25, TRUE, -1)
		return TRUE

	//charge(?) and go
	if(bodypart.heal_damage(5,5,null,BODYPART_ROBOTIC))
		blessed.update_damage_overlays()

	blessed.visible_message(span_notice("[chap] [did_we_charge ? "repairs" : "repairs and charges"] [blessed] with the power of [GLOB.deity]!"))
	to_chat(blessed, span_boldnotice("The inner machinations of [GLOB.deity] [did_we_charge ? "repairs" : "repairs and charges"] you!"))
	playsound(chap, 'sound/effects/bang.ogg', 25, TRUE, -1)
	SEND_SIGNAL(blessed, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
	return TRUE

/datum/religion_sect/mechanical/on_sacrifice(obj/item/I, mob/living/chap)
	var/obj/item/stock_parts/cell/the_cell = I
	if(!istype(the_cell)) //how...
		return
	if(the_cell.charge < 300)
		to_chat(chap,span_notice("[GLOB.deity] does not accept pity amounts of power."))
		return
	adjust_favor(round(the_cell.charge/300), chap)
	to_chat(chap, span_notice("You offer [the_cell]'s power to [GLOB.deity], pleasing them."))
	qdel(I)
	return TRUE

/**** Pyre God ****/

/datum/religion_sect/pyre
	name = "Pyre God"
	desc = "Sacrificing burning corpses with a lot of burn damage and candles grants you favor."
	quote = "It must burn! The primal energy must be respected."
	tgui_icon = "fire-alt"
	alignment = ALIGNMENT_NEUT
	max_favor = 10000
	desired_items = list(/obj/item/candle = "already lit")
	rites_list = list(/datum/religion_rites/fireproof, /datum/religion_rites/burning_sacrifice, /datum/religion_rites/infinite_candle)
	altar_icon_state = "convertaltar-red"

//candle sect bibles don't heal or do anything special apart from the standard holy water blessings
/datum/religion_sect/pyre/sect_bless(mob/living/target, mob/living/chap)
	return TRUE

/datum/religion_sect/pyre/on_sacrifice(obj/item/candle/offering, mob/living/user)
	if(!istype(offering))
		return
	if(!offering.lit)
		to_chat(user, span_notice("The candle needs to be lit to be offered!"))
		return
	to_chat(user, span_notice("[GLOB.deity] is pleased with your sacrifice."))
	adjust_favor(20, user) //it's not a lot but hey there's a pacifist favor option at least
	qdel(offering)
	return TRUE

#define GREEDY_HEAL_COST 50

/datum/religion_sect/greed
	name = "Greedy God"
	quote = "Greed is good."
	desc = "In the eyes of your mercantile deity, your wealth is your favor. Earn enough wealth to purchase some more business opportunities."
	tgui_icon = "dollar-sign"
	altar_icon_state = "convertaltar-yellow"
	alignment = ALIGNMENT_EVIL //greed is not good wtf
	rites_list = list(/datum/religion_rites/greed/vendatray, /datum/religion_rites/greed/custom_vending)
	altar_icon_state = "convertaltar-yellow"

/datum/religion_sect/greed/tool_examine(mob/living/holy_creature) //display money policy
	return "In the eyes of [GLOB.deity], your wealth is your favor."

/datum/religion_sect/greed/sect_bless(mob/living/blessed_living, mob/living/chap)
	var/datum/bank_account/account = chap.get_bank_account()
	if(!account)
		to_chat(chap, span_warning("You need a way to pay for the heal!"))
		return TRUE
	if(account.account_balance < GREEDY_HEAL_COST)
		to_chat(chap, span_warning("Healing from [GLOB.deity] costs [GREEDY_HEAL_COST] credits for 30 health!"))
		return TRUE
	if(!ishuman(blessed_living))
		return FALSE
	var/mob/living/carbon/human/blessed = blessed_living
	for(var/obj/item/bodypart/robolimb as anything in blessed.bodyparts)
		if(robolimb.status == BODYPART_ROBOTIC)
			to_chat(chap, span_warning("[GLOB.deity] refuses to heal this metallic taint!"))
			return TRUE

	account.adjust_money(-GREEDY_HEAL_COST)
	var/heal_amt = 30
	var/list/hurt_limbs = blessed.get_damaged_bodyparts(1, 1, null, BODYPART_ORGANIC)
	if(hurt_limbs.len)
		for(var/obj/item/bodypart/affecting as anything in hurt_limbs)
			if(affecting.heal_damage(heal_amt, heal_amt, null, BODYPART_ORGANIC))
				blessed.update_damage_overlays()
		blessed.visible_message(span_notice("[chap] barters a heal for [blessed] from [GLOB.deity]!"))
		to_chat(blessed, span_boldnotice("May the power of [GLOB.deity] compel you to be healed! Thank you for choosing [GLOB.deity]!"))
		playsound(chap, 'sound/effects/cashregister.ogg', 60, TRUE)
		SEND_SIGNAL(blessed, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
	return TRUE

#undef GREEDY_HEAL_COST

/datum/religion_sect/honorbound
	name = "Honorbound God"
	quote = "A good, honorable crusade against evil is required."
	desc = "Your deity requires fair fights from you. You may not attack the unready, the just, or the innocent. \
	You earn favor by getting others to join the crusade, and you may spend favor to announce a battle, bypassing some conditions to attack."
	tgui_icon = "scroll"
	altar_icon_state = "convertaltar-white"
	alignment = ALIGNMENT_GOOD
	invalidating_qualities = TRAIT_GENELESS
	rites_list = list(/datum/religion_rites/deaconize, /datum/religion_rites/forgive, /datum/religion_rites/summon_rules)
	///people who have agreed to join the crusade, and can be deaconized
	var/list/possible_crusaders = list()
	///people who have been offered an invitation, they haven't finished the alert though.
	var/list/currently_asking = list()

/**
 * Called by deaconize rite, this async'd proc waits for a response on joining the sect.
 * If yes, the deaconize rite can now recruit them instead of just offering invites
 */
/datum/religion_sect/honorbound/proc/invite_crusader(mob/living/carbon/human/invited)
	currently_asking += invited
	var/ask = tgui_alert(invited, "Join [GLOB.deity]? You will be bound to a code of honor.", "Invitation", list("Yes", "No"), 60 SECONDS)
	currently_asking -= invited
	if(ask == "Yes")
		possible_crusaders += invited

/datum/religion_sect/honorbound/on_conversion(mob/living/carbon/new_convert)
	..()
	if(!ishuman(new_convert))
		to_chat(new_convert, span_warning("[GLOB.deity] has no respect for lower creatures, and refuses to make you honorbound."))
		return FALSE
	if(TRAIT_GENELESS in new_convert.dna.species.inherent_traits)
		to_chat(new_convert, span_warning("[GLOB.deity] has deemed your species as one that could never show honor."))
		return FALSE
	var/datum/dna/holy_dna = new_convert.dna
	holy_dna.add_mutation(HONORBOUND)

/datum/religion_sect/burden
	name = "Punished God"
	quote = "To feel the freedom, you must first understand captivity."
	desc = "Incapacitate yourself in any way possible. Bad mutations, lost limbs, traumas, \
	even addictions. You will learn the secrets of the universe from your defeated shell."
	tgui_icon = "user-injured"
	altar_icon_state = "convertaltar-burden"
	alignment = ALIGNMENT_NEUT
	invalidating_qualities = TRAIT_GENELESS

/datum/religion_sect/burden/on_conversion(mob/living/carbon/human/new_convert)
	..()
	if(!ishuman(new_convert))
		to_chat(new_convert, span_warning("[GLOB.deity] needs higher level creatures to fully comprehend the suffering. You are not burdened."))
		return
	if(TRAIT_GENELESS in new_convert.dna.species.inherent_traits)
		to_chat(new_convert, span_warning("[GLOB.deity] cannot help a species such as yourself comprehend the suffering. You are not burdened."))
		return
	var/datum/dna/holy_dna = new_convert.dna
	holy_dna.add_mutation(/datum/mutation/human/burdened)

/datum/religion_sect/burden/tool_examine(mob/living/carbon/human/burdened) //display burden level
	if(!ishuman(burdened))
		return FALSE
	var/datum/mutation/human/burdened/burdenmut = burdened.dna.check_mutation(/datum/mutation/human/burdened)
	if(burdenmut)
		return "You are at burden level [burdenmut.burden_level]/6."
	return "You are not burdened."

#define MINIMUM_YUCK_REQUIRED 5

/datum/religion_sect/maintenance
	name = "Maintenance God"
	quote = "Your kingdom in the darkness."
	desc = "Sacrifice the organic slurry created from rats dipped in welding fuel to gain favor. Exchange favor to adapt to the maintenance shafts."
	tgui_icon = "eye"
	altar_icon_state = "convertaltar-maint"
	alignment = ALIGNMENT_EVIL //while maint is more neutral in my eyes, the flavor of it kinda pertains to rotting and becoming corrupted by the maints
	rites_list = list(/datum/religion_rites/maint_adaptation, /datum/religion_rites/adapted_eyes, /datum/religion_rites/adapted_food, /datum/religion_rites/ritual_totem)
	desired_items = list(/obj/item/reagent_containers = "holding organic slurry")

/datum/religion_sect/maintenance/sect_bless(mob/living/blessed_living, mob/living/chap)
	if(!ishuman(blessed_living))
		return TRUE
	var/mob/living/carbon/human/blessed = blessed_living
	if(blessed.reagents.has_reagent(/datum/reagent/drug/maint/sludge))
		to_chat(blessed, span_warning("[GLOB.deity] has already empowered them."))
		return TRUE
	blessed.reagents.add_reagent(/datum/reagent/drug/maint/sludge, 5)
	blessed.visible_message(span_notice("[chap] empowers [blessed] with the power of [GLOB.deity]!"))
	to_chat(blessed, span_boldnotice("The power of [GLOB.deity] has made you harder to wound for a while!"))
	playsound(chap, "punch", 25, TRUE, -1)
	SEND_SIGNAL(blessed, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
	return TRUE //trust me, you'll be feeling the pain from the maint drugs all well enough

/datum/religion_sect/maintenance/on_sacrifice(obj/item/reagent_containers/offering, mob/living/user)
	if(!istype(offering))
		return
	var/datum/reagent/yuck/wanted_yuck = offering.reagents.has_reagent(/datum/reagent/yuck, MINIMUM_YUCK_REQUIRED)
	var/favor_earned = offering.reagents.get_reagent_amount(/datum/reagent/yuck)
	if(!wanted_yuck)
		to_chat(user, span_warning("[offering] does not have enough organic slurry for [GLOB.deity] to enjoy."))
		return
	to_chat(user, span_notice("[GLOB.deity] loves organic slurry."))
	adjust_favor(favor_earned, user)
	playsound(get_turf(offering), 'sound/items/drink.ogg', 50, TRUE)
	offering.reagents.clear_reagents()
	return TRUE

#undef MINIMUM_YUCK_REQUIRED
