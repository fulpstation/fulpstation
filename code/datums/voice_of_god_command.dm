#define COOLDOWN_STUN 120 SECONDS
#define COOLDOWN_DAMAGE 60 SECONDS
#define COOLDOWN_MEME 30 SECONDS
#define COOLDOWN_NONE 1 SECONDS

/// Used to stop listeners with silly or clown-esque (first) names such as "Honk" or "Flip" from screwing up certain commands.
GLOBAL_DATUM(all_voice_of_god_triggers, /regex)
/// List of all voice of god commands
GLOBAL_LIST_INIT(voice_of_god_commands, init_voice_of_god_commands())

/proc/init_voice_of_god_commands()
	. = list()
	var/all_triggers
	var/separator
	for(var/datum/voice_of_god_command/prototype as anything in subtypesof(/datum/voice_of_god_command))
		var/init_trigger = initial(prototype.trigger)
		if(!init_trigger)
			continue
		. += new prototype
		all_triggers += "[separator][init_trigger]"
		separator = "|" // Shouldn't be at the start or end of the regex, or it won't work.
	GLOB.all_voice_of_god_triggers = regex(all_triggers, "i")

//////////////////////////////////////
///////////VOICE OF GOD///////////////
//////////////////////////////////////

/*
 * The main proc for the voice of god power. it makes the user shout a message in an ominous way,
 * The first matching command (from a list of static datums) the listeners must obey,
 * and the return value of this proc the cooldown variable of the command dictates. (only relevant for things with cooldowns i guess)
 */
/proc/voice_of_god(message, mob/living/user, list/span_list, base_multiplier = 1, include_speaker = FALSE, message_admins = TRUE)
	var/log_message = uppertext(message)
	var/is_cultie = IS_CULTIST(user)
	if(LAZYLEN(span_list))
		if(is_cultie)
			span_list = list("narsiesmall")
		else
			span_list = list()

	if(!user.say(message, spans = span_list, sanitize = FALSE))
		return

	message = lowertext(message)

	var/list/mob/living/listeners = list()
	//used to check if the speaker specified a name or a job to focus on
	var/list/specific_listeners = list()
	// string to remove at the end of the following of the following loop, so saying "Burn Mr. Hopkins" doesn't also burn the HoP later when we check jobs.
	var/to_remove_string
	var/list/candidates = get_hearers_in_view(8, user) - (include_speaker ? null : user)
	for(var/mob/living/candidate in candidates)
		if(candidate.stat != DEAD && candidate.can_hear() && !candidate.anti_magic_check(magic = FALSE, holy = TRUE))
			listeners += candidate

			//Let's ensure the listener's name is not matched within another word or command (and viceversa). e.g. "Saul" in "somersault"
			var/their_first_name = candidate.first_name()
			if(!GLOB.all_voice_of_god_triggers.Find(their_first_name) && findtext(message, regex("(\\L|^)[their_first_name](\\L|$)", "i")))
				specific_listeners += candidate //focus on those with the specified name
				to_remove_string += "[to_remove_string ? "|" : null][their_first_name]"
				continue
			var/their_last_name = candidate.last_name()
			if(their_last_name != their_first_name && !GLOB.all_voice_of_god_triggers.Find(their_last_name) && findtext(message, regex("(\\L|^)[their_last_name](\\L|$)", "i")))
				specific_listeners += candidate // Ditto
				to_remove_string += "[to_remove_string ? "|" : null][their_last_name]"

	if(!listeners.len)
		return
	if(to_remove_string)
		to_remove_string = "(\\L|^)([to_remove_string])(\\L|$)"
		message = replacetext(message, regex(to_remove_string, "i"), "")

	var/power_multiplier = base_multiplier

	if(user.mind)
		//Chaplains are very good at speaking with the voice of god
		if(user.mind.assigned_role == "Chaplain")
			power_multiplier *= 2
		//Command staff has authority
		if(user.mind.assigned_role in GLOB.command_positions)
			power_multiplier *= 1.4
		//Why are you speaking
		if(user.mind.assigned_role == "Mime")
			power_multiplier *= 0.5

	//Cultists are closer to their gods and are more powerful, but they'll give themselves away
	if(is_cultie)
		power_multiplier *= 2

	//Now get the proper job titles and check for matches.
	var/job_message = get_full_job_name(message)
	for(var/mob/living/candidate in candidates)
		var/their_role = candidate.mind?.assigned_role
		if(their_role && findtext(job_message, their_role))
			specific_listeners |= candidate //focus on those with the specified job. "|=" instead "+=" so "Mrs. Capri the Captain" doesn't get affected twice.

	if(specific_listeners.len)
		listeners = specific_listeners
		power_multiplier *= (1 + (1/specific_listeners.len)) //2x on a single guy, 1.5x on two and so on

	for(var/datum/voice_of_god_command/command as anything in GLOB.voice_of_god_commands)
		if(findtext(message, command.trigger))
			. = command.execute(listeners, user, power_multiplier, message) || command.cooldown
			break

	if(message_admins)
		message_admins("[ADMIN_LOOKUPFLW(user)] has said '[log_message]' with a Voice of God, affecting [english_list(listeners)], with a power multiplier of [power_multiplier].")
	log_game("[key_name(user)] has said '[log_message]' with a Voice of God, affecting [english_list(listeners)], with a power multiplier of [power_multiplier].")
	SSblackbox.record_feedback("tally", "voice_of_god", 1, log_message)

