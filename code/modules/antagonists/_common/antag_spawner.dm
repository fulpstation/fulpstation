/obj/item/antag_spawner
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	var/used = FALSE

/obj/item/antag_spawner/proc/spawn_antag(client/C, turf/T, kind = "", datum/mind/user)
	return

/obj/item/antag_spawner/proc/equip_antag(mob/target)
	return


///////////WIZARD

/obj/item/antag_spawner/contract
	name = "contract"
	desc = "A magic contract previously signed by an apprentice. In exchange for instruction in the magical arts, they are bound to answer your call for aid."
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"

/obj/item/antag_spawner/contract/attack_self(mob/user)
	user.set_machine(src)
	var/dat
	if(used)
		dat = "<B>You have already summoned your apprentice.</B><BR>"
	else
		dat = "<B>Contract of Apprenticeship:</B><BR>"
		dat += "<I>Using this contract, you may summon an apprentice to aid you on your mission.</I><BR>"
		dat += "<I>If you are unable to establish contact with your apprentice, you can feed the contract back to the spellbook to refund your points.</I><BR>"
		dat += "<B>Which school of magic is your apprentice studying?:</B><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_DESTRUCTION]'>Destruction</A><BR>"
		dat += "<I>Your apprentice is skilled in offensive magic. They know Magic Missile and Fireball.</I><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_BLUESPACE]'>Bluespace Manipulation</A><BR>"
		dat += "<I>Your apprentice is able to defy physics, melting through solid objects and travelling great distances in the blink of an eye. They know Teleport and Ethereal Jaunt.</I><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_HEALING]'>Healing</A><BR>"
		dat += "<I>Your apprentice is training to cast spells that will aid your survival. They know Forcewall and Charge and come with a Staff of Healing.</I><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_ROBELESS]'>Robeless</A><BR>"
		dat += "<I>Your apprentice is training to cast spells without their robes. They know Knock and Mindswap.</I><BR>"
	user << browse(dat, "window=radio")
	onclose(user, "radio")
	return

/obj/item/antag_spawner/contract/Topic(href, href_list)
	. = ..()

	if(usr.stat != CONSCIOUS || HAS_TRAIT(usr, TRAIT_HANDS_BLOCKED))
		return
	if(!ishuman(usr))
		return TRUE
	var/mob/living/carbon/human/H = usr

	if(loc == H || (in_range(src, H) && isturf(loc)))
		H.set_machine(src)
		if(href_list["school"])
			if(used)
				to_chat(H, "<span class='warning'>You already used this contract!</span>")
				return
			var/list/candidates = pollCandidatesForMob("Do you want to play as a wizard's [href_list["school"]] apprentice?", ROLE_WIZARD, ROLE_WIZARD, 150, src)
			if(LAZYLEN(candidates))
				if(QDELETED(src))
					return
				if(used)
					to_chat(H, "<span class='warning'>You already used this contract!</span>")
					return
				used = TRUE
				var/mob/dead/observer/C = pick(candidates)
				spawn_antag(C.client, get_turf(src), href_list["school"],H.mind)
			else
				to_chat(H, "<span class='warning'>Unable to reach your apprentice! You can either attack the spellbook with the contract to refund your points, or wait and try again later.</span>")

/obj/item/antag_spawner/contract/spawn_antag(client/C, turf/T, kind ,datum/mind/user)
	new /obj/effect/particle_effect/smoke(T)
	var/mob/living/carbon/human/M = new/mob/living/carbon/human(T)
	C.prefs.copy_to(M)
	M.key = C.key
	var/datum/mind/app_mind = M.mind

	var/datum/antagonist/wizard/apprentice/app = new()
	app.master = user
	app.school = kind

	var/datum/antagonist/wizard/master_wizard = user.has_antag_datum(/datum/antagonist/wizard)
	if(master_wizard)
		if(!master_wizard.wiz_team)
			master_wizard.create_wiz_team()
		app.wiz_team = master_wizard.wiz_team
		master_wizard.wiz_team.add_member(app_mind)
	app_mind.add_antag_datum(app)
	//TODO Kill these if possible
	app_mind.assigned_role = "Apprentice"
	app_mind.special_role = "apprentice"
	//
	SEND_SOUND(M, sound('sound/effects/magic.ogg'))

///////////BORGS AND OPERATIVES


/**
 * Device to request reinforcments from ghost pop
 */
