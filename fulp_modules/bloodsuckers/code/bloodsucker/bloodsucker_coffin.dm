/// NOTE: This can be any "closet" that you are resting AND inside of.
/datum/antagonist/bloodsucker/proc/ClaimCoffin(obj/structure/closet/crate/claimed)
	// ALREADY CLAIMED
	if(claimed.resident)
		if(claimed.resident == owner.current)
			to_chat(owner, "This is your [src].")
		else
			to_chat(owner, "This [src] has already been claimed by another.")
		return FALSE
	owner.teach_crafting_recipe(/datum/crafting_recipe/vassalrack)
	owner.teach_crafting_recipe(/datum/crafting_recipe/candelabrum)
	owner.teach_crafting_recipe(/datum/crafting_recipe/meatcoffin)
	// This is my Lair
	coffin = claimed
	lair = get_area(claimed)
	to_chat(owner, "<span class='userdanger'>You have claimed the [claimed] as your place of immortal rest! Your lair is now [lair].</span>")
	to_chat(owner, "<span class='danger'>You have learned new construction recipes to improve your lair.</span>")
	to_chat(owner, "<span class='announce'>Bloodsucker Tip: Find new lair recipes in the Misc tab of the <i>Crafting Menu</i>, including the <i>Persuasion Rack</i> for converting crew into Vassals.</span><br><br>")
	RunLair()
	return TRUE

/// From crate.dm
/obj/structure/closet/crate
	var/mob/living/resident	// This lets bloodsuckers claim any "closet" as a Coffin.
	var/pryLidTimer = 250
	breakout_time = 200

/obj/structure/closet/crate/coffin/blackcoffin
	name = "black coffin"
	desc = "For those departed who are not so dear."
	icon_state = "coffin"
	icon = 'fulp_modules/bloodsuckers/icons/vamp_obj.dmi'
	open_sound = 'fulp_modules/bloodsuckers/sounds/coffin_open.ogg'
	close_sound = 'fulp_modules/bloodsuckers/sounds/coffin_close.ogg'
	breakout_time = 600
	pryLidTimer = 400
	resistance_flags = NONE
	material_drop = /obj/item/stack/sheet/iron
	material_drop_amount = 2
	armor = list(MELEE = 50, BULLET = 20, LASER = 30, ENERGY = 0, BOMB = 50, BIO = 0, RAD = 0, FIRE = 70, ACID = 60)

/obj/structure/closet/crate/coffin/meatcoffin
	name = "meat coffin"
	desc = "When you're ready to meat your maker, the steaks can never be too high."
	icon_state = "meatcoffin"
	icon = 'fulp_modules/bloodsuckers/icons/vamp_obj.dmi'
	resistance_flags = FIRE_PROOF
	open_sound = 'sound/effects/footstep/slime1.ogg'
	close_sound = 'sound/effects/footstep/slime1.ogg'
	breakout_time = 200
	pryLidTimer = 200
	resistance_flags = NONE
	material_drop = /obj/item/food/meat/slab/human
	material_drop_amount = 3
	armor = list(MELEE = 70, BULLET = 10, LASER = 10, ENERGY = 0, BOMB = 70, BIO = 0, RAD = 0, FIRE = 70, ACID = 60)

/obj/structure/closet/crate/coffin/metalcoffin
	name = "metal coffin"
	desc = "A big metal sardine can inside of another big metal sardine can, in space."
	icon_state = "metalcoffin"
	icon = 'fulp_modules/bloodsuckers/icons/vamp_obj.dmi'
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	open_sound = 'sound/effects/pressureplate.ogg'
	close_sound = 'sound/effects/pressureplate.ogg'
	breakout_time = 300
	pryLidTimer = 200
	material_drop = /obj/item/stack/sheet/iron
	material_drop_amount = 5
	armor = list(MELEE = 40, BULLET = 15, LASER = 50, ENERGY = 0, BOMB = 10, BIO = 0, RAD = 0, FIRE = 70, ACID = 60)

//////////////////////////////////////////////

/// NOTE: This can be any "closet" that you are resting AND inside of.
/obj/structure/closet/crate/proc/ClaimCoffin(mob/living/claimant)
	// Bloodsucker Claim
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = claimant.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(bloodsuckerdatum)
		// Successfully claimed?
		if(bloodsuckerdatum.ClaimCoffin(src))
			resident = claimant
			anchored = 1

