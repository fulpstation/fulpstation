/*
 * Absorbs /obj/item/secstorage.
 * Reimplements it only slightly to use existing storage functionality.
 *
 * Contains:
 * Secure Briefcase
 * Wall Safe
 */

///Generic Safe
/obj/item/storage/secure
	name = "secstorage"
	desc = "This shouldn't exist. If it does, create an issue report."
	w_class = WEIGHT_CLASS_NORMAL
	/// The code entered by the user
	var/entered_code
	/// The code that will open this safe
	var/lock_code
	/// Does this lock have a code set?
	var/lock_set = FALSE
	/// Is this lock currently being hacked?
	var/lock_hacking = FALSE
	/// Is the safe service panel open?
	var/panel_open = FALSE
	/// Is this door hackable?
	var/can_hack_open = TRUE

/obj/item/storage/secure/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 14
	update_appearance()

/obj/item/storage/secure/examine(mob/user)
	. = ..()
	if(can_hack_open)
		. += "The service panel is currently <b>[panel_open ? "unscrewed" : "screwed shut"]</b>."

/obj/item/storage/secure/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][atom_storage?.locked ? "_locked" : null]"

/obj/item/storage/secure/tool_act(mob/living/user, obj/item/tool)
	if(can_hack_open && atom_storage.locked)
		return ..()
	else
		return FALSE

/obj/item/storage/secure/wirecutter_act(mob/living/user, obj/item/tool)
	to_chat(user, span_danger("[src] is protected from this sort of tampering, yet it appears the internal memory wires can still be <b>pulsed</b>."))
	return

/obj/item/storage/secure/screwdriver_act(mob/living/user, obj/item/tool)
	if(tool.use_tool(src, user, 20))
		panel_open = !panel_open
		balloon_alert(user, "panel [panel_open ? "opened" : "closed"]")
		return TRUE

/obj/item/storage/secure/multitool_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(lock_hacking)
		balloon_alert(user, "already hacking!")
		return
	if(panel_open)
		balloon_alert(user, "hacking...")
		lock_hacking = TRUE
		if (tool.use_tool(src, user, 400))
			balloon_alert(user, "hacked")
			lock_set = FALSE

		lock_hacking = FALSE
		return

	balloon_alert(user, "unscrew panel!")

/obj/item/storage/secure/attack_self(mob/user)
	var/locked = atom_storage.locked
	user.set_machine(src)
	var/dat = text("<TT><B>[]</B><BR>\n\nLock Status: []",src, (locked ? "LOCKED" : "UNLOCKED"))
	var/message = "Code"
	if (!lock_set)
		dat += text("<p>\n<b>5-DIGIT PASSCODE NOT SET.<br>ENTER NEW PASSCODE.</b>")
	message = text("[]", entered_code)
	if (!locked)
		message = "*****"
	dat += text("<HR>\n>[]<BR>\n<A href='?src=[REF(src)];type=1'>1</A>-<A href='?src=[REF(src)];type=2'>2</A>-<A href='?src=[REF(src)];type=3'>3</A><BR>\n<A href='?src=[REF(src)];type=4'>4</A>-<A href='?src=[REF(src)];type=5'>5</A>-<A href='?src=[REF(src)];type=6'>6</A><BR>\n<A href='?src=[REF(src)];type=7'>7</A>-<A href='?src=[REF(src)];type=8'>8</A>-<A href='?src=[REF(src)];type=9'>9</A><BR>\n<A href='?src=[REF(src)];type=R'>R</A>-<A href='?src=[REF(src)];type=0'>0</A>-<A href='?src=[REF(src)];type=E'>E</A><BR>\n</TT>", message)
	user << browse(dat, "window=caselock;size=300x280")

/obj/item/storage/secure/Topic(href, href_list)
	..()
	if (usr.stat != CONSCIOUS || HAS_TRAIT(usr, TRAIT_HANDS_BLOCKED) || (get_dist(src, usr) > 1))
		return
	if (href_list["type"])
		if (href_list["type"] == "E")
			if (!lock_set && (length(entered_code) == 5) && (entered_code != "ERROR"))
				lock_code = entered_code
				lock_set = TRUE
			else if ((entered_code == lock_code) && lock_set)
				atom_storage.locked = FALSE
				update_appearance()
				entered_code = null
			else
				entered_code = "ERROR"
		else
			if (href_list["type"] == "R")
				atom_storage.locked = TRUE
				update_appearance()
				entered_code = null
				atom_storage.hide_contents(usr)
			else
				entered_code += text("[]", sanitize_text(href_list["type"]))
				if (length(entered_code) > 5)
					entered_code = "ERROR"
		add_fingerprint(usr)
		for(var/mob/M in viewers(1, loc))
			if ((M.client && M.machine == src))
				attack_self(M)
			return
	return

