// - MAP TEMPLATE DATUM - //
/datum/map_template/ruin/space/fulp/ghost_diner
	name = "Space-Ruin Staffed All-American Diner"
	id = "ghost diner"
	description = "A fully staffed american diner, floating in the void of space."
	suffix = "allamericandiner_openforbusiness.dmm"


// - CUSTOM RTG SUBTYPE FOR THE DINER MAP - //
/obj/item/circuitboard/machine/rtg/advanced/pre_upgraded
	name = "Prebuilt RTG"
	build_path = /obj/machinery/power/rtg/advanced/pre_upgraded
	specific_parts = TRUE
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/capacitor/tier4 = 1,
		/datum/stock_part/micro_laser/tier4 = 1,
		/obj/item/stack/sheet/mineral/uranium = 10,
		/obj/item/stack/sheet/mineral/plasma = 5,
	)

/obj/machinery/power/rtg/advanced/pre_upgraded
	name = "prebuilt radioisotope thermoelectric generator"
	desc = "An incredibly expensive RTG that requires highly specific parts to function. "
	circuit = /obj/item/circuitboard/machine/rtg/advanced/pre_upgraded


// - JOB DATUMS - //
/datum/job/fulp_ghostchef
	title = ROLE_GHOST_CHEF

/datum/job/fulp_ghostcook
	title = ROLE_GHOST_COOK

/datum/job/fulp_ghostregular
	title = ROLE_GHOST_REGULAR


// - GHOST ROLE COMPONENT DATUM(S) - //

/// A subtype of the stationstuck component that's primarily intended for use in one ghost role.
/// Turns its (presumably '/mob/living') owner into a pizza if they leave the z-level the component
/// is attatched on.
/datum/component/stationstuck/diner
	punishment = PIZZAFICATION

// Copied over from "/datum/smite/objectify/effect()"
// in 'code\modules\admin\smites\become_object.dm'
/datum/component/stationstuck/diner/punish()
	if(punishment != PIZZAFICATION)
		return ..()

	var/mob/living/future_pizza = parent
	if(message)
		to_chat(future_pizza, span_userdanger("[message]"))

	// We're turning them into a Hawaiian pizza for extra shock value.
	var/atom/transform_path = /obj/item/food/pizza/pineapple
	var/mutable_appearance/pizzafied_player = mutable_appearance(initial(transform_path.icon), initial(transform_path.icon_state))
	pizzafied_player.pixel_x = initial(transform_path.pixel_x)
	pizzafied_player.pixel_y = initial(transform_path.pixel_y)
	var/mutable_appearance/transform_scanline = mutable_appearance('icons/effects/effects.dmi', "transform_effect")

	var/turf/future_pizza_turf = get_turf(future_pizza)
	message_admins("[future_pizza.real_name] ([future_pizza.ckey]) has been turned into a pizza near \
		[ADMIN_VERBOSEJMP(future_pizza_turf)] for attempting to move to a different z_level.")

	future_pizza.transformation_animation(pizzafied_player, 5 SECONDS, transform_scanline.appearance)
	future_pizza.Immobilize(5 SECONDS, ignore_canstun = TRUE)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(objectify), future_pizza, transform_path), 5 SECONDS)


// - GHOST ROLE SPAWNERS - //
/obj/effect/mob_spawn/ghost_role/human/allamerican
	prompt_name = "A real american"
	you_are_text = "A real american, fight for the rights of every man!"
	flavour_text = "Fight what's right, fight for your life!"

// (Implementation of the stationstuck component has been copied over from
// 'fulp_modules\mapping\ruins\space\syndicate_engineer\syndicate_engineer.dm')
/obj/effect/mob_spawn/ghost_role/human/allamerican/special(mob/living/new_spawn)
	. = ..()
	to_chat(new_spawn, span_warning("You have been implanted with a pizzafication implant that will activate if you stray too far from the diner. Glory to Nanotrasen."))
	new_spawn.AddComponent(/datum/component/stationstuck/diner, PIZZAFICATION, "You have left the vicinity of the diner. Your pizzafication implant has been triggered.")

	// Beacons won't spawn as a part of outfit datums for some reason, so we'll spawn ours here.
	var/turf/beacon_spawn_turf = get_turf(new_spawn)
	var/obj/item/beacon/new_beacon = new /obj/item/beacon(beacon_spawn_turf)
	new_spawn.put_in_hands(new_beacon, ignore_animation = TRUE)

/obj/effect/mob_spawn/ghost_role/human/allamerican/chef
	name = "All-American Chef"
	desc = "A cryogenics pod, storing a trained chef to prepare meals when activity is detected in this sector."
	prompt_name = "an all american chef"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a head chef employed by the All American foods company."
	flavour_text = "After a recent accquistion by Nanotrasen, you've been reassigned. \
	Lead the kitchen and ensure your cook has direction. Create culinary masterpieces."
	important_text = "Do not abandon the kitchen! Lead with grace."
	spawner_job_path = /datum/job/fulp_ghostchef
	outfit = /datum/outfit/diner_ghost/fulp_ghostchef

/obj/effect/mob_spawn/ghost_role/human/allamerican/cook
	name = "All-American Cook"
	desc = "A cryogenics pod, storing a trained(?) cook to assist when activity is detected in this sector."
	prompt_name = "an all american cook"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a line cook employed by the All American foods company."
	flavour_text = "After a recent accquistion by Nanotrasen, you've been reassigned. \
	Follow the chef's direction. Do menial tasks. Clean up after the recent Flyperson birthday bash."
	important_text = "Yes chef! You answer directly to the chef."
	spawner_job_path = /datum/job/fulp_ghostcook
	outfit = /datum/outfit/diner_ghost/fulp_ghostcook

