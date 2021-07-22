//////////////////////
//     BLOODBAG     //
//////////////////////

/// Taken from drinks.dm
/obj/item/reagent_containers/blood/attack(mob/M, mob/user, def_zone)
	if(reagents.total_volume > 0)
		if(user != M)
			user.visible_message(span_notice("[user] forces [M] to drink from the [src]."), \
							  	span_notice("You put the [src] up to [M]'s mouth."))
			if(!do_mob(user, M, 5 SECONDS))
				return
		else
			if(!do_mob(user, M, 1 SECONDS))
				return
			user.visible_message(span_notice("[user] puts the [src] up to their mouth."), \
		  		span_notice("You take a sip from the [src]."))
		// Safety: In case you spam clicked the blood bag on yourself, and it is now empty (below will divide by zero)
		if(reagents.total_volume <= 0)
			return
		var/gulp_size = 5
		reagents.trans_to(M, gulp_size, transfered_by = user, methods = INGEST)
		playsound(M.loc, 'sound/items/drink.ogg', rand(10,50), 1)
	..()

//////////////////////
//      HEART       //
//////////////////////

/// Do I have any parts that need replacing?
/* // Removed - Replaced with HealVampireOrgans()
/datum/antagonist/bloodsucker/proc/CheckVampOrgans()
	var/obj/item/organ/heart/O = owner.current.getorganslot(ORGAN_SLOT_HEART)
	if(!istype(O, /obj/item/organ/heart/vampheart) || !istype(O, /obj/item/organ/heart/demon) || !istype(O, /obj/item/organ/heart/cursed))
		qdel(O)
		var/obj/item/organ/heart/vampheart/H = new
		H.Insert(owner.current)
		/// Now... stop beating!
		H.Stop()
*/
/datum/antagonist/bloodsucker/proc/RemoveVampOrgans()
	var/obj/item/organ/heart/H = owner.current.getorganslot(ORGAN_SLOT_HEART)
	if(H)
		qdel(H)
	H = new()
	H.Insert(owner.current)

// 		HEART: OVERWRITE	//
// 		HEART 		//
/obj/item/organ/heart/vampheart
	beating = 0
	var/fakingit = 0

/obj/item/organ/heart/vampheart/Restart()
	beating = 0	// DONT run ..() -- We don't want to start beating again.
	return 0

/obj/item/organ/heart/vampheart/Stop()
	fakingit = 0
	return ..()

/obj/item/organ/heart/vampheart/proc/FakeStart()
	fakingit = 1 // We're pretending to beat, to fool people.

/// Bloodsuckers don't have a heartbeat at all when stopped (default is "an unstable")
/obj/item/organ/heart/vampheart/HeartStrengthMessage()
	if(fakingit)
		return "a healthy"
	return span_danger("no")

/// Proc for the default (Non-Bloodsucker) Heart!
/obj/item/organ/heart/proc/HeartStrengthMessage()
	if(beating)
		return "a healthy"
	return span_danger("an unstable")

//////////////////////
//      EYES        //
//////////////////////

/* /// Removed due to Mothpeople & Flypeople spawning with Vampiric eyes, getting them instantly lynched.
/// Taken from augmented_eyesight.dm
/obj/item/organ/eyes/bloodsucker
	lighting_alpha = 180 // LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE  <--- This is too low a value at 128. We need to SEE what the darkness is so we can hide in it.
	see_in_dark = 12
	sight_flags = SEE_MOBS // Bloodsuckers are predators, and detect life/heartbeats nearby. -2019 Breakdown of Bloodsuckers
	flash_protect = -1 // These eyes are weaker to flashes, but let you see in the dark
*/

/*
//////////////////////
//      LIVER       //
//////////////////////

/// Livers run on_life(), which calls reagents.metabolize() in holder.dm, which calls on_mob_life.dm in the cheam (medicine_reagents.dm)
/obj/item/organ/liver/vampliver
/obj/item/organ/liver/vampliver/on_life()
	var/mob/living/carbon/C = owner
	if(!istype(C))
		return
*/

//////////////////////
//      STAKES      //
//////////////////////

