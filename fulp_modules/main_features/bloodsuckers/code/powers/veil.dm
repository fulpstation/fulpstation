/datum/action/bloodsucker/veil
	name = "Veil of Many Faces"
	desc = "Disguise yourself in the illusion of another identity."
	button_icon_state = "power_veil"
	power_explanation = "<b>Veil of Many Faces</b>:\n\
		Activating Veil of Many Faces will shroud you in smoke and forge you a new identity.\n\
		Your name and appearance will be completely randomized, and turning the ability off again will undo it all.\n\
		Clothes, gear, and Security/Medical HUD status is kept the same while this power is active."
	power_flags = BP_AM_TOGGLE
	check_flags = BP_CANT_USE_IN_FRENZY
	purchase_flags = VASSAL_CAN_BUY
	bloodcost = 15
	constant_bloodcost = 0.1
	cooldown = 10 SECONDS
	// Outfit Vars
	var/list/original_items = list()
	// Identity Vars
	var/prev_gender
	var/prev_skin_tone
	var/prev_hair_style
	var/prev_facial_hair_style
	var/prev_hair_color
	var/prev_facial_hair_color
	var/prev_underwear
	var/prev_undershirt
	var/prev_socks
	var/prev_disfigured
	var/list/prev_features // For lizards and such

/datum/action/bloodsucker/veil/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return FALSE
	return TRUE

/datum/action/bloodsucker/veil/ActivatePower()
	cast_effect() // POOF
	//if(blahblahblah)
	//	Disguise_Outfit()
	Disguise_FaceName()
	owner.balloon_alert(owner, "veil turned on.")
	. = ..()

/datum/action/bloodsucker/veil/proc/Disguise_Outfit()
	return
	// Step One: Back up original items

/datum/action/bloodsucker/veil/proc/Disguise_FaceName()
	// Change Name/Voice
	var/mob/living/carbon/human/user = owner
	user.name_override = user.dna.species.random_name(user.gender)
	user.name = user.name_override
	user.SetSpecialVoice(user.name_override)
	to_chat(owner, span_warning("You mystify the air around your person. Your identity is now altered."))

	// Store Prev Appearance
	prev_gender = user.gender
	prev_skin_tone = user.skin_tone
	prev_hair_style = user.hairstyle
	prev_facial_hair_style = user.facial_hairstyle
	prev_hair_color = user.hair_color
	prev_facial_hair_color = user.facial_hair_color
	prev_underwear = user.underwear
	prev_undershirt = user.undershirt
	prev_socks = user.socks
//	prev_eye_color
	prev_disfigured = HAS_TRAIT(user, TRAIT_DISFIGURED) // I was disfigured! //prev_disabilities = user.disabilities
	prev_features = user.dna.features

	// Change Appearance
	user.gender = pick(MALE, FEMALE)
	user.skin_tone = random_skin_tone()
	user.hairstyle = random_hairstyle(user.gender)
	user.facial_hairstyle = pick(random_facial_hairstyle(user.gender),"Shaved")
	user.hair_color = random_short_color()
	user.facial_hair_color = user.hair_color
	user.underwear = random_underwear(user.gender)
	user.undershirt = random_undershirt(user.gender)
	user.socks = random_socks(user.gender)
	//user.eye_color = random_eye_color()
	REMOVE_TRAIT(user, TRAIT_DISFIGURED, null)
	user.dna.features = random_features()

	// Beefmen
	proof_beefman_features(user.dna.features)
	user.dna.species.set_beef_color(user)

	// Apply Appearance
	user.update_body() // Outfit and underware, also body.
	user.update_mutant_bodyparts() // Lizard tails etc
	user.update_hair()
	user.update_body_parts()

/datum/action/bloodsucker/veil/DeactivatePower(mob/living/carbon/human/user = owner, mob/living/target)
	. = ..()
	if(!ishuman(user))
		return

	// Revert Identity
	user.UnsetSpecialVoice()
	user.name_override = null
	user.name = user.real_name

	// Revert Appearance
	user.gender = prev_gender
	user.skin_tone = prev_skin_tone
	user.hairstyle = prev_hair_style
	user.facial_hairstyle = prev_facial_hair_style
	user.hair_color = prev_hair_color
	user.facial_hair_color = prev_facial_hair_color
	user.underwear = prev_underwear
	user.undershirt = prev_undershirt
	user.socks = prev_socks

	//user.disabilities = prev_disabilities // Restore HUSK, CLUMSY, etc.
	if(prev_disfigured)
		ADD_TRAIT(user, TRAIT_DISFIGURED, TRAIT_HUSK) // NOTE: We are ASSUMING husk. // user.status_flags |= DISFIGURED	// Restore "Unknown" disfigurement
	user.dna.features = prev_features

	// Apply Appearance
	user.update_body() // Outfit and underware, also body.
	user.update_hair()
	user.update_body_parts()	// Body itself, maybe skin color?

	cast_effect() // POOF
	owner.balloon_alert(owner, "veil turned off.")

// CAST EFFECT // General effect (poof, splat, etc) when you cast. Doesn't happen automatically!
/datum/action/bloodsucker/veil/proc/cast_effect()
	// Effect
	playsound(get_turf(owner), 'sound/magic/smoke.ogg', 20, 1)
	var/datum/effect_system/steam_spread/puff = new /datum/effect_system/steam_spread/()
	puff.effect_type = /obj/effect/particle_effect/smoke/vampsmoke
	puff.set_up(3, 0, get_turf(owner))
	puff.attach(owner) //OPTIONAL
	puff.start()
	owner.spin(8, 1) //Spin around like a loon.

/obj/effect/particle_effect/smoke/vampsmoke
	opaque = FALSE
	amount = 0
	lifetime = 0

/obj/effect/particle_effect/smoke/vampsmoke/fade_out(frames = 6)
	..(frames)
