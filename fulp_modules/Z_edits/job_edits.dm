/**
 *	# Job edits
 *
 * Overwrite TG code to add exp requirement of a few dangerous jobs.
 * Additionally setting fulp config job slots, since TG's job config is unstable, and overwrites map .json job positions.
 */

/** Security */
/datum/job/warden
	total_positions = 2
	spawn_positions = 1

/datum/job/detective
	total_positions = 2
	spawn_positions = 1

/datum/job/security_officer
	total_positions = 8
	spawn_positions = 8

/** Engineering */
/datum/job/station_engineer
	total_positions = 7
	spawn_positions = 5
	exp_requirements = 180

/datum/job/atmospheric_technician
	exp_requirements = 300

/** Science */
/datum/job/scientist
	total_positions = 6
	spawn_positions = 3
	exp_requirements = 180

/datum/job/roboticist
	total_positions = 3
	spawn_positions = 2
	exp_requirements = 180

/datum/job/geneticist
	total_positions = 3
	spawn_positions = 2
	exp_requirements = 180

/** Medical */
/datum/job/doctor
	total_positions = 8
	spawn_positions = 6
	exp_requirements = 180

/datum/job/paramedic
	total_positions = 2
	spawn_positions = 2
	exp_requirements = 180

/datum/job/chemist
	total_positions = 3
	spawn_positions = 2
	exp_requirements = 180

/datum/job/virologist
	exp_requirements = 300

/** Supply */
/datum/job/quartermaster
	exp_requirements = 300

/datum/job/cargo_technician
	total_positions = 6
	spawn_positions = 4
	exp_requirements = 300

/datum/job/shaft_miner
	total_positions = 5
	spawn_positions = 3
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CREW

/** Service */
/datum/job/bartender
	total_positions = 2
	spawn_positions = 2

/datum/job/botanist
	total_positions = 3
	spawn_positions = 3

/datum/job/cook
	total_positions = 2
	spawn_positions = 2

/datum/job/janitor
	total_positions = 6
	spawn_positions = 3

/datum/job/clown
	total_positions = 2
	spawn_positions = 1

/datum/job/mime
	total_positions = 2
	spawn_positions = 1

/datum/job/curator
	total_positions = 2
	spawn_positions = 1

/datum/job/curator/New()
	mind_traits += list(TRAIT_BLOODSUCKER_HUNTER)
	return ..()

/datum/job/lawyer
	total_positions = 4
	spawn_positions = 2

/datum/job/chaplain
	total_positions = 2
	spawn_positions = 1

/datum/job/psychologist
	total_positions = 2
	spawn_positions = 1

/** Silicon */
/datum/job/cyborg
	total_positions = 0
	spawn_positions = 2
	exp_requirements = 300
