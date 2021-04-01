
/*

CONTAINS:
T-RAY
HEALTH ANALYZER
GAS ANALYZER
SLIME SCANNER
NANITE SCANNER
GENE SCANNER

*/

// Describes the three modes of scanning available for health analyzers
#define SCANMODE_HEALTH 0
#define SCANMODE_WOUND 1
#define SCANMODE_COUNT 2 // Update this to be the number of scan modes if you add more
#define SCANNER_CONDENSED 0
#define SCANNER_VERBOSE 1

/obj/item/t_scanner
	name = "\improper T-ray scanner"
	desc = "A terahertz-ray emitter and scanner used to detect underfloor objects such as cables and pipes."
	custom_price = PAYCHECK_ASSISTANT * 0.7
	icon = 'icons/obj/device.dmi'
	icon_state = "t-ray0"
	var/on = FALSE
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	custom_materials = list(/datum/material/iron=150)

/obj/item/t_scanner/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to emit terahertz-rays into [user.p_their()] brain with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return TOXLOSS

/obj/item/t_scanner/proc/toggle_on()
	on = !on
	icon_state = copytext_char(icon_state, 1, -1) + "[on]"
	if(on)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/t_scanner/attack_self(mob/user)
	toggle_on()

/obj/item/t_scanner/cyborg_unequip(mob/user)
	if(!on)
		return
	toggle_on()

/obj/item/t_scanner/process()
	if(!on)
		STOP_PROCESSING(SSobj, src)
		return null
	scan()

/obj/item/t_scanner/proc/scan()
	t_ray_scan(loc)

/proc/t_ray_scan(mob/viewer, flick_time = 8, distance = 3)
	if(!ismob(viewer) || !viewer.client)
		return
	var/list/t_ray_images = list()
	for(var/obj/O in orange(distance, viewer) )
		if(HAS_TRAIT(O, TRAIT_T_RAY_VISIBLE))
			var/image/I = new(loc = get_turf(O))
			var/mutable_appearance/MA = new(O)
			MA.alpha = 128
			MA.dir = O.dir
			I.appearance = MA
			t_ray_images += I
	if(t_ray_images.len)
		flick_overlay(t_ray_images, list(viewer.client), flick_time)

/obj/item/healthanalyzer
	name = "health analyzer"
	icon = 'icons/obj/device.dmi'
	icon_state = "health"
	inhand_icon_state = "healthanalyzer"
	worn_icon_state = "healthanalyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "A hand-held body scanner capable of distinguishing vital signs of the subject. Has a side button to scan for chemicals, and can be toggled to scan wounds."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=200)
	var/mode = SCANNER_VERBOSE
	var/scanmode = SCANMODE_HEALTH
	var/advanced = FALSE
	custom_price = PAYCHECK_HARD

/obj/item/healthanalyzer/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to analyze [user.p_them()]self with [src]! The display shows that [user.p_theyre()] dead!</span>")
	return BRUTELOSS

/obj/item/healthanalyzer/attack_self(mob/user)
	scanmode = (scanmode + 1) % SCANMODE_COUNT
	switch(scanmode)
		if(SCANMODE_HEALTH)
			to_chat(user, "<span class='notice'>You switch the health analyzer to check physical health.</span>")
		if(SCANMODE_WOUND)
			to_chat(user, "<span class='notice'>You switch the health analyzer to report extra info on wounds.</span>")

