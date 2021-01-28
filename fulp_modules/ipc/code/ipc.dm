/datum/species/ipc
	name = "I.P.C."
	id = "ipc"
	say_mod = "beeps"
	default_color = "00FF00"
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER,TRAIT_RADIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_NOBREATH,TRAIT_TOXIMMUNE,TRAIT_NOCLONELOSS,TRAIT_GENELESS,TRAIT_STABLEHEART,TRAIT_NO_HUSK)
	species_traits = list(MUTCOLORS_PARTSONLY,LIPS,NOEYESPRITES,NOTRANSSTING,REVIVES_BY_HEALING,ROBOTIC_LIMBS,TRAIT_RESISTCOLD,NOZOMBIE,TRAIT_PIERCEIMMUNE, TRAIT_NOFLASH)
	mutant_bodyparts = list("ipc_screen" = "BSOD", "ipc_antenna" = "None", "ipc_chassis" = "Morpheus Cyberkinetics(Greyscale)")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	burnmod = 1.5
	heatmod = 1.2
	brutemod = 1.5
	siemens_coeff = 1.2 //Not more because some shocks will outright crit you, which is very unfun
	limbs_icon = 'fulp_modules/ipc/icons/ipc_parts.dmi'
	sexes = 0
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)
	mutantbrain = /obj/item/organ/brain/ipc_positron
	mutantstomach = /obj/item/organ/stomach/robot_ipc
	mutantears = /obj/item/organ/ears/robot_ipc
	mutanttongue = /obj/item/organ/tongue/robot_ipc
	mutanteyes = /obj/item/organ/eyes/robot_ipc
	mutantlungs = /obj/item/organ/lungs/robot_ipc
	mutantheart = /obj/item/organ/heart/robot_ipc
	mutantliver = /obj/item/organ/liver/robot_ipc
	exotic_blood = /datum/reagent/fuel/oil
	species_language_holder = /datum/language_holder/ipc
	reagent_flags = PROCESS_SYNTHETIC
	var/datum/action/innate/monitor_change/screen
	var/saved_screen = "Blank"

/datum/species/ipc/spec_life(mob/living/carbon/human/H)
	if(H.stat == SOFT_CRIT || H.stat == HARD_CRIT)
		H.adjustFireLoss(1)
		H.adjust_bodytemperature(13) //We're overheating!!
		if(prob(10))
			to_chat(H, "<span class='warning'>Alert: Critical damage taken! Cooling systems failing!</span>")
			do_sparks(3, TRUE, H)

/datum/species/ipc/spec_revival(mob/living/carbon/human/H)
	. = ..()
	H.dna.features["ipc_screen"] = "BSOD"
	H.update_body()
	H.say("Reactivating [pick("core systems", "central subroutines", "key functions")]...")
	sleep(3 SECONDS)
	H.say("Reinitializing [pick("personality matrix", "behavior logic", "morality subsystems")]...")
	sleep(3 SECONDS)
	H.say("Finalizing setup...")
	sleep(3 SECONDS)
	H.say("Unit [H.real_name] is fully functional. Have a nice day.")
	H.dna.features["ipc_screen"] = saved_screen
	H.update_body()

/datum/species/ipc/spec_death(gibbed, mob/living/carbon/human/C)
	. = ..()
	saved_screen = C.dna.features["ipc_screen"]
	C.dna.features["ipc_screen"] = "BSOD"
	C.update_body()
	sleep(3 SECONDS)
	C.dna.features["ipc_screen"] = null // Turns off their monitor on death.
	C.update_body()

/datum/species/ipc/on_species_gain(mob/living/carbon/human/C)
	. = ..()
	var/obj/item/organ/appendix/appendix = C.getorganslot(ORGAN_SLOT_APPENDIX)
	if(appendix)
		appendix.Remove(C)
		qdel(appendix)
	if(!screen)
		screen = new
		screen.Grant(C)
	var/chassis = C.dna.features["ipc_chassis"]
	if(!chassis)
		return
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.ipc_chassis_list[chassis]
	if(chassis_of_choice)
		limbs_id = chassis_of_choice.icon_state
		if(chassis_of_choice.color_src)
			species_traits += MUTCOLORS
		C.update_body()

/datum/species/ipc/on_species_loss(mob/living/carbon/human/C)
	. = ..()
	if(screen)
		screen.Remove(C)
	..()

/datum/action/innate/monitor_change
	name = "Screen Change"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/monitor_change/Activate()
	var/mob/living/carbon/human/H = owner
	var/new_ipc_screen = input(usr, "Choose your character's screen:", "Monitor Display") as null|anything in GLOB.ipc_screens_list
	if(!new_ipc_screen)
		return
	H.dna.features["ipc_screen"] = new_ipc_screen
	H.update_body()

/datum/species/ipc/check_roundstart_eligible()
	return TRUE

/datum/species/ipc/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_ipc_name()

	var/randname = ipc_name()

	if(lastname)
		randname += " [lastname]"

	return randname
