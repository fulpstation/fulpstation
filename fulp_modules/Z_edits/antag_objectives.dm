/datum/objective_item/steal/low_risk/deputy_beret_eng
	name = "the engineering deputy's beret"
	targetitem = /obj/item/clothing/head/fulpberet/engineering
	excludefromjob = list(JOB_DEPUTY_ENG)
	exists_on_map = TRUE

/datum/objective_item/steal/low_risk/deputy_beret_med
	name = "the medical deputy's beret"
	targetitem = /obj/item/clothing/head/fulpberet/medical
	excludefromjob = list(JOB_DEPUTY_MED)
	exists_on_map = TRUE

/datum/objective_item/steal/low_risk/deputy_beret_sci
	name = "the science deputy's beret"
	targetitem = /obj/item/clothing/head/fulpberet/science
	excludefromjob = list(JOB_DEPUTY_SCI)
	exists_on_map = TRUE

/datum/objective_item/steal/low_risk/deputy_beret_sup
	name = "the supply deputy's beret"
	targetitem = /obj/item/clothing/head/fulpberet/supply
	excludefromjob = list(JOB_DEPUTY_SUP)
	exists_on_map = TRUE

/datum/traitor_objective/destroy_item/low_risk/New(datum/uplink_handler/handler)
	. = ..()
	possible_items |= list(
		/datum/objective_item/steal/low_risk/deputy_beret_eng,
		/datum/objective_item/steal/low_risk/deputy_beret_med,
		/datum/objective_item/steal/low_risk/deputy_beret_sci,
		/datum/objective_item/steal/low_risk/deputy_beret_sup,
	)