/obj/item/healthanalyzer/attack(mob/living/M, mob/living/carbon/human/user)
	flick("[icon_state]-scan", src) //makes it so that it plays the scan animation upon scanning, including clumsy scanning

	// Clumsiness/brain damage check
	if ((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(50))
		user.visible_message("<span class='warning'>[user] analyzes the floor's vitals!</span>", \
							"<span class='notice'>You stupidly try to analyze the floor's vitals!</span>")
		to_chat(user, "<span class='info'>Analyzing results for The floor:\n\tOverall status: <b>Healthy</b></span>\
				\n<span class='info'>Key: <font color='#00cccc'>Suffocation</font>/<font color='#00cc66'>Toxin</font>/<font color='#ffcc33'>Burn</font>/<font color='#ff3333'>Brute</font></span>\
				\n<span class='info'>\tDamage specifics: <font color='#66cccc'>0</font>-<font color='#00cc66'>0</font>-<font color='#ff9933'>0</font>-<font color='#ff3333'>0</font></span>\
				\n<span class='info'>Body temperature: ???</span>")
		return

	if(ispodperson(M)&& !advanced)
		to_chat(user, "<span class='info'>[M]'s biologal structure is too complex for the health analyzer.")
		return

	user.visible_message("<span class='notice'>[user] analyzes [M]'s vitals.</span>", \
						"<span class='notice'>You analyze [M]'s vitals.</span>")

	switch (scanmode)
		if (SCANMODE_HEALTH)
			healthscan(user, M, mode, advanced)
		if (SCANMODE_WOUND)
			woundscan(user, M, src)

	add_fingerprint(user)

/obj/item/healthanalyzer/attack_secondary(mob/living/victim, mob/living/user, params)
	chemscan(user, victim)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

// Used by the PDA medical scanner too
/proc/healthscan(mob/user, mob/living/M, mode = SCANNER_VERBOSE, advanced = FALSE)
	if(user.incapacitated())
		return

	if(user.is_blind())
		to_chat(user, "<span class='warning'>You realize that your scanner has no accessibility support for the blind!</span>")
		return

	// the final list of strings to render
	var/render_list = list()

	// Damage specifics
	var/oxy_loss = M.getOxyLoss()
	var/tox_loss = M.getToxLoss()
	var/fire_loss = M.getFireLoss()
	var/brute_loss = M.getBruteLoss()
	var/mob_status = (M.stat == DEAD ? "<span class='alert'><b>Deceased</b></span>" : "<b>[round(M.health/M.maxHealth,0.01)*100]% healthy</b>")

	if(HAS_TRAIT(M, TRAIT_FAKEDEATH) && !advanced)
		mob_status = "<span class='alert'><b>Deceased</b></span>"
		oxy_loss = max(rand(1, 40), oxy_loss, (300 - (tox_loss + fire_loss + brute_loss))) // Random oxygen loss

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.undergoing_cardiac_arrest() && H.stat != DEAD)
			render_list += "<span class='alert'>Subject suffering from heart attack: Apply defibrillation or other electric shock immediately!</span>\n"
		if(H.has_reagent(/datum/reagent/inverse/technetium))
			advanced = TRUE

	render_list += "<span class='info'>Analyzing results for [M]:</span>\n<span class='info ml-1'>Overall status: [mob_status]</span>\n"

	// Husk detection
	if(advanced && HAS_TRAIT_FROM(M, TRAIT_HUSK, BURN))
		render_list += "<span class='alert ml-1'>Subject has been husked by severe burns.</span>\n"
	else if (advanced && HAS_TRAIT_FROM(M, TRAIT_HUSK, CHANGELING_DRAIN))
		render_list += "<span class='alert ml-1'>Subject has been husked by dessication.</span>\n"
	else if(HAS_TRAIT(M, TRAIT_HUSK))
		render_list += "<span class='alert ml-1'>Subject has been husked.</span>\n"

	// Damage descriptions
	if(brute_loss > 10)
		render_list += "<span class='alert ml-1'>[brute_loss > 50 ? "Severe" : "Minor"] tissue damage detected.</span>\n"
	if(fire_loss > 10)
		render_list += "<span class='alert ml-1'>[fire_loss > 50 ? "Severe" : "Minor"] burn damage detected.</span>\n"
	if(oxy_loss > 10)
		render_list += "<span class='info ml-1'><span class='alert'>[oxy_loss > 50 ? "Severe" : "Minor"] oxygen deprivation detected.</span>\n"
	if(tox_loss > 10)
		render_list += "<span class='alert ml-1'>[tox_loss > 50 ? "Severe" : "Minor"] amount of toxin damage detected.</span>\n"
	if(M.getStaminaLoss())
		render_list += "<span class='alert ml-1'>Subject appears to be suffering from fatigue.</span>\n"
		if(advanced)
			render_list += "<span class='info ml-1'>Fatigue Level: [M.getStaminaLoss()]%.</span>\n"
	if (M.getCloneLoss())
		render_list += "<span class='alert ml-1'>Subject appears to have [M.getCloneLoss() > 30 ? "Severe" : "Minor"] cellular damage.</span>\n"
		if(advanced)
			render_list += "<span class='info ml-1'>Cellular Damage Level: [M.getCloneLoss()].</span>\n"
	if (!M.getorganslot(ORGAN_SLOT_BRAIN)) // brain not added to carbon/human check because it's funny to get to bully simple mobs
		render_list += "<span class='alert ml-1'>Subject lacks a brain.</span>\n"
	if(ishuman(M))
		var/mob/living/carbon/human/the_dude = M
		var/datum/species/the_dudes_species = the_dude.dna.species
		if (!(NOBLOOD in the_dudes_species.species_traits) && !the_dude.getorganslot(ORGAN_SLOT_HEART))
			render_list += "<span class='alert ml-1'>Subject lacks a heart.</span>\n"
		if (!(TRAIT_NOBREATH in the_dudes_species.species_traits) && !the_dude.getorganslot(ORGAN_SLOT_LUNGS))
			render_list += "<span class='alert ml-1'>Subject lacks lungs.</span>\n"
		if (!(TRAIT_NOMETABOLISM in the_dudes_species.species_traits) && !the_dude.getorganslot(ORGAN_SLOT_LIVER))
			render_list += "<span class='alert ml-1'>Subject lacks a liver.</span>\n"
		if (!(NOSTOMACH in the_dudes_species.species_traits) && !the_dude.getorganslot(ORGAN_SLOT_STOMACH))
			render_list += "<span class='alert ml-1'>Subject lacks a stomach.</span>\n"

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(LAZYLEN(C.get_traumas()))
			var/list/trauma_text = list()
			for(var/datum/brain_trauma/B in C.get_traumas())
				var/trauma_desc = ""
				switch(B.resilience)
					if(TRAUMA_RESILIENCE_SURGERY)
						trauma_desc += "severe "
					if(TRAUMA_RESILIENCE_LOBOTOMY)
						trauma_desc += "deep-rooted "
					if(TRAUMA_RESILIENCE_WOUND)
						trauma_desc += "fracture-derived "
					if(TRAUMA_RESILIENCE_MAGIC, TRAUMA_RESILIENCE_ABSOLUTE)
						trauma_desc += "permanent "
				trauma_desc += B.scan_desc
				trauma_text += trauma_desc
			render_list += "<span class='alert ml-1'>Cerebral traumas detected: subject appears to be suffering from [english_list(trauma_text)].</span>\n"
		if(C.roundstart_quirks.len)
			render_list += "<span class='info ml-1'>Subject Major Disabilities: [C.get_quirk_string(FALSE, CAT_QUIRK_MAJOR_DISABILITY)].</span>\n"
			if(advanced)
				render_list += "<span class='info ml-1'>Subject Minor Disabilities: [C.get_quirk_string(FALSE, CAT_QUIRK_MINOR_DISABILITY)].</span>\n"
	if(advanced)
		render_list += "<span class='info ml-1'>Brain Activity Level: [(200 - M.getOrganLoss(ORGAN_SLOT_BRAIN))/2]%.</span>\n"

	if (M.radiation)
		render_list += "<span class='alert ml-1'>Subject is irradiated.</span>\n"
		if(advanced)
			render_list += "<span class='info ml-1'>Radiation Level: [M.radiation]%.</span>\n"

	if(advanced && M.hallucinating())
		render_list += "<span class='info ml-1'>Subject is hallucinating.</span>\n"

	// Body part damage report
	if(iscarbon(M) && mode == SCANNER_VERBOSE)
		var/mob/living/carbon/C = M
		var/list/damaged = C.get_damaged_bodyparts(1,1)
		if(length(damaged)>0 || oxy_loss>0 || tox_loss>0 || fire_loss>0)
			var/dmgreport = "<span class='info ml-1'>General status:</span>\
							<table class='ml-2'><tr><font face='Verdana'>\
							<td style='width:7em;'><font color='#ff0000'><b>Damage:</b></font></td>\
							<td style='width:5em;'><font color='#ff3333'><b>Brute</b></font></td>\
							<td style='width:4em;'><font color='#ff9933'><b>Burn</b></font></td>\
							<td style='width:4em;'><font color='#00cc66'><b>Toxin</b></font></td>\
							<td style='width:8em;'><font color='#00cccc'><b>Suffocation</b></font></td></tr>\
							<tr><td><font color='#ff3333'><b>Overall:</b></font></td>\
							<td><font color='#ff3333'><b>[CEILING(brute_loss,1)]</b></font></td>\
							<td><font color='#ff9933'><b>[CEILING(fire_loss,1)]</b></font></td>\
							<td><font color='#00cc66'><b>[CEILING(tox_loss,1)]</b></font></td>\
							<td><font color='#33ccff'><b>[CEILING(oxy_loss,1)]</b></font></td></tr>"

			for(var/o in damaged)
				var/obj/item/bodypart/org = o //head, left arm, right arm, etc.
				dmgreport += "<tr><td><font color='#cc3333'>[capitalize(org.name)]:</font></td>\
								<td><font color='#cc3333'>[(org.brute_dam > 0) ? "[CEILING(org.brute_dam,1)]" : "0"]</font></td>\
								<td><font color='#ff9933'>[(org.burn_dam > 0) ? "[CEILING(org.burn_dam,1)]" : "0"]</font></td></tr>"
			dmgreport += "</font></table>"
			render_list += dmgreport // tables do not need extra linebreak

	//Eyes and ears
	if(advanced && iscarbon(M))
		var/mob/living/carbon/C = M

		// Ear status
		var/obj/item/organ/ears/ears = C.getorganslot(ORGAN_SLOT_EARS)
		var/message = "\n<span class='alert ml-2'>Subject does not have ears.</span>"
		if(istype(ears))
			message = ""
			if(HAS_TRAIT_FROM(C, TRAIT_DEAF, GENETIC_MUTATION))
				message = "\n<span class='alert ml-2'>Subject is genetically deaf.</span>"
			else if(HAS_TRAIT_FROM(C, TRAIT_DEAF, EAR_DAMAGE))
				message = "\n<span class='alert ml-2'>Subject is deaf from ear damage.</span>"
			else if(HAS_TRAIT(C, TRAIT_DEAF))
				message = "\n<span class='alert ml-2'>Subject is deaf.</span>"
			else
				if(ears.damage)
					message += "\n<span class='alert ml-2'>Subject has [ears.damage > ears.maxHealth ? "permanent ": "temporary "]hearing damage.</span>"
				if(ears.deaf)
					message += "\n<span class='alert ml-2'>Subject is [ears.damage > ears.maxHealth ? "permanently ": "temporarily "] deaf.</span>"
		render_list += "<span class='info ml-1'>Ear status:</span>[message == "" ? "\n<span class='info ml-2'>Healthy.</span>" : message]\n"

		// Eye status
		var/obj/item/organ/eyes/eyes = C.getorganslot(ORGAN_SLOT_EYES)
		message = "\n<span class='alert ml-2'>Subject does not have eyes.</span>"
		if(istype(eyes))
			message = ""
			if(C.is_blind())
				message += "\n<span class='alert ml-2'>Subject is blind.</span>"
			if(HAS_TRAIT(C, TRAIT_NEARSIGHT))
				message += "\n<span class='alert ml-2'>Subject is nearsighted.</span>"
			if(eyes.damage > 30)
				message += "\n<span class='alert ml-2'>Subject has severe eye damage.</span>"
			else if(eyes.damage > 20)
				message += "\n<span class='alert ml-2'>Subject has significant eye damage.</span>"
			else if(eyes.damage)
				message += "\n<span class='alert ml-2'>Subject has minor eye damage.</span>"
		render_list += "<span class='info ml-1'>Eye status:</span>[message == "" ? "\n<span class='info ml-2'>Healthy.</span>" : message]\n"

	if(ishuman(M))
		var/mob/living/carbon/human/H = M

		// Organ damage
		if (H.internal_organs && H.internal_organs.len)
			var/render = FALSE
			var/toReport = "<span class='info ml-1'>Organs:</span>\
				<table class='ml-2'><tr>\
				<td style='width:6em;'><font color='#ff0000'><b>Organ:</b></font></td>\
				[advanced ? "<td style='width:3em;'><font color='#ff0000'><b>Dmg</b></font></td>" : ""]\
				<td style='width:12em;'><font color='#ff0000'><b>Status</b></font></td>"

			for(var/obj/item/organ/organ in H.internal_organs)
				var/status = ""
				if(H.has_reagent(/datum/reagent/inverse/technetium))
					if(organ.damage)
						status = "<font color='#E42426'> organ is [round((organ.damage/organ.maxHealth)*100, 1)]% damaged.</font>"
				else
					if (organ.organ_flags & ORGAN_FAILING)
						status = "<font color='#cc3333'>Non-Functional</font>"
					else if (organ.damage > organ.high_threshold)
						status = "<font color='#ff9933'>Severely Damaged</font>"
					else if (organ.damage > organ.low_threshold)
						status = "<font color='#ffcc33'>Mildly Damaged</font>"
				if (status != "")
					render = TRUE
					toReport += "<tr><td><font color='#cc3333'>[organ.name]:</font></td>\
						[advanced ? "<td><font color='#ff3333'>[CEILING(organ.damage,1)]</font></td>" : ""]\
						<td>[status]</td></tr>"

			if (render)
				render_list += toReport + "</table>" // tables do not need extra linebreak

		//Genetic damage
		if(advanced && H.has_dna())
			render_list += "<span class='info ml-1'>Genetic Stability: [H.dna.stability]%.</span>\n"

		// Species and body temperature
		var/datum/species/S = H.dna.species
		var/mutant = H.dna.check_mutation(HULK) \
			|| S.mutantlungs != initial(S.mutantlungs) \
			|| S.mutantbrain != initial(S.mutantbrain) \
			|| S.mutantheart != initial(S.mutantheart) \
			|| S.mutanteyes != initial(S.mutanteyes) \
			|| S.mutantears != initial(S.mutantears) \
			|| S.mutanthands != initial(S.mutanthands) \
			|| S.mutanttongue != initial(S.mutanttongue) \
			|| S.mutantliver != initial(S.mutantliver) \
			|| S.mutantstomach != initial(S.mutantstomach) \
			|| S.mutantappendix != initial(S.mutantappendix) \
			|| S.flying_species != initial(S.flying_species)

		render_list += "<span class='info ml-1'>Species: [S.name][mutant ? "-derived mutant" : ""]</span>\n"
		render_list += "<span class='info ml-1'>Core temperature: [round(H.coretemperature-T0C,0.1)] &deg;C ([round(H.coretemperature*1.8-459.67,0.1)] &deg;F)</span>\n"
	render_list += "<span class='info ml-1'>Body temperature: [round(M.bodytemperature-T0C,0.1)] &deg;C ([round(M.bodytemperature*1.8-459.67,0.1)] &deg;F)</span>\n"

	// Time of death
	if(M.tod && (M.stat == DEAD || ((HAS_TRAIT(M, TRAIT_FAKEDEATH)) && !advanced)))
		render_list += "<span class='info ml-1'>Time of Death: [M.tod]</span>\n"
		var/tdelta = round(world.time - M.timeofdeath)
		render_list += "<span class='alert ml-1'><b>Subject died [DisplayTimeText(tdelta)] ago.</b></span>\n"

	// Wounds
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		var/list/wounded_parts = C.get_wounded_bodyparts()
		for(var/i in wounded_parts)
			var/obj/item/bodypart/wounded_part = i
			render_list += "<span class='alert ml-1'><b>Warning: Physical trauma[LAZYLEN(wounded_part.wounds) > 1? "s" : ""] detected in [wounded_part.name]</b>"
			for(var/k in wounded_part.wounds)
				var/datum/wound/W = k
				render_list += "<div class='ml-2'>Type: [W.name]\nSeverity: [W.severity_text()]\nRecommended Treatment: [W.treat_text]</div>\n" // less lines than in woundscan() so we don't overload people trying to get basic med info
			render_list += "</span>"

	for(var/thing in M.diseases)
		var/datum/disease/D = thing
		if(!(D.visibility_flags & HIDDEN_SCANNER))
			render_list += "<span class='alert ml-1'><b>Warning: [D.form] detected</b>\n\
			<div class='ml-2'>Name: [D.name].\nType: [D.spread_text].\nStage: [D.stage]/[D.max_stages].\nPossible Cure: [D.cure_text]</div>\
			</span>" // divs do not need extra linebreak

	// Blood Level
	if(M.has_dna())
		var/mob/living/carbon/C = M
		var/blood_id = C.get_blood_id()
		if(blood_id)
			if(ishuman(C))
				var/mob/living/carbon/human/H = C
				if(H.is_bleeding())
					render_list += "<span class='alert ml-1'><b>Subject is bleeding!</b></span>\n"
			var/blood_percent =  round((C.blood_volume / BLOOD_VOLUME_NORMAL)*100)
			var/blood_type = C.dna.blood_type
			if(blood_id != /datum/reagent/blood) // special blood substance
				var/datum/reagent/R = GLOB.chemical_reagents_list[blood_id]
				blood_type = R ? R.name : blood_id
			if(C.blood_volume <= BLOOD_VOLUME_SAFE && C.blood_volume > BLOOD_VOLUME_OKAY)
				render_list += "<span class='alert ml-1'>Blood level: LOW [blood_percent] %, [C.blood_volume] cl,</span> <span class='info'>type: [blood_type]</span>\n"
			else if(C.blood_volume <= BLOOD_VOLUME_OKAY)
				render_list += "<span class='alert ml-1'>Blood level: <b>CRITICAL [blood_percent] %</b>, [C.blood_volume] cl,</span> <span class='info'>type: [blood_type]</span>\n"
			else
				render_list += "<span class='info ml-1'>Blood level: [blood_percent] %, [C.blood_volume] cl, type: [blood_type]</span>\n"

		var/cyberimp_detect
		for(var/obj/item/organ/cyberimp/CI in C.internal_organs)
			if(CI.status == ORGAN_ROBOTIC && !CI.syndicate_implant)
				cyberimp_detect += "[!cyberimp_detect ? "[CI.get_examine_string(user)]" : ", [CI.get_examine_string(user)]"]"
		if(cyberimp_detect)
			render_list += "<span class='notice ml-1'>Detected cybernetic modifications:</span>\n"
			render_list += "<span class='notice ml-2'>[cyberimp_detect]</span>\n"

	SEND_SIGNAL(M, COMSIG_NANITE_SCAN, user, FALSE)
	to_chat(user, jointext(render_list, ""), trailing_newline = FALSE) // we handled the last <br> so we don't need handholding

