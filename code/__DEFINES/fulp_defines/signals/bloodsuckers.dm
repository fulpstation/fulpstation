///Called when a Bloodsucker ranks up: (datum/bloodsucker_datum, mob/owner, mob/target)
#define BLOODSUCKER_RANK_UP "bloodsucker_rank_up"
///Called when a Bloodsucker interacts with a Vassal on their persuasion rack.
#define BLOODSUCKER_INTERACT_WITH_VASSAL "bloodsucker_interact_with_vassal"
///Called when a Bloodsucker makes a Vassal into their Favorite Vassal: (datum/vassal_datum, mob/master)
#define BLOODSUCKER_MAKE_FAVORITE "bloodsucker_make_favorite"
///Called when a new Vassal is successfully made: (datum/bloodsucker_datum)
#define BLOODSUCKER_MADE_VASSAL "bloodsucker_made_vassal"
///Called when a Bloodsucker exits Torpor.
#define BLOODSUCKER_EXIT_TORPOR "bloodsucker_exit_torpor"
///Called when a Bloodsucker reaches Final Death.
#define BLOODSUCKER_FINAL_DEATH "bloodsucker_final_death"
	///Whether the Bloodsucker should not be dusted when arriving Final Death
	#define DONT_DUST (1<<0)
///Called when a Bloodsucker breaks the Masquerade
#define COMSIG_BLOODSUCKER_BROKE_MASQUERADE "comsig_bloodsucker_broke_masquerade"
///Called when a Bloodsucker enters Frenzy
#define BLOODSUCKER_ENTERS_FRENZY "bloodsucker_enters_frenzy"
///Called when a Bloodsucker exits Frenzy
#define BLOODSUCKER_EXITS_FRENZY "bloodsucker_exits_frenzy"
