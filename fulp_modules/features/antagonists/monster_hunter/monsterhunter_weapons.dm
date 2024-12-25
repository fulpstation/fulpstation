#define upgraded_val(x,y) ( CEILING((x * (1.07 ** y)), 1) )
#define CALIBER_BLOODSILVER "bloodsilver"
#define WEAPON_UPGRADE "weapon_upgrade"

/obj/item/melee/trick_weapon
	icon = 'fulp_modules/icons/antagonists/monster_hunter/weapons.dmi'
	lefthand_file = 'fulp_modules/icons/antagonists/monster_hunter/weapons_lefthand.dmi'
	righthand_file = 'fulp_modules/icons/antagonists/monster_hunter/weapons_righthand.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	///upgrade level of the weapon
	var/upgrade_level = 0
	///base force when transformed
	var/on_force
	///base force when in default state
	var/base_force
	///default name of the weapon
	var/base_name
	///is the weapon in its transformed state?
	var/enabled = FALSE


/obj/item/melee/trick_weapon/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("This is a trick weapon.")
		. += span_notice("It will deal less damage to anyone who isn't sufficiently monstrous.")

/obj/item/melee/trick_weapon/proc/upgrade_weapon()
	SIGNAL_HANDLER

	upgrade_level++
	force = upgraded_val(base_force,upgrade_level)
	var/datum/component/transforming/transform = GetComponent(/datum/component/transforming)
	transform.force_on = upgraded_val(on_force,upgrade_level)


/obj/item/melee/trick_weapon/attack(mob/target, mob/living/user, params) //our weapon does 25% less damage on non monsters
	var/old_force = force
	if(!(target.mind?.has_antag_datum(/datum/antagonist/changeling)) && !IS_BLOODSUCKER(target) && !IS_HERETIC(target))
		force = force * 0.75
	..()
	force = old_force

/obj/item/melee/trick_weapon/darkmoon
	name = "Darkmoon Greatsword"
	base_name = "Darkmoon Greatsword"
	desc = "Ahh my guiding moonlight, you were by my side all along."
	icon_state = "darkmoon"
	inhand_icon_state = "darkmoon_hilt"
	w_class = WEIGHT_CLASS_SMALL
	block_chance = 20
	on_force = 20
	base_force = 17
	light_system = OVERLAY_LIGHT
	light_color = "#59b3c9"
	light_range = 2
	light_power = 2
	light_on = FALSE
	throwforce = 12
	damtype = BURN
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	///ready to launch a beam attack?
	COOLDOWN_DECLARE(moonbeam_fire)


/obj/item/melee/trick_weapon/darkmoon/Initialize(mapload)
	. = ..()
	force = base_force
	AddComponent(/datum/component/transforming, \
		force_on = on_force , \
		throwforce_on = 20, \
		throw_speed_on = throw_speed, \
		sharpness_on = SHARP_EDGED, \
		w_class_on = WEIGHT_CLASS_BULKY)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	RegisterSignal(src, WEAPON_UPGRADE, PROC_REF(upgrade_weapon))
	register_item_context()

/obj/item/melee/trick_weapon/darkmoon/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	. = ..()
	if(enabled)
		context[SCREENTIP_CONTEXT_RMB] = "Fire Moonbeam"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/melee/trick_weapon/darkmoon/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("<b>Right-click</b> a target when this weapon is active to fire a beam of moonlight at it.")

/obj/item/melee/trick_weapon/darkmoon/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER
	balloon_alert(user, active ? "extended" : "collapsed")
	if(active)
		playsound(src, 'fulp_modules/features/antagonists/monster_hunter/sounds/moonlightsword.ogg',50)
	inhand_icon_state = active ? "darkmoon" : "darkmoon_hilt"
	enabled = active
	set_light_on(active)
	force = active ? upgraded_val(on_force, upgrade_level) : upgraded_val(base_force, upgrade_level)
	return COMPONENT_NO_DEFAULT_MESSAGE


