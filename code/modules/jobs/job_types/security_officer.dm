/datum/job/security_officer
	title = "Security Officer"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 5 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	spawn_positions = 5 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	supervisors = "the head of security, and the head of your assigned department (if applicable)"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/security
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC
	departments = DEPARTMENT_SECURITY

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/boomerang/loaded = 1
	)

GLOBAL_LIST_INIT(available_depts, list(SEC_DEPT_ENGINEERING, SEC_DEPT_MEDICAL, SEC_DEPT_SCIENCE, SEC_DEPT_SUPPLY))

/**
 * The department distribution of the security officers.
 *
 * Keys are refs of the security officer mobs. This is to preserve the list's structure even if the
 * mob gets deleted. This is also safe, as mobs are guaranteed to have a unique ref, as per /mob/GenerateTag().
 */
GLOBAL_LIST_EMPTY(security_officer_distribution)

/datum/job/security_officer/after_spawn(mob/living/carbon/human/H, mob/M, latejoin = FALSE)
	. = ..()

	var/department

	var/prefered_department = M.client?.prefs?.prefered_security_department
	if (!isnull(prefered_department))
		department = get_my_department(H, prefered_department)

		if (latejoin)
			announce_latejoin(H, department, GLOB.security_officer_distribution)

		// In the event we're a latejoin, or otherwise aren't in the round-start distributions.
		// This is outside the latejoin check because this should theoretically still run if
		// a player isn't in the distributions, but isn't a late join.
		GLOB.security_officer_distribution[REF(H)] = department

	var/ears = null
	var/accessory = null
	var/list/dep_trim = null
	var/destination = null
	var/spawn_point = pick(LAZYACCESS(GLOB.department_security_spawns, department))

	switch(department)
		if(SEC_DEPT_SUPPLY)
			ears = /obj/item/radio/headset/headset_sec/alt/department/supply
			dep_trim = /datum/id_trim/job/security_officer/supply
			destination = /area/security/checkpoint/supply
			accessory = /obj/item/clothing/accessory/armband/cargo
		if(SEC_DEPT_ENGINEERING)
			ears = /obj/item/radio/headset/headset_sec/alt/department/engi
			dep_trim = /datum/id_trim/job/security_officer/engineering
			destination = /area/security/checkpoint/engineering
			accessory = /obj/item/clothing/accessory/armband/engine
		if(SEC_DEPT_MEDICAL)
			ears = /obj/item/radio/headset/headset_sec/alt/department/med
			dep_trim = /datum/id_trim/job/security_officer/medical
			destination = /area/security/checkpoint/medical
			accessory =  /obj/item/clothing/accessory/armband/medblue
		if(SEC_DEPT_SCIENCE)
			ears = /obj/item/radio/headset/headset_sec/alt/department/sci
			dep_trim = /datum/id_trim/job/security_officer/science
			destination = /area/security/checkpoint/science
			accessory = /obj/item/clothing/accessory/armband/science

	if(accessory)
		var/obj/item/clothing/under/U = H.w_uniform
		U.attach_accessory(new accessory)
	if(ears)
		if(H.ears)
			qdel(H.ears)
		H.equip_to_slot_or_del(new ears(H),ITEM_SLOT_EARS)

	// If there's a departmental sec trim to apply to the card, overwrite.
	if(dep_trim)
		var/obj/item/card/id/worn_id = H.wear_id
		SSid_access.apply_trim_to_card(worn_id, dep_trim)
		H.sec_hud_set_ID()

	var/teleport = 0
	if(!CONFIG_GET(flag/sec_start_brig))
		if(destination || spawn_point)
			teleport = 1
	if(teleport)
		var/turf/T
		if(spawn_point)
			T = get_turf(spawn_point)
			H.Move(T)
		else
			var/list/possible_turfs = get_area_turfs(destination)
			while (length(possible_turfs))
				var/I = rand(1, possible_turfs.len)
				var/turf/target = possible_turfs[I]
				if (H.Move(target))
					break
				possible_turfs.Cut(I,I+1)
	if(department)
		to_chat(M, "<b>You have been assigned to [department]!</b>")
	else
		to_chat(M, "<b>You have not been assigned to any department. Patrol the halls and help where needed.</b>")

/datum/job/security_officer/proc/announce_latejoin(
	mob/officer,
	department,
	distribution,
)
	var/obj/machinery/announcement_system/announcement_system = pick(GLOB.announcement_systems)
	if (isnull(announcement_system))
		return

	announcement_system.announce_officer(officer, department)

	var/list/targets = list()

	var/list/partners = list()
	for (var/officer_ref in distribution)
		var/mob/partner = locate(officer_ref)
		if (!istype(partner) || distribution[officer_ref] != department)
			continue
		partners += partner.real_name

	if (partners.len)
		for (var/obj/item/pda/pda as anything in GLOB.PDAs)
			if (pda.owner in partners)
				targets += "[pda.owner] ([pda.ownjob])"

	if (!targets.len)
		return

	var/datum/signal/subspace/messaging/pda/signal = new(announcement_system, list(
		"name" = "Security Department Update",
		"job" = "Automated Announcement System",
		"message" = "Officer [officer.real_name] has been assigned to your department, [department].",
		"targets" = targets,
		"automated" = TRUE,
	))

	signal.send_to_receivers()

