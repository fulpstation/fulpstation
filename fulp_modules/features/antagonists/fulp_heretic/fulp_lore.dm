/**
 * # The path of tomfoolery.
 *
 * Goes as follows:
 *
 * beef blade
 * bwoink grasp
 * unhinging glare
 * 	side paths to mind gate and void cloak
 * beef mark
 * breakfast ritual
 * antagroll
 * placebo batong
 * 	side paths to curse of corrosion and wave of desparation
 * slippery blade
 * pony summon
 * TOM FULP
 */
#define PATH_FOOL "Fool Path"

//first of all, set up our colors
/datum/antagonist/heretic/New()
	. = ..()
	path_to_ui_color[PATH_FOOL] = "red"
	path_to_rune_color[PATH_FOOL] = COLOR_MOSTLY_PURE_PINK

//a special knowledge that locks all the other paths
/datum/heretic_knowledge/fool_lock
	name = "Day of the Fool"
	desc = "Locks all the paths other than Path of the Fool to you."
	gain_text = "Once a year, the Mansus-gates align. All the doors shut and the pathways barred... \
		But a different path opens, one only a fool would walk..."
	banned_knowledge = list(
		/datum/heretic_knowledge/limited_amount/starting/base_ash,
		/datum/heretic_knowledge/limited_amount/starting/base_flesh,
		/datum/heretic_knowledge/limited_amount/starting/base_rust,
		/datum/heretic_knowledge/limited_amount/starting/base_void,
		/datum/heretic_knowledge/limited_amount/starting/base_blade,
		/datum/heretic_knowledge/limited_amount/starting/base_cosmic,
		/datum/heretic_knowledge/limited_amount/starting/base_knock,
		/datum/heretic_knowledge/limited_amount/starting/base_moon,
	)
	route = PATH_START


/datum/heretic_knowledge/limited_amount/starting/base_beef
	name = "A Taste of Beef"
	desc = "Opens up the Path of the Fool to you. \
		Allows you to transmute a slab of meat and a knife into the beefblade. \
		You can only create two at a time. \
		You can not break it like you would a normal sickly blade, but you can take a bite out of it to teleport to a random location. \
		You can also feed it to heathens to force this effect upon them. \
		Finally, it works as a kitchen knife, slicing food with ease."
	gain_text = "I have met a peculiar man today, a man made of beef. \
		He claimed to work his job at fulpstation, and promised to show me around, one glorious day."
	next_knowledge = list(/datum/heretic_knowledge/fulp_grasp)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/food/meat/slab = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/beef)
	route = PATH_FOOL

//we need to load the map, for historic reasons we wait until research
/datum/heretic_knowledge/limited_amount/starting/base_beef/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	//this is how wonderland does it I think it should work here too???
	var/datum/map_template/heretic_sacrifice_room_fool/special_map = new()
	special_map.load_new_z()


/datum/heretic_knowledge/fulp_grasp
	name = "Bwoinking Grasp"
	desc = "Your Mansus Grasp will now emit an audible bwoink."
	gain_text = "The Moderators rule the Fulpites with their knowledge of the Variables and mastery of the Ban Hammer... \
		This is just a little piece of their vast power, a mansus-tone which makes mortals tremble."
	next_knowledge = list(/datum/heretic_knowledge/spell/door)
	cost = 1
	route = PATH_FOOL

/datum/heretic_knowledge/fulp_grasp/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, PROC_REF(on_mansus_grasp))

/datum/heretic_knowledge/fulp_grasp/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, list(COMSIG_HERETIC_MANSUS_GRASP_ATTACK))

/datum/heretic_knowledge/fulp_grasp/proc/on_mansus_grasp(mob/living/source, mob/living/target)
	SIGNAL_HANDLER

	playsound(target, 'sound/effects/adminhelp.ogg', 100)


/datum/heretic_knowledge/spell/door
	name = "Shed Guardian's Ways"
	desc = "Grants you Unhinging Glare - a spell that makes airlocks sentient. \
		Do be aware they have their own will and may not be your mindless servants..."
	gain_text = "Beneath the skin of Fulpstation lay a dark place known as the Shed. \
		Its guardian taught me how to unhinge any obstacle in my way..."
	next_knowledge = list(
		/datum/heretic_knowledge/mark/beef_mark,
		/datum/heretic_knowledge/void_cloak,
		/datum/heretic_knowledge/spell/mind_gate,
	)
	spell_to_add = /datum/action/cooldown/spell/pointed/ascend_door
	cost = 1
	route = PATH_FOOL


