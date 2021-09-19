/* How it works:
The shuttle arrives at CentCom dock and calls sell(), which recursively loops through all the shuttle contents that are unanchored.

Each object in the loop is checked for applies_to() of various export datums, except the invalid ones.
*/

/* The rule in figuring out item export cost:
Export cost of goods in the shipping crate must be always equal or lower than:
	packcage cost - crate cost - manifest cost
Crate cost is 500cr for a regular plasteel crate and 100cr for a large wooden one. Manifest cost is always 200cr.
This is to avoid easy cargo points dupes.

Credit dupes that require a lot of manual work shouldn't be removed, unless they yield too much profit for too little work.
For example, if some player buys iron and glass sheets and uses them to make and sell reinforced glass:

100 glass + 50 iron-> 100 reinforced glass
1500cr -> 1600cr)

Then the player gets the profit from selling his own wasted time.
*/

// Simple holder datum to pass export results around
/datum/export_report
	var/list/exported_atoms = list() //names of atoms sold/deleted by export
	var/list/total_amount = list() //export instance => total count of sold objects of its type, only exists if any were sold
	var/list/total_value = list() //export instance => total value of sold objects
	var/list/exported_atoms_ref = list() //if they're not deleted they go in here for use.

// external_report works as "transaction" object, pass same one in if you're doing more than one export in single go
/proc/export_item_and_contents(atom/movable/AM, apply_elastic = TRUE, delete_unsold = TRUE, dry_run=FALSE, datum/export_report/external_report)
	if(!GLOB.exports_list.len)
		setupExports()

	var/profit_ratio = 1 //Percentage that gets sent to the seller, rest goes to cargo.

	var/list/contents = AM.GetAllContents()

	var/datum/export_report/report = external_report

	if(!report) //If we don't have any longer transaction going on
		report = new

	// We go backwards, so it'll be innermost objects sold first
	for(var/i in reverseRange(contents))
		var/atom/movable/thing = i
		var/sold = FALSE
		if(QDELETED(thing))
			continue

		for(var/datum/export/E in GLOB.exports_list)
			if(!E)
				continue
			if(E.applies_to(thing, apply_elastic))
				sold = E.sell_object(thing, report, dry_run, apply_elastic, profit_ratio)
				report.exported_atoms += " [thing.name]"
				if(!QDELETED(thing))
					report.exported_atoms_ref += thing
				break
		if(!dry_run && (sold || delete_unsold))
			if(ismob(thing))
				thing.investigate_log("deleted through cargo export",INVESTIGATE_CARGO)
			qdel(thing)

	return report

/datum/export
	/// Unit name. Only used in "Received [total_amount] [name]s [message]." message
	var/unit_name = ""
	var/message = ""
	/// Cost of item, in cargo credits. Must not allow for infinite price dupes, see above.
	var/cost = 1
	/// whether this export can have a negative impact on the cargo budget or not
	var/allow_negative_cost = FALSE
	/// coefficient used in marginal price calculation that roughly corresponds to the inverse of price elasticity, or "quantity elasticity"
	var/k_elasticity = 1/30
	/// The multiplier of the amount sold shown on the report. Useful for exports, such as material, which costs are not strictly per single units sold.
	var/amount_report_multiplier = 1
	/// Type of the exported object. If none, the export datum is considered base type.
	var/list/export_types = list()
	/// Set to FALSE to make the datum apply only to a strict type.
	var/include_subtypes = TRUE
	/// Types excluded from export
	var/list/exclude_types = list()

	/// cost includes elasticity, this does not.
	var/init_cost



/datum/export/New()
	..()
	SSprocessing.processing += src
	init_cost = cost
	export_types = typecacheof(export_types, FALSE, !include_subtypes)
	exclude_types = typecacheof(exclude_types)

/datum/export/Destroy()
	SSprocessing.processing -= src
	return ..()

/datum/export/process()
	..()
	cost *= NUM_E**(k_elasticity * (1/30))
	if(cost > init_cost)
		cost = init_cost

