/datum/antagonist/werewolf
	name = "\improper Werewolf"
	show_in_antagpanel = TRUE
	roundend_category = "werewolves"
	antagpanel_category = "Werewolf"
	job_rank = ROLE_WEREWOLF
	antag_hud_name = "werewolf"
	show_name_in_check_antagonists = TRUE
	// Doesn't look like this is actually used anywhere but you never know
	can_coexist_with_others = FALSE
	tip_theme = "spookyconsole"
	antag_tips = list(
		"You're a werewolf, nuff said.",
		"This will be replaced with actual real tips later on."
	)
	/// Whether or not we're transformed
	var/transformed = FALSE

	/// All the powers we have available
	var/list/datum/action/cooldown/werewolf/powers = list()
	/// Traits the werewolf has while transformed
	var/list/transformed_traits = list(
		TRAIT_WEREWOLF_TRANSFORMED,
		TRAIT_BATON_RESISTANCE,
		TRAIT_ILLITERATE,
		TRAIT_CHUNKYFINGERS,
		TRAIT_DISCOORDINATED_TOOL_USER,
		TRAIT_FEARLESS,
		TRAIT_SLEEPIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_PUSHIMMUNE,
		TRAIT_NODISMEMBER,
		TRAIT_NO_ZOMBIFY,
		TRAIT_NO_TRANSFORMATION_STING,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_SLIP_WATER,
		TRAIT_GOOD_HEARING,
		TRAIT_NOFLASH,
		TRAIT_DISFIGURED,
		TRAIT_SNOWSTORM_IMMUNE,
		TRAIT_GIANT,
		TRAIT_STUNIMMUNE
	)

	var/atom/movable/screen/werewolf/bite_button/bite_display
	var/datum/component/tackler/werewolf/werewolf_tackler

/datum/antagonist/werewolf/on_gain()
	. = ..()
	var/datum/hud/werewolf_hud = owner.current.hud_used
	bite_display = new /atom/movable/screen/werewolf/bite_button(null, werewolf_hud)
	werewolf_hud.infodisplay += bite_display

	RegisterSignal(SSsunlight, COMSIG_LUN_WARNING, PROC_REF(handle_lun_warnings))
	RegisterSignal(SSsunlight, COMSIG_LUN_START, PROC_REF(handle_lun_start))
	RegisterSignal(SSsunlight, COMSIG_LUN_END, PROC_REF(handle_lun_end))

	add_power(new /datum/action/cooldown/werewolf/bite)
	add_power(new /datum/action/cooldown/werewolf/freedom)
	add_power(new /datum/action/cooldown/werewolf/transform)

	werewolf_hud.show_hud(werewolf_hud.hud_version)

	check_start_sol()

/datum/antagonist/werewolf/on_removal()
	var/datum/hud/werewolf_hud = owner.current.hud_used
	werewolf_hud.infodisplay -= bite_display
	werewolf_hud.show_hud(werewolf_hud.hud_version)
	revert_transformation()
	remove_powers()
	check_cancel_sol()

	UnregisterSignal(SSsunlight, COMSIG_LUN_WARNING)
	UnregisterSignal(SSsunlight, COMSIG_LUN_START)
	UnregisterSignal(SSsunlight, COMSIG_LUN_END)

	return ..()

/datum/antagonist/werewolf/proc/add_power(datum/action/cooldown/werewolf/power)
	power.Grant(owner.current)
	powers += power


/datum/antagonist/werewolf/proc/remove_power(datum/action/cooldown/werewolf/power)
	power.Remove(owner.current)
	powers -= power


/datum/antagonist/werewolf/proc/remove_powers()
	for(var/datum/action/cooldown/werewolf/power as anything in powers)
		remove_power(power)


/datum/antagonist/werewolf/proc/apply_transformation()
	if(!owner?.current)
		return FALSE
	if(transformed)
		return TRUE
	owner.current.add_traits(transformed_traits, WEREWOLF_TRAIT)
	werewolf_tackler = owner.current.AddComponent( \
		/datum/component/tackler/werewolf, \
		stamina_cost=WP_TACKLE_STAM_COST, \
		base_knockdown = WP_TACKLE_BASE_KNOCKDOWN, \
		range = WP_TACKLE_RANGE, \
		speed = WP_TACKLE_SPEED, \
		skill_mod = WP_TACKLE_SKILL_MOD, \
		min_distance = WP_TACKLE_MIN_DIST \
	)
	transformed = TRUE
	SEND_SIGNAL(owner.current, WEREWOLF_TRANSFORMED)
	return TRUE


/datum/antagonist/werewolf/proc/revert_transformation()
	if(!owner?.current)
		return FALSE
	if(!transformed)
		return TRUE
	// owner.current.remove_traits(transformed_traits, WEREWOLF_TRAIT)
	qdel(werewolf_tackler)
	transformed = FALSE
	SEND_SIGNAL(owner.current, WEREWOLF_REVERTED)
	return TRUE

/datum/antagonist/werewolf/proc/toggle_transformation()
	if(!owner?.current)
		return FALSE
	if(transformed)
		revert_transformation()
	else
		apply_transformation()
	return TRUE