/datum/heretic_knowledge/mark/beef_mark
	name = "Mark of Beef"
	desc = "Your Mansus Grasp now applies the Mark of Beef. The mark is triggered from an attack with your Beefy Blade. \
		When triggered, the victim will themselves become a beefman. \
		If already a beefman or immune, their surroundings will become meat instead."
	gain_text = "The Beefmen of Fulpstation see things other mortals do not and know every secret. \
		That is the torture I will inflict upon those who oppose me. \
		The beef is only more ravenous with each sacrifice..."
	next_knowledge = list(/datum/heretic_knowledge/breakfast_ritual)
	route = PATH_FOOL
	mark_type = /datum/status_effect/eldritch/beef


/datum/heretic_knowledge/breakfast_ritual
	name = "Ritual of Knowledge"
	desc = "A transmutation ritual that rewards 4 points and can only be completed once."
	gain_text = "Everything can be a key to a balanced breakfast. I must be wary and wise."
	abstract_parent_type = /datum/heretic_knowledge/knowledge_ritual
	mutually_exclusive = TRUE
	cost = 1
	priority = MAX_KNOWLEDGE_PRIORITY - 10
	var/was_completed = FALSE

	next_knowledge = list(/datum/heretic_knowledge/spell/antagroll)
	route = PATH_FOOL

	required_atoms = list(
		/obj/item/food/branrequests = 1,
		/obj/item/reagent_containers/condiment/milk = 1,
		/obj/item/food/meat/bacon = 1,
		/obj/item/food/friedegg = 2,
		/obj/item/reagent_containers/cup/glass/bottle/juice/orangejuice = 1,
	)

	result_atoms = list(/obj/item/food/salad/eldritch)

/datum/heretic_knowledge/breakfast_ritual/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	var/list/requirements_string = list()

	to_chat(user, span_hierophant("The [name] requires the following:"))
	for(var/obj/item/path as anything in required_atoms)
		var/amount_needed = required_atoms[path]
		to_chat(user, span_hypnophrase("[amount_needed] [initial(path.name)]\s..."))
		requirements_string += "[amount_needed == 1 ? "":"[amount_needed] "][initial(path.name)]\s"

	to_chat(user, span_hierophant("Completing it will reward you 4 points. You can check the knowledge in your Researched Knowledge to be reminded."))

	desc = "Allows you to transmute [english_list(requirements_string)] for 4 points. This can only be completed once."

/datum/heretic_knowledge/breakfast_ritual/can_be_invoked(datum/antagonist/heretic/invoker)
	return !was_completed

/datum/heretic_knowledge/breakfast_ritual/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	return !was_completed

/datum/heretic_knowledge/breakfast_ritual/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()

	was_completed = TRUE
	var/drain_message = "SPECIAL LIMITED EDITION CEREAL."
	to_chat(user, span_boldnotice("[name] completed!"))
	to_chat(user, span_hypnophrase(span_big("[drain_message]")))
	desc += " (Completed!)"
	log_heretic_knowledge("[key_name(user)] completed a [name] at [worldtime2text()].")
	//TODO: custom breakfast memory
	user.add_mob_memory(/datum/memory/heretic_knowledge_ritual)
	return


/datum/heretic_knowledge/spell/antagroll
	name = "Method of the Mentors"
	desc = "Grants you Rolling of the Antagonist, a spell that allows you to roll over and crush."
	gain_text = "Madness of the Mentors knew no bounds. They searched for any way to escape the Basement, \
		even throwing themselves into the gaping expanse of the void... \
		But this torture has taught them a valuable lesson..."
	next_knowledge = list(/datum/heretic_knowledge/batong)
	spell_to_add = /datum/action/cooldown/spell/pointed/antagroll
	cost = 1
	route = PATH_FOOL


