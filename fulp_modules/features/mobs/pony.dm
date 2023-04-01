/mob/living/simple_animal/hostile/pony
	name = "Pony"
	desc = "Is that a fucking Pony?"
	icon = 'fulp_modules/features/mobs/pony.dmi'
	icon_state = "pony"
	gender = NEUTER
	health = 150
	maxHealth = 150
	obj_damage = 60
	melee_damage_lower = 20
	melee_damage_upper = 20
	response_help_continuous = "prods"
	response_help_simple = "prod"
	response_disarm_continuous = "challenges"
	response_disarm_simple = "challenge"
	response_harm_continuous = "thumps"
	response_harm_simple = "thump"
	attack_verb_continuous = "uses the power of friendship to kick"
	attack_verb_simple = "kick"
	speak_emote = list("hisses")
	combat_mode = TRUE
	attack_sound = 'sound/weapons/punch1.ogg'
	attack_vis_effect = ATTACK_EFFECT_KICK
	del_on_death = TRUE
	var/list/pony_skins = list(
	"applejack",
	"clownie",
	"fleur",
	"fluttershy",
	"luna",
	"lyra",
	"mac",
	"pinkie",
	"rainbow",
	"rarity",
	"tia",
	"trixie_a_cape",
	"trixie_a_full",
	"twilight",
	"vinyl",
	"whooves",
	"pony",
	)

/mob/living/simple_animal/hostile/pony/Initialize(mapload)
	icon_state = "[pick(pony_skins)]"
	. = ..()
