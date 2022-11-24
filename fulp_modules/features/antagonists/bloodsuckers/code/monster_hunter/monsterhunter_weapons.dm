#define upgraded_val(x,y) ( CEILING((x * (1.07 ** y)), 1) )
#define CALIBER_BLOODSILVER "bloodsilver"

/obj/item/melee/trick_weapon
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons.dmi'
	lefthand_file = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons_lefthand.dmi'
	righthand_file = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons_righthand.dmi'
	///upgrade level of the weapon
	var/upgrade_level
	///base force when transformed
	var/on_force
	///base force when in default state
	var/base_force
	///default name of the weapon
	var/base_name
	///is the weapon in its transformed state?
	var/enabled = FALSE

/obj/item/melee/trick_weapon/attack(mob/target, mob/living/user, params) //our weapon does 25% less damage on non monsters
	var/old_force = force
	if(!(target.mind?.has_antag_datum(/datum/antagonist/changeling)) && !IS_BLOODSUCKER(target))
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
	slot_flags = ITEM_SLOT_BELT
	block_chance = 20
	on_force = 20
	base_force = 17
	throwforce = 12
	damtype = BURN
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	///ready to launch a beam attack?
	var/charged = TRUE


/obj/item/melee/trick_weapon/darkmoon/Initialize(mapload)
	. = ..()
	force = base_force
	AddComponent(/datum/component/transforming, \
		force_on = on_force , \
		throwforce_on = 20, \
		throw_speed_on = throw_speed, \
		sharpness_on = SHARP_EDGED, \
		w_class_on = WEIGHT_CLASS_BULKY)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, .proc/on_transform)

/obj/item/melee/trick_weapon/darkmoon/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER
	balloon_alert(user, active ? "extended" : "collapsed")
	inhand_icon_state = active ? "darkmoon" : "darkmoon_hilt"
	enabled = active
	force = active ? upgraded_val(on_force, upgrade_level) : upgraded_val(base_force, upgrade_level)
	return COMPONENT_NO_DEFAULT_MESSAGE


/obj/item/melee/trick_weapon/darkmoon/attack_secondary(atom/target, mob/living/user, clickparams)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/melee/trick_weapon/darkmoon/afterattack_secondary(atom/target, mob/living/user, clickparams)
	if(!enabled)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!charged)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(target == user)
		balloon_alert(user, "can't aim at yourself!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	fire_moonbeam(target, user, clickparams)
	user.changeNext_move(CLICK_CD_MELEE)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/melee/trick_weapon/darkmoon/proc/fire_moonbeam(atom/target, mob/living/user, clickparams)
	if(!charged)
		return
	var/modifiers = params2list(clickparams)
	var/turf/proj_turf = user.loc
	if(!isturf(proj_turf))
		return
	var/obj/projectile/moonbeam/moon = new(proj_turf)
	moon.preparePixelProjectile(target, user, modifiers)
	moon.firer = user
	moon.fire()
	charged = FALSE
	addtimer(CALLBACK(src, .proc/recharge), 4 SECONDS)


/obj/item/melee/trick_weapon/darkmoon/proc/recharge()
	charged = !charged

/obj/projectile/moonbeam
	name = "Moonlight"
	icon = 'icons/effects/effects.dmi'
	icon_state = "plasmasoul"
	damage = 10
	damage_type = BURN
	range = 10



/obj/item/melee/trick_weapon/threaded_cane
	name = "Threaded Cane"
	base_name = "Threaded Cane"
	desc = "A blind man's whip."
	icon_state = "threaded_cane"
	inhand_icon_state = "threaded_cane"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	block_chance = 20
	on_force = 15
	base_force = 18
	throwforce = 12
	reach = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
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
		w_class_on = WEIGHT_CLASS_BULKY)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, .proc/on_transform)

/obj/item/melee/trick_weapon/threaded_cane/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER
	balloon_alert(user, active ? "extended" : "collapsed")
	inhand_icon_state = active ? "chain" : "threaded_cane"
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
	slot_flags = ITEM_SLOT_BELT
	block_chance = 20
	base_force = 20
	on_force = 23
	throwforce = 12
	reach = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
	damtype = BURN
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	var/charged = TRUE
	var/force_unwielded = 20
	var/force_wielded = 25



