// CHAPLAIN CUSTOM ARMORS //

/obj/item/clothing/head/helmet/chaplain/clock
	name = "forgotten helmet"
	desc = "It has the unyielding gaze of a god eternally forgotten."
	icon_state = "clockwork_helmet"
	inhand_icon_state = "clockwork_helmet_inhand"
	armor = list(MELEE = 50, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 0, BIO = 0, RAD = 0, FIRE = 80, ACID = 80)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	strip_delay = 8 SECONDS
	dog_fashion = null

/obj/item/clothing/suit/armor/riot/chaplain/clock
	name = "forgotten armour"
	desc = "It sounds like hissing steam, ticking cogs, gone silent, It looks like a dead machine, trying to tick with life."
	icon_state = "clockwork_cuirass"
	inhand_icon_state = "clockwork_cuirass_inhand"
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	slowdown = 0
	clothing_flags = NONE

/obj/item/clothing/head/helmet/chaplain
	name = "crusader helmet"
	desc = "Deus Vult."
	icon_state = "knight_templar"
	inhand_icon_state = "knight_templar"
	armor = list(MELEE = 50, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 0, BIO = 0, RAD = 0, FIRE = 80, ACID = 80)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	strip_delay = 80
	dog_fashion = null

/obj/item/clothing/suit/armor/riot/chaplain
	name = "crusader armour"
	desc = "God wills it!"
	icon_state = "knight_templar"
	inhand_icon_state = "knight_templar"
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	slowdown = 0
	clothing_flags = NONE

/obj/item/choice_beacon/holy
	name = "armaments beacon"
	desc = "Contains a set of armaments for the chaplain."

/obj/item/choice_beacon/holy/canUseBeacon(mob/living/user)
	if(user.mind && user.mind.holy_role)
		return ..()
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 40, TRUE)
		return FALSE

/obj/item/choice_beacon/holy/generate_display_names()
	var/static/list/holy_item_list
	if(!holy_item_list)
		holy_item_list = list()
		var/list/templist = typesof(/obj/item/storage/box/holy)
		for(var/V in templist)
			var/atom/A = V
			holy_item_list[initial(A.name)] = A
	return holy_item_list

/obj/item/choice_beacon/holy/spawn_option(obj/choice,mob/living/M)
	if(!GLOB.holy_armor_type)
		..()
		playsound(src, 'sound/effects/pray_chaplain.ogg', 40, TRUE)
		SSblackbox.record_feedback("tally", "chaplain_armor", 1, "[choice]")
		GLOB.holy_armor_type = choice
	else
		to_chat(M, span_warning("A selection has already been made. Self-Destructing..."))
		return


/obj/item/storage/box/holy/clock
	name = "Forgotten kit"

/obj/item/storage/box/holy/clock/PopulateContents()
	new /obj/item/clothing/head/helmet/chaplain/clock(src)
	new /obj/item/clothing/suit/armor/riot/chaplain/clock(src)

/obj/item/storage/box/holy
	name = "Templar Kit"

/obj/item/storage/box/holy/PopulateContents()
	new /obj/item/clothing/head/helmet/chaplain(src)
	new /obj/item/clothing/suit/armor/riot/chaplain(src)

/obj/item/storage/box/holy/student
	name = "Profane Scholar Kit"

/obj/item/storage/box/holy/student/PopulateContents()
	new /obj/item/clothing/suit/armor/riot/chaplain/studentuni(src)
	new /obj/item/clothing/head/helmet/chaplain/cage(src)

/obj/item/clothing/suit/armor/riot/chaplain/studentuni
	name = "student robe"
	desc = "The uniform of a bygone institute of learning."
	icon_state = "studentuni"
	inhand_icon_state = "studentuni"
	body_parts_covered = ARMS|CHEST

/obj/item/clothing/head/helmet/chaplain/cage
	name = "cage"
	desc = "A cage that restrains the will of the self, allowing one to see the profane world for what it is."
	flags_inv = NONE
	icon_state = "cage"
	inhand_icon_state = "cage"
	dynamic_hair_suffix = ""
	worn_y_offset = 7