/proc/chemscan(mob/living/user, mob/living/M)
	if(user.incapacitated())
		return

	if(user.is_blind())
		to_chat(user, "<span class='warning'>You realize that your scanner has no accessibility support for the blind!</span>")
		return

	if(istype(M) && M.reagents)
		var/render_list = list()
		if(M.reagents.reagent_list.len)
			render_list += "<span class='notice ml-1'>Subject contains the following reagents in their blood:</span>\n"
			for(var/r in M.reagents.reagent_list)
				var/datum/reagent/reagent = r
				if(reagent.chemical_flags & REAGENT_INVISIBLE) //Don't show hidden chems on scanners
					continue
				render_list += "<span class='notice ml-2'>[round(reagent.volume, 0.001)] units of [reagent.name][reagent.overdosed ? "</span> - <span class='boldannounce'>OVERDOSING</span>" : ".</span>"]\n"
		else
			render_list += "<span class='notice ml-1'>Subject contains no reagents in their blood.</span>\n"
		var/obj/item/organ/stomach/belly = M.getorganslot(ORGAN_SLOT_STOMACH)
		if(belly)
			if(belly.reagents.reagent_list.len)
				render_list += "<span class='notice ml-1'>Subject contains the following reagents in their stomach:</span>\n"
				for(var/bile in belly.reagents.reagent_list)
					var/datum/reagent/bit = bile
					if(bit.chemical_flags & REAGENT_INVISIBLE) //Don't show hidden chems on scanners
						continue
					if(!belly.food_reagents[bit.type])
						render_list += "<span class='notice ml-2'>[round(bit.volume, 0.001)] units of [bit.name][bit.overdosed ? "</span> - <span class='boldannounce'>OVERDOSING</span>" : ".</span>"]\n"
					else
						var/bit_vol = bit.volume - belly.food_reagents[bit.type]
						if(bit_vol > 0)
							render_list += "<span class='notice ml-2'>[round(bit_vol, 0.001)] units of [bit.name][bit.overdosed ? "</span> - <span class='boldannounce'>OVERDOSING</span>" : ".</span>"]\n"
			else
				render_list += "<span class='notice ml-1'>Subject contains no reagents in their stomach.</span>\n"

		if(LAZYLEN(M.mind?.active_addictions))
			render_list += "<span class='boldannounce ml-1'>Subject is addicted to the following types of drug:</span>\n"
			for(var/datum/addiction/addiction_type as anything in M.mind.active_addictions)
				render_list += "<span class='alert ml-2'>[initial(addiction_type.name)]</span>\n"
		else
			render_list += "<span class='notice ml-1'>Subject is not addicted to any types of drug.</span>\n"

		if(M.has_status_effect(/datum/status_effect/eigenstasium))
			render_list += "<span class='notice ml-1'>Subject is temporally unstable. Stabilising agent is recommended to reduce disturbances.</span>\n"

		to_chat(user, jointext(render_list, ""), trailing_newline = FALSE) // we handled the last <br> so we don't need handholding

