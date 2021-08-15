/* smoothing_flags */
/// Smoothing system in where adjacencies are calculated and used to build an image by mounting each corner at runtime.
#define SMOOTH_CORNERS (1<<0)
/// Smoothing system in where adjacencies are calculated and used to select a pre-baked icon_state, encoded by bitmasking.
#define SMOOTH_BITMASK (1<<1)
/// Atom has diagonal corners, with underlays under them.
#define SMOOTH_DIAGONAL_CORNERS (1<<2)
/// Atom will smooth with the borders of the map.
#define SMOOTH_BORDER (1<<3)
/// Atom is currently queued to smooth.
#define SMOOTH_QUEUED (1<<4)
/// Smooths with objects, and will thus need to scan turfs for contents.
#define SMOOTH_OBJ (1<<5)

DEFINE_BITFIELD(smoothing_flags, list(
	"SMOOTH_CORNERS" = SMOOTH_CORNERS,
	"SMOOTH_BITMASK" = SMOOTH_BITMASK,
	"SMOOTH_DIAGONAL_CORNERS" = SMOOTH_DIAGONAL_CORNERS,
	"SMOOTH_BORDER" = SMOOTH_BORDER,
	"SMOOTH_QUEUED" = SMOOTH_QUEUED,
	"SMOOTH_OBJ" = SMOOTH_OBJ,
))


/*smoothing macros*/

#define QUEUE_SMOOTH(thing_to_queue) if(thing_to_queue.smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK)) {SSicon_smooth.add_to_queue(thing_to_queue)}

#define QUEUE_SMOOTH_NEIGHBORS(thing_to_queue) for(var/neighbor in orange(1, thing_to_queue)) {var/atom/atom_neighbor = neighbor; QUEUE_SMOOTH(atom_neighbor)}


/**SMOOTHING GROUPS
 * Groups of things to smooth with.
 * * Contained in the `list/smoothing_groups` variable.
 * * Matched with the `list/canSmoothWith` variable to check whether smoothing is possible or not.
 */

#define S_TURF(num) ((24 * 0) + num) //Not any different from the number itself, but kept this way in case someone wants to expand it by adding stuff before it.
/* /turf only */

#define SMOOTH_GROUP_TURF_OPEN S_TURF(0) ///turf/open
#define SMOOTH_GROUP_TURF_CHASM S_TURF(1) ///turf/open/chasm, /turf/open/floor/fakepit
#define SMOOTH_GROUP_FLOOR_LAVA S_TURF(2) ///turf/open/lava/smooth
#define SMOOTH_GROUP_FLOOR_TRANSPARENT_GLASS S_TURF(3) ///turf/open/floor/glass

#define SMOOTH_GROUP_OPEN_FLOOR S_TURF(4) ///turf/open/floor

#define SMOOTH_GROUP_FLOOR_GRASS S_TURF(5) ///turf/open/floor/plating/grass
#define SMOOTH_GROUP_FLOOR_ASH S_TURF(6) ///turf/open/floor/plating/ashplanet/ash
#define SMOOTH_GROUP_FLOOR_ASH_ROCKY S_TURF(7) ///turf/open/floor/plating/ashplanet/rocky
#define SMOOTH_GROUP_FLOOR_ICE S_TURF(8) ///turf/open/floor/plating/ice
#define SMOOTH_GROUP_FLOOR_SNOWED S_TURF(9) ///turf/open/floor/plating/snowed