/obj/item/storage/box/holy/sentinel
	name = "Stone Sentinel Kit"

/obj/item/storage/box/holy/sentinel/PopulateContents()
	new /obj/item/clothing/suit/armor/riot/chaplain/ancient(src)
	new /obj/item/clothing/head/helmet/chaplain/ancient(src)

/obj/item/clothing/head/helmet/chaplain/ancient
	name = "ancient helmet"
	desc = "None may pass!"
	icon_state = "knight_ancient"
	inhand_icon_state = "knight_ancient"

/obj/item/clothing/suit/armor/riot/chaplain/ancient
	name = "ancient armour"
	desc = "Defend the treasure..."
	icon_state = "knight_ancient"
	inhand_icon_state = "knight_ancient"

/obj/item/storage/box/holy/witchhunter
	name = "Witchhunter Kit"

/obj/item/storage/box/holy/witchhunter/PopulateContents()
	new /obj/item/clothing/suit/armor/riot/chaplain/witchhunter(src)
	new /obj/item/clothing/head/helmet/chaplain/witchunter_hat(src)

/obj/item/clothing/suit/armor/riot/chaplain/witchhunter
	name = "witchunter garb"
	desc = "This worn outfit saw much use back in the day."
	icon_state = "witchhunter"
	inhand_icon_state = "witchhunter"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/head/helmet/chaplain/witchunter_hat
	name = "witchunter hat"
	desc = "This hat saw much use back in the day."
	icon_state = "witchhunterhat"
	inhand_icon_state = "witchhunterhat"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEEYES|HIDEHAIR

/obj/item/storage/box/holy/adept
	name = "Divine Adept Kit"

/obj/item/storage/box/holy/adept/PopulateContents()
	new /obj/item/clothing/suit/armor/riot/chaplain/adept(src)
	new /obj/item/clothing/head/helmet/chaplain/adept(src)

/obj/item/clothing/head/helmet/chaplain/adept
	name = "adept hood"
	desc = "Its only heretical when others do it."
	icon_state = "crusader"
	inhand_icon_state = "crusader"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/suit/armor/riot/chaplain/adept
	name = "adept robes"
	desc = "The ideal outfit for burning the unfaithful."
	icon_state = "crusader"
	inhand_icon_state = "crusader"

/obj/item/storage/box/holy/follower
	name = "Followers of the Chaplain Kit"

/obj/item/storage/box/holy/follower/PopulateContents()
	new /obj/item/clothing/suit/hooded/chaplain_hoodie/leader(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)

/obj/item/clothing/suit/hooded/chaplain_hoodie
	name = "follower hoodie"
	desc = "Hoodie made for acolytes of the chaplain."
	icon_state = "chaplain_hoodie"
	inhand_icon_state = "chaplain_hoodie"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	hoodtype = /obj/item/clothing/head/hooded/chaplain_hood

/obj/item/clothing/head/hooded/chaplain_hood
	name = "follower hood"
	desc = "Hood made for acolytes of the chaplain."
	icon_state = "chaplain_hood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/suit/hooded/chaplain_hoodie/leader
	name = "leader hoodie"
	desc = "Now you're ready for some 50 dollar bling water."
	icon_state = "chaplain_hoodie_leader"
	inhand_icon_state = "chaplain_hoodie_leader"
	hoodtype = /obj/item/clothing/head/hooded/chaplain_hood/leader

/obj/item/clothing/head/hooded/chaplain_hood/leader
	name = "leader hood"
	desc = "I mean, you don't /have/ to seek bling water. I just think you should."
	icon_state = "chaplain_hood_leader"


// CHAPLAIN NULLROD AND CUSTOM WEAPONS //