/obj/item/melee/trick_weapon/darkmoon/attack_secondary(atom/target, mob/living/user, clickparams)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/melee/trick_weapon/darkmoon/ranged_interact_with_atom_secondary(atom/target, mob/living/user, clickparams)
	if(!enabled)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!COOLDOWN_FINISHED(src, moonbeam_fire))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(target == user)
		balloon_alert(user, "can't aim at yourself!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	fire_moonbeam(target, user, clickparams)
	user.changeNext_move(CLICK_CD_MELEE)
	COOLDOWN_START(src, moonbeam_fire, 4 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/trick_weapon/darkmoon/proc/fire_moonbeam(atom/target, mob/living/user, clickparams)
	var/modifiers = params2list(clickparams)
	var/turf/proj_turf = user.loc
	if(!isturf(proj_turf))
		return
	var/obj/projectile/moonbeam/moon = new(proj_turf)
	moon.aim_projectile(target, user, modifiers)
	moon.firer = user
	playsound(src, 'fulp_modules/features/antagonists/monster_hunter/sounds/moonlightbeam.ogg',50)
	moon.fire()


/obj/projectile/moonbeam
	name = "Moonlight"
	icon = 'icons/effects/effects.dmi'
	icon_state = "plasmasoul"
	damage = 25
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1
	light_color = "#44acb1"
	damage_type = BURN
	hitsound = 'sound/items/weapons/sear.ogg'
	hitsound_wall = 'sound/items/weapons/effects/searwall.ogg'



/obj/item/melee/trick_weapon/threaded_cane
	name = "Threaded Cane"
	base_name = "Threaded Cane"
	desc = "A blind man's whip."
	icon_state = "threaded_cane"
	inhand_icon_state = "threaded_cane"
	w_class = WEIGHT_CLASS_SMALL
	block_chance = 20
	on_force = 15
	base_force = 18
	throwforce = 12
	reach = 1
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	damtype = BURN
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

/obj/item/melee/trick_weapon/threaded_cane/Initialize(mapload)
	. = ..()
	force = base_force
	AddComponent(/datum/component/transforming, \
		force_on = on_force, \
		throwforce_on = 10, \
		throw_speed_on = throw_speed, \
		sharpness_on = SHARP_EDGED, \
		w_class_on = WEIGHT_CLASS_BULKY, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	RegisterSignal(src,WEAPON_UPGRADE, PROC_REF(upgrade_weapon))

/obj/item/melee/trick_weapon/threaded_cane/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("When transformed into a whip this weapon can hit enemies who are up to two tiles away.")

/obj/item/melee/trick_weapon/threaded_cane/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER
	balloon_alert(user, active ? "extended" : "collapsed")
	inhand_icon_state = active ? "chain" : "threaded_cane"
	if(active)
		playsound(src, 'sound/effects/magic/clockwork/fellowship_armory.ogg',50)
	reach = active ? 2 : 1
	enabled = active
	force = active ? upgraded_val(on_force, upgrade_level) : upgraded_val(base_force, upgrade_level)
	return COMPONENT_NO_DEFAULT_MESSAGE


/obj/item/melee/trick_weapon/hunter_axe
	name = "Hunter's Axe"
	base_name = "Hunter's Axe"
	desc = "A brute's tool of choice."
	icon_state = "hunteraxe0"
	base_icon_state = "hunteraxe"
	w_class = WEIGHT_CLASS_SMALL
	block_chance = 20
	base_force = 20
	on_force = 25
	throwforce = 12
	reach = 1
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	damtype = BURN
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")



/obj/item/melee/trick_weapon/hunter_axe/Initialize(mapload)
	. = ..()
	force = base_force
	AddComponent(/datum/component/two_handed, \
		force_unwielded=base_force, \
		force_wielded= on_force, \
		icon_wielded="[base_icon_state]1", \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)
	RegisterSignal(src, WEAPON_UPGRADE, PROC_REF(upgrade_weapon))

/obj/item/melee/trick_weapon/hunter_axe/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("When wielded in both hands this weapon deals more damage.")

/obj/item/melee/trick_weapon/hunter_axe/upgrade_weapon()

	upgrade_level++
	var/datum/component/two_handed/handed = GetComponent(/datum/component/two_handed)
	handed.force_wielded = upgraded_val(on_force, upgrade_level)
	handed.force_unwielded = upgraded_val(base_force,upgrade_level)
	force = handed.force_unwielded

/obj/item/melee/trick_weapon/hunter_axe/update_icon_state()
	icon_state = "[base_icon_state]0"
	playsound(src,'sound/effects/magic/clockwork/fellowship_armory.ogg',50)
	return ..()

/obj/item/melee/trick_weapon/hunter_axe/proc/on_wield(obj/item/source)
	enabled = TRUE
	block_chance = 75

/obj/item/melee/trick_weapon/hunter_axe/proc/on_unwield(obj/item/source)
	enabled = FALSE
	block_chance = 20

/obj/item/rabbit_eye
	name = "Rabbit eye"
	desc = "The bloodshot lenses of a lost rabbit."
	icon_state = "rabbit_eye"
	icon = 'fulp_modules/icons/antagonists/monster_hunter/weapons.dmi'

/obj/item/rabbit_eye/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("Apply this to the weapon forge in Wonderland <b>with combat mode enabled</b> to upgrade any trick weapon currently on the forge.")

/obj/item/rabbit_eye/proc/upgrade(obj/item/melee/trick_weapon/killer, mob/user)
	if(killer.upgrade_level >= 3)
		user.balloon_alert(user, "Already at maximum upgrade state!")
		return
	if(killer.enabled)
		user.balloon_alert(user, "Weapon must be in base form!")
		return
	SEND_SIGNAL(killer,WEAPON_UPGRADE)
	killer.name = "[killer.base_name] +[killer.upgrade_level]"
	balloon_alert(user, "[src] crumbles away...")
	playsound(src, 'fulp_modules/features/antagonists/monster_hunter/sounds/weaponsmithing.ogg', 50)
	qdel(src)

/obj/item/gun/ballistic/revolver/hunter_revolver
	name = "\improper Hunter's Revolver"
	desc = "A revolver delicately modified with some form of alchemical apparatus. It smells of rusted copper."
	icon_state = "revolver"
	icon = 'fulp_modules/icons/antagonists/monster_hunter/weapons.dmi'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/bloodsilver
	initial_caliber = CALIBER_BLOODSILVER
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/gun/ballistic/revolver/hunter_revolver/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("This revolver deals miniscule damage, but it will temporarily slow down any monster shot with it.")

/datum/movespeed_modifier/silver_bullet
	movetypes = GROUND
	multiplicative_slowdown = 4
	flags = IGNORE_NOSLOW


/obj/item/ammo_box/magazine/internal/cylinder/bloodsilver
	name = "bloodsilver revolver cylinder"
	ammo_type = /obj/item/ammo_casing/silver
	caliber = CALIBER_BLOODSILVER
	max_ammo = 2

/obj/item/ammo_casing/silver
	name = "Bloodsilver casing"
	desc = "A Bloodsilver bullet casing."
	icon_state = "bloodsilver"
	icon = 'fulp_modules/icons/antagonists/monster_hunter/weapons.dmi'
	projectile_type = /obj/projectile/bullet/bloodsilver
	caliber = CALIBER_BLOODSILVER


/obj/projectile/bullet/bloodsilver
	name = "Bloodsilver bullet"
	damage = 3
	ricochets_max = 4

/obj/projectile/bullet/bloodsilver/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(!iscarbon(target))
		return
	var/mob/living/carbon/man = target
	if(!man)
		return
	if(!IS_HERETIC(man) && !(IS_BLOODSUCKER(man)) && !(man.mind.has_antag_datum(/datum/antagonist/changeling)))
		return
	man.apply_status_effect(/datum/status_effect/silver_bullet)

/datum/status_effect/silver_bullet
	id = "silver_debuff"
	duration = 8 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/silver_bullet

/atom/movable/screen/alert/status_effect/silver_bullet
	name = "Cursed Blood"
	desc = "Something foreign is flowing through you, stiffening your carcass to a standstill... "
	icon = 'fulp_modules/icons/antagonists/monster_hunter/status_effects.dmi'
	icon_state = "silver_bullet"

/datum/status_effect/silver_bullet/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/silver_bullet)
	to_chat(owner, span_bolddanger("Your entire bloodstream feels weighted down!"))

/datum/status_effect/silver_bullet/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/silver_bullet)


/obj/structure/weaponsmith //Was a subtype of /obj/structure/rack, but that allowed it to be wrenched apart
	name = "Weapon Forge"
	desc = "Fueled by the tears of rabbits."
	icon = 'icons/obj/antags/cult/structures.dmi'
	icon_state = "altar"
	layer = TABLE_LAYER
	density = TRUE
	anchored = TRUE
	pass_flags_self = LETPASSTHROW
	resistance_flags = INDESTRUCTIBLE

/obj/structure/weaponsmith/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 12)