///Secure Briefcase
/obj/item/storage/secure/briefcase
	name = "secure briefcase"
	icon = 'icons/obj/storage/case.dmi'
	icon_state = "secure"
	inhand_icon_state = "sec-case"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	desc = "A large briefcase with a digital locking system."
	force = 8
	hitsound = SFX_SWING_HIT
	throw_speed = 2
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "thrashes", "whacks")
	attack_verb_simple = list("bash", "batter", "bludgeon", "thrash", "whack")

/obj/item/storage/secure/briefcase/PopulateContents()
	new /obj/item/paper(src)
	new /obj/item/pen(src)

/obj/item/storage/secure/briefcase/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 21
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL

///Syndie variant of Secure Briefcase. Contains space cash, slightly more robust.
/obj/item/storage/secure/briefcase/syndie
	force = 15

/obj/item/storage/secure/briefcase/syndie/PopulateContents()
	..()
	for(var/iterator in 1 to 5)
		new /obj/item/stack/spacecash/c1000(src)

/// A briefcase that contains various sought-after spoils
/obj/item/storage/secure/briefcase/riches

/obj/item/storage/secure/briefcase/riches/PopulateContents()
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/gun/ballistic/automatic/pistol(src)
	new /obj/item/suppressor(src)
	new /obj/item/melee/baton/telescopic(src)
	new /obj/item/clothing/mask/balaclava(src)
	new /obj/item/bodybag(src)
	new /obj/item/soap/nanotrasen(src)

///Secure Safe
/obj/item/storage/secure/safe
	name = "secure safe"
	icon = 'icons/obj/storage/storage.dmi'
	icon_state = "wall_safe"
	desc = "Excellent for securing things away from grubby hands."
	w_class = WEIGHT_CLASS_GIGANTIC
	anchored = TRUE
	density = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/item/storage/secure/safe, 32)

/obj/item/storage/secure/safe/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(cant_hold_list = list(/obj/item/storage/secure/briefcase))
	atom_storage.max_specific_storage = WEIGHT_CLASS_GIGANTIC

/obj/item/storage/secure/safe/PopulateContents()
	new /obj/item/paper(src)
	new /obj/item/pen(src)

/obj/item/storage/secure/safe/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	return attack_self(user)

/obj/item/storage/secure/safe/hos
	name = "head of security's safe"

/**
 * This safe is meant to be damn robust. To break in, you're supposed to get creative, or use acid or an explosion.
 *
 * This makes the safe still possible to break in for someone who is prepared and capable enough, either through
 * chemistry, botany or whatever else.
 *
 * The safe is also weak to explosions, so spending some early TC could allow an antag to blow it upen if they can
 * get access to it.
 */
/obj/item/storage/secure/safe/caps_spare
	name = "captain's spare ID safe"
	desc = "In case of emergency, do not break glass. All Captains and Acting Captains are provided with codes to access this safe. \
It is made out of the same material as the station's Black Box and is designed to resist all conventional weaponry. \
There appears to be a small amount of surface corrosion. It doesn't look like it could withstand much of an explosion.\
It remains quite flush against the wall, and there only seems to be enough room to fit something as slim as an ID card."
	can_hack_open = FALSE
	armor_type = /datum/armor/safe_caps_spare
	max_integrity = 300
	color = "#ffdd33"

MAPPING_DIRECTIONAL_HELPERS(/obj/item/storage/secure/safe/caps_spare, 32)

/datum/armor/safe_caps_spare
	melee = 100
	bullet = 100
	laser = 100
	energy = 100
	bomb = 70
	fire = 80
	acid = 70

/obj/item/storage/secure/safe/caps_spare/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(can_hold_list = list(/obj/item/card/id))
	lock_code = SSid_access.spare_id_safe_code
	lock_set = TRUE
	atom_storage.locked = TRUE
	update_appearance()

/obj/item/storage/secure/safe/caps_spare/PopulateContents()
	new /obj/item/card/id/advanced/gold/captains_spare(src)

/obj/item/storage/secure/safe/caps_spare/rust_heretic_act()
	take_damage(damage_amount = 100, damage_type = BRUTE, damage_flag = MELEE, armour_penetration = 100)
