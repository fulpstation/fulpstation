/**
 * Overwriting the Economy subsystem to add Prisoner budgets
 */
/datum/controller/subsystem/economy/Initialize(timeofday)
	department_accounts |= list(ACCOUNT_PRISON = ACCOUNT_PRISON_NAME)
	. = ..()