/*
 *	NOTE: sheet_types.dm is where the WOOD stack lives. Maybe move this over there.
 *	Taken from /obj/item/stack/rods/attackby in [rods.dm]
 */

/// Crafting
/obj/item/stack/sheet/mineral/wood/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		user.visible_message("[user] begins whittling [src] into a pointy object.", span_notice("You begin whittling [src] into a sharp point at one end."), "<span class='italics'>You hear wood carving.</span>")
		// 8 Second Timer
		if(!do_after(user, 8 SECONDS, src, NONE, TRUE))
			return
		// Make Stake
		var/obj/item/stake/new_item = new(user.loc)
		user.visible_message("[user] finishes carving a stake out of [src].", span_notice("You finish carving a stake out of [src]."))
		// Prepare to Put in Hands (if holding wood)
		var/obj/item/stack/sheet/mineral/wood/N = src
		var/replace = (user.get_inactive_held_item() == N)
		// Use Wood
		N.use(1)
		// If stack depleted, put item in that hand (if it had one)
		if(!N && replace)
			user.put_in_hands(new_item)
	if(istype(W, merge_type))
		var/obj/item/stack/S = W
		if(merge(S))
			to_chat(user, span_notice("Your [S.name] stack now contains [S.get_amount()] [S.singular_name]\s."))
	else
		. = ..()

/// Do I have a stake in my heart?
/mob/living/AmStaked()
	var/obj/item/bodypart/BP = get_bodypart(BODY_ZONE_CHEST)
	if(!BP)
		return FALSE
	for(var/obj/item/I in BP.embedded_objects)
		if(istype(I,/obj/item/stake))
			return TRUE
	return FALSE

/mob/proc/AmStaked()
	return FALSE

/// You can't go to sleep in a coffin with a stake in you.
/mob/living/proc/StakeCanKillMe()
	return IsSleeping() || stat >= UNCONSCIOUS || blood_volume <= 0 || HAS_TRAIT(src, TRAIT_NODEATH)

/obj/item/stake
	name = "wooden stake"
	desc = "A simple wooden stake carved to a sharp point."
	icon = 'fulp_modules/main_features/bloodsuckers/icons/stakes.dmi'
	icon_state = "wood"
	inhand_icon_state = "wood"
	lefthand_file = 'fulp_modules/main_features/bloodsuckers/icons/bs_leftinhand.dmi'
	righthand_file = 'fulp_modules/main_features/bloodsuckers/icons/bs_rightinhand.dmi'
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("staked", "stabbed", "tore into")
	attack_verb_simple = list("staked", "stabbed", "tore into")
	/// Embedding
	sharpness = SHARP_EDGED
	embedding = list("embed_chance" = 20)
	force = 6
	throwforce = 10
	max_integrity = 30
	/// Time it takes to embed the stake into someone's chest.
	var/staketime = 12 SECONDS

/obj/item/stake/afterattack(mob/living/target, mob/living/user, proximity, discover_after = TRUE)
	// Invalid Target, or not targetting the chest?
	if(!iscarbon(target) || check_zone(user.zone_selected) != BODY_ZONE_CHEST)
		return
	var/mob/living/carbon/C = target
	// Needs to be Down/Slipped in some way to Stake.
	if(!C.can_be_staked() || target == user) // Oops! Can't.
		to_chat(user, span_danger("You can't stake [target] when they are moving about! They have to be laying down or grabbed by the neck!"))
		return
	if(HAS_TRAIT(C, TRAIT_PIERCEIMMUNE))
		to_chat(user, span_danger("[target]'s chest resists the stake. It won't go in."))
		return
	to_chat(user, span_notice("You put all your weight into embedding the stake into [target]'s chest..."))
	playsound(user, 'sound/magic/Demon_consume.ogg', 50, 1)
	if(!do_mob(user, C, staketime, extra_checks = CALLBACK(C, /mob/living/carbon/proc/can_be_staked))) // user / target / time / uninterruptable / show progress bar / extra checks
		return
	// Drop & Embed Stake
	user.visible_message(span_danger("[user.name] drives the [src] into [target]'s chest!"), \
			 span_danger("You drive the [src] into [target]'s chest!"))
	playsound(get_turf(target), 'sound/effects/splat.ogg', 40, 1)
	user.dropItemToGround(src, TRUE) //user.drop_item() // "drop item" doesn't seem to exist anymore. New proc is user.dropItemToGround() but it doesn't seem like it's needed now?
	if(tryEmbed(target.get_bodypart(BODY_ZONE_CHEST), TRUE, TRUE)) //and if it embeds successfully in their chest, cause a lot of pain
		target.apply_damage(max(10, force*1.5), BRUTE, BODY_ZONE_CHEST, wound_bonus = 0, sharpness = TRUE)
		discover_after = FALSE
	if(QDELETED(src)) // in case trying to embed it caused its deletion (say, if it's DROPDEL)
		return
	if(C.mind)
		var/datum/antagonist/bloodsucker/bloodsucker = C.mind.has_antag_datum(/datum/antagonist/bloodsucker)
		if(bloodsucker)
			// If DEAD or TORPID...kill vamp!
			if(C.StakeCanKillMe()) // NOTE: This is the ONLY time a staked Torpid vamp dies.
				bloodsucker.FinalDeath()
				return
			else
				to_chat(target, span_userdanger("You have been staked! Your powers are useless, your death forever, while it remains in place."))

