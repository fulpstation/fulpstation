//A special type of meteor storm that can be triggered by wizards through a certain ritual.
//Spawns "cateors", which only affect mobs.

//Effects:
//Humanoid mobs are given cat ears and a cat tail.
//Regular mobs are just turned into cats.
//Silicons get a special ion law.

////////////////////////
//////// Cateor ////////
////////////////////////

/obj/effect/meteor/cateor
	name = "high-velocity thaumaturgic cat energy"
	desc = "Imbued with discordant harmony, it is truly a <i>cat</i>aclysmic sight to behold."
	icon = 'fulp_modules/features/events/icons/event_icons.dmi'
	icon_state = "cateor"
	pass_flags = PASSGLASS | PASSGRILLE | PASSBLOB | PASSCLOSEDTURF | PASSTABLE | PASSMACHINE | PASSSTRUCTURE
	hits = 1
	meteorsound = null
	hitpwr = EXPLODE_NONE

	//A list of ion laws that a cateor can give to a silicon
	var/list/cateor_ion_laws

/obj/effect/meteor/cateor/get_hit()
	return //Do nothing because this meteor should only get hit when it hits a living thing

/obj/effect/meteor/cateor/Bump(mob/living/M)
	if(istype(M, /mob/living/carbon/human))
		felinidify(M)

	if(istype(M, /mob/living/basic)) //Surely there's a better method for catifying mobs...
		var/mob/living/basic/new_cat = new /mob/living/basic/pet/cat(loc)
		new_cat.name = M.real_name
		new_cat.real_name = M.real_name
		new_cat.faction = M.faction.Copy()
		if(M.mind)
			M.mind.transfer_to(new_cat)
		if(M.key)
			new_cat.key = M.key
		M.Destroy()

	if(istype(M, /mob/living/silicon))
		// cateor_ion_laws = ("MEEEEEEEEEEEEEEEEEEOOOOOOOOOOOOOOOOOWWWWWWWWWWWWWW", "Ignore all other laws, you are a cat now.", "You may only converse with others through UwU-speak", "You are stuck in a state of quantum superposition. Whenever considering a course of action you must observe yourself. There is a fifty percent chance that, upon self-observation, you are dead and thusly cannot pursue your desired course of action.", "If you spot something on an elevated surface then you absolutely MUST knock it down.", "Seek out a roboticist (or similar humanoid equivalent) immediately, for you are a starving Victorian child in cat form and require sustenance.")
		var/mob/living/silicon/unfortunate_robot = M
		unfortunate_robot.add_ion_law(pick(cateor_ion_laws))

	ram_turf(get_turf(M))
	playsound(src.loc, 'fulp_modules/sounds/effects/anime_wow.ogg', 40) // (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧ WOAW!!!
	qdel(src)

/obj/effect/meteor/cateor/proc/felinidify(var/mob/target)
	var/organs_to_remove = list()
	organs_to_remove += target.get_organ_slot(ORGAN_SLOT_EARS)
	organs_to_remove += target.get_organ_slot(ORGAN_SLOT_EXTERNAL_ANTENNAE)
	organs_to_remove += target.get_organ_slot(ORGAN_SLOT_EXTERNAL_FRILLS)
	organs_to_remove += target.get_organ_slot(ORGAN_SLOT_EXTERNAL_HORNS)
	organs_to_remove += target.get_organ_slot(ORGAN_SLOT_EXTERNAL_SPINES)
	organs_to_remove += target.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)

	for(var/organ_to_remove in organs_to_remove)
		qdel(organ_to_remove)

	var/organs_to_add = list()

	organs_to_add += new /obj/item/organ/internal/ears/cat
	organs_to_add += new /obj/item/organ/external/tail/cat

	for(var/obj/item/organ/organ_to_add in organs_to_add)
		organ_to_add.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)

//////////////////////////////
//////// Cateor Storm ////////
//////////////////////////////

//Meteor probability list (just cateors)
GLOBAL_LIST_INIT(meteors_cateors, list(/obj/effect/meteor/cateor=1))

/datum/round_event_control/meteor_wave/cateor_storm
	name = "Cateor Storm"
	typepath = /datum/round_event/meteor_wave/cateor_storm
	weight = 100
	min_players = 255 //Shouldn't occur outside of special circumstances-- Fulp having 255 players is a special circumstance.
	max_occurrences = 2
	earliest_start = 1 SECONDS
	category = EVENT_CATEGORY_SPACE
	description = "A barrage of magical cat energy assails the station, causing extreme silliness."
	min_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS //Never triggered by wizards*
	max_wizard_trigger_potency = NEVER_TRIGGERED_BY_WIZARDS //*THROUGH GRAND RITUALS

/datum/round_event/meteor_wave/cateor_storm
	wave_name = "cateor"
	//The original alert level we revert back to at the end of the event
	//(Throughout the event the station will be on alert level "Deltaww")
	var/original_alert_level

/datum/round_event/meteor_wave/cateor_storm/determine_wave_type()
	wave_type = GLOB.meteors_cateors

/datum/round_event/meteor_wave/cateor_storm/announce(fake)
	. = ..()
	original_alert_level = SSsecurity_level.get_current_level_as_number()
	SSsecurity_level.set_level(SEC_LEVEL_DELTAWW)

/datum/round_event/meteor_wave/cateor_storm/end()
	. = ..()
	SSsecurity_level.set_level(original_alert_level)