/obj/item/nullrod
	name = "null rod"
	desc = "A rod of pure obsidian; its very presence disrupts and dampens 'magical forces'. That's what the guidebook says, anyway."
	icon_state = "nullrod"
	inhand_icon_state = "nullrod"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 18
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_TINY
	obj_flags = UNIQUE_RENAME
	wound_bonus = -10
	/// If this item has already been reskinned
	var/reskinned = FALSE
	/// If this item can be used in a reskin variant selection
	var/chaplain_spawnable = TRUE
	/// Short description of what this item is capable of, for radial menu uses
	var/menu_description = "A standard chaplain's weapon. Fits in pockets. Can be worn on the belt."

/obj/item/nullrod/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)

/obj/item/nullrod/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is killing [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to get closer to god!"))
	return (BRUTELOSS|FIRELOSS)

/obj/item/nullrod/attack_self(mob/user)
	if(user.mind && (user.mind.holy_role) && !reskinned)
		reskin_holy_weapon(user)

/**
 * Shows a user a radial menu of all available null rod reskins and replaces the current null rod with the user's chosen reskinned variant
 *
 * Arguments:
 * * user The mob choosing a null rod reskin variant
 */
/obj/item/nullrod/proc/reskin_holy_weapon(mob/user)
	if(GLOB.holy_weapon_type)
		return
	var/list/display_names = list()
	var/list/nullrod_icons = list()
	for(var/rod in typesof(/obj/item/nullrod))
		var/obj/item/nullrod/rodtype = rod
		if(initial(rodtype.chaplain_spawnable))
			var/datum/radial_menu_choice/option = new
			option.image = image(icon = initial(rodtype.icon), icon_state = initial(rodtype.icon_state))
			option.info = span_boldnotice("[initial(rodtype.menu_description)]")
			display_names[initial(rodtype.name)] = rodtype
			nullrod_icons += list(initial(rodtype.name) = option)

	nullrod_icons = sortList(nullrod_icons)
	var/choice = show_radial_menu(user, src , nullrod_icons, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 42, require_near = TRUE)
	if(!choice || !check_menu(user))
		return

	var/picked_rod_type = display_names[choice] // This needs to be on a separate var as list member access is not allowed for new
	var/obj/item/nullrod/holy_weapon = new picked_rod_type(user.drop_location())
	GLOB.holy_weapon_type = holy_weapon.type

	SSblackbox.record_feedback("tally", "chaplain_weapon", 1, "[choice]")

	if(holy_weapon)
		holy_weapon.reskinned = TRUE
		qdel(src)
		user.put_in_hands(holy_weapon)

/**
 * Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The mob interacting with the menu
 */
/obj/item/nullrod/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(QDELETED(src) || reskinned)
		return FALSE
	if(user.incapacitated() || !user.is_holding(src))
		return FALSE
	return TRUE

/obj/item/nullrod/godhand
	name = "god hand"
	desc = "This hand of yours glows with an awesome power!"
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	lefthand_file = 'icons/mob/inhands/misc/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/touchspell_righthand.dmi'
	slot_flags = null
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	hitsound = 'sound/weapons/sear.ogg'
	damtype = BURN
	attack_verb_continuous = list("punches", "cross counters", "pummels")
	attack_verb_simple = list("punch", "cross counter", "pummel")
	menu_description = "An undroppable god hand dealing burn damage. Disappears if the arm holding it is cut off."

/obj/item/nullrod/godhand/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)

/obj/item/nullrod/staff
	name = "red holy staff"
	desc = "It has a mysterious, protective aura."
	icon_state = "godstaff-red"
	inhand_icon_state = "godstaff-red"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 5
	slot_flags = ITEM_SLOT_BACK
	block_chance = 50
	menu_description = "A red staff which provides a high chance of blocking incoming attacks via a protective red aura around it's user, but deals very low amount of damage. Can be worn only on the back."
	/// The icon which appears over the mob holding the item
	var/shield_icon = "shield-red"

/obj/item/nullrod/staff/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(isinhands)
		. += mutable_appearance('icons/effects/effects.dmi', shield_icon, MOB_SHIELD_LAYER)