/obj/effect/mob_spawn/ghost_role/human/allamerican/regular
	name = "All-American \"Customer\""
	desc = "A cryogenics pod storing a regular customer of the diner. They seem to be sleeping off a serious food coma."
	prompt_name = "an all american customer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a lover of fine dining."
	flavour_text = "After realizing you could claim to be a health inspector (and receive free meals) \
	you began a journey across the Spinward sector (on a quest for free meals). As an ironic punishment \
	for impersonating a food safety official, you are now unwillingly imprisoned on a space diner."
	important_text = "Don't get yourself kicked out: you'll turn into a pizza!"
	spawner_job_path = /datum/job/fulp_ghostregular
	outfit = /datum/outfit/diner_ghost/fulp_ghostregular


// - EXPOSITIONAL POCKET NOTES - //
/obj/item/paper/crumpled/fluff/space_diner_general
	name = "NOTICE: Feeling lonely?"
	color = "#e0e010"
	default_raw_text = {"
<center><h1>No customers?</h1></center>
<p>Try hailing nearby stations over your wall intercomms and telling them that you're open! Anyone with a functional teleporter should be able to make a one-way trip to your restaurant once you and your tracking beacons are out of cryostasis.</p>
<p>Changing the name of the handheld GPS unit in the front airlock will help non-teleporting spacefarers locate you manually. Enjoy your new life.</p>
<p><i><b>NOTE</b>: All proceeds from the Nanotrasen Brand restaurant portal tourism system legally belong to the Nanotrasen Revenue Department. You will receive your salary in full after your six quadrum employment period has ceased. Ensure that these proceeds are kept secure in the manager's safe. Glory to Nanotrasen.</i></p>
	"}

/obj/item/paper/fluff/space_diner_staff
	name = "Notice of Employment"
	desc = "A formal document detailing employment information."

	default_raw_text = {"
<center><h1>Notice of Employment</h1></center>
<center><h2>Issued by the Nanotrasen Department of Humanoid Resource Management</h1></center>
<small><i>This document is to be kept on its recipient at all times as a contingency against any possible amnesia caused by prolonged cryostasis.</small></i>
<p>Welcome to your new life employee. You have applied for the position of <b>CULINARY STAFF</b> on a state of the art stellar dining platform. Given that your employment is not nullified due to a contract violation, you will be receiving <b>WAGE</b> credits at the end of your <b>LONG-TERM</b> shift on <b>STANDARDIZED_INTERSTELLAR_DATE</b>.</p>
<p>On your person you may find the following equipment:</p>
<ol>
<li><b>JOB_EQUIPMENT</b> for <b>EQUIPMENT_PURPOSE</b>.
<li>A Nanotrasen patented tracking beacon to allow for easy transportation between your work
site and any others that might intersect with its orbit. (Please note that you are requested to
turn this beacon off as a means of closing your work site prior to resting.)
<li>One Unauthorized Workplace Leave Prevention (UWLP) subdermal implant.
<li><b><i>INK CARTRIDGE LOW</i></b>
</ol>
	"}

/obj/item/paper/fluff/space_diner_customer
	name = "Notice of Penalization"
	desc = "A stern document conveying civil penalties."
	color = "#b07020"

	default_raw_text = {"
<center><h1>Notice of Penalization</h1></center>
<center><h2>Issued by the Nanotrasen Department of Justice</h2></center>
<small><i>This document is to be kept on its recipient at all times as a contingency against any possible amnesia caused by prolonged cryostasis.</small></i>
<p>By order of the <b>COURT_NAME</b> you, <b>CONVICT_NAME</b>, are hereby sentenced to <b>SENTENCE_DURATION</b> quarter(s) of interment on <b>CORRECTIONAL_FACILITY_NAME</b> for the crime of <b>FELONY_NAME</b>.
<p>Sentencing notes: "Repeat offender, court authorized unusual punishment. Send to a restaurant or something."</p>
	"}


// - OUTFIT DATUMS - //

// Parent datum for our diner ghost roll outfits
/datum/outfit/diner_ghost
	name = "PARENT OUTFIT DATUM; DO NOT USE"

// Sets up the outfit's ID; seen throughout a lot of outfit code for some reason.
// Original source for copied code unknown.
/datum/outfit/diner_ghost/post_equip(mob/living/carbon/human/H, visuals_only = FALSE)
	if(visuals_only)
		return

	var/obj/item/card/id/W = H.wear_id
	W.registered_name = H.real_name
	W.update_label()
	W.update_icon()

/datum/outfit/diner_ghost/fulp_ghostchef
	name = "All-American Chef"
	uniform = /obj/item/clothing/under/misc/patriotsuit
	suit = /obj/item/clothing/suit/toggle/chef
	head = /obj/item/clothing/head/utility/chefhat
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/job/cook/chef
	l_pocket = /obj/item/paper/fluff/space_diner_staff

/datum/outfit/diner_ghost/fulp_ghostcook
	name = "All-American Cook"
	uniform = /obj/item/clothing/under/misc/patriotsuit
	suit = /obj/item/clothing/suit/apron/chef
	head = /obj/item/clothing/head/soft/mime
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/job/cook
	l_pocket = /obj/item/paper/fluff/space_diner_staff

/datum/outfit/diner_ghost/fulp_ghostregular
	name = "Diner Regular"
	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	r_hand = /obj/item/storage/briefcase
	l_pocket = /obj/item/paper/fluff/space_diner_customer