/obj/item/melee/trick_weapon/hunter_axe/Initialize(mapload)
	. = ..()
	force = base_force
	AddComponent(/datum/component/two_handed, force_unwielded=base_force, force_wielded= on_force, icon_wielded="[base_icon_state]1", wield_callback = CALLBACK(src, .proc/on_wield), unwield_callback = CALLBACK(src, .proc/on_unwield))

/obj/item/melee/trick_weapon/hunter_axe/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/melee/trick_weapon/hunter_axe/proc/on_wield(obj/item/source)
	enabled = TRUE

/obj/item/melee/trick_weapon/hunter_axe/proc/on_unwield(obj/item/source)
	enabled = FALSE

/obj/item/rabbit_eye
	name = "Rabbit eye"
	desc = "An item that resonates with trick weapons."
	icon_state = "rabbit_eye"
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons.dmi'

/obj/item/rabbit_eye/proc/upgrade(obj/item/melee/trick_weapon/killer, mob/user)
	if(killer.upgrade_level >= 3)
		user.balloon_alert(user, "Already at maximum upgrade!")
		return
	killer.upgrade_level++
	var/number = killer.enabled ? killer.on_force : killer.base_force
	var/two_handed = FALSE
	for(var/datum/component/two_handed/hands as anything in killer.GetComponents(/datum/component/two_handed))
		if(!hands) //for weapons that use the two handed component rather than the transform component
			continue
		hands.force_wielded = upgraded_val(killer.on_force, killer.upgrade_level)
		hands.force_unwielded =  upgraded_val(killer.base_force, killer.upgrade_level)
		killer.force = killer.enabled ? hands.force_wielded : hands.force_unwielded
		two_handed = TRUE
	if(!two_handed)
		killer.force = upgraded_val(number, killer.upgrade_level)
	killer.name = "[killer.base_name] +[killer.upgrade_level]"
	to_chat(user, span_warning ("The [src] crumbles away..."))
	qdel(src)

/obj/item/gun/ballistic/revolver/hunter_revolver
	name = "\improper Hunter's Revolver"
	desc = "Does minimal damage but slows down the enemy."
	icon_state = "revolver"
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/bloodsilver
	initial_caliber = CALIBER_BLOODSILVER

/datum/movespeed_modifier/silver_bullet
	movetypes = GROUND
	multiplicative_slowdown = 4
	flags = IGNORE_NOSLOW


/obj/item/ammo_box/magazine/internal/cylinder/bloodsilver
	name = "detective revolver cylinder"
	ammo_type = /obj/item/ammo_casing/silver
	caliber = CALIBER_BLOODSILVER
	max_ammo = 2

/obj/item/ammo_casing/silver
	name = "Bloodsilver casing"
	desc = "A Bloodsilver bullet casing."
	icon_state = "bloodsilver"
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons.dmi'
	projectile_type = /obj/projectile/bullet/bloodsilver
	caliber = CALIBER_BLOODSILVER


/obj/projectile/bullet/bloodsilver
	name = "Bloodsilver bullet"
	damage = 3
	ricochets_max = 4

/obj/projectile/bullet/bloodsilver/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(!iscarbon(target))
		return
	var/mob/living/carbon/man = target
	if(!man)
		return
	if(man.has_movespeed_modifier(/datum/movespeed_modifier/silver_bullet))
		return
	if(!(IS_BLOODSUCKER(man)) && !(man.mind.has_antag_datum(/datum/antagonist/changeling)))
		return
	man.add_movespeed_modifier(/datum/movespeed_modifier/silver_bullet)
	addtimer(CALLBACK(man, /mob/living/carbon/proc/remove_bloodsilver), 20 SECONDS)

/mob/living/carbon/proc/remove_bloodsilver()
	if (src.has_movespeed_modifier(/datum/movespeed_modifier/silver_bullet))
		remove_movespeed_modifier(/datum/movespeed_modifier/silver_bullet)

