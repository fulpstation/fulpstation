//////////////////////
//     BLOODBAG     //
//////////////////////
/obj/item/reagent_containers/blood/attack(mob/M, mob/user, def_zone)
	if(reagents.total_volume > 0) // TO DO: ADD HELP INTENT ONCE COMBAT MODE IS MERGED
		if(user != M)
			user.visible_message("<span class='notice'>[user] forces [M] to drink from the [src].</span>", \
							  	"<span class='notice'>You put the [src] up to [M]'s mouth.</span>")
			if(!do_mob(user, M, 50))
				return
		else
			if(!do_mob(user, M, 10))
				return
			user.visible_message("<span class='notice'>[user] puts the [src] up to their mouth.</span>", \
		  		"<span class='notice'>You take a sip from the [src].</span>")
		// Safety: In case you spam clicked the blood bag on yourself, and it is now empty (below will divide by zero)
		if(reagents.total_volume <= 0)
			return
		// Taken from drinks.dm
		var/gulp_size = 5
		reagents.trans_to(M, gulp_size, transfered_by = user, methods = INGEST)
		playsound(M.loc,'sound/items/drink.ogg', rand(10,50), 1)
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
		H.Stop() // Now...stop beating!
	// Eyes
	O = owner.current.getorganslot(ORGAN_SLOT_EYES)
	if(!istype(O, /obj/item/organ/eyes/vassal/bloodsucker))
		qdel(O)
		var/obj/item/organ/eyes/vassal/bloodsucker/E = new
		E.Insert(owner.current)

/datum/antagonist/bloodsucker/proc/RemoveVampOrgans()
	// Heart
	var/obj/item/organ/heart/H = new
	H.Insert(owner.current)
	// Eyes
	var/obj/item/organ/eyes/E = new
	E.Insert(owner.current)

// 		HEART: OVERWRITE	//
// 		HEART 		//

/obj/item/organ/heart/vampheart
	beating = 0
	var/fakingit = 0

/obj/item/organ/heart/vampheart/Restart()
	beating = 0	// DONT run ..(). We don't want to start beating again.
	return 0

/obj/item/organ/heart/vampheart/Stop()
	fakingit = 0
	return ..()

/obj/item/organ/heart/vampheart/proc/FakeStart()
	fakingit = 1 // We're pretending to beat, to fool people.

/obj/item/organ/heart/vampheart/HeartStrengthMessage()
	if(fakingit)
		return "a healthy"
	return "<span class='danger'>no</span>"	// Bloodsuckers don't have a heartbeat at all when stopped (default is "an unstable")

/obj/item/organ/heart/proc/HeartStrengthMessage() // Proc for the default (Non-Bloodsucker) Heart!
	if(beating)
		return "a healthy"
	return "<span class='danger'>an unstable</span>"

//////////////////////
//      EYES        //
//////////////////////
/obj/item/organ/eyes/vassal/
	lighting_alpha = 180 //  LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE  <--- This is too low a value at 128. We need to SEE what the darkness is so we can hide in it.
	see_in_dark = 12
	flash_protect = -1 //These eyes are weaker to flashes, but let you see in the dark

/obj/item/organ/eyes/vassal/bloodsucker
	flash_protect = 2 //Eye healing isnt working properly
	sight_flags = SEE_MOBS // Taken from augmented_eyesight.dm

/*
//////////////////////
//      LIVER       //
//////////////////////
/obj/item/organ/liver/vampliver
	// Livers run on_life(), which calls reagents.metabolize() in holder.dm, which calls on_mob_life.dm in the cheam (medicine_reagents.dm)
/obj/item/organ/liver/vampliver/on_life()
	var/mob/living/carbon/C = owner
	if(!istype(C))
		return
*/

//////////////////////
//      STAKES      //
//////////////////////
// Crafting the stake!

