/// From recipes.dm
/datum/crafting_recipe/blackcoffin
	name = "Black Coffin"
	result = /obj/structure/closet/crate/coffin/blackcoffin
	time = 15 SECONDS
	reqs = list(/obj/item/stack/sheet/cloth = 1, /obj/item/stack/sheet/mineral/wood = 5, /obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	category = CAT_PRIMAL

/datum/crafting_recipe/meatcoffin
	name = "Meat Coffin"
	result = /obj/structure/closet/crate/coffin/meatcoffin
	reqs = list(/obj/item/food/meat/slab = 5, /obj/item/restraints/handcuffs/cable = 1)
	time = 15 SECONDS
	tools = list(TOOL_KNIFE, TOOL_ROLLINGPIN)
	category = CAT_PRIMAL
	always_available = FALSE //The sacred coffin!

/datum/crafting_recipe/metalcoffin
	name = "Metal Coffin"
	result = /obj/structure/closet/crate/coffin/metalcoffin
	reqs = list(/obj/item/stack/sheet/metal = 5)
	time = 10 SECONDS
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	category = CAT_PRIMAL

/datum/crafting_recipe/vassalrack
	name = "Persuasion Rack"
	result = /obj/structure/bloodsucker/vassalrack
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3, /obj/item/stack/sheet/metal = 2, /obj/item/restraints/handcuffs/cable = 2)
	time = 15 SECONDS
	tools = list(TOOL_WELDER, TOOL_WRENCH)
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/candelabrum
	name = "Candelabrum"
	result = /obj/structure/bloodsucker/candelabrum
	reqs = list(/obj/item/stack/sheet/metal = 3, /obj/item/stack/rods = 1, /obj/item/candle = 1)
	time = 10 SECONDS
	tools = list(TOOL_WELDER, TOOL_WRENCH)
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
	tools = list(TOOL_WELDER)
	reqs = list(/obj/item/stack/rods = 1)
	time = 6 SECONDS
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/silver_stake
	name = "Silver Stake"
	result = /obj/item/stake/hardened/silver
	tools = list(TOOL_WELDER)
	reqs = list(/obj/item/stack/sheet/mineral/silver = 1, /obj/item/stake/hardened = 1)
	time = 8 SECONDS
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