#define SMOOTH_GROUP_CARPET S_TURF(10) ///turf/open/floor/carpet
#define SMOOTH_GROUP_CARPET_BLACK S_TURF(11) ///turf/open/floor/carpet/black
#define SMOOTH_GROUP_CARPET_BLUE S_TURF(12) ///turf/open/floor/carpet/blue
#define SMOOTH_GROUP_CARPET_CYAN S_TURF(13) ///turf/open/floor/carpet/cyan
#define SMOOTH_GROUP_CARPET_GREEN S_TURF(14) ///turf/open/floor/carpet/green
#define SMOOTH_GROUP_CARPET_ORANGE S_TURF(15) ///turf/open/floor/carpet/orange
#define SMOOTH_GROUP_CARPET_PURPLE S_TURF(16) ///turf/open/floor/carpet/purple
#define SMOOTH_GROUP_CARPET_RED S_TURF(17) ///turf/open/floor/carpet/red
#define SMOOTH_GROUP_CARPET_ROYAL_BLACK S_TURF(18) ///turf/open/floor/carpet/royalblack
#define SMOOTH_GROUP_CARPET_ROYAL_BLUE S_TURF(19) ///turf/open/floor/carpet/royalblue
#define SMOOTH_GROUP_CARPET_EXECUTIVE S_TURF(20) ///turf/open/floor/carpet/executive
#define SMOOTH_GROUP_CARPET_STELLAR S_TURF(21) ///turf/open/floor/carpet/stellar
#define SMOOTH_GROUP_CARPET_DONK S_TURF(22) ///turf/open/floor/carpet/donk
#define SMOOTH_GROUP_CARPET_NEON S_TURF(23) //![turf/open/floor/carpet/neon]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON S_TURF(24) //![turf/open/floor/carpet/neon/simple]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_WHITE S_TURF(25) //![turf/open/floor/carpet/neon/simple/white]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_BLACK S_TURF(26) //![turf/open/floor/carpet/neon/simple/black]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_RED S_TURF(27) //![turf/open/floor/carpet/neon/simple/red]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_ORANGE S_TURF(28) //![turf/open/floor/carpet/neon/simple/orange]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_YELLOW S_TURF(29) //![turf/open/floor/carpet/neon/simple/yellow]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_LIME S_TURF(30) //![turf/open/floor/carpet/neon/simple/lime]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_GREEN S_TURF(31) //![turf/open/floor/carpet/neon/simple/green]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_TEAL S_TURF(32) //![turf/open/floor/carpet/neon/simple/teal]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_CYAN S_TURF(33) //![turf/open/floor/carpet/neon/simple/cyan]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_BLUE S_TURF(34) //![turf/open/floor/carpet/neon/simple/blue]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_PURPLE S_TURF(35) //![turf/open/floor/carpet/neon/simple/purple]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_VIOLET S_TURF(36) //![turf/open/floor/carpet/neon/simple/violet]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_PINK S_TURF(37) //![turf/open/floor/carpet/neon/simple/pink]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_NODOTS S_TURF(38) //![turf/open/floor/carpet/neon/simple/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_WHITE_NODOTS S_TURF(39) //![turf/open/floor/carpet/neon/simple/white/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_BLACK_NODOTS S_TURF(40) //![turf/open/floor/carpet/neon/simple/black/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_RED_NODOTS S_TURF(41) //![turf/open/floor/carpet/neon/simple/red/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_ORANGE_NODOTS S_TURF(42) //![turf/open/floor/carpet/neon/simple/orange/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_YELLOW_NODOTS S_TURF(43) //![turf/open/floor/carpet/neon/simple/yellow/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_LIME_NODOTS S_TURF(44) //![turf/open/floor/carpet/neon/simple/lime/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_GREEN_NODOTS S_TURF(45) //![turf/open/floor/carpet/neon/simple/green/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_TEAL_NODOTS S_TURF(46) //![turf/open/floor/carpet/neon/simple/teal/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_CYAN_NODOTS S_TURF(47) //![turf/open/floor/carpet/neon/simple/cyan/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_BLUE_NODOTS S_TURF(48) //![turf/open/floor/carpet/neon/simple/blue/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_PURPLE_NODOTS S_TURF(49) //![turf/open/floor/carpet/neon/simple/purple/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_VIOLET_NODOTS S_TURF(50) //![turf/open/floor/carpet/neon/simple/violet/nodots]
#define SMOOTH_GROUP_CARPET_SIMPLE_NEON_PINK_NODOTS S_TURF(51) //![turf/open/floor/carpet/neon/simple/pink/nodots]

#define SMOOTH_GROUP_CLOSED_TURFS S_TURF(52) ///turf/closed
#define SMOOTH_GROUP_MATERIAL_WALLS S_TURF(53) ///turf/closed/wall/material
#define SMOOTH_GROUP_SYNDICATE_WALLS S_TURF(54) ///turf/closed/wall/r_wall/syndicate, /turf/closed/indestructible/syndicate
#define SMOOTH_GROUP_HOTEL_WALLS S_TURF(55) ///turf/closed/indestructible/hotelwall
#define SMOOTH_GROUP_MINERAL_WALLS S_TURF(56) ///turf/closed/mineral, /turf/closed/indestructible
#define SMOOTH_GROUP_BOSS_WALLS S_TURF(57) ///turf/closed/indestructible/riveted/boss
#define SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS S_TURF(58) ///turf/closed/wall/mineral/titanium/survival

#define MAX_S_TURF SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS //Always match this value with the one above it.


#define S_OBJ(num) (MAX_S_TURF + 1 + num)
/* /obj included */

