#define MEAT (1<<0)
#define VEGETABLES (1<<1)
#define RAW (1<<2)
#define JUNKFOOD (1<<3)
#define GRAIN (1<<4)
#define FRUIT (1<<5)
#define DAIRY (1<<6)
#define FRIED (1<<7)
#define ALCOHOL (1<<8)
#define SUGAR (1<<9)
#define GROSS (1<<10)
#define TOXIC (1<<11)
#define PINEAPPLE (1<<12)
#define BREAKFAST (1<<13)
#define CLOTH (1<<14)
#define NUTS (1<<15)
#define SEAFOOD (1<<16)
#define ORANGES (1<<17)
#define BUGS (1<<18)
#define GORE (1<<19)
#define STONE (1<<20)

DEFINE_BITFIELD(foodtypes, list(
	"MEAT" = MEAT,
	"VEGETABLES" = VEGETABLES,
	"RAW" = RAW,
	"JUNKFOOD" = JUNKFOOD,
	"GRAIN" = GRAIN,
	"FRUIT" = FRUIT,
	"DAIRY" = DAIRY,
	"FRIED" = FRIED,
	"ALCOHOL" = ALCOHOL,
	"SUGAR" = SUGAR,
	"GROSS" = GROSS,
	"TOXIC" = TOXIC,
	"PINEAPPLE" = PINEAPPLE,
	"BREAKFAST" = BREAKFAST,
	"CLOTH" = CLOTH,
	"NUTS" = NUTS,
	"SEAFOOD" = SEAFOOD,
	"ORANGES" = ORANGES,
	"BUGS" = BUGS,
	"GORE" = GORE,
	"STONE" = STONE,
))

/// A list of food type names, in order of their flags
#define FOOD_FLAGS list( \
	"MEAT", \
	"VEGETABLES", \
	"RAW", \
	"JUNKFOOD", \
	"GRAIN", \
	"FRUIT", \
	"DAIRY", \
	"FRIED", \
	"ALCOHOL", \
	"SUGAR", \
	"GROSS", \
	"TOXIC", \
	"PINEAPPLE", \
	"BREAKFAST", \
	"CLOTH", \
	"NUTS", \
	"SEAFOOD", \
	"ORANGES", \
	"BUGS", \
	"GORE", \
	"STONE", \
)

/// IC meaning (more or less) for food flags
#define FOOD_FLAGS_IC list( \
	"Meat", \
	"Vegetables", \
	"Raw food", \
	"Junk food", \
	"Grain", \
	"Fruits", \
	"Dairy products", \
	"Fried food", \
	"Alcohol", \
	"Sugary food", \
	"Gross food", \
	"Toxic food", \
	"Pineapples", \
	"Breakfast food", \
	"Clothing", \
	"Nuts", \
	"Seafood", \
	"Oranges", \
	"Bugs", \
	"Gore", \
	"Rocks", \
)

#define DRINK_REVOLTING 1
#define DRINK_NICE 2
#define DRINK_GOOD 3
#define DRINK_VERYGOOD 4
#define DRINK_FANTASTIC 5
#define FOOD_AMAZING 6

/// Food is "in a container", not in a code sense, but in a literal sense (canned foods)
#define FOOD_IN_CONTAINER (1<<0)
/// Finger food can be eaten while walking / running around
#define FOOD_FINGER_FOOD (1<<1)

DEFINE_BITFIELD(food_flags, list(
	"FOOD_FINGER_FOOD" = FOOD_FINGER_FOOD,
	"FOOD_IN_CONTAINER" = FOOD_IN_CONTAINER,
))

#define STOP_SERVING_BREAKFAST (15 MINUTES)

#define FOOD_MEAT_NORMAL 5
#define FOOD_MEAT_HUMAN 50
#define FOOD_MEAT_MUTANT 100
#define FOOD_MEAT_MUTANT_RARE 200

///Amount of reagents you start with on crafted food excluding the used parts
#define CRAFTED_FOOD_BASE_REAGENT_MODIFIER 0.7
///Modifier of reagents you get when crafting food from the parts used
#define CRAFTED_FOOD_INGREDIENT_REAGENT_MODIFIER 0.5

#define IS_EDIBLE(O) (O.GetComponent(/datum/component/edible))


///Food trash flags
#define FOOD_TRASH_POPABLE (1<<0)
#define FOOD_TRASH_OPENABLE (1<<1)



///Food preference enums
#define FOOD_LIKED 1
#define FOOD_DISLIKED 2
#define FOOD_TOXIC 3

///Venue reagent requirement
#define VENUE_BAR_MINIMUM_REAGENTS 10



///***Food price classes***
///Foods that are meant to have no value, such as lollypops from medborgs.
#define FOOD_PRICE_WORTHLESS 0
///cheap and quick foods, like those from vending machines.
#define FOOD_PRICE_TRASH 25
///In line with prices of cheap snacks and foods you find in vending machine, practically disposable.
#define FOOD_PRICE_CHEAP 70
///Half a crate of profit, selling 4 of these lets you buy a kitchen crate from cargo.
#define FOOD_PRICE_NORMAL 150
///Making one of these should be worth the time investment, solid chunk of profit.
#define FOOD_PRICE_EXOTIC 450
///Large windfall for making something from this list.
#define FOOD_PRICE_LEGENDARY 1300

///***Drink price classes***
///Drinks that are only limited by a single click of the dispenser.
#define DRINK_PRICE_STOCK 20
///Drinks that are made through very basic processing.
#define DRINK_PRICE_EASY 35
///Drinks that are made through more basic processing, or multiple steps.
#define DRINK_PRICE_MEDIUM 80
///Drinks that are made through rare ingredients, or high levels of processing.
#define DRINK_PRICE_HIGH 200


/// Flavour defines (also names) for GLOB.ice_cream_flavours list access. Safer from mispelling than plain text.
#define ICE_CREAM_VANILLA "vanilla"
#define ICE_CREAM_CHOCOLATE "chocolate"
#define ICE_CREAM_STRAWBERRY "strawberry"
#define ICE_CREAM_BLUE "blue"
#define ICE_CREAM_MOB "mob"
#define ICE_CREAM_CUSTOM "custom"
#define ICE_CREAM_BLAND "bland"

#define DEFAULT_MAX_ICE_CREAM_SCOOPS 3
// the vertical distance in pixels from an ice cream scoop and another.
#define ICE_CREAM_SCOOP_OFFSET 4

#define BLACKBOX_LOG_FOOD_MADE(food) SSblackbox.record_feedback("tally", "food_made", 1, food)

/// Point water boils at
#define WATER_BOILING_POINT (T0C + 100)
/// Point at which soups begin to burn at
#define SOUP_BURN_TEMP 540

/// Serving size of soup. Plus or minus five units.
#define SOUP_SERVING_SIZE 25

// Venues for the barbots.
#define VENUE_RESTAURANT "Restaurant Venue"
#define VENUE_BAR "Bar Venue"

/// How much milk is needed to make butter on a reagent grinder
#define MILK_TO_BUTTER_COEFF 25
