/// Digi Magboots
/datum/techweb_node/adv_engi/New()
	design_ids += list("digi_magboots")

/// Prisoner restaurant stuff
/datum/techweb_node/emp_basic/New()
	design_ids += list(
		"holosignprisonrestaurant",
		"prison_restaurant_portal",
	)

/// Tech cult shenanigans
/datum/techweb_node/mars_tech
	id = "mars_tech"
	display_name = "Marsian Technology"
	description = "A complicated technology, used by Marsian scientists and soldiers alike."
	boost_item_paths = list(
		/obj/item/gun/energy/sniper,
		/obj/item/gun/energy/sniper/pin,
		/obj/item/organ/heart/cybernetic/tier4,
		/obj/item/organ/lungs/cybernetic/tier4,
		/obj/item/organ/cyberimp/chest/reviver/plus,
		/obj/item/organ/cyberimp/arm/surgery/plus,
		/obj/item/nullrod/spear,
	)
	design_ids = list(
		"ci-reviver-plus",
		"ci-surgery-plus",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)
	hidden = TRUE

/datum/techweb_node/cyber_organs_ultra
	id = "cyber_organs_ultra"
	display_name = "Quadro-Cybernetic Organs"
	description = "An advanced set of cybernetic organs, used by a group of religious fanatics on Mars."
	prereq_ids = list("cyber_organs_upgraded", "mars_tech")
	design_ids = list(
		"cybernetic_heart_tier4",
		"cybernetic_lungs_tier4",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)

/datum/techweb_node/energy_sniper
	id = "energy_sniper"
	display_name = "Energy Sniper Rifle"
	description = "An advanced piece of weaponry, used by highly advanced group of religious fanatics on Mars."
	prereq_ids = list("adv_beam_weapons", "mars_tech")
	design_ids = list(
		"energysniper",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