/obj/item/stack/sheet/mineral/wood/attackby(obj/item/W, mob/user, params) // NOTE: sheet_types.dm is where the WOOD stack lives. Maybe move this over there.
	// Taken from /obj/item/stack/rods/attackby in [rods.dm]
	if(W.get_sharpness())
		user.visible_message("[user] begins whittling [src] into a pointy object.", \
				 "<span class='notice'>You begin whittling [src] into a sharp point at one end.</span>", \
				 "<span class='italics'>You hear wood carving.</span>")
		// 8 Second Timer
		if(!do_after(user, 80, TRUE, src))
			return
		// Make Stake
		var/obj/item/stake/basic/new_item = new(user.loc)
		user.visible_message("[user] finishes carving a stake out of [src].", \
				 "<span class='notice'>You finish carving a stake out of [src].</span>")
		// Prepare to Put in Hands (if holding wood)
		var/obj/item/stack/sheet/mineral/wood/N = src
		var/replace = (user.get_inactive_held_item() == N)
		// Use Wood
		N.use(1)
		// If stack depleted, put item in that hand (if it had one)
		if (!N && replace)
			user.put_in_hands(new_item)
	if(istype(W, merge_type))
		var/obj/item/stack/S = W
		if(merge(S))
			to_chat(user, "<span class='notice'>Your [S.name] stack now contains [S.get_amount()] [S.singular_name]\s.</span>")
	else
		. = ..()

// Do I have a stake in my heart?
/mob/living/AmStaked()
	var/obj/item/bodypart/BP = get_bodypart("chest")
	if (!BP)
		return FALSE
	for(var/obj/item/I in BP.embedded_objects)
		if (istype(I,/obj/item/stake/))
			return TRUE
	return FALSE

/mob/proc/AmStaked()
	return FALSE

/mob/living/proc/StakeCanKillMe()
	return IsSleeping() || stat >= UNCONSCIOUS || blood_volume <= 0 || HAS_TRAIT(src, TRAIT_DEATHCOMA) // NOTE: You can't go to sleep in a coffin with a stake in you.

/obj/item/stake
	name = "wooden stake"
	desc = "A simple wooden stake carved to a sharp point."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "wood" // Inventory Icon
	inhand_icon_state = "wood" // In-hand Icon
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi' // File for in-hand icon
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	attack_verb_continuous = list("staked", "stabbed", "tore into")
	attack_verb_simple = list("staked", "stabbed", "tore into")
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	hitsound = 'sound/weapons/bladeslice.ogg'
	force = 6
	throwforce = 10
	embedding = list("embed_chance" = 25, "fall_chance" = 0.5) // UPDATE 2/10/18 embedding_behavior.dm is how this is handled
	//embed_chance = 25  // Look up "is_pointed" to see where we set stakes able to do this.
	//embedded_fall_chance = 0.5 // Chance it will fall out.
	obj_integrity = 30
	max_integrity = 30
	//embedded_fall_pain_multiplier
	var/staketime = 120		// Time it takes to embed the stake into someone's chest.

/obj/item/stake/basic
	name = "wooden stake"
	// This exists so Hardened/Silver Stake can't have a welding torch used on them.

/obj/item/stake/basic/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/weldingtool))
		//if (amWelded)
		//	to_chat(user, "<span class='warning'>This stake has already been treated with fire.</span>")
		//	return
		//amWelded = TRUE
		// Weld it
		var/obj/item/weldingtool/WT = W
		if(WT.use(0))//remove_fuel(0,user))
			user.visible_message("[user.name] scorched the pointy end of [src] with the welding tool.", \
						 "<span class='notice'>You scorch the pointy end of [src] with the welding tool.</span>", \
						 "<span class='italics'>You hear welding.</span>")
		// 8 Second Timer
		if(!do_mob(user, src, 80))
			return
		// Create the Stake
		qdel(src)
		var/obj/item/stake/hardened/new_item = new(usr.loc)
		user.put_in_hands(new_item)
	else
		return ..()