/// Can this target be staked? If someone stands up before this is complete, it fails. Best used on someone stationary.
/mob/living/carbon/proc/can_be_staked()
	return !(mobility_flags & MOBILITY_MOVE)

/// Created by welding and acid-treating a simple stake.
/obj/item/stake/hardened
	name = "hardened stake"
	desc = "A hardened wooden stake carved to a sharp point and scorched at the end."
	icon_state = "hardened"
	force = 8
	throwforce = 12
	armour_penetration = 10
	embedding = list("embed_chance" = 35)
	staketime = 80

/obj/item/stake/hardened/silver
	name = "silver stake"
	desc = "Polished and sharp at the end. For when some mofo is always trying to iceskate uphill."
	icon_state = "silver"
	inhand_icon_state = "silver"
	siemens_coefficient = 1 //flags = CONDUCT // var/siemens_coefficient = 1 // for electrical admittance/conductance (electrocution checks and shit)
	force = 9
	armour_penetration = 25
	embedding = list("embed_chance" = 65)
	staketime = 60

//////////////////////
//     ARCHIVES     //
//////////////////////

/*
 *	# Archives of the Kindred:
 *
 *	A book that can only be used by Curators and Tremere Bloodsuckers.
 *	When used on a player, after a short timer, will reveal if the player is a Bloodsucker, including their real name and Clan.
 *	This book should not work on Bloodsuckers using the Masquerade ability.
 *	If it reveals a Bloodsucker, the Curator will then be able to tell they are a Bloodsucker on examine (Like a Vassal).
 *	Reading it normally will allow Curators to read what each Clan does, with some extra flavor text ones.
 *
 *	Regular Bloodsuckers won't have any negative effects from the book, while everyone else will get burns/eye damage.
 *	It is also Tremere's Clan objective to ensure a Tremere Bloodsucker has stolen this by the end of the round.
 */

/obj/item/book/codex_gigas/Initialize(mapload)
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/item/book/kindred(T)

/obj/item/book/kindred
	name = "\improper Archive of the Kindred"
	title = "the Archive of the Kindred"
	desc = "Cryptic documents explaining hidden truths behind Undead beings. It is said only Curators can decipher what they really mean."
	icon = 'fulp_modules/main_features/bloodsuckers/icons/vamp_obj.dmi'
	lefthand_file = 'fulp_modules/main_features/bloodsuckers/icons/bs_leftinhand.dmi'
	righthand_file = 'fulp_modules/main_features/bloodsuckers/icons/bs_rightinhand.dmi'
	icon_state = "kindred_book"
	author = "dozens of generations of Curators"
	unique = TRUE
	throw_speed = 1
	throw_range = 10
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/in_use = FALSE

/*
 *	# Attacking someone with the Book
 */