/datum/job/security_officer/proc/get_my_department(mob/character, preferred_department)
	var/department = GLOB.security_officer_distribution[REF(character)]

	// This passes when they are a round start security officer.
	if (department)
		return department

	return get_new_officer_distribution_from_late_join(
		preferred_department,
		shuffle(GLOB.available_depts),
		GLOB.security_officer_distribution,
	)

/datum/outfit/job/security
	name = "Security Officer"
	jobtype = /datum/job/security_officer

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/officer
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/sec
	suit = /obj/item/clothing/suit/armor/vest/alt
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	suit_store = /obj/item/gun/energy/disabler
	backpack_contents = list(/obj/item/melee/baton/loaded=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/energy/disabler, /obj/item/clothing/glasses/hud/security/sunglasses, /obj/item/clothing/head/helmet)
	//The helmet is necessary because /obj/item/clothing/head/helmet/sec is overwritten in the chameleon list by the standard helmet, which has the same name and icon state

	id_trim = /datum/id_trim/job/security_officer

/obj/item/radio/headset/headset_sec/alt/department/Initialize()
	. = ..()
	wires = new/datum/wires/radio(src)
	secure_radio_connections = new
	recalculateChannels()

/obj/item/radio/headset/headset_sec/alt/department/engi
	keyslot = new /obj/item/encryptionkey/headset_sec
	keyslot2 = new /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/headset_sec/alt/department/supply
	keyslot = new /obj/item/encryptionkey/headset_sec
	keyslot2 = new /obj/item/encryptionkey/headset_cargo
/obj/item/radio/headset/headset_sec/alt/department/med
	keyslot = new /obj/item/encryptionkey/headset_sec
	keyslot2 = new /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/headset_sec/alt/department/sci
	keyslot = new /obj/item/encryptionkey/headset_sec
	keyslot2 = new /obj/item/encryptionkey/headset_sci

