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

	/// Score, gained by eating bodies. Does not decrease
	var/score = 0
	/// Points, gained primarily by eating bodies. Can be used on powers
	var/points = 0
	/// Whether or not we're transformed
	var/transformed = FALSE

	/// All the powers we have available always
	var/list/datum/action/cooldown/spell/powers = list()
	/// All the powers we have available when transformed
	var/list/datum/action/cooldown/spell/transformed_powers = list()
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

	var/datum/action/cooldown/spell/shapeshift/werewolf_transform/transform_spell
	var/atom/movable/screen/werewolf/bite_button/bite_display
	var/datum/component/tackler/werewolf/werewolf_tackler
	/// Old unarmed damage values for left arm. [1] = low, [2] = high
	var/list/old_left_arm_unarmed_damage = list()
	/// Old unarmed damage values for right arm. [1] = low, [2] = high
	var/list/old_right_arm_unarmed_damage = list()

/datum/antagonist/werewolf/on_gain()
	. = ..()
	var/datum/hud/werewolf_hud = owner.current.hud_used
	bite_display = new /atom/movable/screen/werewolf/bite_button(null, werewolf_hud)
	werewolf_hud.infodisplay += bite_display

	RegisterSignal(SSsunlight, COMSIG_LUN_WARNING, PROC_REF(handle_lun_warnings))
	RegisterSignal(SSsunlight, COMSIG_LUN_START, PROC_REF(handle_lun_start))
	RegisterSignal(SSsunlight, COMSIG_LUN_END, PROC_REF(handle_lun_end))
	RegisterSignal(owner.current, COMSIG_WEREWOLF_TRANSFORM_CAST, PROC_REF(handle_transform_cast))

	transform_spell = new /datum/action/cooldown/spell/shapeshift/werewolf_transform(src)
	transform_spell.Grant(owner.current)

	learn_transformed_power(new /datum/action/cooldown/spell/touch/werewolf_bite)
	learn_transformed_power(new /datum/action/cooldown/spell/werewolf_freedom)
	learn_transformed_power(new /datum/action/cooldown/spell/werewolf_claws)

	werewolf_hud.show_hud(werewolf_hud.hud_version)

	check_start_sol()

/datum/antagonist/werewolf/on_removal()
	var/datum/hud/werewolf_hud = owner.current.hud_used
	werewolf_hud.infodisplay -= bite_display
	werewolf_hud.show_hud(werewolf_hud.hud_version)
	revert_transformation()
	remove_powers()
	check_cancel_sol()

	transform_spell.Remove(owner.current)
	qdel(transform_spell)

	UnregisterSignal(SSsunlight, COMSIG_LUN_WARNING)
	UnregisterSignal(SSsunlight, COMSIG_LUN_START)
	UnregisterSignal(SSsunlight, COMSIG_LUN_END)

	UnregisterSignal(owner.current, COMSIG_WEREWOLF_TRANSFORM_CAST)

	return ..()

/datum/antagonist/werewolf/proc/learn_power(datum/action/cooldown/spell/power)
	powers += power
	power.Grant(owner.current)

/datum/antagonist/werewolf/proc/unlearn_power(datum/action/cooldown/spell/power)
	powers -= power
	power.Remove(owner.current)

/datum/antagonist/werewolf/proc/learn_transformed_power(datum/action/cooldown/spell/power)
	transformed_powers += power
	if(transformed)
		power.Grant(owner.current)


/datum/antagonist/werewolf/proc/unlearn_transformed_power(datum/action/cooldown/spell/power)
	transformed_powers -= power
	power.Remove(owner.current)


/datum/antagonist/werewolf/proc/remove_powers()
	for(var/datum/action/cooldown/spell/power as anything in powers)
		unlearn_power(power)
	for(var/datum/action/cooldown/spell/power as anything in transformed_powers)
		unlearn_transformed_power(power)

/datum/antagonist/werewolf/proc/handle_transform_cast(atom/owner)
	SIGNAL_HANDLER
	toggle_transformation()

/datum/antagonist/werewolf/proc/apply_transformation()
	if(!owner?.current)
		return FALSE
	if(transformed)
		return TRUE

	if(owner.current.has_status_effect(/datum/status_effect/shapechange_mob))
		return FALSE

	transform_spell.cast(owner.current)
	return TRUE

/datum/antagonist/werewolf/proc/revert_transformation()
	if(!owner?.current)
		return FALSE

	if(!transformed)
		return TRUE

	if(!owner.current.has_status_effect(/datum/status_effect/shapechange_mob/from_spell))
		return FALSE

	transform_spell.cast(owner.current)
	return TRUE

/datum/antagonist/werewolf/proc/toggle_transformation()
	if(!owner?.current)
		return FALSE
	if(transformed)
		revert_transformation()
	else
		apply_transformation()
	return TRUE
