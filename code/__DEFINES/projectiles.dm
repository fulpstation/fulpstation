
// check_pierce() return values
/// Default behavior: hit and delete self
#define PROJECTILE_PIERCE_NONE 0
/// Hit the thing but go through without deleting. Causes on_hit to be called with pierced = TRUE
#define PROJECTILE_PIERCE_HIT 1
/// Entirely phase through the thing without ever hitting.
#define PROJECTILE_PIERCE_PHASE 2
// Delete self without hitting
#define PROJECTILE_DELETE_WITHOUT_HITTING 3

// Caliber defines: (current count stands at 24)
/// The caliber used by the [L6 SAW][/obj/item/gun/ballistic/automatic/l6_saw].
#define CALIBER_712X82MM "mm71282"
/// The caliber used by the [security auto-rifle][/obj/item/gun/ballistic/automatic/wt550].
#define CALIBER_46X30MM "4.6x30mm"
/// The caliber used by the Nanotrasen Saber SMG, PP-95 SMG and Type U3 Uzi. Also used as the default caliber for pistols but only the stechkin APS machine pistol doesn't override it.
#define CALIBER_9MM "9mm"
/// The caliber used as the default for ballistic guns. Only not overridden for the [surplus rifle][/obj/item/gun/ballistic/automatic/surplus].
#define CALIBER_10MM "10mm"
/// The caliber used by most revolver variants.
#define CALIBER_357 ".357"
/// The caliber used by the detective's revolver.
#define CALIBER_38 ".38"
/// The caliber used by the chaplain's revolver.
#define CALIBER_77 ".77"
/// The caliber used by the C-20r SMG, the tommygun, and the M1911 pistol.
#define CALIBER_45 ".45"
/// The caliber used by sniper rifles and the desert eagle.
#define CALIBER_50 ".50"
/// The caliber used by the gyrojet pistol.
#define CALIBER_75 ".75"
/// The caliber used by [one revolver variant][/obj/item/gun/ballistic/revolver/nagant].
#define CALIBER_N762 "n762"
/// The caliber used by the the M-90gl Carbine, and NT-ARG 'Boarder'.
#define CALIBER_A556 "a556"
/// The caliber used by bolt action rifles.
#define CALIBER_A762 "a762"
/// The caliber used by shotguns.
#define CALIBER_SHOTGUN "shotgun"
/// The caliber used by grenade launchers.
#define CALIBER_40MM "40mm"
/// The caliber used by rocket launchers.
#define CALIBER_84MM "84mm"
/// The caliber used by laser guns.
#define CALIBER_LASER "laser"
/// The caliber used by most energy guns.
#define CALIBER_ENERGY "energy"
/// The acliber used by foam force and donksoft toy guns.
#define CALIBER_FOAM "foam_force"
/// The caliber used by the bow and arrow.
#define CALIBER_ARROW "arrow"
/// The caliber used by the harpoon gun.
#define CALIBER_HARPOON "harpoon"
/// The caliber used by the meat hook.
#define CALIBER_HOOK "hook"
/// The caliber used by the changeling tentacle mutation.
#define CALIBER_TENTACLE "tentacle"

/// For gunpoints, how many tiles around the target the shooter can roam without losing their shot
#define GUNPOINT_SHOOTER_STRAY_RANGE 2

//Designed for things that need precision trajectories like projectiles.
//Don't use this for anything that you don't absolutely have to use this with (like projectiles!) because it isn't worth using a datum unless you need accuracy down to decimal places in pixels.

//You might see places where it does - 16 - 1. This is intentionally 17 instead of 16, because of how byond's tiles work and how not doing it will result in rounding errors like things getting put on the wrong turf.

#define RETURN_PRECISE_POSITION(A) new /datum/position(A)
#define RETURN_PRECISE_POINT(A) new /datum/point(A)

#define RETURN_POINT_VECTOR(ATOM, ANGLE, SPEED) (new /datum/point/vector(ATOM, null, null, null, null, ANGLE, SPEED))
#define RETURN_POINT_VECTOR_INCREMENT(ATOM, ANGLE, SPEED, AMT) (new /datum/point/vector(ATOM, null, null, null, null, ANGLE, SPEED, AMT))