/// Returns the distribution of splitting the given security officers into departments.
/// Return value is an assoc list of candidate => SEC_DEPT_*.
/proc/get_officer_departments(list/preferences, list/departments)
	if (!preferences.len)
		return list()

	/**
	 * This is a pretty complicated algorithm, but it's one I'm rather proud of.
	 *
	 * This is the function that is responsible for taking the list of preferences,
	 * and spitting out what to put them in.
	 *
	 * However, it should, wherever possible, prevent solo departments.
	 * That means that if there's one medical officer, and one engineering officer,
	 * that they should be put onto the same department (either medical or engineering).
	 *
	 * The first step is to get the "distribution". This describes how many officers
	 * should be in each department, no matter what they are.
	 * This is handled in `get_distribution`. Examples of inputs/outputs are:
	 * get_distribution(1, 4) => [1]
	 * get_distribution(2, 4) => [2]
	 * get_distribution(3, 4) => [3] # If this returned [2, 1], then we'd get a loner.
	 * get_distribution(4, 4) => [2, 2] # We have enough to put into a separate group
	 *
	 * Once this distribution is received, the next step is to figure out where to put everyone.
	 *
	 * If all members have no preference, just make one an unused department (from the departments argument).
	 * Then, call ourselves again.
	 *
	 * Order the groups from most populated to least.
	 *
	 * If the top group has enough officers who actually *want* that department, then we give it to them.
	 * If there are any leftovers (for example, if 3 officers want medical, but we only want 2), then we
	 * update those to have no preference instead.
	 *
	 * If the top group does NOT have enough officers, then we kill the least popular group by setting
	 * them all to have no preference.
	 *
	 * Anyone in the most popular group will be removed from the list, and the final tally will be updated.
	 * In the case of not having enough officers, this is a no-op, as there won't be any in the most popular group yet.
	 *
	 * If there are any candidates left, then we call the algorithm again, but for everyone who hasn't been selected yet.
	 * We take the results from that run, and put them in the correct order.
	 *
	 * As an example, let's assume we have the following preferences:
	 * [engineer, medical, medical, medical, medical, cargo]
	 *
	 * The distribution of this is [2, 2, 2], meaning there will be 3 departments chosen and they will have 2 each.
	 * We order from most popular to least popular and get:
	 * - medical: 4
	 * - engineer: 1
	 * - cargo: 1
	 *
	 * We need 2 to fill the first group. There are enough medical staff to do it. Thus, we take the first 2 medical staff
	 * and update the output, making it now: [engineer, medical, medical, ?, ?, cargo].
	 *
	 * The remaining two want-to-be-medical officers are now updated to act as no preference. We run the algorithm again.
	 * This time, are candidates are [engineer, none, none, cargo].
	 * The distribution of this is [2, 2]. The frequency is:
	 * - engineer: 1
	 * - cargo: 1
	 * - no preference: 2
	 *
	 * We need 2 to fill the engineering group, but only have one who wants to do it.
	 * We have enough no preferences for it, making our result: [engineer, engineer, none, cargo].
	 * We run the algorithm again, but this time with: [none, cargo].
	 * Frequency is:
	 * - cargo: 1
	 * - no preference: 1
	 * Enough to fill cargo, etc, and we get [cargo, cargo].
	 *
	 * These are all then compounded into one list.
	 *
	 * In the case that all are no preference, it will pop the last department, and use that.
	 * For example, if `departments` is [engi, medical, cargo], and we have the preferences:
	 * [none, none, none]...
	 * Then we will just give them all cargo.
	 *
	 * One of the most important parts of this algorithm is IT IS DETERMINISTIC.
	 * That means that this proc is 100% testable.
	 * Instead, to get random results, the preferences and departments are shuffled
	 * before the proc is ever called.
	*/

	preferences = preferences.Copy()
	departments = departments.Copy()

	var/distribution = get_distribution(preferences.len, departments.len)
	var/selection[preferences.len]

	var/list/grouped = list()
	var/list/biggest_group
	var/biggest_preference
	var/list/indices = list()

	for (var/index in 1 to preferences.len)
		indices += index

		var/preference = preferences[index]
		if (!(preference in grouped))
			grouped[preference] = list()
		grouped[preference] += index

		var/list/preferred_group = grouped[preference]

		if (preference != SEC_DEPT_NONE && (isnull(biggest_group) || biggest_group.len < preferred_group.len))
			biggest_group = grouped[preference]
			biggest_preference = preference

	if (isnull(biggest_group))
		preferences[1] = pop(departments)
		return get_officer_departments(preferences, departments)

	if (biggest_group.len >= distribution[1])
		for (var/index in 1 to distribution[1])
			selection[biggest_group[index]] = biggest_preference

		if (biggest_group.len > distribution[1])
			for (var/leftover in (distribution[1] + 1) to biggest_group.len)
				preferences[leftover] = SEC_DEPT_NONE
	else
		var/needed = distribution[1] - biggest_group.len
		if (LAZYLEN(LAZYACCESS(grouped, SEC_DEPT_NONE)) >= needed)
			for (var/candidate_index in biggest_group)
				selection[candidate_index] = biggest_preference

			for (var/index in 1 to needed)
				selection[grouped[SEC_DEPT_NONE][index]] = biggest_preference
		else
			var/least_popular_index = grouped[grouped.len]
			if (least_popular_index == SEC_DEPT_NONE)
				least_popular_index = grouped[grouped.len - 1]
			var/least_popular = grouped[least_popular_index]
			for (var/candidate_index in least_popular)
				preferences[candidate_index] = SEC_DEPT_NONE

	// Remove all members of the most popular candidate from the list
	for (var/chosen in 1 to selection.len)
		if (selection[chosen] == biggest_preference)
			indices -= chosen
			preferences[chosen] = null

	listclearnulls(preferences)

	departments -= biggest_preference

	if (grouped.len != 1)
		var/list/next_step = get_officer_departments(preferences, departments)
		for (var/index in 1 to indices.len)
			var/place = indices[index]
			selection[place] = next_step[index]

	return selection

/proc/get_distribution(candidates, departments)
	var/number_of_twos = min(departments, round(candidates / 2))
	var/redistribute = candidates - (2 * number_of_twos)

	var/distribution[max(1, number_of_twos)]

	for (var/index in 1 to number_of_twos)
		distribution[index] = 2

	for (var/index in 0 to redistribute - 1)
		distribution[(index % departments) + 1] += 1

	return distribution

/proc/get_new_officer_distribution_from_late_join(
	preference,
	list/departments,
	list/distribution,
)
	/**
	 * For late joiners, we're forced to put them in an alone department at some point.
	 *
	 * This is because reusing the round-start algorithm would force existing officers into
	 * a different department in order to preserve having partners at all times.
	 *
	 * This would mean retroactively updating their access as well, which is too much
	 * of a headache for me to want to bother.
	 *
	 * So, here's the method. If any department currently has 1 officer, they are forced into
	 * that.
	 *
	 * Otherwise, the department with the least officers in it is chosen.
	 * Preference takes priority, meaning that if both medical and engineering have zero officers,
	 * and the preference is medical, then medical is what will be chosen.
	 *
	 * Just like `get_officer_departments`, this function is deterministic.
	 * Randomness should instead be handled in the shuffling of the `departments` argument.
	 */
	var/list/amount_in_departments = list()

	for (var/department in departments)
		amount_in_departments[department] = 0

	for (var/officer in distribution)
		var/department = distribution[officer]
		if (!isnull(department))
			amount_in_departments[department] += 1

	var/list/lowest_departments = list(departments[1])
	var/lowest_amount = INFINITY

	for (var/department in amount_in_departments)
		var/amount = amount_in_departments[department]

		if (amount == 1)
			return department
		else if (lowest_amount > amount)
			lowest_departments = list(department)
			lowest_amount = amount
		else if (lowest_amount == amount)
			lowest_departments += department

	return (preference in lowest_departments) ? preference : lowest_departments[1]