// M is the person being hit here
/obj/item/book/kindred/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!user.can_read(src))
		return
	// Curator/Tremere using it
	if(HAS_TRAIT(user, TRAIT_BLOODSUCKER_HUNTER))
		if(in_use || (M == user))
			return
		user.visible_message(
			span_notice("[user] starts reading [src] while repeatedly looking up at [M]."),
			span_notice("[user] begins to quickly look through [src], repeatedly looking back up at you.")
		)
		in_use = TRUE
		if(!do_mob(user, M, 3 SECONDS, NONE, TRUE))
			to_chat(user, span_notice("You quickly close the book and move out of [M]'s way."))
			in_use = FALSE
			return
		in_use = FALSE
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(M)
		// Are we a Bloodsucker | Are we not part of a Clan | Are we on Masquerade. If any are true, they will fail.
		if(IS_BLOODSUCKER(M) && !bloodsuckerdatum?.poweron_masquerade)
			if(bloodsuckerdatum.my_clan != null)
				to_chat(user, span_warning("You found the one! [M], also known as '[bloodsuckerdatum.ReturnFullName(TRUE)]', is part of the [bloodsuckerdatum.my_clan]! You quickly note this information down, memorizing it."))
			else
				to_chat(user, span_warning("You found the one! [M], also known as '[bloodsuckerdatum.ReturnFullName(TRUE)]', is not knowingly part of a Clan. You quickly note this information down, memorizing it."))
			bloodsuckerdatum.Curator_Discovered = TRUE
		else
			to_chat(user, span_notice("You fail to draw any conclusions to [M] being a Bloodsucker."))
		return
	// Bloodsucker using it
	else if(IS_BLOODSUCKER(user))
		to_chat(user, span_notice("[src] seems to be too complicated for you. It would be best to leave this for someone else to take."))
		return
	to_chat(user, span_warning("[src] burns your hands as you try to use it!"))
	user.apply_damage(12, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))


/*
 *	# Reading the Book
 */
/obj/item/book/kindred/attack_self(mob/living/carbon/user)
//	Don't call parent since it handles reading the book.
//	. = ..()
	if(!user.can_read(src))
		return
	// Curator/Tremere using it
	if(HAS_TRAIT(user, TRAIT_BLOODSUCKER_HUNTER))
		user.visible_message(span_notice("[user] opens [src] and begins reading intently."))
		ui_interact(user)
		return
	// Bloodsucker using it
	else if(IS_BLOODSUCKER(user))
		to_chat(user, span_notice("[src] seems to be too complicated for you. It would be best to leave this for someone else to take."))
		return
	to_chat(user, span_warning("You feel your eyes burn as you begin to read through [src]!"))
	var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
	user.blur_eyes(10)
	eyes.applyOrganDamage(5)

/obj/item/book/kindred/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "KindredArchives", name)
		ui.open()

/obj/item/book/kindred/ui_act(action, params)
	if(..())
		return
	if(!action)
		return FALSE
	SStgui.close_uis(src)
	if(action == "search_brujah")
		INVOKE_ASYNC(src, .proc/search, usr, CLAN_BRUJAH)
	if(action == "search_toreador")
		INVOKE_ASYNC(src, .proc/search, usr, CLAN_TOREADOR)
	if(action == "search_nosferatu")
		INVOKE_ASYNC(src, .proc/search, usr, CLAN_NOSFERATU)
	if(action == "search_tremere")
		INVOKE_ASYNC(src, .proc/search, usr, CLAN_TREMERE)
	if(action == "search_gangrel")
		INVOKE_ASYNC(src, .proc/search, usr, CLAN_GANGREL)
	if(action == "search_ventrue")
		INVOKE_ASYNC(src, .proc/search, usr, CLAN_VENTRUE)
	if(action == "search_malkavian")
		INVOKE_ASYNC(src, .proc/search, usr, CLAN_MALKAVIAN)