/obj/item/nullrod/staff/blue
	name = "blue holy staff"
	icon_state = "godstaff-blue"
	inhand_icon_state = "godstaff-blue"
	shield_icon = "shield-old"
	menu_description = "A blue staff which provides a high chance of blocking incoming attacks via a protective blue aura around it's user, but deals very low amount of damage. Can be worn only on the back."

/obj/item/nullrod/claymore
	name = "holy claymore"
	desc = "A weapon fit for a crusade!"
	icon_state = "claymore_gold"
	inhand_icon_state = "claymore_gold"
	worn_icon_state = "claymore_gold"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	block_chance = 30
	sharpness = SHARP_EDGED
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	menu_description = "A sharp claymore which provides a low chance of blocking incoming melee attacks. Can be worn on the back or belt."

/obj/item/nullrod/claymore/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight
	return ..()

/obj/item/nullrod/claymore/darkblade
	name = "dark blade"
	desc = "Spread the glory of the dark gods!"
	icon_state = "cultblade"
	inhand_icon_state = "cultblade"
	worn_icon_state = "cultblade"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	hitsound = 'sound/hallucinations/growl1.ogg'
	menu_description = "A sharp blade which provides a low chance of blocking incoming melee attacks. Can be worn on the back or belt."

/obj/item/nullrod/claymore/chainsaw_sword
	name = "sacred chainsaw sword"
	desc = "Suffer not a heretic to live."
	icon_state = "chainswordon"
	inhand_icon_state = "chainswordon"
	worn_icon_state = "chainswordon"
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1.5 //slower than a real saw
	menu_description = "A sharp chainsaw sword which provides a low chance of blocking incoming melee attacks. Can be used as a slower saw tool. Can be worn on the belt."

/obj/item/nullrod/claymore/glowing
	name = "force weapon"
	desc = "The blade glows with the power of faith. Or possibly a battery."
	icon_state = "swordon"
	inhand_icon_state = "swordon"
	worn_icon_state = "swordon"
	menu_description = "A sharp weapon which provides a low chance of blocking incoming melee attacks. Can be worn on the back or belt."

/obj/item/nullrod/claymore/katana
	name = "\improper Hanzo steel"
	desc = "Capable of cutting clean through a holy claymore."
	icon_state = "katana"
	inhand_icon_state = "katana"
	worn_icon_state = "katana"
	menu_description = "A sharp katana which provides a low chance of blocking incoming melee attacks. Can be worn on the back or belt."

/obj/item/nullrod/claymore/multiverse
	name = "extradimensional blade"
	desc = "Once the harbinger of an interdimensional war, its sharpness fluctuates wildly."
	icon_state = "multiverse"
	inhand_icon_state = "multiverse"
	worn_icon_state = "multiverse"
	slot_flags = ITEM_SLOT_BACK
	force = 15
	menu_description = "An odd sharp blade which provides a low chance of blocking incoming melee attacks and deals a random amount of damage, which can range from almost nothing to very high. Can be worn on the back."

/obj/item/nullrod/claymore/multiverse/melee_attack_chain(mob/user, atom/target, params)
	var/old_force = force
	force += rand(-14, 15)
	. = ..()
	force = old_force

/obj/item/nullrod/claymore/saber
	name = "light energy sword"
	desc = "If you strike me down, I shall become more robust than you can possibly imagine."
	icon = 'icons/obj/transforming_energy.dmi'
	icon_state = "swordblue"
	inhand_icon_state = "swordblue"
	worn_icon_state = "swordblue"
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/weapons/blade1.ogg'
	menu_description = "A sharp energy sword which provides a low chance of blocking incoming melee attacks. Can be worn on the belt."

/obj/item/nullrod/claymore/saber/red
	name = "dark energy sword"
	desc = "Woefully ineffective when used on steep terrain."
	icon_state = "swordred"
	inhand_icon_state = "swordred"
	worn_icon_state = "swordred"