/// Voice of god command datums that are used in [/proc/voice_of_god()]
/datum/voice_of_god_command
	///a text string or regex that triggers the command.
	var/trigger
	/// Is the trigger supposed to be a regex? If so, convert it to such on New()
	var/is_regex = TRUE
	/// cooldown variable which is normally returned to [proc/voice_of_god] and used as its return value.
	var/cooldown = COOLDOWN_MEME

/datum/voice_of_god_command/New()
	if(is_regex)
		trigger = regex(trigger)

/*
 * What happens when the command is triggered.
 * If a return value is set, it'll be used in place of the 'cooldown' var.
 * Args:
 * * listeners: the list of living mobs who are affected by the command.
 * * user: the one who casted Voice of God
 * * power_multiplier: multiplies the power of the command, most times.
 */
/datum/voice_of_god_command/proc/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	return

/// This command stuns the listeners.
/datum/voice_of_god_command/stun
	trigger = "stop|wait|stand\\s*still|hold\\s*on|halt"
	cooldown = COOLDOWN_STUN

/datum/voice_of_god_command/stun/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	// Ensure 'as anything' is not used for loops that don't target all living mob types.
	for(var/mob/living/target as anything in listeners)
		target.Stun(4 SECONDS * power_multiplier)

/// This command knocks the listeners down.
/datum/voice_of_god_command/paralyze
	trigger = "drop|fall|trip|knockdown"
	cooldown = COOLDOWN_STUN

/datum/voice_of_god_command/paralyze/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.Paralyze(4 SECONDS * power_multiplier)

/// This command puts carbon listeners to sleep.
/datum/voice_of_god_command/sleeping
	trigger = "sleep|slumber|rest"
	cooldown = COOLDOWN_STUN

/datum/voice_of_god_command/sleeping/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/carbon/target as anything in listeners)
		target.Sleeping(2 SECONDS * power_multiplier)

/// This command makes carbon listeners throw up like Mr. Creosote.
/datum/voice_of_god_command/vomit
	trigger = "vomit|throw\\s*up|sick"
	cooldown = COOLDOWN_STUN

/datum/voice_of_god_command/vomit/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/carbon/target in listeners)
		target.vomit(10 * power_multiplier, distance = power_multiplier)

/// This command silences the listeners. Thrice as effective is the user is a mime or curator.
/datum/voice_of_god_command/silence
	trigger = "shut\\s*up|silence|be\\s*silent|ssh|quiet|hush"
	cooldown = COOLDOWN_STUN

/datum/voice_of_god_command/silence/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	if(user.mind && (user.mind.assigned_role == "Curator" || user.mind.assigned_role == "Mime"))
		power_multiplier *= 3
	for(var/mob/living/carbon/target in listeners)
		target.silent += (10 * power_multiplier)

/// This command makes the listeners see others as corgis, carps, skellies etcetera etcetera.
/datum/voice_of_god_command/hallucinate
	trigger = "see\\s*the\\s*truth|hallucinate"

/datum/voice_of_god_command/hallucinate/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/carbon/target in listeners)
		new /datum/hallucination/delusion(target, TRUE, null, 150 * power_multiplier, 0)

/// This command wakes up the listeners.
/datum/voice_of_god_command/wake_up
	trigger = "wake\\s*up|awaken"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/wake_up/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.SetSleeping(0)

/// This command heals the listeners for 10 points of total damage.
/datum/voice_of_god_command/heal
	trigger = "live|heal|survive|mend|life|heroes\\s*never\\s*die"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/heal/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.heal_overall_damage(10 * power_multiplier, 10 * power_multiplier)

/// This command applies 15 points of brute damage to the listeners. There's subtle theological irony in this being more powerful than healing.
/datum/voice_of_god_command/brute
	trigger = "die|suffer|hurt|pain|death"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/brute/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.apply_damage(15 * power_multiplier, def_zone = BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)