/obj/item/healthanalyzer/verb/toggle_mode()
	set name = "Switch Verbosity"
	set category = "Object"

	if(usr.incapacitated())
		return

	mode = !mode
	to_chat(usr, mode == SCANNER_VERBOSE ? "The scanner now shows specific limb damage." : "The scanner no longer shows limb damage.")

/obj/item/healthanalyzer/advanced
	name = "advanced health analyzer"
	icon_state = "health_adv"
	desc = "A hand-held body scanner able to distinguish vital signs of the subject with high accuracy."
	advanced = TRUE

/// Displays wounds with extended information on their status vs medscanners
/proc/woundscan(mob/user, mob/living/carbon/patient, obj/item/healthanalyzer/wound/scanner)
	if(!istype(patient) || user.incapacitated())
		return

	if(user.is_blind())
		to_chat(user, "<span class='warning'>You realize that your scanner has no accessibility support for the blind!</span>")
		return

	var/render_list = ""
	for(var/i in patient.get_wounded_bodyparts())
		var/obj/item/bodypart/wounded_part = i
		render_list += "<span class='alert ml-1'><b>Warning: Physical trauma[LAZYLEN(wounded_part.wounds) > 1? "s" : ""] detected in [wounded_part.name]</b>"
		for(var/k in wounded_part.wounds)
			var/datum/wound/W = k
			render_list += "<div class='ml-2'>[W.get_scanner_description()]</div>\n"
		render_list += "</span>"

	if(render_list == "")
		if(istype(scanner))
			// Only emit the cheerful scanner message if this scan came from a scanner
			playsound(scanner, 'sound/machines/ping.ogg', 50, FALSE)
			to_chat(user, "<span class='notice'>\The [scanner] makes a happy ping and briefly displays a smiley face with several exclamation points! It's really excited to report that [patient] has no wounds!</span>")
		else
			to_chat(user, "<span class='notice ml-1'>No wounds detected in subject.</span>")
	else
		to_chat(user, jointext(render_list, ""))

