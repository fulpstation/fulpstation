/// -- Botany plant stat defines. --
/// MAXES:
#define MAX_PLANT_YIELD 10
#define MAX_PLANT_LIFESPAN 100
#define MAX_PLANT_ENDURANCE 100
#define MAX_PLANT_PRODUCTION 10
#define MAX_PLANT_POTENCY 100
#define MAX_PLANT_INSTABILITY 100
#define MAX_PLANT_WEEDRATE 10
#define MAX_PLANT_WEEDCHANCE 67
/// MINS:
#define MIN_PLANT_ENDURANCE 10

/// -- Some botany trait value defines. --
/// Weed Hardy can only reduce plants to 3 yield.
#define WEED_HARDY_YIELD_MIN 3
/// Carnivory potency can only reduce potency to 30.
#define CARNIVORY_POTENCY_MIN 30
/// Fungle megabolism plants have a min yield of 1.
#define FUNGAL_METAB_YIELD_MIN 1

/// -- Hydroponics tray defines. --
/// Macro for updating the tray name.
#define TRAY_NAME_UPDATE name = myseed ? "[initial(name)] ([myseed.plantname])" : initial(name)
///  Base amount of nutrients a tray can old.
#define STATIC_NUTRIENT_CAPACITY 10
/// Maximum amount of toxins a tray can reach.
#define MAX_TRAY_TOXINS 100
/// Maxumum pests a tray can reach.
#define MAX_TRAY_PESTS 10
/// Maximum weeds a tray can reach.
#define MAX_TRAY_WEEDS 10
/// Minumum plant health required for gene shears.
#define GENE_SHEAR_MIN_HEALTH 15

/// -- Flags for genes --
/// Plant genes that can be removed via gene shears.
#define PLANT_GENE_REMOVABLE (1<<0)
/// Plant genes that can be mutated randomly in strange seeds / due to high instability.
#define PLANT_GENE_MUTATABLE (1<<1)
/// Plant genes that can be graftable. Used in formatting text, as they need to be set to be graftable anyways.
#define PLANT_GENE_GRAFTABLE (1<<2)

/// -- Flags for seeds. --
/// Allows a plant to wild mutate (mutate on haravest) at a certain instability.
#define MUTATE_EARLY (1<<0)

/// -- Flags for traits. --
/// Caps the plant's yield at 5 instead of 10.
#define TRAIT_HALVES_YIELD (1<<0)

/// -- Trait IDs. Plants that match IDs cannot be added to the same plant. --
/// Plants that glow.
#define GLOW_ID (1<<0)
/// Plant types.
#define PLANT_TYPE_ID (1<<1)
/// Plants that affect the reagent's temperature.
#define TEMP_CHANGE_ID (1<<2)
/// Plants that affect the reagent contents.
#define CONTENTS_CHANGE_ID (1<<3)
/// Plants that do something special when they impact.
#define THROW_IMPACT_ID (1<<4)
/// Plants that transfer reagents on impact.
#define REAGENT_TRANSFER_ID (1<<5)
/// Plants that have a unique effect on attack_self.
#define ATTACK_SELF_ID (1<<6)