/// This command makes carbon listeners bleed from a random body part.
/datum/voice_of_god_command/bleed
	trigger = "bleed|there\\s*will\\s*be\\s*blood"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/bleed/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/carbon/human/target in listeners)
		var/obj/item/bodypart/chosen_part = pick(target.bodyparts)
		chosen_part.generic_bleedstacks += 5

/// This command sets the listeners ablaze.
/datum/voice_of_god_command/burn
	trigger = "burn|ignite"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/burn/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.adjust_fire_stacks(1 * power_multiplier)
		target.IgniteMob()

/// This command heats the listeners up like boiling water.
/datum/voice_of_god_command/hot
	trigger = "heat|hot|hell"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/hot/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.adjust_bodytemperature(50 * power_multiplier)

/// This command cools the listeners down like freezing water.
/datum/voice_of_god_command/cold
	trigger = "cold|chill|freeze"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/cold/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.adjust_bodytemperature(-50 * power_multiplier)

/// This command throws the listeners away from the user.
/datum/voice_of_god_command/repulse
	trigger = "shoo|go\\s*away|leave\\s*me\\s*alone|begone|flee|fus\\s*ro\\s*dah|get\\s*away|repulse"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/repulse/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		var/throwtarget = get_edge_target_turf(user, get_dir(user, get_step_away(target, user)))
		target.throw_at(throwtarget, 3 * power_multiplier, 1 * power_multiplier)

/// This command throws the listeners at the user.
/datum/voice_of_god_command/attract
	trigger = "come\\s*here|come\\s*to\\s*me|get\\s*over\\s*here|attract"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/attract/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.throw_at(get_step_towards(user, target), 3 * power_multiplier, 1 * power_multiplier)

/// This command forces the listeners to say their true name (so masks and hoods won't help).
/datum/voice_of_god_command/who_are_you
	trigger = "who\\s*are\\s*you|say\\s*your\\s*name|state\\s*your\\s*name|identify"

/datum/voice_of_god_command/who_are_you/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	var/iteration = 1
	for(var/mob/living/target as anything in listeners)
		addtimer(CALLBACK(target, /atom/movable/proc/say, target.real_name), 0.5 SECONDS * iteration)
		iteration++

/// This command forces the listeners to say the user's name
/datum/voice_of_god_command/say_my_name
	trigger = "say\\s*my\\s*name|who\\s*am\\s*i"

/datum/voice_of_god_command/say_my_name/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	var/iteration = 1
	for(var/mob/living/target as anything in listeners)
		addtimer(CALLBACK(target, /atom/movable/proc/say, user.name), 0.5 SECONDS * iteration)
		iteration++

/// This command forces the listeners to say "Who's there?".
/datum/voice_of_god_command/knock_knock
	trigger = "knock\\s*knock"

/datum/voice_of_god_command/knock_knock/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	var/iteration = 1
	for(var/mob/living/target as anything in listeners)
		addtimer(CALLBACK(target, /atom/movable/proc/say, "Who's there?"), 0.5 SECONDS * iteration)
		iteration++

/// This command forces silicon listeners to state all their laws.
/datum/voice_of_god_command/state_laws
	trigger = "state\\s*(your)?\\s*laws"

/datum/voice_of_god_command/state_laws/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	var/iteration = 0
	for(var/mob/living/silicon/target in listeners)
		addtimer(CALLBACK(target, /mob/living/silicon/proc/statelaws, TRUE), (3 SECONDS * iteration) + 0.5 SECONDS)
		iteration++

/// This command forces the listeners to take step in a direction chosen by the user, otherwise a random cardinal one.
/datum/voice_of_god_command/move
	trigger = "move|walk"
	var/static/up_words = regex("up|north|fore")
	var/static/down_words = regex("down|south|aft")
	var/static/left_words = regex("left|west|port")
	var/static/right_words = regex("right|east|starboard")

/datum/voice_of_god_command/move/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	var/iteration = 1
	var/direction
	if(findtext(message, up_words))
		direction = NORTH
	else if(findtext(message, down_words))
		direction = SOUTH
	else if(findtext(message, left_words))
		direction = WEST
	else if(findtext(message, right_words))
		direction = EAST
	for(var/mob/living/target as anything in listeners)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/_step, target, direction || pick(GLOB.cardinals)), 1 SECONDS * (iteration - 1))
		iteration++

/// This command forces the listeners to switch to walk intent.
/datum/voice_of_god_command/walk
	trigger = "slow\\s*down"

/datum/voice_of_god_command/walk/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		if(target.m_intent != MOVE_INTENT_WALK)
			target.toggle_move_intent()