/obj/item/healthanalyzer/wound
	name = "first aid analyzer"
	icon_state = "adv_spectrometer"
	desc = "A prototype MeLo-Tech medical scanner used to diagnose injuries and recommend treatment for serious wounds, but offers no further insight into the patient's health. You hope the final version is less annoying to read!"
	var/next_encouragement
	var/greedy

/obj/item/healthanalyzer/wound/attack_self(mob/user)
	if(next_encouragement < world.time)
		playsound(src, 'sound/machines/ping.ogg', 50, FALSE)
		var/list/encouragements = list("briefly displays a happy face, gazing emptily at you", "briefly displays a spinning cartoon heart", "displays an encouraging message about eating healthy and exercising", \
				"reminds you that everyone is doing their best", "displays a message wishing you well", "displays a sincere thank-you for your interest in first-aid", "formally absolves you of all your sins")
		to_chat(user, "<span class='notice'>\The [src] makes a happy ping and [pick(encouragements)]!</span>")
		next_encouragement = world.time + 10 SECONDS
		greedy = FALSE
	else if(!greedy)
		to_chat(user, "<span class='warning'>\The [src] displays an eerily high-definition frowny face, chastizing you for asking it for too much encouragement.</span>")
		greedy = TRUE
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		if(isliving(user))
			var/mob/living/L = user
			to_chat(L, "<span class='warning'>\The [src] makes a disappointed buzz and pricks your finger for being greedy. Ow!</span>")
			L.adjustBruteLoss(4)
			L.dropItemToGround(src)

/obj/item/healthanalyzer/wound/attack(mob/living/carbon/patient, mob/living/carbon/human/user)
	add_fingerprint(user)
	user.visible_message("<span class='notice'>[user] scans [patient] for serious injuries.</span>", "<span class='notice'>You scan [patient] for serious injuries.</span>")

	if(!istype(patient))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
		to_chat(user, "<span class='notice'>\The [src] makes a sad buzz and briefly displays a frowny face, indicating it can't scan [patient].</span>")
		return

	woundscan(user, patient, src)

