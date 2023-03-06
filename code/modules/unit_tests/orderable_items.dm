/// Makes sure that no orderable items have dynamic descriptions, if they
/// don't explicitly set a description.
/// Also makes sure 2 orderable items don't sell the same thing.
/datum/unit_test/orderable_items

/datum/unit_test/orderable_items/Run()
	var/list/all_paths = list()
	for (var/datum/orderable_item/orderable_item as anything in subtypesof(/datum/orderable_item))
		if(isnull(initial(orderable_item.item_path))) // don't check if they're not actual orderable items
			continue
		if (!isnull(initial(orderable_item.desc))) //don't check if they have a custom description
			continue

		var/item_path = initial(orderable_item.item_path)

		var/obj/item/item_instance = allocate(item_path)
		var/initial_desc = initial(item_instance.desc)

		if(item_path in all_paths)
			TEST_FAIL("[orderable_item] is purchasable under two different orderable_item types,")
		all_paths += item_path

		if (item_instance.desc != initial_desc)
			TEST_FAIL("[orderable_item] has an item ([item_path]) that has a dynamic description. [item_instance.desc] (dynamic description) != [initial_desc] (initial description)")