/// This command forces the listeners to switch to run intent.
/datum/voice_of_god_command/run
	trigger = "run"
	is_regex = FALSE

/datum/voice_of_god_command/walk/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		if(target.m_intent != MOVE_INTENT_RUN)
			target.toggle_move_intent()

/// This command turns the listeners' throw mode on.
/datum/voice_of_god_command/throw_catch
	trigger = "throw|catch"

/datum/voice_of_god_command/throw_catch/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/carbon/target in listeners)
		target.throw_mode_on(THROW_MODE_TOGGLE)

/// This command forces the listeners to say a brain damage line.
/datum/voice_of_god_command/speak
	trigger = "speak|say\\s*something"

/datum/voice_of_god_command/speak/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	var/iteration = 1
	for(var/mob/living/target in listeners)
		addtimer(CALLBACK(target, /atom/movable/proc/say, pick_list_replacements(BRAIN_DAMAGE_FILE, "brain_damage")), 0.5 SECONDS * iteration)
		iteration++

/// This command forces the listeners to get the fuck up, resetting all stuns.
/datum/voice_of_god_command/getup
	trigger = "get\\s*up"
	cooldown = COOLDOWN_DAMAGE

/datum/voice_of_god_command/getup/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.set_resting(FALSE)
		target.SetAllImmobility(0)

/// This command forces each listener to buckle to a chair found on the same tile.
/datum/voice_of_god_command/sit
	trigger = "sit"
	is_regex = FALSE

/datum/voice_of_god_command/sit/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		var/obj/structure/chair/chair = locate(/obj/structure/chair) in get_turf(target)
		chair?.buckle_mob(target)

/// This command forces each listener to unbuckle from whatever they are buckled to.
/datum/voice_of_god_command/stand
	trigger = "stand"
	is_regex = FALSE

/datum/voice_of_god_command/stand/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.buckled?.unbuckle_mob(target)

/// This command forces the listener to do the jump emote 3/4 of the times or reply "HOW HIGH?!!".
/datum/voice_of_god_command/jump
	trigger = "jump"
	is_regex = FALSE

/datum/voice_of_god_command/jump/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	var/iteration = 1
	for(var/mob/living/target as anything in listeners)
		if(prob(25))
			addtimer(CALLBACK(target, /atom/movable/proc/say, "HOW HIGH?!!"), 0.5 SECONDS * iteration)
		else
			addtimer(CALLBACK(target, /mob/living/.proc/emote, "jump"), 0.5 SECONDS * iteration)
		iteration++

///This command plays a bikehorn sound after 2 seconds and a half have passed, and also slips listeners if the user is a clown.
/datum/voice_of_god_command/honk
	trigger = "ho+nk"

/datum/voice_of_god_command/honk/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, get_turf(user), 'sound/items/bikehorn.ogg', 300, 1), 2.5 SECONDS)
	if(user.mind?.assigned_role == "Clown")
		. = COOLDOWN_STUN //it slips.
		for(var/mob/living/carbon/target in listeners)
			target.slip(14 SECONDS * power_multiplier)

///This command spins the listeners 1800° degrees clockwise.
/datum/voice_of_god_command/multispin
	trigger = "like\\s*a\\s*record\\s*baby|right\\s*round"

/datum/voice_of_god_command/multispin/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	for(var/mob/living/target as anything in listeners)
		target.SpinAnimation(speed = 10, loops = 5)

/// Supertype of all those commands that make people emote and nothing else. Fuck copypasta.
/datum/voice_of_god_command/emote
	/// The emote to run.
	var/emote_name = "dance"

/datum/voice_of_god_command/emote/execute(list/listeners, mob/living/user, power_multiplier = 1, message)
	var/iteration = 1
	for(var/mob/living/target as anything in listeners)
		addtimer(CALLBACK(target, /mob/living/.proc/emote, emote_name), 0.5 SECONDS * iteration)
		iteration++

/datum/voice_of_god_command/emote/flip
	trigger = "flip|rotate|revolve|roll|somersault"
	emote_name = "flip"

/datum/voice_of_god_command/emote/dance
	trigger = "dance"
	is_regex = FALSE

/datum/voice_of_god_command/emote/salute
	trigger = "salute"
	emote_name = "salute"
	is_regex = FALSE

/datum/voice_of_god_command/emote/play_dead
	trigger = "play\\s*dead"
	emote_name = "deathgasp"

/datum/voice_of_god_command/emote/clap
	trigger = "clap|applaud"
	emote_name = "clap"

#undef COOLDOWN_STUN
#undef COOLDOWN_DAMAGE
#undef COOLDOWN_MEME
#undef COOLDOWN_NONE