/obj/structure/weaponsmith/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("This forge can be used to upgrade trick weapons with rabbit eyes.")

/obj/structure/weaponsmith/CanAllowThrough(atom/movable/mover, border_dir) //Copied from tables_racks.dm
	. = ..()
	if(.)
		return
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return TRUE

/obj/structure/weaponsmith/item_interaction(mob/living/user, obj/item/tool, list/modifiers) //See comment above
	if(user.combat_mode)
		return NONE
	if(user.transferItemToLoc(tool, drop_location(), silent = FALSE))
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

//Used to find a trick weapon placed on the smithing table and return it
/obj/structure/weaponsmith/proc/identify_weapon()
	var/obj/item/melee/trick_weapon/tool
	for(var/obj/item/weapon in src.loc.contents)
		if(!istype(weapon, /obj/item/melee/trick_weapon))
			continue
		tool = weapon
		break
	if(tool)
		return tool

/obj/structure/weaponsmith/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	if(!istype(held_item, /obj/item/rabbit_eye))
		return
	var/obj/item/melee/trick_weapon/weapon = identify_weapon()
	if(!(weapon in source.loc.contents))
		return
	if(weapon.upgrade_level >= 3)
		return
	context[SCREENTIP_CONTEXT_LMB] = "Upgrade Weapon with Combat Mode Active"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/weaponsmith/attackby(obj/item/organ, mob/living/user, params)
	if(!istype(organ, /obj/item/rabbit_eye))
		return ..()
	var/obj/item/rabbit_eye/eye = organ
	var/obj/item/melee/trick_weapon/weapon = identify_weapon()
	if(!weapon)
		to_chat(user, span_warning ("Place your weapon upon the table before upgrading it!"))
		return
	eye.upgrade(weapon, user)