/obj/item/analyzer
	desc = "A hand-held environmental scanner which reports current gas levels. Alt-Click to use the built in barometer function."
	name = "analyzer"
	custom_price = PAYCHECK_ASSISTANT * 0.9
	icon = 'icons/obj/device.dmi'
	icon_state = "analyzer"
	inhand_icon_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	tool_behaviour = TOOL_ANALYZER
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=20)
	grind_results = list(/datum/reagent/mercury = 5, /datum/reagent/iron = 5, /datum/reagent/silicon = 5)
	var/cooldown = FALSE
	var/cooldown_time = 250
	var/accuracy // 0 is the best accuracy.

/obj/item/analyzer/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click [src] to activate the barometer function.</span>"

/obj/item/analyzer/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to analyze [user.p_them()]self with [src]! The display shows that [user.p_theyre()] dead!</span>")
	return BRUTELOSS

/obj/item/analyzer/attack_self(mob/user)
	add_fingerprint(user)

	if (user.stat || user.is_blind())
		return

	var/turf/location = user.loc
	if(!istype(location))
		return

	var/render_list = list()
	var/datum/gas_mixture/environment = location.return_air()
	var/pressure = environment.return_pressure()
	var/total_moles = environment.total_moles()

	render_list += "<span class='info'><B>Results:</B></span>\
				\n<span class='[abs(pressure - ONE_ATMOSPHERE) < 10 ? "info" : "alert"]'>Pressure: [round(pressure, 0.01)] kPa</span>\n"
	if(total_moles)
		var/list/env_gases = environment.gases

		environment.assert_gases(arglist(GLOB.hardcoded_gases))
		var/o2_concentration = env_gases[/datum/gas/oxygen][MOLES]/total_moles
		var/n2_concentration = env_gases[/datum/gas/nitrogen][MOLES]/total_moles
		var/co2_concentration = env_gases[/datum/gas/carbon_dioxide][MOLES]/total_moles
		var/plasma_concentration = env_gases[/datum/gas/plasma][MOLES]/total_moles

		render_list += "<span class='[abs(n2_concentration - N2STANDARD) < 20 ? "info" : "alert"]'>Nitrogen: [round(n2_concentration*100, 0.01)] % ([round(env_gases[/datum/gas/nitrogen][MOLES], 0.01)] mol)</span>\
			\n<span class='[abs(o2_concentration - O2STANDARD) < 2 ? "info" : "alert"]'>Oxygen: [round(o2_concentration*100, 0.01)] % ([round(env_gases[/datum/gas/oxygen][MOLES], 0.01)] mol)</span>\
			\n<span class='[co2_concentration > 0.01 ? "alert" : "info"]'>CO2: [round(co2_concentration*100, 0.01)] % ([round(env_gases[/datum/gas/carbon_dioxide][MOLES], 0.01)] mol)</span>\
			\n<span class='[plasma_concentration > 0.005 ? "alert" : "info"]'>Plasma: [round(plasma_concentration*100, 0.01)] % ([round(env_gases[/datum/gas/plasma][MOLES], 0.01)] mol)</span>\n"

		environment.garbage_collect()

		for(var/id in env_gases)
			if(id in GLOB.hardcoded_gases)
				continue
			var/gas_concentration = env_gases[id][MOLES]/total_moles
			render_list += "<span class='alert'>[env_gases[id][GAS_META][META_GAS_NAME]]: [round(gas_concentration*100, 0.01)] % ([round(env_gases[id][MOLES], 0.01)] mol)</span>\n"
		render_list += "<span class='info'>Temperature: [round(environment.temperature-T0C, 0.01)] &deg;C ([round(environment.temperature, 0.01)] K)</span>\n"
	to_chat(user, jointext(render_list, ""), trailing_newline = FALSE) // we handled the last <br> so we don't need handholding

/obj/item/analyzer/AltClick(mob/user) //Barometer output for measuring when the next storm happens
	..()

	if(user.canUseTopic(src, BE_CLOSE))
		if(cooldown)
			to_chat(user, "<span class='warning'>[src]'s barometer function is preparing itself.</span>")
			return

		var/turf/T = get_turf(user)
		if(!T)
			return

		playsound(src, 'sound/effects/pop.ogg', 100)
		var/area/user_area = T.loc
		var/datum/weather/ongoing_weather = null

		if(!user_area.outdoors)
			to_chat(user, "<span class='warning'>[src]'s barometer function won't work indoors!</span>")
			return

		for(var/V in SSweather.processing)
			var/datum/weather/W = V
			if(W.barometer_predictable && (T.z in W.impacted_z_levels) && W.area_type == user_area.type && !(W.stage == END_STAGE))
				ongoing_weather = W
				break

		if(ongoing_weather)
			if((ongoing_weather.stage == MAIN_STAGE) || (ongoing_weather.stage == WIND_DOWN_STAGE))
				to_chat(user, "<span class='warning'>[src]'s barometer function can't trace anything while the storm is [ongoing_weather.stage == MAIN_STAGE ? "already here!" : "winding down."]</span>")
				return

			to_chat(user, "<span class='notice'>The next [ongoing_weather] will hit in [butchertime(ongoing_weather.next_hit_time - world.time)].</span>")
			if(ongoing_weather.aesthetic)
				to_chat(user, "<span class='warning'>[src]'s barometer function says that the next storm will breeze on by.</span>")
		else
			var/next_hit = SSweather.next_hit_by_zlevel["[T.z]"]
			var/fixed = next_hit ? timeleft(next_hit) : -1
			if(fixed < 0)
				to_chat(user, "<span class='warning'>[src]'s barometer function was unable to trace any weather patterns.</span>")
			else
				to_chat(user, "<span class='warning'>[src]'s barometer function says a storm will land in approximately [butchertime(fixed)].</span>")
		cooldown = TRUE
		addtimer(CALLBACK(src,/obj/item/analyzer/proc/ping), cooldown_time)