/obj/item/nullrod/claymore/saber/pirate
	name = "nautical energy sword"
	desc = "Convincing HR that your religion involved piracy was no mean feat."
	icon_state = "cutlass1"
	inhand_icon_state = "cutlass1"
	worn_icon_state = "swordred"

/obj/item/nullrod/sord
	name = "\improper UNREAL SORD"
	desc = "This thing is so unspeakably HOLY you are having a hard time even holding it."
	icon_state = "sord"
	inhand_icon_state = "sord"
	worn_icon_state = "sord"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 4.13
	throwforce = 1
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	menu_description = "An odd s(w)ord dealing a laughable amount of damage. Fits in pockets. Can be worn on the belt."

/obj/item/nullrod/sord/suicide_act(mob/user) //a near-exact copy+paste of the actual sord suicide_act()
	user.visible_message(span_suicide("[user] is trying to impale [user.p_them()]self with [src]! It might be a suicide attempt if it weren't so HOLY."), \
	span_suicide("You try to impale yourself with [src], but it's TOO HOLY..."))
	return SHAME

/obj/item/nullrod/scythe
	name = "reaper scythe"
	desc = "Ask not for whom the bell tolls..."
	icon_state = "scythe1"
	inhand_icon_state = "scythe1"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	armour_penetration = 35
	slot_flags = ITEM_SLOT_BACK
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("chops", "slices", "cuts", "reaps")
	attack_verb_simple = list("chop", "slice", "cut", "reap")
	menu_description = "A sharp scythe which partially penetrates armor. Very effective at butchering bodies. Can be worn on the back."

/obj/item/nullrod/scythe/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 70, 110) //the harvest gives a high bonus chance

/obj/item/nullrod/scythe/vibro
	name = "high frequency blade"
	desc = "Bad references are the DNA of the soul."
	icon_state = "hfrequency0"
	inhand_icon_state = "hfrequency1"
	worn_icon_state = "hfrequency0"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	attack_verb_continuous = list("chops", "slices", "cuts", "zandatsu's")
	attack_verb_simple = list("chop", "slice", "cut", "zandatsu")
	hitsound = 'sound/weapons/rapierhit.ogg'
	menu_description = "A sharp blade which partially penetrates armor. Very effective at butchering bodies. Can be worn on the back."

/obj/item/nullrod/scythe/spellblade
	name = "dormant spellblade"
	desc = "The blade grants the wielder nearly limitless power...if they can figure out how to turn it on, that is."
	icon_state = "spellblade"
	inhand_icon_state = "spellblade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	worn_icon_state = "spellblade"
	icon = 'icons/obj/guns/magic.dmi'
	hitsound = 'sound/weapons/rapierhit.ogg'
	menu_description = "A sharp blade which partially penetrates armor. Very effective at butchering bodies. Can be worn on the back."

