/datum/ai_planning_subtree/random_speech
	//The chance of an emote occurring each second
	var/speech_chance = 0
	///Hearable emotes
	var/list/emote_hear = list()
	///Unlike speak_emote, the list of things in this variable only show by themselves with no spoken text. IE: Ian barks, Ian yaps
	var/list/emote_see = list()
	///Possible lines of speech the AI can have
	var/list/speak = list()
	///The sound effects associated with this speech, if any
	var/list/sound = list()

/datum/ai_planning_subtree/random_speech/New()
	. = ..()
	if(speak)
		speak = string_list(speak)
	if(sound)
		sound = string_list(sound)
	if(emote_hear)
		emote_hear = string_list(emote_hear)
	if(emote_see)
		emote_see = string_list(emote_see)

/datum/ai_planning_subtree/random_speech/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(SPT_PROB(speech_chance, seconds_per_tick))
		var/audible_emotes_length = emote_hear?.len
		var/non_audible_emotes_length = emote_see?.len
		var/speak_lines_length = speak?.len

		var/total_choices_length = audible_emotes_length + non_audible_emotes_length + speak_lines_length

		var/random_number_in_range = rand(1, total_choices_length)

		if(random_number_in_range <= audible_emotes_length)
			controller.queue_behavior(/datum/ai_behavior/perform_emote, pick(emote_hear))
		else if(random_number_in_range <= (audible_emotes_length + non_audible_emotes_length))
			controller.queue_behavior(/datum/ai_behavior/perform_emote, pick(emote_see))
		else
			controller.queue_behavior(/datum/ai_behavior/perform_speech, pick(speak), length(sound) > 0 ? pick(sound) : null)

/datum/ai_planning_subtree/random_speech/insect
	speech_chance = 5
	emote_hear = list("chitters.")

/datum/ai_planning_subtree/random_speech/mothroach
	speech_chance = 15
	emote_hear = list("flutters.")

/datum/ai_planning_subtree/random_speech/mouse
	speech_chance = 1
	speak = list("Squeak!", "SQUEAK!", "Squeak?")
	emote_hear = list("squeaks.")
	emote_see = list("runs in a circle.", "shakes.")

/datum/ai_planning_subtree/random_speech/frog
	speech_chance = 3
	emote_see = list("jumps in a circle.", "shakes.")

/datum/ai_planning_subtree/random_speech/lizard // all of these have to be three words long or i'm killing you. you're dead.
	speech_chance = 3
	emote_hear = list("stamps around some.", "hisses a bit.")
	emote_see = list("blehs the tongue.", "tilts the head.", "does a spin.")

/datum/ai_planning_subtree/random_speech/sheep
	speech_chance = 5
	speak = list("baaa","baaaAAAAAH!","baaah")
	sound = list('sound/creatures/sheep1.ogg', 'sound/creatures/sheep2.ogg', 'sound/creatures/sheep3.ogg')
	emote_hear = list("bleats.")
	emote_see = list("shakes her head.", "stares into the distance.")

/datum/ai_planning_subtree/random_speech/rabbit
	speech_chance = 10
	speak = list("Mrrp.", "CHIRP!", "Mrrp?") // rabbits make some weird noises dude i don't know what to tell you
	emote_hear = list("hops.")
	emote_see = list("hops around.", "bounces up and down.")

/// For the easter subvariant of rabbits, these ones actually speak catchphrases.
/datum/ai_planning_subtree/random_speech/rabbit/easter
	speak = list(
		"Hop into Easter!",
		"Come get your eggs!",
		"Prizes for everyone!",
	)

/// These ones have a space mask on, so their catchphrases are muffled.
/datum/ai_planning_subtree/random_speech/rabbit/easter/space
	speak = list(
		"Hmph mmph mmmph!",
		"Mmphe mmphe mmphe!",
		"Hmm mmm mmm!",
	)

/datum/ai_planning_subtree/random_speech/chicken
	speech_chance = 15 // really talkative ladies
	speak = list("Cluck!", "BWAAAAARK BWAK BWAK BWAK!", "Bwaak bwak.")
	emote_hear = list("clucks.", "croons.")
	emote_see = list("pecks at the ground.","flaps her wings viciously.")

/datum/ai_planning_subtree/random_speech/chick
	speech_chance = 4
	speak = list("Cherp.", "Cherp?", "Chirrup.", "Cheep!")
	emote_hear = list("cheeps.")
	emote_see = list("pecks at the ground.","flaps her tiny wings.")

/datum/ai_planning_subtree/random_speech/cow
	speech_chance = 1
	speak = list("moo?","moo","MOOOOOO")
	sound = list('sound/creatures/cow.ogg')
	emote_hear = list("brays.")
	emote_see = list("shakes her head.")

///unlike normal cows, wisdom cows speak of wisdom and won't shut the fuck up
/datum/ai_planning_subtree/random_speech/cow/wisdom
	speech_chance = 15

/datum/ai_planning_subtree/random_speech/cow/wisdom/New()
	. = ..()
	speak = GLOB.wisdoms //Done here so it's setup properly
	sound = list()

/datum/ai_planning_subtree/random_speech/deer
	speech_chance = 1
	speak = list("Weeeeeeee?", "Weeee", "WEOOOOOOOOOO")
	emote_hear = list("brays.")
	emote_see = list("shakes her head.")

/datum/ai_planning_subtree/random_speech/dog
	speech_chance = 1

/datum/ai_planning_subtree/random_speech/dog/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(!isdog(controller.pawn))
		return

	// Stay in sync with dog fashion.
	var/mob/living/basic/pet/dog/dog_pawn = controller.pawn
	dog_pawn.update_dog_speech(src)

	return ..()

/datum/ai_planning_subtree/random_speech/faithless
	speech_chance = 1
	emote_see = list("wails.")

/datum/ai_planning_subtree/random_speech/garden_gnome
	speech_chance = 5
	speak = list("Gnot a gnelf!", "Gnot a gnoblin!", "Howdy chum!")
	emote_hear = list("snores.", "burps.")
	emote_see = list("blinks.")

/datum/ai_planning_subtree/random_speech/tree
	speech_chance = 3
	emote_see = list("photosynthesizes angirly.")

/datum/ai_planning_subtree/random_speech/pig
	speech_chance = 3
	speak = list("oink?","oink","snurf")
	sound = list('sound/creatures/pig1.ogg', 'sound/creatures/pig2.ogg')
	emote_hear = list("snorts.")
	emote_see = list("sniffs around.")

/datum/ai_planning_subtree/random_speech/killer_tomato
	speech_chance = 3
	speak = list("gnashes.", "growls lowly.", "snarls.")
	emote_hear = list("gnashes.")
	emote_see = list("salivates.")

/datum/ai_planning_subtree/random_speech/ant
	speech_chance = 1
	emote_hear = list("buzzes.", "clacks.")
	emote_see = list("shakes their head.", "twitches their antennae.")
	speak = list("BZZZZT!", "CHTCHTCHT!", "Bzzz", "ChtChtCht")