/obj/item/analyzer/proc/ping()
	if(isliving(loc))
		var/mob/living/L = loc
		to_chat(L, "<span class='notice'>[src]'s barometer function is ready!</span>")
	playsound(src, 'sound/machines/click.ogg', 100)
	cooldown = FALSE

/obj/item/analyzer/proc/butchertime(amount)
	if(!amount)
		return
	if(accuracy)
		var/inaccurate = round(accuracy*(1/3))
		if(prob(50))
			amount -= inaccurate
		if(prob(50))
			amount += inaccurate
	return DisplayTimeText(max(1,amount))

/proc/atmosanalyzer_scan(mob/user, atom/target, silent=FALSE)
	var/mixture = target.return_analyzable_air()
	if(!mixture)
		return FALSE

	var/icon = target
	var/render_list = list()
	if(!silent && isliving(user))
		user.visible_message("<span class='notice'>[user] uses the analyzer on [icon2html(icon, viewers(user))] [target].</span>", "<span class='notice'>You use the analyzer on [icon2html(icon, user)] [target].</span>")
	render_list += "<span class='boldnotice'>Results of analysis of [icon2html(icon, user)] [target].</span>"

	var/list/airs = islist(mixture) ? mixture : list(mixture)
	for(var/g in airs)
		if(airs.len > 1) //not a unary gas mixture
			render_list += "<span class='boldnotice'>Node [airs.Find(g)]</span>"
		var/datum/gas_mixture/air_contents = g

		var/total_moles = air_contents.total_moles()
		var/pressure = air_contents.return_pressure()
		var/volume = air_contents.return_volume() //could just do mixture.volume... but safety, I guess?
		var/temperature = air_contents.temperature
		var/cached_scan_results = air_contents.analyzer_results

		if(total_moles > 0)
			render_list += "<span class='notice'>Moles: [round(total_moles, 0.01)] mol</span>\
							\n<span class='notice'>Volume: [volume] L</span>\
							\n<span class='notice'>Pressure: [round(pressure,0.01)] kPa</span>"

			var/list/cached_gases = air_contents.gases
			for(var/id in cached_gases)
				var/gas_concentration = cached_gases[id][MOLES]/total_moles
				render_list += "<span class='notice'>[cached_gases[id][GAS_META][META_GAS_NAME]]: [round(gas_concentration*100, 0.01)] % ([round(cached_gases[id][MOLES], 0.01)] mol)</span>"
			render_list += "<span class='notice'>Temperature: [round(temperature - T0C,0.01)] &deg;C ([round(temperature, 0.01)] K)</span>"
		else
			render_list += airs.len > 1 ? "<span class='notice'>This node is empty!</span>" : "<span class='notice'>[target] is empty!</span>"

		if(cached_scan_results && cached_scan_results["fusion"]) //notify the user if a fusion reaction was detected
			render_list += "<span class='boldnotice'>Large amounts of free neutrons detected in the air indicate that a fusion reaction took place.</span>\
						\n<span class='notice'>Instability of the last fusion reaction: [round(cached_scan_results["fusion"], 0.01)].</span>"

	to_chat(user, jointext(render_list, "\n")) // we let the join apply newlines so we do need handholding
	return TRUE

//slime scanner

/obj/item/slime_scanner
	name = "slime scanner"
	desc = "A device that analyzes a slime's internal composition and measures its stats."
	icon = 'icons/obj/device.dmi'
	icon_state = "adv_spectrometer"
	inhand_icon_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=20)

/obj/item/slime_scanner/attack(mob/living/M, mob/living/user)
	if(user.stat || user.is_blind())
		return
	if (!isslime(M))
		to_chat(user, "<span class='warning'>This device can only scan slimes!</span>")
		return
	var/mob/living/simple_animal/slime/T = M
	slime_scan(T, user)

/proc/slime_scan(mob/living/simple_animal/slime/T, mob/living/user)
	var/to_render = "========================\
					\n<b>Slime scan results:</b>\
					\n<span class='notice'>[T.colour] [T.is_adult ? "adult" : "baby"] slime</span>\
					\nNutrition: [T.nutrition]/[T.get_max_nutrition()]"
	if (T.nutrition < T.get_starve_nutrition())
		to_render += "\n<span class='warning'>Warning: slime is starving!</span>"
	else if (T.nutrition < T.get_hunger_nutrition())
		to_render += "\n<span class='warning'>Warning: slime is hungry</span>"
	to_render += "\nElectric change strength: [T.powerlevel]\nHealth: [round(T.health/T.maxHealth,0.01)*100]%"
	if (T.slime_mutation[4] == T.colour)
		to_render += "\nThis slime does not evolve any further."
	else
		if (T.slime_mutation[3] == T.slime_mutation[4])
			if (T.slime_mutation[2] == T.slime_mutation[1])
				to_render += "\nPossible mutation: [T.slime_mutation[3]]\
							  \nGenetic destability: [T.mutation_chance/2] % chance of mutation on splitting"
			else
				to_render += "\nPossible mutations: [T.slime_mutation[1]], [T.slime_mutation[2]], [T.slime_mutation[3]] (x2)\
							  \nGenetic destability: [T.mutation_chance] % chance of mutation on splitting"
		else
			to_render += "\nPossible mutations: [T.slime_mutation[1]], [T.slime_mutation[2]], [T.slime_mutation[3]], [T.slime_mutation[4]]\
						  \nGenetic destability: [T.mutation_chance] % chance of mutation on splitting"
	if (T.cores > 1)
		to_render += "\nMultiple cores detected"
	to_render += "\nGrowth progress: [T.amount_grown]/[SLIME_EVOLUTION_THRESHOLD]"
	if(T.effectmod)
		to_render += "\n<span class='notice'>Core mutation in progress: [T.effectmod]</span>\
					  \n<span class='notice'>Progress in core mutation: [T.applied] / [SLIME_EXTRACT_CROSSING_REQUIRED]</span>"
	to_chat(user, to_render + "\n========================")


/obj/item/nanite_scanner
	name = "nanite scanner"
	icon = 'icons/obj/device.dmi'
	icon_state = "nanite_scanner"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "A hand-held body scanner able to detect nanites and their programming."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=200)