/obj/item/nullrod/scythe/talking
	name = "possessed blade"
	desc = "When the station falls into chaos, it's nice to have a friend by your side."
	icon_state = "talking_sword"
	inhand_icon_state = "talking_sword"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	worn_icon_state = "talking_sword"
	attack_verb_continuous = list("chops", "slices", "cuts")
	attack_verb_simple= list("chop", "slice", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	menu_description = "A sharp blade which partially penetrates armor. Able to awaken a friendly spirit to provide guidance. Very effective at butchering bodies. Can be worn on the back."
	/// If there is a ghost possessing the item
	var/possessed = FALSE

/obj/item/nullrod/scythe/talking/relaymove(mob/living/user, direction)
	return //stops buckled message spam for the ghost.

/obj/item/nullrod/scythe/talking/attack_self(mob/living/user)
	if(possessed)
		return
	if(!(GLOB.ghost_role_flags & GHOSTROLE_STATION_SENTIENCE))
		to_chat(user, span_notice("Anomalous otherworldly energies block you from awakening the blade!"))
		return

	to_chat(user, span_notice("You attempt to wake the spirit of the blade..."))

	possessed = TRUE

	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you want to play as the spirit of [user.real_name]'s blade?", ROLE_PAI, FALSE, 100, POLL_IGNORE_POSSESSED_BLADE)

	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		var/mob/living/simple_animal/shade/S = new(src)
		S.ckey = C.ckey
		S.fully_replace_character_name(null, "The spirit of [name]")
		S.status_flags |= GODMODE
		S.copy_languages(user, LANGUAGE_MASTER) //Make sure the sword can understand and communicate with the user.
		S.update_atom_languages()
		grant_all_languages(FALSE, FALSE, TRUE) //Grants omnitongue
		var/input = sanitize_name(stripped_input(S,"What are you named?", ,"", MAX_NAME_LEN))

		if(src && input)
			name = input
			S.fully_replace_character_name(null, "The spirit of [input]")
	else
		to_chat(user, span_warning("The blade is dormant. Maybe you can try again later."))
		possessed = FALSE

/obj/item/nullrod/scythe/talking/Destroy()
	for(var/mob/living/simple_animal/shade/S in contents)
		to_chat(S, span_userdanger("You were destroyed!"))
		qdel(S)
	return ..()

/obj/item/nullrod/scythe/talking/chainsword
	name = "possessed chainsaw sword"
	desc = "Suffer not a heretic to live."
	icon_state = "chainswordon"
	inhand_icon_state = "chainswordon"
	worn_icon_state = "chainswordon"
	force = 30
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 0.5 //faster than normal saw
	chaplain_spawnable = FALSE
	menu_description = "A sharp chainsaw sword dealing a very high amount of damage which partially penetrates armor. Able to awaken a friendly spirit providing guidance. Can be used as a faster saw tool. Very effective at butchering bodies. Can be worn on the belt."

/obj/item/nullrod/hammer
	name = "relic war hammer"
	desc = "This war hammer cost the chaplain forty thousand space dollars."
	icon_state = "hammeron"
	inhand_icon_state = "hammeron"
	worn_icon_state = "hammeron"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("smashes", "bashes", "hammers", "crunches")
	attack_verb_simple = list("smash", "bash", "hammer", "crunch")
	menu_description = "A war hammer. Capable of tapping knees to measure brain health. Can be worn on the belt."

/obj/item/nullrod/hammer/Initialize()
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/nullrod/chainsaw
	name = "chainsaw hand"
	desc = "Good? Bad? You're the guy with the chainsaw hand."
	icon_state = "chainsaw_on"
	inhand_icon_state = "mounted_chainsaw"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = null
	item_flags = ABSTRACT
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 2 //slower than a real saw
	menu_description = "An undroppable sharp chainsaw hand. Can be used as a very slow saw tool. Capable of slowly butchering bodies. Disappears if the arm holding it is cut off."

/obj/item/nullrod/chainsaw/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)
	AddComponent(/datum/component/butchering, 30, 100, 0, hitsound)

/obj/item/nullrod/clown
	name = "clown dagger"
	desc = "Used for absolutely hilarious sacrifices."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "clownrender"
	inhand_icon_state = "render"
	worn_icon_state = "render"
	hitsound = 'sound/items/bikehorn.ogg'
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	menu_description = "A sharp dagger. Fits in pockets. Can be worn on the belt. Honk."

/obj/item/nullrod/pride_hammer
	name = "Pride-struck Hammer"
	desc = "It resonates an aura of Pride."
	icon_state = "pride"
	inhand_icon_state = "pride"
	worn_icon_state = "pride"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	force = 16
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("attacks", "smashes", "crushes", "splatters", "cracks")
	attack_verb_simple = list("attack", "smash", "crush", "splatter", "crack")
	hitsound = 'sound/weapons/blade1.ogg'
	menu_description = "A hammer dealing a little less damage due to it's user's pride. Has a low chance of transferring some of the user's reagents to the target. Capable of tapping knees to measure brain health. Can be worn on the back."

