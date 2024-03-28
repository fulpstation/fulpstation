/mob/living/basic/heretic_summon/pony
	name = "Pony"
	desc = "The My Little Pony brand describes its characters as ponies. As the name suggests, they usually consist of small colorful \
			ponies. The characters on the various My Little Pony television shows and movies are depicted with varying degrees of \
			fantasy elements, like the ability to speak, fly, and use magic. This one is actually an eldritch monster."
	icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/pony.dmi'
	icon_state = "pony"
	gender = NEUTER
	health = 100
	maxHealth = 100
	obj_damage = 60
	melee_damage_lower = 5
	melee_damage_upper = 15
	response_help_continuous = "prods"
	response_help_simple = "prod"
	response_disarm_continuous = "challenges"
	response_disarm_simple = "challenge"
	response_harm_continuous = "clops"
	response_harm_simple = "clops"
	attack_verb_continuous = "uses the power of friendship to kick"
	attack_verb_simple = "kick"
	speak_emote = list("neighs")
	combat_mode = TRUE
	attack_sound = 'sound/weapons/punch1.ogg'
	attack_vis_effect = ATTACK_EFFECT_KICK
	var/list/pony_skins = list(
		"applejack",
		"clownie",
		"dash",
		"fleur",
		"fluttershy",
		"luna",
		"lyra",
		"mac",
		"pinkie",
		"rarity",
		"tia",
		"trixie",
		"twilight",
		"vinyl",
		"whooves",
	)

	var/static/list/actions_to_add = list(
		/datum/action/cooldown/spell/pointed/antagroll = BB_GENERIC_ACTION,
	)

	var/list/powers_by_name = list(
		"applejack" = /datum/action/cooldown/spell/pointed/barnyardcurse/pony,
		//clowns are known for using knives in battle
		"clownie" = /datum/action/cooldown/spell/pointed/projectile/furious_steel,
		"dash" = /datum/action/cooldown/spell/pointed/projectile/lightningbolt/pony,
		"fleur" = /datum/action/cooldown/spell/aoe/knock/pony,
		"fluttershy" = /datum/action/cooldown/spell/conjure/bee/pony,
		"luna" = /datum/action/cooldown/spell/pointed/projectile/moon_parade,
		"lyra" = /datum/action/cooldown/spell/emp/disable_tech/pony,
		//he's red so he gets a violent spell
		"mac" = /datum/action/cooldown/spell/pointed/apetra_vulnera,
		//out of excuses. Pinkie Pie has fire cascade because.
		"pinkie" = /datum/action/cooldown/spell/fire_cascade,
		"rarity" = /datum/action/cooldown/spell/aoe/magic_missile/pony,
		"tia" = /datum/action/cooldown/spell/pointed/void_phase,
		"trixie" = /datum/action/cooldown/spell/teleport/area_teleport/wizard/pony,
		"twilight" = /datum/action/cooldown/spell/pointed/projectile/star_blast,
		"vinyl" = /datum/action/cooldown/spell/summon_dancefloor/pony,
		"whooves" = /datum/action/cooldown/spell/timestop/pony,
	)

/mob/living/basic/heretic_summon/pony/Initialize(mapload)
	. = ..()

	grant_actions_by_list(actions_to_add)


/mob/living/basic/heretic_summon/pony/random

/mob/living/basic/heretic_summon/pony/random/Initialize(mapload)
	icon_state = "[pick(pony_skins)]"
	name = capitalize(icon_state)
	var/action = powers_by_name[icon_state]
	var/datum/action/ability = new action(src)
	ability.Grant(src)
	return ..()
