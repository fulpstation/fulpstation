
/datum/job/prisoner
	//Because we're now a "Service" role rather than a "No Department" one, we need to overwrite this to have a proper display order.
	//At time of writing, pun pun is the lowest Service role, so we're basing it off of that. If tests fail, then a new job was added,
	//simply make the new job the typepath we're copying below to fix it.
	display_order = /datum/job/pun_pun::display_order + 1
	department_for_prefs = /datum/job_department/service
	//Set to service so award_service() works
	departments_list = list(
		/datum/job_department/service,
		)

/datum/job/prisoner/award_service(client/winner, award)
	winner.give_award(award, winner.mob)

	var/datum/venue/restaurant = SSrestaurant.all_venues[/datum/venue/restaurant/prison]
	var/award_score = restaurant.total_income
	var/award_status = winner.get_award_status(/datum/award/score/prisoner_tourist_score)
	if(award_score > award_status)
		award_score -= award_status
	winner.give_award(/datum/award/score/prisoner_tourist_score, winner.mob, award_score)
