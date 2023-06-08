/*ALL DEFINES RELATED TO CONSTRUCTION, CONSTRUCTING THINGS, OR CONSTRUCTED OBJECTS GO HERE*/

//Defines for construction states

//girder construction states
#define GIRDER_NORMAL 0
#define GIRDER_REINF_STRUTS 1
#define GIRDER_REINF 2
#define GIRDER_DISPLACED 3
#define GIRDER_DISASSEMBLED 4
#define GIRDER_TRAM 5

//rwall construction states
#define INTACT 0
#define SUPPORT_LINES 1
#define COVER 2
#define CUT_COVER 3
#define ANCHOR_BOLTS 4
#define SUPPORT_RODS 5
#define SHEATH 6

//window construction states
#define WINDOW_OUT_OF_FRAME 0
#define WINDOW_IN_FRAME 1
#define WINDOW_SCREWED_TO_FRAME 2

//reinforced window construction states
#define RWINDOW_FRAME_BOLTED 3
#define RWINDOW_BARS_CUT 4
#define RWINDOW_POPPED 5
#define RWINDOW_BOLTS_OUT 6
#define RWINDOW_BOLTS_HEATED 7
#define RWINDOW_SECURE 8

//airlock assembly construction states
#define AIRLOCK_ASSEMBLY_NEEDS_WIRES 0
#define AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS 1
#define AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER 2

//blast door (de)construction states
#define BLASTDOOR_NEEDS_WIRES 0
#define BLASTDOOR_NEEDS_ELECTRONICS 1
#define BLASTDOOR_FINISHED 2

//default_unfasten_wrench() return defines
#define CANT_UNFASTEN 0
#define FAILED_UNFASTEN 1
#define SUCCESSFUL_UNFASTEN 2

//ai core defines
#define EMPTY_CORE 0
#define CIRCUIT_CORE 1
#define SCREWED_CORE 2
#define CABLED_CORE 3
#define GLASS_CORE 4
#define AI_READY_CORE 5

//Construction defines for the pinion airlock
#define GEAR_SECURE 1
#define GEAR_LOOSE 2

//floodlights because apparently we use defines now
#define FLOODLIGHT_NEEDS_WIRES 0
#define FLOODLIGHT_NEEDS_LIGHTS 1
#define FLOODLIGHT_NEEDS_SECURING 2

// Stationary gas tanks
#define TANK_FRAME 0
#define TANK_PLATING_UNSECURED 1

//other construction-related things

//windows affected by Nar'Sie turn this color.
#define NARSIE_WINDOW_COLOUR "#7D1919"

// Defines related to the custom materials used on objects.
///The amount of materials you get from a sheet of mineral like iron/diamond/glass etc. 2000 Units.
#define SHEET_MATERIAL_AMOUNT 2000
///The amount of materials you get from half a sheet. Used in standard object quantities. 1000 units.
#define HALF_SHEET_MATERIAL_AMOUNT (SHEET_MATERIAL_AMOUNT/2)
///The amount of materials used in the smallest of objects, like pens and screwdrivers. 100 units.
#define SMALL_MATERIAL_AMOUNT (HALF_SHEET_MATERIAL_AMOUNT/10)

//The maximum size of a stack object.
#define MAX_STACK_SIZE 50
//maximum amount of cable in a coil
#define MAXCOIL 30

//food/drink crafting defines
//When adding new defines, please make sure to also add them to the encompassing list
#define CAT_FOOD "Foods"
#define CAT_BREAD "Breads"
#define CAT_BURGER "Burgers"
#define CAT_CAKE "Cakes"
#define CAT_EGG "Egg-Based Food"
#define CAT_LIZARD "Lizard Food"
#define CAT_MEAT "Meats"
#define CAT_SEAFOOD "Seafood"
#define CAT_MISCFOOD "Misc. Food"
#define CAT_MEXICAN "Mexican Food"
#define CAT_MOTH "Mothic Food"
#define CAT_PASTRY "Pastries"
#define CAT_PIE "Pies"
#define CAT_PIZZA "Pizzas"
#define CAT_SALAD "Salads"
#define CAT_SANDWICH "Sandwiches"
#define CAT_SOUP "Soups"
#define CAT_SPAGHETTI "Spaghettis"
#define CAT_ICE "Frozen"
#define CAT_DRINK "Drinks"