/datum/action/cooldown/spell/conjure_item/blood_silver
	name = "Create bloodsilver bullet"
	desc = "Wield your blood and mold it into a bloodsilver bullet"
	icon_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons.dmi'
	button_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons.dmi'
	button_icon_state = "blood_silver"
	cooldown_time = 2 MINUTES
	item_type = /obj/item/ammo_casing/silver
	delete_old = FALSE

/datum/action/cooldown/spell/blood_silver/conjure_item/cast(mob/living/carbon/cast_on)
	if(cast_on.blood_volume < BLOOD_VOLUME_NORMAL)
		to_chat(cast_on, span_warning ("Using this ability would put our health at risk!"))
		return
	. = ..()
	cast_on.blood_volume -= 50

/obj/structure/table/weaponsmith
	name = "Weapon Forge"
	desc = "Table used by blacksmiths to upgrade weapons."
	icon = 'icons/obj/smooth_structures/fancy_table_black.dmi'
	icon_state = "fancy_table_black-0"
	base_icon_state = "fancy_table_black"
	resistance_flags = INDESTRUCTIBLE


/obj/structure/table/weaponsmith/attackby(obj/item/I, mob/living/user, params)
	if(!istype(I, /obj/item/rabbit_eye))
		return ..()
	var/obj/item/rabbit_eye/eye = I
	var/obj/item/melee/trick_weapon/tool
	for(var/obj/item/weapon in src.loc.contents)
		if(!istype(weapon, /obj/item/melee/trick_weapon))
			continue
		tool = weapon
		break
	if(!tool)
		to_chat(user, span_warning ("Place your weapon upon the table before upgrading it!"))
		return
	eye.upgrade(tool,user)


/obj/item/clothing/mask/cursed_rabbit
	name = "Damned Rabbit Mask"
	desc = "Slip into the wonderland."
	icon =  'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons.dmi'
	icon_state = "rabbit_mask"
	worn_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/worn_mask.dmi'
	worn_icon_state = "rabbit_mask"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	var/datum/action/cooldown/paradox/paradox


/obj/item/clothing/mask/cursed_rabbit/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/paradox/rabby = new
	if(!rabby)
		return
	rabby.chessmark = GLOB.wonderland_marks["Wonderchess landmark"]
	if(!rabby.chessmark)
		return
	paradox = rabby

/obj/item/clothing/mask/cursed_rabbit/equipped(mob/living/carbon/human/user,slot)
	..()
	if(!paradox)
		return
	if(!(slot & ITEM_SLOT_MASK))
		return
	paradox.Grant(user)

/obj/item/clothing/mask/cursed_rabbit/dropped(mob/user)
	. = ..()
	paradox.Remove(user)

/obj/item/rabbit_locator
	name = "Accursed Red Queen card"
	desc = "Hunts down the white rabbits."
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons.dmi'
	icon_state = "locator"
	w_class = WEIGHT_CLASS_SMALL
	var/datum/brain_trauma/special/rabbit_hole/mental
	var/cooldown = TRUE


/obj/item/rabbit_locator/Initialize(mapload, datum/antagonist/monsterhunter/hunter)
	. = ..()
	if(!hunter)
		return
	mental = hunter.sickness

/obj/item/rabbit_locator/attack_self(mob/user, modifiers)
	if(!cooldown)
		return
	if(!mental)
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
		to_chat(user,span_warning("You feel an intense hint..."))
	if(distance < 10)
		sound_value = 100
		to_chat(user,span_warning("Here...its definitely here!"))
	playsound(src, 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/sounds/rabbitlocator.ogg',sound_value)
	cooldown = !cooldown
	addtimer(CALLBACK(src, .proc/recharge), 9 SECONDS)


/obj/item/rabbit_locator/proc/recharge()
	cooldown = !cooldown

/obj/item/rabbit_locator/proc/get_minimum_distance(mob/user)
	var/dist=1000
	if(!mental)
		return
	if(!mental.white_rabbits.len)
		return
	for(var/obj/effect/located as anything in mental.white_rabbits)
		if(get_dist(user,located) < dist)
			dist = get_dist(user,located)
	return dist