/obj/item/antag_spawner/nuke_ops
	name = "syndicate operative beacon"
	desc = "A single-use beacon designed to quickly launch reinforcement operatives into the field."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"
	var/borg_to_spawn
	var/special_role_name = "Nuclear Operative" ///The name of the special role given to the recruit
	var/datum/outfit/syndicate/outfit = /datum/outfit/syndicate/no_crystals ///The applied outfit
	var/datum/antagonist/nukeop/antag_datum = /datum/antagonist/nukeop ///The antag datam applied
	/// Style used by the droppod
	var/pod_style = STYLE_SYNDICATE

/obj/item/antag_spawner/nuke_ops/proc/check_usability(mob/user)
	if(used)
		to_chat(user, "<span class='warning'>[src] is out of power!</span>")
		return FALSE
	if(!user.mind.has_antag_datum(/datum/antagonist/nukeop,TRUE))
		to_chat(user, "<span class='danger'>AUTHENTICATION FAILURE. ACCESS DENIED.</span>")
		return FALSE
	return TRUE

/// Creates the drop pod the nukie will be dropped by
/obj/item/antag_spawner/nuke_ops/proc/setup_pod()
	var/obj/structure/closet/supplypod/pod = new(null, pod_style)
	pod.explosionSize = list(0,0,0,0)
	pod.bluespace = TRUE
	return pod

/obj/item/antag_spawner/nuke_ops/attack_self(mob/user)
	if(!(check_usability(user)))
		return

	to_chat(user, "<span class='notice'>You activate [src] and wait for confirmation.</span>")
	var/list/nuke_candidates = pollGhostCandidates("Do you want to play as a syndicate [borg_to_spawn ? "[lowertext(borg_to_spawn)] cyborg":"operative"]?", ROLE_OPERATIVE, ROLE_OPERATIVE, 150, POLL_IGNORE_SYNDICATE)
	if(LAZYLEN(nuke_candidates))
		if(QDELETED(src) || !check_usability(user))
			return
		used = TRUE
		var/mob/dead/observer/G = pick(nuke_candidates)
		spawn_antag(G.client, get_turf(src), "nukeop", user.mind)
		do_sparks(4, TRUE, src)
		qdel(src)
	else
		to_chat(user, "<span class='warning'>Unable to connect to Syndicate command. Please wait and try again later or use the beacon on your uplink to get your points refunded.</span>")

/obj/item/antag_spawner/nuke_ops/spawn_antag(client/C, turf/T, kind, datum/mind/user)
	var/mob/living/carbon/human/nukie = new()
	var/obj/structure/closet/supplypod/pod = setup_pod()
	C.prefs.copy_to(nukie)
	nukie.ckey = C.key
	var/datum/mind/op_mind = nukie.mind

	antag_datum = new()
	antag_datum.send_to_spawnpoint = FALSE
	antag_datum.nukeop_outfit = outfit

	var/datum/antagonist/nukeop/creator_op = user.has_antag_datum(/datum/antagonist/nukeop, TRUE)
	op_mind.add_antag_datum(antag_datum, creator_op ? creator_op.get_team() : null)
	op_mind.special_role = special_role_name
	nukie.forceMove(pod)
	new /obj/effect/pod_landingzone(get_turf(src), pod)

//////CLOWN OP
/obj/item/antag_spawner/nuke_ops/clown
	name = "clown operative beacon"
	desc = "A single-use beacon designed to quickly launch reinforcement clown operatives into the field."
	special_role_name = "Clown Operative"
	outfit = /datum/outfit/syndicate/clownop/no_crystals
	antag_datum = /datum/antagonist/nukeop/clownop
	pod_style = STYLE_HONK

//////SYNDICATE BORG
/obj/item/antag_spawner/nuke_ops/borg_tele
	name = "syndicate cyborg beacon"
	desc = "A single-use beacon designed to quickly launch reinforcement cyborgs into the field."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"

/obj/item/antag_spawner/nuke_ops/borg_tele/assault
	name = "syndicate assault cyborg beacon"
	borg_to_spawn = "Assault"

/obj/item/antag_spawner/nuke_ops/borg_tele/medical
	name = "syndicate medical beacon"
	borg_to_spawn = "Medical"

/obj/item/antag_spawner/nuke_ops/borg_tele/saboteur
	name = "syndicate saboteur beacon"
	borg_to_spawn = "Saboteur"

