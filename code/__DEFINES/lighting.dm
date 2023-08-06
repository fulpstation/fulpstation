/// Object doesn't use any of the light systems. Should be changed to add a light source to the object.
#define NO_LIGHT_SUPPORT 0
/// Light made with the lighting datums, applying a matrix.
#define STATIC_LIGHT 1
/// Light made by masking the lighting darkness plane.
#define MOVABLE_LIGHT 2
/// Light made by masking the lighting darkness plane, and is directional.
#define MOVABLE_LIGHT_DIRECTIONAL 3
///Light made by masking the lighting darkness plane, and is a directionally focused beam.
#define MOVABLE_LIGHT_BEAM 4
/// Nonesensical value for light color, used for null checks.
#define NONSENSICAL_VALUE -99999

/// Is a movable light source attached to another movable (its loc), meaning that the lighting component should go one level deeper.
#define LIGHT_ATTACHED (1<<0)
/// Freezes a light in its current state, blocking any attempts at modification
#define LIGHT_FROZEN (1<<1)
/// Does this light ignore inherent offsets? (Pixels, transforms, etc)
#define LIGHT_IGNORE_OFFSET (1<<2)

// Bay lighting engine shit, not in /code/modules/lighting because BYOND is being shit about it
/// frequency, in 1/10ths of a second, of the lighting process
#define LIGHTING_INTERVAL 5

#define MINIMUM_USEFUL_LIGHT_RANGE 1.4

/// type of falloff to use for lighting; 1 for circular, 2 for square
#define LIGHTING_FALLOFF 1
/// use lambertian shading for light sources
#define LIGHTING_LAMBERTIAN 0
/// height off the ground of light sources on the pseudo-z-axis, you should probably leave this alone
#define LIGHTING_HEIGHT 1
/// Value used to round lumcounts, values smaller than 1/129 don't matter (if they do, thanks sinking points), greater values will make lighting less precise, but in turn increase performance, VERY SLIGHTLY.
#define LIGHTING_ROUND_VALUE (1 / 64)

/// icon used for lighting shading effects
#define LIGHTING_ICON 'icons/effects/lighting_object.dmi'

/// If the max of the lighting lumcounts of each spectrum drops below this, disable luminosity on the lighting objects.
/// Set to zero to disable soft lighting. Luminosity changes then work if it's lit at all.
#define LIGHTING_SOFT_THRESHOLD 0

///How many tiles standard fires glow.
#define LIGHT_RANGE_FIRE 3
#define LIGHT_FIRE_BLOSSOM 2.1
#define LIGHT_RANGE_FIRE_BLOSSOM_HARVESTED 2.7
#define LIGHT_POWER_FIRE_BLOSSOM_HARVESTED 1.5

// Lighting cutoff defines
// These are a percentage of how much darkness to cut off (in rgb)
#define LIGHTING_CUTOFF_VISIBLE 0
#define LIGHTING_CUTOFF_REAL_LOW 4.5
#define LIGHTING_CUTOFF_MEDIUM 15
#define LIGHTING_CUTOFF_HIGH 30
#define LIGHTING_CUTOFF_FULLBRIGHT 100

/// What counts as being able to see in the dark
#define LIGHTING_NIGHTVISION_THRESHOLD 7

/// The amount of lumcount on a tile for it to be considered dark (used to determine reading and nyctophobia)
#define LIGHTING_TILE_IS_DARK 0.2

//code assumes higher numbers override lower numbers.
#define LIGHTING_NO_UPDATE 0
#define LIGHTING_VIS_UPDATE 1
#define LIGHTING_CHECK_UPDATE 2
#define LIGHTING_FORCE_UPDATE 3

#define FLASH_LIGHT_DURATION 2
#define FLASH_LIGHT_POWER 3
#define FLASH_LIGHT_RANGE 3.8

// Emissive blocking.
/// Uses vis_overlays to leverage caching so that very few new items need to be made for the overlay. For anything that doesn't change outline or opaque area much or at all.
#define EMISSIVE_BLOCK_GENERIC 0
/// Uses a dedicated render_target object to copy the entire appearance in real time to the blocking layer. For things that can change in appearance a lot from the base state, like humans.
#define EMISSIVE_BLOCK_UNIQUE 1
/// Don't block any emissives. Useful for things like, pieces of paper?
#define EMISSIVE_BLOCK_NONE 2

/// The color matrix applied to all emissive overlays. Should be solely dependent on alpha and not have RGB overlap with [EM_BLOCK_COLOR].
#define EMISSIVE_COLOR list(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 1,1,1,0)
/// A globaly cached version of [EMISSIVE_COLOR] for quick access.
GLOBAL_LIST_INIT(emissive_color, EMISSIVE_COLOR)
/// The color matrix applied to all emissive blockers. Should be solely dependent on alpha and not have RGB overlap with [EMISSIVE_COLOR].
#define EM_BLOCK_COLOR list(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0)
/// A globaly cached version of [EM_BLOCK_COLOR] for quick access.
GLOBAL_LIST_INIT(em_block_color, EM_BLOCK_COLOR)
/// A set of appearance flags applied to all emissive and emissive blocker overlays.
/// KEEP_APART to prevent parent hooking, KEEP_TOGETHER for children, and we reset the color and alpha of our parent so nothing gets overriden
#define EMISSIVE_APPEARANCE_FLAGS (KEEP_APART|KEEP_TOGETHER|RESET_COLOR|RESET_ALPHA)
/// The color matrix used to mask out emissive blockers on the emissive plane. Alpha should default to zero, be solely dependent on the RGB value of [EMISSIVE_COLOR], and be independant of the RGB value of [EM_BLOCK_COLOR].
#define EM_MASK_MATRIX list(0,0,0,1/3, 0,0,0,1/3, 0,0,0,1/3, 0,0,0,0, 1,1,1,0)
/// A globaly cached version of [EM_MASK_MATRIX] for quick access.
GLOBAL_LIST_INIT(em_mask_matrix, EM_MASK_MATRIX)

/// Returns the red part of a #RRGGBB hex sequence as number
#define GETREDPART(hexa) hex2num(copytext(hexa, 2, 4))

/// Returns the green part of a #RRGGBB hex sequence as number
#define GETGREENPART(hexa) hex2num(copytext(hexa, 4, 6))

/// Returns the blue part of a #RRGGBB hex sequence as number
#define GETBLUEPART(hexa) hex2num(copytext(hexa, 6, 8))

/// Parse the hexadecimal color into lumcounts of each perspective.
#define PARSE_LIGHT_COLOR(source) \
do { \
	if (source.light_color != COLOR_WHITE) { \
		var/__light_color = source.light_color; \
		source.lum_r = GETREDPART(__light_color) / 255; \
		source.lum_g = GETGREENPART(__light_color) / 255; \
		source.lum_b = GETBLUEPART(__light_color) / 255; \
	} else { \
		source.lum_r = 1; \
		source.lum_g = 1; \
		source.lum_b = 1; \
	}; \
} while (FALSE)