/obj/item/clothing/mask/cursed_rabbit
	name = "Damned Rabbit Mask"
	desc = "An eerie visage covered with a light, almost reflective fur."
	icon =  'fulp_modules/icons/antagonists/monster_hunter/weapons.dmi'
	icon_state = "rabbit_mask"
	worn_icon = 'fulp_modules/icons/antagonists/monster_hunter/worn_mask.dmi'
	worn_icon_state = "rabbit_mask"
	clothing_flags = MASKINTERNALS
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	flash_protect = FLASH_PROTECTION_WELDER
	resistance_flags = FIRE_PROOF | ACID_PROOF
	///the paradox rabbit ability
	var/datum/action/cooldown/paradox/paradox
	///teleporting to the wonderland
	var/datum/action/cooldown/wonderland_drop/wonderland


/obj/item/clothing/mask/cursed_rabbit/Initialize(mapload)
	. = ..()
	generate_abilities()

/obj/item/clothing/mask/cursed_rabbit/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("You can use this mask to teleport to Wonderland for a short period of time.")
		. += span_notice("It can also be used to phase through reality by repeatedly transposing your location with that of a paradox rabbit.")
		. += span_boldnotice("Do not leave it in Wonderland unless you wish to risk losing it forever.")

/obj/item/clothing/mask/cursed_rabbit/proc/generate_abilities()
	var/datum/action/cooldown/paradox/para = new
	if(!para.landmark || !para.chessmark)
		return
	paradox = para
	var/datum/action/cooldown/wonderland_drop/drop = new
	if(!drop.landmark)
		return
	wonderland = drop


/obj/item/clothing/mask/cursed_rabbit/equipped(mob/living/carbon/human/user,slot)
	..()
	if(!paradox)
		return
	if(!wonderland)
		return
	if(!(slot & ITEM_SLOT_MASK))
		return
	if(!IS_MONSTERHUNTER(user))
		return
	paradox.Grant(user)
	wonderland.Grant(user)


/obj/item/clothing/mask/cursed_rabbit/dropped(mob/user)
	. = ..()
	if(!paradox)
		return
	if(paradox.owner != user)
		return
	paradox.Remove(user)
	if(!wonderland)
		return
	if(wonderland.owner != user)
		return
	wonderland.Remove(user)

/obj/item/rabbit_locator
	name = "Accursed Red Queen card"
	desc = "A card bearing the sinister face of an unknown monarch. It is otherwise unremarkable."
	icon = 'fulp_modules/icons/antagonists/monster_hunter/weapons.dmi'
	icon_state = "locator"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = INDESTRUCTIBLE
	///the hunter the card is tied too
	var/datum/antagonist/monsterhunter/hunter
	///cooldown for the locator
	var/cooldown = TRUE

	COOLDOWN_DECLARE(locator_timer)


/obj/item/rabbit_locator/Initialize(mapload, datum/antagonist/monsterhunter/killer)
	. = ..()
	if(!killer)
		return
	hunter = killer
	hunter.locator = src

/obj/item/rabbit_locator/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("When <b>used in hand</b> this card will vaguely indicate your distance to a nearby rabbit on the station, allowing you to gradually deduce its location.")
		. += span_boldnotice("This card cannot be replaced.")

