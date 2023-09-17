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
