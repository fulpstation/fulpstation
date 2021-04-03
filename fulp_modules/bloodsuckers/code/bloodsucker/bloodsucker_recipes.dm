/// From recipes.dm
/datum/crafting_recipe/blackcoffin
	name = "Black Coffin"
	result = /obj/structure/closet/crate/coffin/blackcoffin
	tool_behaviors = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	reqs = list(/obj/item/stack/sheet/cloth = 1, /obj/item/stack/sheet/mineral/wood = 5, /obj/item/stack/sheet/iron = 1)
	time = 15 SECONDS
	category = CAT_PRIMAL

/datum/crafting_recipe/meatcoffin
	name = "Meat Coffin"
	result = /obj/structure/closet/crate/coffin/meatcoffin
	tool_behaviors = list(TOOL_KNIFE, TOOL_ROLLINGPIN)
	reqs = list(/obj/item/food/meat/slab = 5, /obj/item/restraints/handcuffs/cable = 1)
	time = 15 SECONDS
	category = CAT_PRIMAL
	always_available = FALSE //The sacred coffin!

/datum/crafting_recipe/metalcoffin
	name = "Metal Coffin"
	result = /obj/structure/closet/crate/coffin/metalcoffin
	tool_behaviors = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	reqs = list(/obj/item/stack/sheet/iron = 5)
	time = 10 SECONDS
	category = CAT_PRIMAL

/datum/crafting_recipe/vassalrack
	name = "Persuasion Rack"
	result = /obj/structure/bloodsucker/vassalrack
	tool_behaviors = list(TOOL_WELDER, TOOL_WRENCH)
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3, /obj/item/stack/sheet/iron = 2, /obj/item/restraints/handcuffs/cable = 2)
	time = 15 SECONDS
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/candelabrum
	name = "Candelabrum"
	result = /obj/structure/bloodsucker/candelabrum
	tool_behaviors = list(TOOL_WELDER, TOOL_WRENCH)
	reqs = list(/obj/item/stack/sheet/iron = 3, /obj/item/stack/rods = 1, /obj/item/candle = 1)
	time = 10 SECONDS
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/stake
	name = "Stake"
	result = /obj/item/stake
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3)
	time = 8 SECONDS
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/hardened_stake
	name = "Hardened Stake"
	result = /obj/item/stake/hardened
	tool_behaviors = list(TOOL_WELDER)
	reqs = list(/obj/item/stack/rods = 1)
	time = 6 SECONDS
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_available = FALSE

/datum/crafting_recipe/silver_stake
	name = "Silver Stake"
	result = /obj/item/stake/hardened/silver
	tool_behaviors = list(TOOL_WELDER)
	reqs = list(/obj/item/stack/sheet/mineral/silver = 1, /obj/item/stake/hardened = 1)
	time = 8 SECONDS
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_available = FALSE