/obj/item/nanite_scanner/attack(mob/living/M, mob/living/carbon/human/user)
	user.visible_message("<span class='notice'>[user] analyzes [M]'s nanites.</span>", \
						"<span class='notice'>You analyze [M]'s nanites.</span>")

	add_fingerprint(user)

	var/response = SEND_SIGNAL(M, COMSIG_NANITE_SCAN, user, TRUE)
	if(!response)
		to_chat(user, "<span class='info'>No nanites detected in the subject.</span>")

/obj/item/sequence_scanner
	name = "genetic sequence scanner"
	icon = 'icons/obj/device.dmi'
	icon_state = "gene"
	inhand_icon_state = "healthanalyzer"
	worn_icon_state = "healthanalyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "A hand-held scanner for analyzing someones gene sequence on the fly. Hold near a DNA console to update the internal database."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=200)
	var/list/discovered = list() //hit a dna console to update the scanners database
	var/list/buffer
	var/ready = TRUE
	var/cooldown = 200

/obj/item/sequence_scanner/attack(mob/living/M, mob/living/carbon/human/user)
	add_fingerprint(user)
	if (!HAS_TRAIT(M, TRAIT_GENELESS) && !HAS_TRAIT(M, TRAIT_BADDNA)) //no scanning if its a husk or DNA-less Species
		user.visible_message("<span class='notice'>[user] analyzes [M]'s genetic sequence.</span>", \
							"<span class='notice'>You analyze [M]'s genetic sequence.</span>")
		gene_scan(M, user)

	else
		user.visible_message("<span class='notice'>[user] fails to analyze [M]'s genetic sequence.</span>", "<span class='warning'>[M] has no readable genetic sequence!</span>")

/obj/item/sequence_scanner/attack_self(mob/user)
	display_sequence(user)

/obj/item/sequence_scanner/attack_self_tk(mob/user)
	return

/obj/item/sequence_scanner/afterattack(obj/O, mob/user, proximity)
	. = ..()
	if(!istype(O) || !proximity)
		return

	if(istype(O, /obj/machinery/computer/scan_consolenew))
		var/obj/machinery/computer/scan_consolenew/C = O
		if(C.stored_research)
			to_chat(user, "<span class='notice'>[name] linked to central research database.</span>")
			discovered = C.stored_research.discovered_mutations
		else
			to_chat(user,"<span class='warning'>No database to update from.</span>")

/obj/item/sequence_scanner/proc/gene_scan(mob/living/carbon/C, mob/living/user)
	if(!iscarbon(C) || !C.has_dna())
		return
	buffer = C.dna.mutation_index
	to_chat(user, "<span class='notice'>Subject [C.name]'s DNA sequence has been saved to buffer.</span>")
	if(LAZYLEN(buffer))
		for(var/A in buffer)
			to_chat(user, "<span class='notice'>[get_display_name(A)]</span>")


/obj/item/sequence_scanner/proc/display_sequence(mob/living/user)
	if(!LAZYLEN(buffer) || !ready)
		return
	var/list/options = list()
	for(var/A in buffer)
		options += get_display_name(A)

	var/answer = input(user, "Analyze Potential", "Sequence Analyzer")  as null|anything in sortList(options)
	if(answer && ready && user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		var/sequence
		for(var/A in buffer) //this physically hurts but i dont know what anything else short of an assoc list
			if(get_display_name(A) == answer)
				sequence = buffer[A]
				break

		if(sequence)
			var/display
			for(var/i in 0 to length_char(sequence) / DNA_MUTATION_BLOCKS-1)
				if(i)
					display += "-"
				display += copytext_char(sequence, 1 + i*DNA_MUTATION_BLOCKS, DNA_MUTATION_BLOCKS*(1+i) + 1)

			to_chat(user, "<span class='boldnotice'>[display]</span><br>")

		ready = FALSE
		icon_state = "[icon_state]_recharging"
		addtimer(CALLBACK(src, .proc/recharge), cooldown, TIMER_UNIQUE)

/obj/item/sequence_scanner/proc/recharge()
	icon_state = initial(icon_state)
	ready = TRUE

/obj/item/sequence_scanner/proc/get_display_name(mutation)
	var/datum/mutation/human/HM = GET_INITIALIZED_MUTATION(mutation)
	if(!HM)
		return "ERROR"
	if(mutation in discovered)
		return  "[HM.name] ([HM.alias])"
	else
		return HM.alias

/obj/item/scanner_wand
	name = "kiosk scanner wand"
	icon = 'icons/obj/device.dmi'
	icon_state = "scanner_wand"
	inhand_icon_state = "healthanalyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "A wand for scanning someone else for a medical analysis. Insert into a kiosk is make the scanned patient the target of a health scan."
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	var/selected_target = null

/obj/item/scanner_wand/attack(mob/living/M, mob/living/carbon/human/user)
	flick("[icon_state]_active", src) //nice little visual flash when scanning someone else.

	if((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(25))
		user.visible_message("<span class='warning'>[user] targets himself for scanning.</span>", \
		to_chat(user, "<span class='info'>You try scanning [M], before realizing you're holding the scanner backwards. Whoops.</span>"))
		selected_target = user
		return

	if(!ishuman(M))
		to_chat(user, "<span class='info'>You can only scan human-like, non-robotic beings.</span>")
		selected_target = null
		return

	user.visible_message("<span class='notice'>[user] targets [M] for scanning.</span>", \
						"<span class='notice'>You target [M] vitals.</span>")
	selected_target = M
	return

/obj/item/scanner_wand/attack_self(mob/user)
	to_chat(user, "<span class='info'>You clear the scanner's target.</span>")
	selected_target = null

/obj/item/scanner_wand/proc/return_patient()
	var/returned_target = selected_target
	return returned_target

#undef SCANMODE_HEALTH
#undef SCANMODE_WOUND
#undef SCANMODE_COUNT
#undef SCANNER_CONDENSED
#undef SCANNER_VERBOSE
