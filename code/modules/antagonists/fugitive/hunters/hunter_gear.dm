//works similar to the experiment machine (experiment.dm) except it just holds more and more prisoners

/obj/machinery/fugitive_capture
	name = "bluespace capture machine"
	desc = "Much, MUCH bigger on the inside to transport prisoners safely."
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "bluespace-prison"
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF //ha ha no getting out!!

/obj/machinery/fugitive_capture/examine(mob/user)
	. = ..()
	. += span_notice("Add a prisoner by dragging them into the machine.")

/obj/machinery/fugitive_capture/MouseDrop_T(mob/target, mob/user)
	var/mob/living/fugitive_hunter = user
	if(!isliving(fugitive_hunter))
		return
	if(HAS_TRAIT(fugitive_hunter, TRAIT_UI_BLOCKED) || !Adjacent(fugitive_hunter) || !target.Adjacent(fugitive_hunter) || !ishuman(target))
		return
	var/mob/living/carbon/human/fugitive = target
	var/datum/antagonist/fugitive/fug_antag = fugitive.mind.has_antag_datum(/datum/antagonist/fugitive)
	if(!fug_antag)
		to_chat(fugitive_hunter, span_warning("This is not a wanted fugitive!"))
		return
	if(do_after(fugitive_hunter, 50, target = fugitive))
		add_prisoner(fugitive, fug_antag)

/obj/machinery/fugitive_capture/proc/add_prisoner(mob/living/carbon/human/fugitive, datum/antagonist/fugitive/antag)
	fugitive.forceMove(src)
	antag.is_captured = TRUE
	to_chat(fugitive, span_userdanger("You are thrown into a vast void of bluespace, and as you fall further into oblivion the comparatively small entrance to reality gets smaller and smaller until you cannot see it anymore. You have failed to avoid capture."))
	fugitive.ghostize(TRUE) //so they cannot suicide, round end stuff.
	use_power(active_power_usage)

/obj/machinery/computer/shuttle/hunter
	name = "shuttle console"
	shuttleId = "huntership"
	possible_destinations = "huntership_home;huntership_custom;whiteship_home;syndicate_nw"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/hunter
	name = "shuttle navigation computer"
	desc = "Used to designate a precise transit location to travel to."
	shuttleId = "huntership"
	lock_override = CAMERA_LOCK_STATION
	shuttlePortId = "huntership_custom"
	see_hidden = FALSE
	jump_to_ports = list("huntership_home" = 1, "whiteship_home" = 1, "syndicate_nw" = 1)
	view_range = 4.5

/obj/structure/closet/crate/eva
	name = "EVA crate"

/obj/structure/closet/crate/eva/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/clothing/suit/space/eva(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/head/helmet/space/eva(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/mask/breath(src)
	for(var/i in 1 to 3)
		new /obj/item/tank/internals/oxygen(src)

///Psyker-friendly shuttle gear!

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/hunter/psyker
	name = "psyker navigation warper"
	desc = "Uses amplified brainwaves to designate and map a precise transit location for the psyker shuttle."
	icon_screen = "recharge_comp_on"
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_SET_MACHINE //blind friendly
	x_offset = 0
	y_offset = 11

/obj/machinery/fugitive_capture/psyker
	name = "psyker recreation cell"
	desc = "A repurposed recreation chamber frequently used by psykers, which soothes its user by bombarding them with loud noises and painful stimuli. Repurposed for the storage of prisoners, and should have no (lasting) side effects on non-psykers forced into it."

/obj/machinery/fugitive_capture/psyker/process() //I have no fucking idea how to make click-dragging work for psykers so this one just sucks them in.
	for(var/mob/living/carbon/human/potential_victim in range(1, get_turf(src)))
		var/datum/antagonist/fugitive/fug_antag = potential_victim.mind.has_antag_datum(/datum/antagonist/fugitive)
		if(fug_antag)
			potential_victim.visible_message(span_alert("[potential_victim] is violently sucked into the [src]!"))
			add_prisoner(potential_victim, fug_antag)

/// Psyker gear
/obj/item/reagent_containers/hypospray/medipen/gore
	name = "gore autoinjector"
	desc = "A ghetto-looking autoinjector filled with gore, aka dirty kronkaine. You probably shouldn't take this while on the job, but it is a super-stimulant. Don't take two at once."
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/drug/kronkaine/gore = 15)
	icon_state = "maintenance"
	base_icon_state = "maintenance"
	label_examine = FALSE

//Captain's special mental recharge gear

/obj/item/clothing/suit/armor/reactive/psykerboost
	name = "reactive psykerboost armor"
	desc = "An experimental suit of armor psykers use to push their mind further. Reacts to hostiles by powering up the wearer's psychic abilities."
	cooldown_message = span_danger("The psykerboost armor's mental coils are still cooling down!")
	emp_message = span_danger("The psykerboost armor's mental coils recalibrate for a moment with a soft whine.")
	color = "#d6ad8b"

/obj/item/clothing/suit/armor/reactive/psykerboost/cooldown_activation(mob/living/carbon/human/owner)
	var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread
	sparks.set_up(1, 1, src)
	sparks.start()
	return ..()

/obj/item/clothing/suit/armor/reactive/psykerboost/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] blocks [attack_text], psykerboosting [owner]'s mental powers!"))
	for(var/datum/action/cooldown/spell/psychic_ability in owner.actions)
		if(psychic_ability.school == SCHOOL_PSYCHIC)
			psychic_ability.reset_spell_cooldown()
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/psykerboost/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] blocks [attack_text], draining [owner]'s mental powers!"))
	for(var/datum/action/cooldown/spell/psychic_ability in owner.actions)
		if(psychic_ability.school == SCHOOL_PSYCHIC)
			psychic_ability.StartCooldown()
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/structure/bouncy_castle
	name = "bouncy castle"
	desc = "And if you do drugs, you go to hell before you die. Please."
	icon = 'icons/obj/bouncy_castle.dmi'
	icon_state = "bouncy_castle"
	anchored = TRUE
	density = TRUE

/obj/structure/bouncy_castle/Initialize(mapload, mob/gored)
	. = ..()
	if(gored)
		name = gored.real_name

/obj/structure/bouncy_castle/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/attackblob.ogg', 50, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, TRUE)

/obj/item/paper/crumpled/fluff/fortune_teller
	name = "scribbled note"
	default_raw_text = "<b>Remember!</b> The customers love that gumball we have as a crystal ball. \
		Even if it's completely useless to us, resist the urge to chew it."