/obj/item/stake/afterattack(atom/target, mob/user, proximity)
	//to_chat(world, "<span class='notice'>DEBUG: Staking </span>")
	// Invalid Target, or not targetting chest with HARM intent?
	if(!iscarbon(target) || check_zone(user.zone_selected) != "chest" || user.a_intent != INTENT_HARM)
		return
	var/mob/living/carbon/C = target
	// Needs to be Down/Slipped in some way to Stake.
	if(!C.can_be_staked() || target == user)
		to_chat(user, "<span class='danger'>You can't stake [target] when they are moving about! They have to be laying down or grabbed by the neck!</span>")
		return
			// Oops! Can't.
	if(HAS_TRAIT(C, TRAIT_PIERCEIMMUNE))
		to_chat(user, "<span class='danger'>[target]'s chest resists the stake. It won't go in.</span>")
		return
	// Make Attempt...
	to_chat(user, "<span class='notice'>You put all your weight into embedding the stake into [target]'s chest...</span>")
	playsound(user, 'sound/magic/Demon_consume.ogg', 50, 1)
	if(!do_mob(user, C, staketime, 0, 1, extra_checks=CALLBACK(C, /mob/living/carbon/proc/can_be_staked))) // user / target / time / uninterruptable / show progress bar / extra checks
		return
	// Drop & Embed Stake
	user.visible_message("<span class='danger'>[user.name] drives the [src] into [target]'s chest!</span>", \
			 "<span class='danger'>You drive the [src] into [target]'s chest!</span>")
	playsound(get_turf(target), 'sound/effects/splat.ogg', 40, 1)
	user.dropItemToGround(src, TRUE) //user.drop_item() // "drop item" doesn't seem to exist anymore. New proc is user.dropItemToGround() but it doesn't seem like it's needed now?
	var/obj/item/bodypart/B = C.get_bodypart("chest")  // This was all taken from hitby() in human_defense.dm
	B.embedded_objects |= src
	embedded()
	add_mob_blood(target)//Place blood on the stake
	loc = C // Put INSIDE the character
	B.receive_damage(w_class * embedding["pain_mult"])
	if(C.mind)
		var/datum/antagonist/bloodsucker/bloodsucker = C.mind.has_antag_datum(/datum/antagonist/bloodsucker)
		if(bloodsucker)
			// If DEAD or TORPID...kill vamp!
			if(C.StakeCanKillMe()) // NOTE: This is the ONLY time a staked Torpid vamp dies.
				bloodsucker.FinalDeath()
				return
			else
				to_chat(target, "<span class='userdanger'>You have been staked! Your powers are useless, your death forever, while it remains in place.</span>")
				to_chat(user, "<span class='warning'>You missed [C.p_their(TRUE)]'s heart! It would be easier if [C.p_they(TRUE)] weren't struggling so much.</span>")

// Can this target be staked? If someone stands up before this is complete, it fails. Best used on someone stationary.
/mob/living/carbon/proc/can_be_staked()
	return !(mobility_flags & MOBILITY_MOVE)

/obj/item/stake/hardened
	// Created by welding and acid-treating a simple stake.
	name = "hardened stake"
	desc = "A hardened wooden stake carved to a sharp point and scorched at the end."
	icon_state = "hardened" // Inventory Icon
	force = 8
	throwforce = 12
	armour_penetration = 10
	embedding = list("embed_chance" = 50, "fall_chance" = 0)
	obj_integrity = 120
	max_integrity = 120

	staketime = 80

/obj/item/stake/hardened/silver
	name = "silver stake"
	desc = "Polished and sharp at the end. For when some mofo is always trying to iceskate uphill."
	icon_state = "silver" // Inventory Icon
	inhand_icon_state = "silver" // In-hand Icon
	siemens_coefficient = 1 //flags = CONDUCT // var/siemens_coefficient = 1 // for electrical admittance/conductance (electrocution checks and shit)
	force = 9
	armour_penetration = 25
	embedding = list("embed_chance" = 65)
	obj_integrity = 300
	max_integrity = 300

	staketime = 60

// Convert back to Silver
/obj/item/stake/hardened/silver/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weldingtool))
		var/obj/item/weldingtool/WT = I
		if(WT.use(0))//remove_fuel(0, user))
			var/obj/item/stack/sheet/mineral/silver/newsheet = new (user.loc)
			for(var/obj/item/stack/sheet/mineral/silver/S in user.loc)
				if(S == newsheet)
					continue
				if(S.amount >= S.max_amount)
					continue
				S.attackby(newsheet, user)
			to_chat(user, "<span class='notice'>You melt down the stake and add it to the stack. It now contains [newsheet.amount] sheet\s.</span>")
			qdel(src)
	else
		return ..()