GLOBAL_LIST_INIT(crafting_category_food, list(
	CAT_FOOD,
	CAT_BREAD,
	CAT_BURGER,
	CAT_CAKE,
	CAT_EGG,
	CAT_LIZARD,
	CAT_MEAT,
	CAT_SEAFOOD,
	CAT_MISCFOOD,
	CAT_MEXICAN,
	CAT_MOTH,
	CAT_PASTRY,
	CAT_PIE,
	CAT_PIZZA,
	CAT_SALAD,
	CAT_SANDWICH,
	CAT_SOUP,
	CAT_SPAGHETTI,
	CAT_ICE,
	CAT_DRINK,
))

//crafting defines
//When adding new defines, please make sure to also add them to the encompassing list
#define CAT_WEAPON_RANGED "Weapons Ranged"
#define CAT_WEAPON_MELEE "Weapons Melee"
#define CAT_WEAPON_AMMO "Weapon Ammo"
#define CAT_ROBOT "Robotics"
#define CAT_MISC "Misc"
#define CAT_CLOTHING "Clothing"
#define CAT_CHEMISTRY "Chemistry"
#define CAT_ATMOSPHERIC "Atmospherics"
#define CAT_STRUCTURE "Structures"
#define CAT_TILES "Tiles"
#define CAT_WINDOWS "Windows"
#define CAT_DOORS "Doors"
#define CAT_FURNITURE "Furniture"
#define CAT_EQUIPMENT "Equipment"
#define CAT_CONTAINERS "Containers"
#define CAT_ENTERTAINMENT "Entertainment"
#define CAT_TOOLS "Tools"
#define CAT_CULT "Blood Cult"

GLOBAL_LIST_INIT(crafting_category, list(
	CAT_WEAPON_RANGED,
	CAT_WEAPON_MELEE,
	CAT_WEAPON_AMMO,
	CAT_ROBOT,
	CAT_MISC,
	CAT_CLOTHING,
	CAT_CHEMISTRY,
	CAT_ATMOSPHERIC,
	CAT_STRUCTURE,
	CAT_TILES,
	CAT_WINDOWS,
	CAT_DOORS,
	CAT_FURNITURE,
	CAT_EQUIPMENT,
	CAT_CONTAINERS,
	CAT_ENTERTAINMENT,
	CAT_TOOLS,
	CAT_CULT,
))

//rcd modes
#define RCD_FLOORWALL 0
#define RCD_AIRLOCK 1
#define RCD_DECONSTRUCT 2
#define RCD_WINDOWGRILLE 3
#define RCD_MACHINE 4
#define RCD_COMPUTER 5
#define RCD_FURNISHING 6
#define RCD_CATWALK 7
#define RCD_FLOODLIGHT 8
#define RCD_WALLFRAME 9
#define RCD_REFLECTOR 10


#define RCD_UPGRADE_FRAMES (1<<0)
#define RCD_UPGRADE_SIMPLE_CIRCUITS (1<<1)
#define RCD_UPGRADE_SILO_LINK (1<<2)
#define RCD_UPGRADE_FURNISHING (1<<3)

#define RPD_UPGRADE_UNWRENCH (1<<0)

#define RCD_WINDOW_FULLTILE "full tile"
#define RCD_WINDOW_DIRECTIONAL "directional"
#define RCD_WINDOW_NORMAL "glass"
#define RCD_WINDOW_REINFORCED "reinforced glass"

#define RCD_MEMORY_WALL 1
#define RCD_MEMORY_WINDOWGRILLE 2

// How much faster to use the RCD when on a tile with memory
#define RCD_MEMORY_SPEED_BUFF 5

/// How much less resources the RCD uses when reconstructing
#define RCD_MEMORY_COST_BUFF 8

// Defines for the construction component
#define FORWARD 1
#define BACKWARD -1

#define ITEM_DELETE "delete"
#define ITEM_MOVE_INSIDE "move_inside"