/obj/item/nullrod/pride_hammer/Initialize()
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/nullrod/pride_hammer/afterattack(atom/A as mob|obj|turf|area, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(prob(30) && ishuman(A))
		var/mob/living/carbon/human/H = A
		user.reagents.trans_to(H, user.reagents.total_volume, 1, 1, 0, transfered_by = user)
		to_chat(user, span_notice("Your pride reflects on [H]."))
		to_chat(H, span_userdanger("You feel insecure, taking on [user]'s burden."))

/obj/item/nullrod/whip
	name = "holy whip"
	desc = "What a terrible night to be on Space Station 13."
	icon_state = "chain"
	inhand_icon_state = "chain"
	worn_icon_state = "whip"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("whips", "lashes")
	attack_verb_simple = list("whip", "lash")
	hitsound = 'sound/weapons/chainhit.ogg'
	menu_description = "A whip. Deals extra damage to vampires. Fits in pockets. Can be worn on the belt."

/obj/item/nullrod/fedora
	name = "atheist's fedora"
	desc = "The brim of the hat is as sharp as your wit. The edge would hurt almost as much as disproving the existence of God."
	icon_state = "fedora"
	inhand_icon_state = "fedora"
	slot_flags = ITEM_SLOT_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	force = 0
	throw_speed = 4
	throw_range = 7
	throwforce = 30
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("enlightens", "redpills")
	attack_verb_simple = list("enlighten", "redpill")
	menu_description = "A sharp fedora dealing a very high amount of throw damage, but none of melee. Fits in pockets. Can be worn on the head, obviously."

/obj/item/nullrod/armblade
	name = "dark blessing"
	desc = "Particularly twisted deities grant gifts of dubious value."
	icon = 'icons/obj/changeling_items.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	slot_flags = null
	item_flags = ABSTRACT
	w_class = WEIGHT_CLASS_HUGE
	sharpness = SHARP_EDGED
	wound_bonus = -20
	bare_wound_bonus = 25
	menu_description = "An undroppable sharp armblade capable of inflicting deep wounds. Capable of an ineffective butchering of bodies. Disappears if the arm holding it is cut off."

/obj/item/nullrod/armblade/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)
	AddComponent(/datum/component/butchering, 80, 70)

/obj/item/nullrod/armblade/tentacle
	name = "unholy blessing"
	icon_state = "tentacle"
	inhand_icon_state = "tentacle"
	menu_description = "An undroppable sharp tentacle capable of inflicting deep wounds. Capable of an ineffective butchering of bodies. Disappears if the arm holding it is cut off."

/obj/item/nullrod/carp
	name = "carp-sie plushie"
	desc = "An adorable stuffed toy that resembles the god of all carp. The teeth look pretty sharp. Activate it to receive the blessing of Carp-Sie."
	icon = 'icons/obj/plushes.dmi'
	icon_state = "carpplush"
	inhand_icon_state = "carp_plushie"
	worn_icon_state = "nullrod"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	force = 15
	attack_verb_continuous = list("bites", "eats", "fin slaps")
	attack_verb_simple = list("bite", "eat", "fin slap")
	hitsound = 'sound/weapons/bite.ogg'
	menu_description = "A plushie dealing a little less damage due to it's cute form. Capable of blessing one person with the Carp-Sie favor, which grants friendship of all wild space carps. Fits in pockets. Can be worn on the belt."
	/// If the item has already been used to bless someone
	var/used_blessing = FALSE

/obj/item/nullrod/carp/attack_self(mob/living/user)
	if(used_blessing)
	else if(user.mind && (user.mind.holy_role))
		to_chat(user, span_boldnotice("You are blessed by Carp-Sie. Wild space carp will no longer attack you."))
		user.faction |= "carp"
		used_blessing = TRUE