#define SMOOTH_GROUP_WALLS S_OBJ(0) ///turf/closed/wall, /obj/structure/falsewall
#define SMOOTH_GROUP_URANIUM_WALLS S_OBJ(1) ///turf/closed/wall/mineral/uranium, /obj/structure/falsewall/uranium
#define SMOOTH_GROUP_GOLD_WALLS S_OBJ(2) ///turf/closed/wall/mineral/gold, /obj/structure/falsewall/gold
#define SMOOTH_GROUP_SILVER_WALLS S_OBJ(3) ///turf/closed/wall/mineral/silver, /obj/structure/falsewall/silver
#define SMOOTH_GROUP_DIAMOND_WALLS S_OBJ(4) ///turf/closed/wall/mineral/diamond, /obj/structure/falsewall/diamond
#define SMOOTH_GROUP_PLASMA_WALLS S_OBJ(5) ///turf/closed/wall/mineral/plasma, /obj/structure/falsewall/plasma
#define SMOOTH_GROUP_BANANIUM_WALLS S_OBJ(6) ///turf/closed/wall/mineral/bananium, /obj/structure/falsewall/bananium
#define SMOOTH_GROUP_SANDSTONE_WALLS S_OBJ(7) ///turf/closed/wall/mineral/sandstone, /obj/structure/falsewall/sandstone
#define SMOOTH_GROUP_WOOD_WALLS S_OBJ(8) ///turf/closed/wall/mineral/wood, /obj/structure/falsewall/wood
#define SMOOTH_GROUP_IRON_WALLS S_OBJ(9) ///turf/closed/wall/mineral/iron, /obj/structure/falsewall/iron
#define SMOOTH_GROUP_ABDUCTOR_WALLS S_OBJ(10) ///turf/closed/wall/mineral/abductor, /obj/structure/falsewall/abductor
#define SMOOTH_GROUP_TITANIUM_WALLS S_OBJ(11) ///turf/closed/wall/mineral/titanium, /obj/structure/falsewall/titanium
#define SMOOTH_GROUP_PLASTITANIUM_WALLS S_OBJ(13) ///turf/closed/wall/mineral/plastitanium, /obj/structure/falsewall/plastitanium
#define SMOOTH_GROUP_SURVIVAL_TIANIUM_POD S_OBJ(14) ///turf/closed/wall/mineral/titanium/survival/pod, /obj/machinery/door/airlock/survival_pod, /obj/structure/window/shuttle/survival_pod
#define SMOOTH_GROUP_HIERO_WALL S_OBJ(15) ///obj/effect/temp_visual/elite_tumor_wall, /obj/effect/temp_visual/hierophant/wall

#define SMOOTH_GROUP_PAPERFRAME S_OBJ(20) ///obj/structure/window/paperframe, /obj/structure/mineral_door/paperframe

#define SMOOTH_GROUP_WINDOW_FULLTILE S_OBJ(21) ///turf/closed/indestructible/fakeglass, /obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile, /obj/structure/window/reinforced/tinted/fulltile, /obj/structure/window/plasma/fulltile, /obj/structure/window/plasma/reinforced/fulltile
#define SMOOTH_GROUP_WINDOW_FULLTILE_BRONZE S_OBJ(22) ///obj/structure/window/bronze/fulltile
#define SMOOTH_GROUP_WINDOW_FULLTILE_PLASTITANIUM S_OBJ(23) ///turf/closed/indestructible/opsglass, /obj/structure/window/plasma/reinforced/plastitanium
#define SMOOTH_GROUP_WINDOW_FULLTILE_SHUTTLE S_OBJ(24) ///obj/structure/window/shuttle

#define SMOOTH_GROUP_LATTICE  S_OBJ(30) ///obj/structure/lattice
#define SMOOTH_GROUP_CATWALK  S_OBJ(31) ///obj/structure/lattice/catwalk

#define SMOOTH_GROUP_AIRLOCK S_OBJ(40) ///obj/machinery/door/airlock

#define SMOOTH_GROUP_TABLES S_OBJ(50) ///obj/structure/table
#define SMOOTH_GROUP_WOOD_TABLES S_OBJ(51) ///obj/structure/table/wood
#define SMOOTH_GROUP_FANCY_WOOD_TABLES S_OBJ(52) ///obj/structure/table/wood/fancy
#define SMOOTH_GROUP_BRONZE_TABLES S_OBJ(53) ///obj/structure/table/bronze
#define SMOOTH_GROUP_ABDUCTOR_TABLES S_OBJ(54) ///obj/structure/table/abductor
#define SMOOTH_GROUP_GLASS_TABLES S_OBJ(55) ///obj/structure/table/glass

#define SMOOTH_GROUP_ALIEN_NEST S_OBJ(59) ///obj/structure/bed/nest
#define SMOOTH_GROUP_ALIEN_RESIN S_OBJ(60) ///obj/structure/alien/resin
#define SMOOTH_GROUP_ALIEN_WALLS S_OBJ(61) ///obj/structure/alien/resin/wall, /obj/structure/alien/resin/membrane
#define SMOOTH_GROUP_ALIEN_WEEDS S_OBJ(62) ///obj/structure/alien/weeds

#define SMOOTH_GROUP_SECURITY_BARRICADE S_OBJ(63) ///obj/structure/barricade/security
#define SMOOTH_GROUP_SANDBAGS S_OBJ(64) ///obj/structure/barricade/sandbags

#define SMOOTH_GROUP_HEDGE_FLUFF S_OBJ(65) ///obj/structure/fluff/hedge

#define SMOOTH_GROUP_SHUTTLE_PARTS S_OBJ(66) ///obj/structure/window/shuttle, /obj/structure/window/plasma/reinforced/plastitanium, /turf/closed/indestructible/opsglass, /obj/structure/shuttle

#define SMOOTH_GROUP_CLEANABLE_DIRT S_OBJ(67) ///obj/effect/decal/cleanable/dirt

#define SMOOTH_GROUP_INDUSTRIAL_LIFT S_OBJ(70) ///obj/structure/industrial_lift

#define SMOOTH_GROUP_GAS_TANK S_OBJ(71)

#define MAX_S_OBJ SMOOTH_GROUP_GAS_TANK //Always match this value with the one above it.
