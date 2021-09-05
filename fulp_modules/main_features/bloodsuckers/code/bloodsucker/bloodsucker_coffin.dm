/datum/antagonist/bloodsucker/proc/ClaimCoffin(obj/structure/closet/crate/claimed)
	// ALREADY CLAIMED
	if(claimed.resident)
		if(claimed.resident == owner.current)
			to_chat(owner, "This is your [src].")
		else
			to_chat(owner, "This [src] has already been claimed by another.")
		return FALSE
	if(!(/datum/crafting_recipe/vassalrack in owner?.learned_recipes))
		owner.teach_crafting_recipe(/datum/crafting_recipe/vassalrack)
		owner.teach_crafting_recipe(/datum/crafting_recipe/candelabrum)
		owner.teach_crafting_recipe(/datum/crafting_recipe/bloodthrone)
		owner.teach_crafting_recipe(/datum/crafting_recipe/meatcoffin)
		owner.current.balloon_alert(owner.current, "new recipes learned!")
		to_chat(owner, span_danger("You learned new recipes - You can view them in the Tribal section of the crafting menu!"))
	// This is my Lair
	coffin = claimed
	lair = get_area(claimed)
	to_chat(owner, span_userdanger("You have claimed the [claimed] as your place of immortal rest! Your lair is now [lair]."))
	to_chat(owner, span_announce("Bloodsucker Tip: Find new lair recipes in the Misc tab of the <i>Crafting Menu</i>, including the <i>Persuasion Rack</i> for converting crew into Vassals."))
	return TRUE

/// From crate.dm
/obj/structure/closet/crate
	var/mob/living/resident /// This lets bloodsuckers claim any "crate" as a Coffin.
	var/pryLidTimer = 25 SECONDS
	breakout_time = 20 SECONDS

/obj/structure/closet/crate/coffin/examine(mob/user)
	. = ..()
	if(user == resident)
		. += span_cult("This is your Claimed Coffin.")
		. += span_cult("Rest in it while injured to enter Torpor. Entering it with unspent Ranks will allow you to spend one.")
		. += span_cult("Alt Click while inside the Coffin to Lock/Unlock.")
		. += span_cult("Alt Click while outside of your Coffin to Unclaim it, unwrenching it and all your other structures as a result.")

/obj/structure/closet/crate/coffin/blackcoffin
	name = "black coffin"
	desc = "For those departed who are not so dear."
	icon_state = "coffin"
	icon = 'fulp_modules/main_features/bloodsuckers/icons/vamp_obj.dmi'
	open_sound = 'fulp_modules/main_features/bloodsuckers/sounds/coffin_open.ogg'
	close_sound = 'fulp_modules/main_features/bloodsuckers/sounds/coffin_close.ogg'
	breakout_time = 30 SECONDS
	pryLidTimer = 20 SECONDS
	resistance_flags = NONE
	material_drop = /obj/item/stack/sheet/iron
	material_drop_amount = 2
	armor = list(MELEE = 50, BULLET = 20, LASER = 30, ENERGY = 0, BOMB = 50, BIO = 0, RAD = 0, FIRE = 70, ACID = 60)

/obj/structure/closet/crate/coffin/securecoffin
	name = "secure coffin"
	desc = "For those too scared of having their place of rest disturbed."
	icon_state = "securecoffin"
	icon = 'fulp_modules/main_features/bloodsuckers/icons/vamp_obj.dmi'
	open_sound = 'fulp_modules/main_features/bloodsuckers/sounds/coffin_open.ogg'
	close_sound = 'fulp_modules/main_features/bloodsuckers/sounds/coffin_close.ogg'
	breakout_time = 35 SECONDS
	pryLidTimer = 35 SECONDS
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF
	material_drop = /obj/item/stack/sheet/iron
	material_drop_amount = 2
	armor = list(MELEE = 35, BULLET = 20, LASER = 20, ENERGY = 0, BOMB = 100, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)

/obj/structure/closet/crate/coffin/meatcoffin
	name = "meat coffin"
	desc = "When you're ready to meat your maker, the steaks can never be too high."
	icon_state = "meatcoffin"
	icon = 'fulp_modules/main_features/bloodsuckers/icons/vamp_obj.dmi'
	resistance_flags = FIRE_PROOF
	open_sound = 'sound/effects/footstep/slime1.ogg'
	close_sound = 'sound/effects/footstep/slime1.ogg'
	breakout_time = 25 SECONDS
	pryLidTimer = 20 SECONDS
	material_drop = /obj/item/food/meat/slab/human
	material_drop_amount = 3
	armor = list(MELEE = 70, BULLET = 10, LASER = 10, ENERGY = 0, BOMB = 70, BIO = 0, RAD = 0, FIRE = 70, ACID = 60)