/obj/item/antag_spawner/nuke_ops/borg_tele/spawn_antag(client/C, turf/T, kind, datum/mind/user)
	var/mob/living/silicon/robot/borg
	var/datum/antagonist/nukeop/creator_op = user.has_antag_datum(/datum/antagonist/nukeop,TRUE)
	if(!creator_op)
		return
	var/obj/structure/closet/supplypod/pod = setup_pod()
	switch(borg_to_spawn)
		if("Medical")
			borg = new /mob/living/silicon/robot/model/syndicate/medical()
		if("Saboteur")
			borg = new /mob/living/silicon/robot/model/syndicate/saboteur()
		else
			borg = new /mob/living/silicon/robot/model/syndicate() //Assault borg by default

	var/brainfirstname = pick(GLOB.first_names_male)
	if(prob(50))
		brainfirstname = pick(GLOB.first_names_female)
	var/brainopslastname = pick(GLOB.last_names)
	if(creator_op.nuke_team.syndicate_name)  //the brain inside the syndiborg has the same last name as the other ops.
		brainopslastname = creator_op.nuke_team.syndicate_name
	var/brainopsname = "[brainfirstname] [brainopslastname]"

	borg.mmi.name = "[initial(borg.mmi.name)]: [brainopsname]"
	borg.mmi.brain.name = "[brainopsname]'s brain"
	borg.mmi.brainmob.real_name = brainopsname
	borg.mmi.brainmob.name = brainopsname
	borg.real_name = borg.name

	borg.key = C.key

	var/datum/antagonist/nukeop/new_borg = new()
	new_borg.send_to_spawnpoint = FALSE
	borg.mind.add_antag_datum(new_borg,creator_op.nuke_team)
	borg.mind.special_role = "Syndicate Cyborg"
	borg.forceMove(pod)
	new /obj/effect/pod_landingzone(get_turf(src), pod)

///////////SLAUGHTER DEMON

/obj/item/antag_spawner/slaughter_demon //Warning edgiest item in the game
	name = "vial of blood"
	desc = "A magically infused bottle of blood, distilled from countless murder victims. Used in unholy rituals to attract horrifying creatures."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"

	var/shatter_msg = "<span class='notice'>You shatter the bottle, no turning back now!</span>"
	var/veil_msg = "<span class='warning'>You sense a dark presence lurking just beyond the veil...</span>"
	var/mob/living/demon_type = /mob/living/simple_animal/hostile/imp/slaughter
	var/antag_type = /datum/antagonist/slaughter


/obj/item/antag_spawner/slaughter_demon/attack_self(mob/user)
	if(!is_station_level(user.z))
		to_chat(user, "<span class='warning'>You should probably wait until you reach the station.</span>")
		return
	if(used)
		return
	var/list/candidates = pollCandidatesForMob("Do you want to play as a [initial(demon_type.name)]?", ROLE_ALIEN, ROLE_ALIEN, 50, src)
	if(LAZYLEN(candidates))
		if(used || QDELETED(src))
			return
		used = TRUE
		var/mob/dead/observer/C = pick(candidates)
		spawn_antag(C.client, get_turf(src), initial(demon_type.name),user.mind)
		to_chat(user, shatter_msg)
		to_chat(user, veil_msg)
		playsound(user.loc, 'sound/effects/glassbr1.ogg', 100, TRUE)
		qdel(src)
	else
		to_chat(user, "<span class='warning'>You can't seem to work up the nerve to shatter the bottle! Perhaps you should try again later.</span>")


/obj/item/antag_spawner/slaughter_demon/spawn_antag(client/C, turf/T, kind = "", datum/mind/user)
	var/obj/effect/dummy/phased_mob/holder = new /obj/effect/dummy/phased_mob(T)
	var/mob/living/simple_animal/hostile/imp/slaughter/S = new demon_type(holder)
	S.key = C.key
	S.mind.assigned_role = S.name
	S.mind.special_role = S.name
	S.mind.add_antag_datum(antag_type)
	to_chat(S, S.playstyle_string)
	to_chat(S, "<B>You are currently not currently in the same plane of existence as the station. \
	Ctrl+Click a blood pool to manifest.</B>")

/obj/item/antag_spawner/slaughter_demon/laughter
	name = "vial of tickles"
	desc = "A magically infused bottle of clown love, distilled from countless hugging attacks. Used in funny rituals to attract adorable creatures."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"
	color = "#FF69B4" // HOT PINK

	veil_msg = "<span class='warning'>You sense an adorable presence lurking just beyond the veil...</span>"
	demon_type = /mob/living/simple_animal/hostile/imp/slaughter/laughter
	antag_type = /datum/antagonist/slaughter/laughter
