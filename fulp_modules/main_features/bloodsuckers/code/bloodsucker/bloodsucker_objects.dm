//////////////////////
//     BLOODBAG     //
//////////////////////

/// Taken from drinks.dm
/obj/item/reagent_containers/blood/attack(mob/M, mob/user, def_zone)
	if(reagents.total_volume > 0)
		if(user != M)
			user.visible_message("<span class='notice'>[user] forces [M] to drink from the [src].</span>", \
							  	"<span class='notice'>You put the [src] up to [M]'s mouth.</span>")
			if(!do_mob(user, M, 5 SECONDS))
				return
		else
			if(!do_mob(user, M, 1 SECONDS))
				return
			user.visible_message("<span class='notice'>[user] puts the [src] up to their mouth.</span>", \
		  		"<span class='notice'>You take a sip from the [src].</span>")
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

/datum/antagonist/bloodsucker/proc/CheckVampOrgans()
	// Do I have any parts that need replacing?
	var/obj/item/organ/O
	// Heart
	O = owner.current.getorganslot(ORGAN_SLOT_HEART)
	if(!istype(O, /obj/item/organ/heart/vampheart) && !istype(O, /obj/item/organ/heart/demon))
		qdel(O)
		var/obj/item/organ/heart/vampheart/H = new
		H.Insert(owner.current)
		H.Stop() // Now... stop beating!
	// Tongue
	O = owner.current.getorganslot(ORGAN_SLOT_TONGUE)
	if(!istype(O, /obj/item/organ/tongue/bloodsucker))
		qdel(O)
		var/obj/item/organ/tongue/bloodsucker/E = new
		E.Insert(owner.current)

/datum/antagonist/bloodsucker/proc/RemoveVampOrgans()
	// Heart
	var/obj/item/organ/heart/H = new
	H.Insert(owner.current)
	// Tongue
	var/obj/item/organ/tongue/O = new
	O.Insert(owner.current)

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
	return "<span class='danger'>no</span>"

/// Proc for the default (Non-Bloodsucker) Heart!
/obj/item/organ/heart/proc/HeartStrengthMessage()
	if(beating)
		return "a healthy"
	return "<span class='danger'>an unstable</span>"

//////////////////////
//      EYES        //
//////////////////////
/* // Removed due to Mothpeople spawning with Vampiric eyes and instantly getting lynched.
/// Taken from augmented_eyesight.dm
/obj/item/organ/eyes/bloodsucker
	lighting_alpha = 180 // LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE  <--- This is too low a value at 128. We need to SEE what the darkness is so we can hide in it.
	see_in_dark = 12
	sight_flags = SEE_MOBS // Bloodsuckers are predators, and detect life/heartbeats nearby. - 2019 Breakdown of Bloodsuckers
	flash_protect = -1 // These eyes are weaker to flashes, but let you see in the dark
*/

//////////////////////
//     TONGUE       //
//////////////////////

/obj/item/organ/tongue/bloodsucker
	sense_of_taste = FALSE
	var/static/list/languages_possible_bloodsucker = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/vampiric,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/nekomimetic,
		/datum/language/buzzwords,
	))

/obj/item/organ/tongue/bloodsucker/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_bloodsucker

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

/// NOTE: sheet_types.dm is where the WOOD stack lives. Maybe move this over there.
/// Taken from /obj/item/stack/rods/attackby in [rods.dm]
/// Crafting the stake!
/obj/item/stack/sheet/mineral/wood/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		user.visible_message("[user] begins whittling [src] into a pointy object.", \
				 "<span class='notice'>You begin whittling [src] into a sharp point at one end.</span>", \
				 "<span class='italics'>You hear wood carving.</span>")
		// 8 Second Timer
		if(!do_after(user, 8 SECONDS, src, NONE, TRUE))
			return
		// Make Stake
		var/obj/item/stake/new_item = new(user.loc)
		user.visible_message("[user] finishes carving a stake out of [src].", \
				 "<span class='notice'>You finish carving a stake out of [src].</span>")
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
			to_chat(user, "<span class='notice'>Your [S.name] stack now contains [S.get_amount()] [S.singular_name]\s.</span>")
	else
		. = ..()

/// Do I have a stake in my heart?
/mob/living/AmStaked()
	var/obj/item/bodypart/BP = get_bodypart("chest")
	if(!BP)
		return FALSE
	for(var/obj/item/I in BP.embedded_objects)
		if(istype(I,/obj/item/stake))
			return TRUE
	return FALSE

/mob/proc/AmStaked()
	return FALSE

/// NOTE: You can't go to sleep in a coffin with a stake in you.
/mob/living/proc/StakeCanKillMe()
	return IsSleeping() || stat >= UNCONSCIOUS || blood_volume <= 0 || HAS_TRAIT(src, TRAIT_FAKEDEATH)

/obj/item/stake
	name = "wooden stake"
	desc = "A simple wooden stake carved to a sharp point."
	icon = 'fulp_modules/main_features/bloodsuckers/icons/stakes.dmi'
	icon_state = "wood"
	inhand_icon_state = "wood"
	lefthand_file = 'fulp_modules/main_features/bloodsuckers/icons/stake_leftinhand.dmi'
	righthand_file = 'fulp_modules/main_features/bloodsuckers/icons/stake_rightinhand.dmi'
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
	var/staketime = 12 SECONDS // Time it takes to embed the stake into someone's chest.

/obj/item/stake/afterattack(mob/living/target, mob/living/user, proximity, discover_after = TRUE)
	// Invalid Target, or not targetting the chest?
	if(!iscarbon(target) || check_zone(user.zone_selected) != "chest")
		return
	var/mob/living/carbon/C = target
	// Needs to be Down/Slipped in some way to Stake.
	if(!C.can_be_staked() || target == user) // Oops! Can't.
		to_chat(user, "<span class='danger'>You can't stake [target] when they are moving about! They have to be laying down or grabbed by the neck!</span>")
		return
	if(HAS_TRAIT(C, TRAIT_PIERCEIMMUNE))
		to_chat(user, "<span class='danger'>[target]'s chest resists the stake. It won't go in.</span>")
		return
	to_chat(user, "<span class='notice'>You put all your weight into embedding the stake into [target]'s chest...</span>")
	playsound(user, 'sound/magic/Demon_consume.ogg', 50, 1)
	if(!do_mob(user, C, staketime, extra_checks=CALLBACK(C, /mob/living/carbon/proc/can_be_staked))) // user / target / time / uninterruptable / show progress bar / extra checks
		return
	// Drop & Embed Stake
	user.visible_message("<span class='danger'>[user.name] drives the [src] into [target]'s chest!</span>", \
			 "<span class='danger'>You drive the [src] into [target]'s chest!</span>")
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
				to_chat(target, "<span class='userdanger'>You have been staked! Your powers are useless, your death forever, while it remains in place.</span>")

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