/obj/structure/closet/crate/coffin/metalcoffin
	name = "metal coffin"
	desc = "A big metal sardine can inside of another big metal sardine can, in space."
	icon_state = "metalcoffin"
	icon = 'fulp_modules/main_features/bloodsuckers/icons/vamp_obj.dmi'
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	open_sound = 'sound/effects/pressureplate.ogg'
	close_sound = 'sound/effects/pressureplate.ogg'
	breakout_time = 25 SECONDS
	pryLidTimer = 30 SECONDS
	material_drop = /obj/item/stack/sheet/iron
	material_drop_amount = 5
	armor = list(MELEE = 40, BULLET = 15, LASER = 50, ENERGY = 0, BOMB = 10, BIO = 0, RAD = 0, FIRE = 70, ACID = 60)

//////////////////////////////////////////////

/// NOTE: This can be any coffin that you are resting AND inside of.
/obj/structure/closet/crate/coffin/proc/ClaimCoffin(mob/living/claimant)
	// Bloodsucker Claim
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = claimant.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(bloodsuckerdatum)
		// Successfully claimed?
		if(bloodsuckerdatum.ClaimCoffin(src))
			resident = claimant
			anchored = TRUE
			START_PROCESSING(SSprocessing, src)

/obj/structure/closet/crate/coffin/Destroy()
	UnclaimCoffin()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/structure/closet/crate/coffin/process(mob/living/user)
	if(!..())
		return FALSE
	if(user in src)
		var/datum/antagonist/bloodsucker/B = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
		if(!B)
			return
		if(B.lair != get_area(B.coffin))
			if(B.coffin)
				B.coffin.UnclaimCoffin()
		var/list/turf/area_turfs = get_area_turfs(B.lair)
		// Create Dirt etc.
		var/turf/T_Dirty = pick(area_turfs)
		if(T_Dirty && !T_Dirty.density)
			// Default: Dirt
			// CHECK: Cobweb already there?
			//if (!locate(var/obj/effect/decal/cleanable/cobweb) in T_Dirty)	// REMOVED! Cleanables don't stack.
			// STEP ONE: COBWEBS
			// CHECK: Wall to North?
			var/turf/check_N = get_step(T_Dirty, NORTH)
			if(istype(check_N, /turf/closed/wall))
				// CHECK: Wall to West?
				var/turf/check_W = get_step(T_Dirty, WEST)
				if(istype(check_W, /turf/closed/wall))
					new /obj/effect/decal/cleanable/cobweb (T_Dirty)
				// CHECK: Wall to East?
				var/turf/check_E = get_step(T_Dirty, EAST)
				if(istype(check_E, /turf/closed/wall))
					new /obj/effect/decal/cleanable/cobweb/cobweb2 (T_Dirty)
			// STEP TWO: DIRT
			new /obj/effect/decal/cleanable/dirt (T_Dirty)
		// Find Animals in Area
/*		if(rand(0,2) == 0)
			var/mobCount = 0
			var/mobMax = clamp(area_turfs.len / 25, 1, 4)
			for(var/turf/T in area_turfs)
				if(!T) continue
				var/mob/living/simple_animal/SA = locate() in T
				if(SA)
					mobCount ++
					if (mobCount >= mobMax) // Already at max
						break
				Spawn One
			if(mobCount < mobMax)
				 Seek Out Location
				while(area_turfs.len > 0)
					var/turf/T = pick(area_turfs) // We use while&pick instead of a for/loop so it's random, rather than from the top of the list.
					if(T && !T.density)
						var/mob/living/simple_animal/SA = /mob/living/simple_animal/mouse // pick(/mob/living/simple_animal/mouse,/mob/living/simple_animal/mouse,/mob/living/simple_animal/mouse, /mob/living/simple_animal/hostile/retaliate/bat) //prob(300) /mob/living/simple_animal/mouse,
						new SA (T)
						break
					area_turfs -= T*/