/obj/item/rabbit_locator/attack_self(mob/user, modifiers)
	if (!COOLDOWN_FINISHED(src, locator_timer))
		return
	if(!cooldown)
		return
	if(!hunter)
		to_chat(user,span_warning("It's just a normal playing card!"))
		return
	if(hunter.owner.current != user)
		to_chat(user,span_warning("It's just a normal playing card!"))
		return
	if(!is_station_level(user.loc.z))
		to_chat(user,span_warning("The card cannot be used here..."))
		return
	var/distance = get_minimum_distance(user)
	var/sound_value
	if(distance >= 50)
		sound_value = 0
		to_chat(user,span_warning("Too far away..."))
	if(distance >= 40 && distance < 50)
		sound_value = 20
		to_chat(user,span_warning("You feel the slightest hint..."))
	if(distance >=30 && distance < 40)
		sound_value = 40
		to_chat(user,span_warning("You feel a mild hint..."))
	if(distance >=20 && distance < 30)
		sound_value = 60
		to_chat(user,span_warning("You feel a strong hint..."))
	if(distance >= 10 && distance < 20)
		sound_value = 80
		to_chat(user,span_warning("You feel a VERY strong hint..."))
	if(distance < 10)
		sound_value = 100
		to_chat(user,span_warning("Here... its definitely here!"))
	user.playsound_local(src, 'fulp_modules/features/antagonists/monster_hunter/sounds/rabbitlocator.ogg',sound_value)
	COOLDOWN_START(src, locator_timer, 7 SECONDS)

/obj/item/rabbit_locator/proc/get_minimum_distance(mob/user)
	var/dist=1000
	if(!hunter)
		return
	if(!hunter.rabbits.len)
		return
	var/obj/effect/selected_bunny
	for(var/obj/effect/located as anything in hunter.rabbits)
		if(get_dist(user,located) < dist)
			dist = get_dist(user,located)
			selected_bunny = located
	var/z_difference = abs(selected_bunny.z - user.z)
	if(dist < 50 && z_difference != 0)
		to_chat(user,span_warning("[z_difference] [z_difference == 1 ? "floor" : "floors"] [selected_bunny.z > user.z ? "above" : "below"]..."))
	return dist

/obj/item/rabbit_locator/Destroy()
	if(hunter)
		hunter.locator = null
		hunter = null
	return ..()

/obj/item/grenade/jack
	name = "jack in the bomb"
	desc = "Best kids' toy"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'fulp_modules/icons/antagonists/monster_hunter/weapons.dmi'
	icon_state = "jack_in_the_bomb"
	inhand_icon_state = "flashbang"
	worn_icon_state = "grenade"
	det_time = 12 SECONDS
	ex_dev = 1
	ex_heavy = 2
	ex_light = 4
	ex_flame = 2

/obj/item/grenade/jack/examine(mob/user)
	. = ..()
	if(IS_MONSTERHUNTER(user))
		. += span_notice("<b>This is a bomb.</b> Use it with utmost caution.")

/obj/item/grenade/jack/arm_grenade(mob/user, delayoverride, msg = TRUE, volume = 60)
	log_grenade(user) //Inbuilt admin procs already handle null users
	if(user)
		add_fingerprint(user)
		if(msg)
			to_chat(user, span_warning("You prime [src]! [capitalize(DisplayTimeText(det_time))]!"))
	playsound(src, 'fulp_modules/features/antagonists/monster_hunter/sounds/jackinthebomb.ogg', volume, TRUE)
	if(istype(user))
		user.add_mob_memory(/datum/memory/bomb_planted, protagonist = user, antagonist = src)
	active = TRUE
	icon_state = initial(icon_state) + "_active"
	SEND_SIGNAL(src, COMSIG_GRENADE_ARMED, det_time, delayoverride)
	addtimer(CALLBACK(src, PROC_REF(detonate)), isnull(delayoverride)? det_time : delayoverride)


/obj/item/grenade/jack/detonate(mob/living/lanced_by)
	if (dud_flags)
		active = FALSE
		update_appearance()
		return FALSE

	dud_flags |= GRENADE_USED // Don't detonate if we have already detonated.
	icon_state = "jack_in_the_bomb_live"
	addtimer(CALLBACK(src, PROC_REF(exploding)), 1 SECONDS)


/obj/item/grenade/jack/proc/exploding(mob/living/lanced_by)
	SEND_SIGNAL(src, COMSIG_GRENADE_DETONATE, lanced_by)
	explosion(src, ex_dev, ex_heavy, ex_light, ex_flame)

