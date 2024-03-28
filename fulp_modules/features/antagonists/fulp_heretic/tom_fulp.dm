//all of this code is made with Narsie as a reference
/obj/tom_fulp
	name = "Tom Fulp"
	gender = MALE
	desc = "Your mind begins to fulp as it tries to comprehend what it sees."
	icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/tom_fulp.dmi'
	icon_state = "tom_fulp"
	anchored = TRUE
	appearance_flags = LONG_GLIDE
	density = FALSE
	plane = MASSIVE_OBJ_PLANE
	light_color = COLOR_RED
	light_power = 0.7
	light_range = 15
	light_range = 6
	move_resist = INFINITY
	obj_flags = CAN_BE_HIT | DANGEROUS_POSSESSION
	pixel_x = -236
	pixel_y = -256
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = SUPERMATTER_IGNORES_1

	var/datum/weakref/singularity

	var/datum/dimension_theme/theme

/obj/tom_fulp/Initialize(mapload)
	. = ..()

	SSpoints_of_interest.make_point_of_interest(src)

	singularity = WEAKREF(AddComponent(
		/datum/component/singularity, \
		bsa_targetable = FALSE, \
		consume_callback = CALLBACK(src, PROC_REF(nice_to_meat_you)), \
		consume_range = 12, \
		disregard_failed_movements = TRUE, \
		grav_pull = 10, \
		roaming = TRUE, \
		singularity_size = 12, \
	))

	send_to_playing_players(span_narsie("TOM FULP HAS RISEN"))
	sound_to_playing_players("fulp_modules/features/antagonists/fulp_heretic/sounds/tom_fulp_arrival.ogg")

	theme = new /datum/dimension_theme/meat/fool_heretic()

/obj/tom_fulp/proc/set_master(mob/master)
	var/datum/component/singularity/singularity_component = singularity.resolve()
	singularity_component.target = master

/obj/tom_fulp/proc/nice_to_meat_you(atom/target)
	if (isturf(target))
		theme.apply_theme(target, show_effect = FALSE)
	if (iscarbon(target))
		var/mob/living/carbon/carbon_victim = target
		var/datum/dna/victim_dna = carbon_victim.has_dna()
		if(victim_dna && !istype(victim_dna.species, /datum/species/beefman))
			carbon_victim.set_species(/datum/species/beefman)

//I honestly don't know what this does exactly but I think it has to do with letting NarSie move freely so I'm gonna leave it as is
/obj/tom_fulp/Bump(atom/target)
	var/turf/target_turf = get_turf(target)
	if (target_turf == loc)
		target_turf = get_step(target, target.dir) //please don't slam into a window like a bird, Tom
	forceMove(target_turf)

/obj/tom_fulp/Destroy()
	. = ..()

	send_to_playing_players(span_narsie(span_bold(pick("Nooooo...", "Not die. How-", "Die. Mort-", "Sas tyen re-"))))
	sound_to_playing_players('sound/magic/demon_dies.ogg', 50)