/obj/structure/closet/crate/proc/UnclaimCoffin(manual = FALSE)
	// Unanchor it (If it hasn't been broken, anyway)
	anchored = FALSE
	if(resident)
		// Unclaiming
		if(resident.mind)
			var/datum/antagonist/bloodsucker/bloodsuckerdatum = resident.mind.has_antag_datum(/datum/antagonist/bloodsucker)
			if(bloodsuckerdatum && bloodsuckerdatum.coffin == src)
				bloodsuckerdatum.coffin = null
				bloodsuckerdatum.lair = null
			for(var/obj/structure/bloodsucker/bloodsucker_structure in get_area(src))
				if(bloodsucker_structure.owner == resident)
					bloodsucker_structure.unbolt()
			if(manual)
				to_chat(resident, span_cultitalic("You have unclaimed your coffin! This also unclaims all your other Bloodsucker structures!"))
			else
				to_chat(resident, span_cultitalic("You sense that the link with your coffin and your sacred lair, has been broken! You will need to seek another."))
		resident = null // Remove resident. Because this object isnt removed from the game immediately (GC?) we need to give them a way to see they don't have a home anymore.

/// You cannot lock in/out a coffin's owner. SORRY.
/obj/structure/closet/crate/coffin/can_open(mob/living/user)
	if(locked)
		if(user == resident)
			if(welded)
				welded = FALSE
				update_icon()
			locked = FALSE
			return 1
		else
			playsound(get_turf(src), 'sound/machines/door_locked.ogg', 20, 1)
			to_chat(user, span_notice("[src] is locked tight from the inside."))
	return ..()

/obj/structure/closet/crate/coffin/close(mob/living/user)
	if(!..())
		return FALSE
	// Only the User can put themself into Torpor. If already in it, you'll start to heal.
	if(user in src)
		if(!IS_BLOODSUCKER(user))
			return FALSE
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
		LockMe(user)
		if(!bloodsuckerdatum.coffin && !resident)
			switch(tgui_alert(user,"Do you wish to claim this as your coffin? [get_area(src)] will be your lair.","Claim Lair", list("Yes", "No")))
				if("Yes")
					ClaimCoffin(user)
		/// Level up? Auto-Fails if not appropriate - Ventrue cannot level up in a Coffin.
		if(bloodsuckerdatum.my_clan != CLAN_VENTRUE)
			bloodsuckerdatum.SpendRank()
		/// You're in a Coffin, everything else is done, you're likely here to heal. Let's offer them the oppertunity to do so.
		bloodsuckerdatum.Check_Begin_Torpor()
	return TRUE

/// You cannot weld or deconstruct an owned coffin. Only the owner can destroy their own coffin.
/obj/structure/closet/crate/coffin/attackby(obj/item/W, mob/user, params)
	if(resident)
		if(user != resident)
			if(istype(W, cutting_tool))
				to_chat(user, span_notice("This is a much more complex mechanical structure than you thought. You don't know where to begin cutting [src]."))
				return
		if(anchored && istype(W, /obj/item/wrench))
			to_chat(user, span_danger("The coffin won't come unanchored from the floor.[user == resident ? " You can Alt Click to unclaim and unwrench your Coffin." : ""]"))
			return

	if(locked && istype(W, /obj/item/crowbar))
		var/pry_time = pryLidTimer * W.toolspeed // Pry speed must be affected by the speed of the tool.
		user.visible_message(span_notice("[user] tries to pry the lid off of [src] with [W]."), \
							  span_notice("You begin prying the lid off of [src] with [W]. This should take about [DisplayTimeText(pry_time)]."))
		if(!do_mob(user, src, pry_time))
			return
		bust_open()
		user.visible_message(span_notice("[user] snaps the door of [src] wide open."), \
							  span_notice("The door of [src] snaps open."))
		return
	. = ..()

/// Distance Check (Inside Of)
/obj/structure/closet/crate/coffin/AltClick(mob/user)
	. = ..()
	if(user in src)
		LockMe(user, !locked)

	else if(user == resident && user.Adjacent(src))
		balloon_alert(user, "unclaim coffin?")
		var/list/unclaim_options = list(
			"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
			"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no")
			)
		var/unclaim_response = show_radial_menu(user, src, unclaim_options, radius = 36, require_near = TRUE)
		switch(unclaim_response)
			if("Yes")
				UnclaimCoffin(TRUE)

/obj/structure/closet/crate/proc/LockMe(mob/user, inLocked = TRUE)
	if(user == resident)
		if(!broken)
			locked = inLocked
			to_chat(user, span_notice("You flip a secret latch and [locked?"":"un"]lock yourself inside [src]."))
		else
			to_chat(resident, span_notice("The secret latch to lock [src] from the inside is broken. You set it back into place..."))
			if(do_mob(resident, src, 5 SECONDS))
				if(broken) // Spam Safety
					to_chat(resident, span_notice("You fix the mechanism and lock it."))
					broken = FALSE
					locked = TRUE