/obj/structure/closet/crate/coffin/Destroy()
	UnclaimCoffin()
	return ..()

/obj/structure/closet/crate/proc/UnclaimCoffin()
	if(resident)
		// Unclaiming
		if(resident.mind)
			var/datum/antagonist/bloodsucker/bloodsuckerdatum = resident.mind.has_antag_datum(/datum/antagonist/bloodsucker)
			if(bloodsuckerdatum && bloodsuckerdatum.coffin == src)
				bloodsuckerdatum.coffin = null
				bloodsuckerdatum.lair = null
			to_chat(resident, "<span class='danger'><span class='italics'>You sense that the link with your coffin, your sacred place of rest, has been broken! You will need to seek another.</span></span>")
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
			to_chat(user, "<span class='notice'>[src] is locked tight from the inside.</span>")
	return ..()

/obj/structure/closet/crate/coffin/close(mob/living/user)
	if(!..())
		return FALSE
	// Only the User can put themself into Torpor. If already in it, you'll start to heal.
	if((user in src))
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
		if(bloodsuckerdatum)
			LockMe(user)
			if(!bloodsuckerdatum.coffin && !resident)
				switch(alert(user,"Do you wish to claim this as your coffin? [get_area(src)] will be your lair.","Claim Lair","Yes", "No"))
					if("Yes")
						ClaimCoffin(user)
			bloodsuckerdatum.SpendRank() // Level up? Auto-Fails if not appropriate
			if(user.AmStaked()) // Staked? Dont heal
				to_chat(bloodsuckerdatum.owner.current, "<span class='userdanger'>You are staked! Remove the offending weapon from your heart before sleeping.</span>")
				return
			// Heal
			var/total_brute = user.getBruteLoss_nonProsthetic()
			var/total_burn = user.getFireLoss_nonProsthetic()
			var/total_damage = total_brute + total_burn
			if(total_damage >= 10)
				to_chat(bloodsuckerdatum.owner.current, "<span class='notice'>You enter the horrible slumber of deathless Torpor. You will heal until you are renewed.</span>")
				bloodsuckerdatum.Torpor_Begin()
	return TRUE

/// You cannot weld or deconstruct an owned coffin. Only the owner can destroy their own coffin.
/obj/structure/closet/crate/coffin/attackby(obj/item/W, mob/user, params)
	if(resident != null && user != resident)
		if(opened)
			if(istype(W, cutting_tool))
				to_chat(user, "<span class='notice'>This is a much more complex mechanical structure than you thought. You don't know where to begin cutting [src].</span>")
				return
		else if(anchored && istype(W, /obj/item/wrench))
			to_chat(user, "<span class='danger'>The coffin won't come unanchored from the floor.</span>")
			return

	if(locked && istype(W, /obj/item/crowbar))
		var/pry_time = pryLidTimer * W.toolspeed // Pry speed must be affected by the speed of the tool.
		user.visible_message("<span class='notice'>[user] tries to pry the lid off of [src] with [W].</span>", \
							  "<span class='notice'>You begin prying the lid off of [src] with [W]. This should take about [DisplayTimeText(pry_time)].</span>")
		if(!do_mob(user, src, pry_time))
			return
		bust_open()
		user.visible_message("<span class='notice'>[user] snaps the door of [src] wide open.</span>", \
							  "<span class='notice'>The door of [src] snaps open.</span>")
		return
	..()

/// Distance Check (Inside Of)
/obj/structure/closet/crate/coffin/AltClick(mob/user)
	if(user in src)
		LockMe(user, !locked)

/obj/structure/closet/crate/proc/LockMe(mob/user, inLocked = TRUE)
	if(user == resident)
		if(!broken)
			locked = inLocked
			to_chat(user, "<span class='notice'>You flip a secret latch and [locked?"":"un"]lock yourself inside [src].</span>")
		else
			to_chat(resident, "<span class='notice'>The secret latch to lock [src] from the inside is broken. You set it back into place...</span>")
			if(do_mob(resident, src, 5 SECONDS))
				if(broken) // Spam Safety
					to_chat(resident, "<span class='notice'>You fix the mechanism and lock it.</span>")
					broken = FALSE
					locked = TRUE