// Checks the cost. 0 cost items are skipped in export.
/datum/export/proc/get_cost(obj/O, apply_elastic = TRUE)
	var/amount = get_amount(O)
	if(apply_elastic)
		if(k_elasticity!=0)
			return round((cost/k_elasticity) * (1 - NUM_E**(-1 * k_elasticity * amount))) //anti-derivative of the marginal cost function
		else
			return round(cost * amount) //alternative form derived from L'Hopital to avoid division by 0
	else
		return round(init_cost * amount)

// Checks the amount of exportable in object. Credits in the bill, sheets in the stack, etc.
// Usually acts as a multiplier for a cost, so item that has 0 amount will be skipped in export.
/datum/export/proc/get_amount(obj/O)
	return 1

// Checks if the item is fit for export datum.
/datum/export/proc/applies_to(obj/O, apply_elastic = TRUE)
	if(!is_type_in_typecache(O, export_types))
		return FALSE
	if(include_subtypes && is_type_in_typecache(O, exclude_types))
		return FALSE
	if(!get_cost(O, apply_elastic))
		return FALSE
	if(O.flags_1 & HOLOGRAM_1)
		return FALSE
	return TRUE

/**
 * Calculates the exact export value of the object, while factoring in all the relivant variables.
 *
 * Called only once, when the object is actually sold by the datum.
 * Adds item's cost and amount to the current export cycle.
 * get_cost, get_amount and applies_to do not neccesary mean a successful sale.
 *
 */
/datum/export/proc/sell_object(obj/O, datum/export_report/report, dry_run = TRUE, apply_elastic = TRUE)
	///This is the value of the object, as derived from export datums.
	var/the_cost = get_cost(O, apply_elastic)
	///Quantity of the object in question.
	var/amount = get_amount(O)
	///Utilized in the pricetag component. Splits the object's profit when it has a pricetag by the specified amount.
	var/profit_ratio = 0

	if(amount <=0 || (the_cost <=0 && !allow_negative_cost))
		return FALSE
	if(dry_run == FALSE)
		if(SEND_SIGNAL(O, COMSIG_ITEM_SOLD, item_value = get_cost(O, apply_elastic)) & COMSIG_ITEM_SPLIT_VALUE)
			profit_ratio = SEND_SIGNAL(O, COMSIG_ITEM_SPLIT_PROFIT_DRY)
			the_cost = the_cost * ((100 - profit_ratio) * 0.01)
	else
		profit_ratio = SEND_SIGNAL(O, COMSIG_ITEM_SPLIT_PROFIT)
		the_cost = the_cost * ((100 - profit_ratio) * 0.01)
	report.total_value[src] += the_cost

	report.total_amount[src] += amount*amount_report_multiplier

	if(!dry_run)
		if(apply_elastic)
			cost *= NUM_E**(-1*k_elasticity*amount) //marginal cost modifier
		SSblackbox.record_feedback("nested tally", "export_sold_cost", 1, list("[O.type]", "[the_cost]"))
	return TRUE

// Total printout for the cargo console.
// Called before the end of current export cycle.
// It must always return something if the datum adds or removes any credts.
/datum/export/proc/total_printout(datum/export_report/ex, notes = TRUE)
	if(!ex.total_amount[src] || !ex.total_value[src])
		return ""

	var/total_value = ex.total_value[src]
	var/total_amount = ex.total_amount[src]

	var/msg = "[total_value] credits: Received [total_amount] "
	if(total_value > 0)
		msg = "+" + msg

	if(unit_name)
		msg += unit_name
		if(total_amount > 1)
			msg += "s"
		if(message)
			msg += " "

	if(message)
		msg += message

	msg += "."
	return msg

GLOBAL_LIST_EMPTY(exports_list)

/proc/setupExports()
	for(var/subtype in subtypesof(/datum/export))
		var/datum/export/E = new subtype
		if(E.export_types && E.export_types.len) // Exports without a type are invalid/base types
			GLOB.exports_list += E
