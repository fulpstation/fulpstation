
/datum/job/prisoner
	paycheck_department = ACCOUNT_PRISON
	department_for_prefs = /datum/job_department/service

/datum/job/prisoner/award_service(client/winner, award)
	winner.give_award(award, winner.mob)

	var/datum/venue/restaurant = SSrestaurant.all_venues[/datum/venue/restaurant/prison]
	var/award_score = restaurant.total_income
	var/award_status = winner.get_award_status(/datum/award/score/prisoner_tourist_score)
	if(award_score > award_status)
		award_score -= award_status
	winner.give_award(/datum/award/score/prisoner_tourist_score, winner.mob, award_score)