/obj/item/nullrod/claymore/bostaff //May as well make it a "claymore" and inherit the blocking
	name = "monk's staff"
	desc = "A long, tall staff made of polished wood. Traditionally used in ancient old-Earth martial arts, it is now used to harass the clown."
	force = 15
	block_chance = 40
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	sharpness = NONE
	hitsound = "swing_hit"
	attack_verb_continuous = list("smashes", "slams", "whacks", "thwacks")
	attack_verb_simple = list("smash", "slam", "whack", "thwack")
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "bostaff0"
	inhand_icon_state = "bostaff0"
	worn_icon_state = "bostaff0"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	menu_description = "A staff which provides a medium chance of blocking incoming melee attacks and deals a little less damage due to being made of wood. Can be worn on the back."

/obj/item/nullrod/tribal_knife
	icon_state = "crysknife"
	desc = "They say fear is the true mind killer, but stabbing them in the head works too. Honour compels you to not sheathe it once drawn."
	inhand_icon_state = "crysknife"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "arrhythmic knife"
	w_class = WEIGHT_CLASS_HUGE
	sharpness = SHARP_EDGED
	slot_flags = null
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	item_flags = SLOWS_WHILE_IN_HAND
	menu_description = "A sharp knife. Randomly speeds or slows it's user at a regular intervals. Capable of butchering bodies. Cannot be worn anywhere."

/obj/item/nullrod/tribal_knife/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	AddComponent(/datum/component/butchering, 50, 100)

/obj/item/nullrod/tribal_knife/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/nullrod/tribal_knife/process()
	slowdown = rand(-10, 10)/10
	if(iscarbon(loc))
		var/mob/living/carbon/wielder = loc
		if(wielder.is_holding(src))
			wielder.update_equipment_speed_mods()

/obj/item/nullrod/pitchfork
	name = "unholy pitchfork"
	desc = "Holding this makes you look absolutely devilish."
	icon_state = "pitchfork0"
	worn_icon_state = "pitchfork0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	worn_icon_state = "pitchfork0"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("pokes", "impales", "pierces", "jabs")
	attack_verb_simple = list("poke", "impale", "pierce", "jab")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	menu_description = "A sharp pitchfork. Can be worn on the back."

/obj/item/nullrod/egyptian
	name = "egyptian staff"
	desc = "A tutorial in mummification is carved into the staff. You could probably craft the wraps if you had some cloth."
	icon = 'icons/obj/guns/magic.dmi'
	icon_state = "pharoah_sceptre"
	inhand_icon_state = "pharoah_sceptre"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	worn_icon_state = "pharoah_sceptre"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("bashes", "smacks", "whacks")
	attack_verb_simple = list("bash", "smack", "whack")
	menu_description = "A staff. Can be used as a tool to craft exclusive egyptian items. Easily stored. Can be worn on the back."

/obj/item/nullrod/hypertool
	name = "hypertool"
	desc = "A tool so powerful even you cannot perfectly use it."
	icon = 'icons/obj/device.dmi'
	icon_state = "hypertool"
	inhand_icon_state = "hypertool"
	worn_icon_state = "hypertool"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	damtype = BRAIN
	armour_penetration = 35
	attack_verb_continuous = list("pulses", "mends", "cuts")
	attack_verb_simple = list("pulse", "mend", "cut")
	hitsound = 'sound/effects/sparks4.ogg'
	menu_description = "A tool dealing brain damage which partially penetrates armor. Fits in pockets. Can be worn on the belt."

/obj/item/nullrod/spear
	name = "ancient spear"
	desc = "An ancient spear made of brass, I mean gold, I mean bronze. It looks highly mechanical."
	icon = 'icons/obj/clockwork_objects.dmi'
	icon_state = "ratvarian_spear"
	inhand_icon_state = "ratvarian_spear"
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	armour_penetration = 10
	sharpness = SHARP_POINTY
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("stabs", "pokes", "slashes", "clocks")
	attack_verb_simple = list("stab", "poke", "slash", "clock")
	hitsound = 'sound/weapons/bladeslice.ogg'
	menu_description = "A pointy spear which penetrates armor a little. Can be worn only on the belt."