/datum/heretic_knowledge/batong
	name = "Charging of the Batong"
	desc = "Allows you to transmute a stunbaton, an arm and a recharger to create a Charged Batong. \
		This weapon fires battery charges. \
		If hit, the victim will be set to arrest and be chased by imaginary securitrons. \
		A mindshield will absorb the charge, preventing these effects but breaking in the process."
	gain_text = "I asked \"where I charge batong\", and the Mentors answered me, and this is the answer, a horrifying rite..."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/fulp,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/curse/corrosion,
		/datum/heretic_knowledge/spell/opening_blast,
	)
	required_atoms = list(
		/obj/item/melee/baton/security = 1,
		//sadly, batong seems to be unobtainable...
		//obj/item/toy/plush/batong = 1,
		list(/obj/item/bodypart/arm/left, /obj/item/bodypart/arm/right) = 1,
		/obj/machinery/recharger = 1,
	)
	result_atoms = list(/obj/item/gun/magic/staff/charged_batong)
	cost = 1
	route = PATH_FOOL


/datum/heretic_knowledge/blade_upgrade/fulp
	name = "Gravy Blade"
	desc = "Your blades now create slippery tiles when hitting heathens."
	gain_text = "I have found a delicious gravy to go with the beef, and now my enemies shall taste my wrath..."
	next_knowledge = list(/datum/heretic_knowledge/summon/pony)
	route = PATH_FOOL

/datum/heretic_knowledge/blade_upgrade/fulp/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	var/turf/location = get_turf(target)
	if(isopenturf(location))
		var/turf/open/ol = location
		ol.MakeSlippery(TURF_WET_LUBE, min_wet_time = 1 SECONDS, wet_time_to_add = 5 SECONDS)
	to_chat(target, span_notice("You can taste gravy."))


/datum/heretic_knowledge/summon/pony
	name = "Magic of the Friendship"
	desc = "Allows you to transmute two slabs of meat, a crayon and a heart to create a pony. \
		Ponies come in many variants with unpredictable spells, but they always excel at crushing heathens."
	gain_text = "The Administrators showed me the tools of their craft, \
		and the ways of creation of monsters I would never have imagined before. \
		They wield an ancient and terrible magic that now is mine to command..."
	next_knowledge = list(/datum/heretic_knowledge/ultimate/fulp_final)
	required_atoms = list(
		/obj/item/food/meat/slab = 2,
		/obj/item/toy/crayon = 1,
		/obj/item/organ/internal/heart = 1,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/pony/random
	cost = 1
	route = PATH_FOOL
	poll_ignore_define = POLL_IGNORE_HERETIC_MONSTER


/datum/heretic_knowledge/ultimate/fulp_final
	name = "The Fulp Moment"
	desc = "The ascension ritual of the Path of Fool. \
		Bring 3 beefman corpses to a transmutation rune to complete the ritual. \
		When completed, HE ARRIVES. You also get a cake for your hard work."
	gain_text = "So many have walked this path before me... So many have strived to reach this power... \
		Yet they all made a fatal mistake... Performed too many actions in a minute, attracting the attention of the Administrators. \
		But this time is different... I will not join them! \
		The power is mine and He is on my side, all be revealed in the moment of Fulp!!!"
	route = PATH_FOOL

	//let's keep Tom saved
	var/obj/tom_fulp/tom

/datum/heretic_knowledge/ultimate/fulp_final/is_valid_sacrifice(mob/living/carbon/human/sacrifice)
	. = ..()
	if(!.)
		return

	var/datum/dna/sac_dna = sacrifice.has_dna()
	if(!sac_dna)
		return FALSE
	if(istype(sac_dna.species, /datum/species/beefman))
		return TRUE
	return FALSE

/datum/heretic_knowledge/ultimate/fulp_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	priority_announce(
		text = "[generate_heretic_text()] Fool of fools, [user.real_name], has ascended! The Fulp Moment is upon us! Get some of the cake before it's all devoured! [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = ANNOUNCER_SPANOMALIES,
		color_override = "pink",
	)

	tom = new /obj/tom_fulp(loc)
	tom.set_master(user)

	RegisterSignal(user, COMSIG_LIVING_DEATH, PROC_REF(on_death))

	//the lag spike spell
	var/datum/action/cooldown/spell/lag_spike/fulp_spell = new(user.mind)
	fulp_spell.nexus = tom
	fulp_spell.Grant(user)

	//cake
	new /obj/structure/table/wood(loc)
	new /obj/item/food/cake/fulp_ascension(loc)

/datum/heretic_knowledge/ultimate/fulp_final/proc/on_death(datum/source)
	SIGNAL_HANDLER

	if(tom)
		qdel(tom)
		tom = null