/obj/item/book/kindred/proc/search(mob/reader, clan)
	dat = "<head>List of information gathered on the <b>[clan]</b>:</head><br>"
	if(clan == CLAN_BRUJAH)
		dat += "This Clan has proven to be the strongest in melee combat, boasting a <i>powerful punch</i>.<br> \
		They also appear to be more calm than the others, entering their 'Frenzies' earlier, but <i>still behaves as usual</i>.<br> \
		Be wary, as they are fearsome warriors, rebels and anarchists, with an inclination towards Frenzy.<br> \
		<b>Strength</b>: Frenzy will not kill them, punches deal a lot of damage.<br> \
		<b>Weakness</b>: They don't become immune to stuns from Frenzy alone."
	if(clan == CLAN_TOREADOR) // Flavortext only
		dat += "The most charming Clan of them all, being borderline <i>party animals</i>, allowing them to <i>very easily</i> disguise among the crew.<br> \
		They are more in touch with their <i>morals</i>, so they suffer and benefit more strongly from the humanity cost or gain of their actions.<br> \
		They can be best defined as 'The most humane kind of vampire', due to their kindred with an obsession with perfectionism and beauty<br> \
		<b>Strength</b>: Highly charismatic and influential.<br> \
		<b>Weakness</b>: Physically and Morally weak."
	if(clan == CLAN_NOSFERATU)
		dat += "This Clan has been the most obvious to find information about.<br> \
		They are <i>disfigured, ghoul-like</i> vampires upon embrace by their Sire, scouts that travel through desolate paths to avoid violating the Masquerade.<br> \
		They make <i>no attempts</i> at hiding themselves within the crew, and have a terrible taste for <i>heavy items</i>.<br> \
		They also seem to manage to fit themsleves into small spaces such as <i>vents</i>.<br> \
		<b>Strength</b>: Ventcrawl.<br> \
		<b>Weakness</b>: Can't disguise themselves, can easily be discovered by their DNA or Blood Level."
	if(clan == CLAN_TREMERE)
		dat += "This Clan seems to hate entering the <i>Chapel</i>.<br> \
		They are a secluded Clan, they are Vampires who've mastered the power of blood, and seek knowledge.<br> \
		They care not about their Vassals, going as far as to <i>dismember and deform</i> them however they see fit.<br> \
		Despite this, their Vassals pledge <i>complete obedience</i> to them no matter what, going as far as to resist Mindshields.<br> \
		They seem to be able to revive dead people using some torture device, something never-before seen.<br> \
		<b>Strength</b>: Vassal Mutilation, reviving the Dead.<br> \
		<b>Weakness</b>: Entering the Chapel sets them on fire, it is a safe place to run to if in combat against one."
	if(clan == CLAN_GANGREL) // Flavortext only
		dat += "This Clan seems to be closer to <i>Animals</i> than to other Vampires.<br> \
		They also go by the name of <i>Werewolves</i>, as that is what appears when they enter a Frenzy.<br> \
		Despite this, they appear to be scared of <i>'True Faith'</i>, someone's ultimate and undying Faith, which itself doesn't require being something Religious.<br> \
		They hate seeing many people, and tend to avoid Stations that have <i>more crewmembers than Nanotrasen's average</i>. Due to this, they are harder to find than others.<br> \
		<b>Strength</b>: Feral, Werewolf during Frenzy.<br> \
		<b>Weakness</b>: Weak to True Faith."
	if(clan == CLAN_VENTRUE)
		dat += "This Clan seems to <i>despise</i> drinking from non sentient organics.<br> \
		They are Masters of manipulation, Greedy and entitled. Authority figures between the kindred society.<br> \
		They seem to take their Vassal's lives <i>very seriously</i>, going as far as to give Vassals some of their own Blood.<br> \
		Compared to other types, this one <i>relies</i> on their Vassals, rather than fighting for themselves.<br> \
		<b>Strength</b>: Slowly turns a Vassal into a Bloodsucker.<br> \
		<b>Weakness</b>: Does not gain more abilities overtime, it is best to target the Bloodsucker over the Vassal."
	if(clan == CLAN_MALKAVIAN)
		dat += "There is barely any information known about this Clan.<br> \
		Members of this Clan seems to <i>mumble things to themselves</i>, unaware of their surroundings.<br> \
		They also seem to enter and dissapear into areas randomly, <i>as if not even they know where they are</i>.<br> \
		<b>Strength</b>: Unknown.<br> \
		<b>Weakness</b>: Unknown."

	reader << browse("<meta charset=UTF-8><TT><I>Penned by [author].</I></TT> <BR>" + "[dat]", "window=book[window_size != null ? ";size=[window_size]" : ""]")
