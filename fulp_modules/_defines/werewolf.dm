#define WEREWOLF_TRAIT "werewolf_trait"
/// Has special interactions with werewolves
#define TRAIT_WEREWOLF_HUNTER "werewolf_hunter"

// Role defines
#define ROLE_WEREWOLF "Werewolf"

/*
 * Power defines
*/
/// Must be transformed to use
#define WP_TRANSFORM_REQUIRED (1<<0)
/// The power is a toggle
#define WP_TOGGLED (1<<1)


/*
 * Werewolf signals
*/
/// Called when a werewolf transforms
#define WEREWOLF_TRANSFORMED "werewolf_transformed"
/// Called when a werewolf reverts to normal
#define WEREWOLF_REVERTED "werewolf_reverted"
/// Called when a werewolf consumes a body
#define WEREWOLF_CONSUMED_BODY "werewolf_consumed_body"


/*
 * Moon cycle signals
*/
#define COMSIG_LUN_WARNING "comsig_lun_warning"
#define COMSIG_LUN_RISE_TICK "comsig_lun_rise_tick"
#define COMSIG_LUN_NEAR_START "comsig_lun_near_start"
#define COMSIG_LUN_START "comsig_lun_start"
#define COMSIG_LUN_END "comsig_lun_end"
