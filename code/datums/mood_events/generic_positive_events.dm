/datum/mood_event/hug
	description = "<span class='nicegreen'>Hugs are nice.</span>\n"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/betterhug
	description = "<span class='nicegreen'>Someone was very nice to me.</span>\n"
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/betterhug/add_effects(mob/friend)
	description = "<span class='nicegreen'>[friend.name] was very nice to me.</span>\n"

/datum/mood_event/besthug
	description = "<span class='nicegreen'>Someone is great to be around, they make me feel so happy!</span>\n"
	mood_change = 5
	timeout = 4 MINUTES

/datum/mood_event/besthug/add_effects(mob/friend)
	description = "<span class='nicegreen'>[friend.name] is great to be around, [friend.p_they()] makes me feel so happy!</span>\n"

/datum/mood_event/warmhug
	description = "<span class='nicegreen'>Warm cozy hugs are the best!</span>\n"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/arcade
	description = "<span class='nicegreen'>I beat the arcade game!</span>\n"
	mood_change = 3
	timeout = 8 MINUTES

/datum/mood_event/blessing
	description = "<span class='nicegreen'>I've been blessed.</span>\n"
	mood_change = 3
	timeout = 8 MINUTES

/datum/mood_event/maintenance_adaptation
	mood_change = 8

/datum/mood_event/maintenance_adaptation/add_effects()
	description = "<span class='nicegreen'>[GLOB.deity] has helped me adapt to the maintenance shafts!</span>\n"

/datum/mood_event/book_nerd
	description = "<span class='nicegreen'>I have recently read a book.</span>\n"
	mood_change = 1
	timeout = 5 MINUTES

/datum/mood_event/exercise
	description = "<span class='nicegreen'>Working out releases those endorphins!</span>\n"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/pet_animal
	description = "<span class='nicegreen'>Animals are adorable! I can't stop petting them!</span>\n"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/pet_animal/add_effects(mob/animal)
	description = "<span class='nicegreen'>\The [animal.name] is adorable! I can't stop petting [animal.p_them()]!</span>\n"

/datum/mood_event/honk
	description = "<span class='nicegreen'>I've been honked!</span>\n"
	mood_change = 2
	timeout = 4 MINUTES
	special_screen_obj = "honked_nose"
	special_screen_replace = FALSE

/datum/mood_event/saved_life
	description = "<span class='nicegreen'>It feels good to save a life.</span>\n"
	mood_change = 6
	timeout = 8 MINUTES

/datum/mood_event/oblivious
	description = "<span class='nicegreen'>What a lovely day.</span>\n"
	mood_change = 3

/datum/mood_event/jolly
	description = "<span class='nicegreen'>I feel happy for no particular reason.</span>\n"
	mood_change = 6
	timeout = 2 MINUTES

/datum/mood_event/focused
	description = "<span class='nicegreen'>I have a goal, and I will reach it, whatever it takes!</span>\n" //Used for syndies, nukeops etc so they can focus on their goals
	mood_change = 4
	hidden = TRUE

/datum/mood_event/badass_antag
	description = "<span class='greentext'>I'm a fucking badass and everyone around me knows it. Just look at them; they're all fucking shaking at the mere thought of having me around.</span>\n"
	mood_change = 7
	hidden = TRUE
	special_screen_obj = "badass_sun"
	special_screen_replace = FALSE

/datum/mood_event/creeping
	description = "<span class='greentext'>The voices have released their hooks on my mind! I feel free again!</span>\n" //creeps get it when they are around their obsession
	mood_change = 18
	timeout = 3 SECONDS
	hidden = TRUE

/datum/mood_event/revolution
	description = "<span class='nicegreen'>VIVA LA REVOLUTION!</span>\n"
	mood_change = 3
	hidden = TRUE

/datum/mood_event/cult
	description = "<span class='nicegreen'>I have seen the truth, praise the almighty one!</span>\n"
	mood_change = 10 //maybe being a cultist isn't that bad after all
	hidden = TRUE

/datum/mood_event/heretics
	description = "<span class='nicegreen'>THE HIGHER I RISE, THE MORE I SEE.</span>\n"
	mood_change = 10 //maybe being a cultist isnt that bad after all
	hidden = TRUE

/datum/mood_event/family_heirloom
	description = "<span class='nicegreen'>My family heirloom is safe with me.</span>\n"
	mood_change = 1

/datum/mood_event/fan_clown_pin
	description = "<span class='nicegreen'>I love showing off my clown pin!</span>\n"
	mood_change = 1

/datum/mood_event/fan_mime_pin
	description = "<span class='nicegreen'>I love showing off my mime pin!</span>\n"
	mood_change = 1

/datum/mood_event/goodmusic
	description = "<span class='nicegreen'>There is something soothing about this music.</span>\n"
	mood_change = 3
	timeout = 60 SECONDS

/datum/mood_event/chemical_euphoria
	description = "<span class='nicegreen'>Heh...hehehe...hehe...</span>\n"
	mood_change = 4

/datum/mood_event/chemical_laughter
	description = "<span class='nicegreen'>Laughter really is the best medicine! Or is it?</span>\n"
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/chemical_superlaughter
	description = "<span class='nicegreen'>*WHEEZE*</span>\n"
	mood_change = 12
	timeout = 3 MINUTES

/datum/mood_event/religiously_comforted
	description = "<span class='nicegreen'>I feel comforted by the presence of a holy person.</span>\n"
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/clownshoes
	description = "<span class='nicegreen'>The shoes are a clown's legacy, I never want to take them off!</span>\n"
	mood_change = 5

/datum/mood_event/sacrifice_good
	description ="<span class='nicegreen'>The gods are pleased with this offering!</span>\n"
	mood_change = 5
	timeout = 3 MINUTES

/datum/mood_event/artok
	description = "<span class='nicegreen'>It's nice to see people are making art around here.</span>\n"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/artgood
	description = "<span class='nicegreen'>What a thought-provoking piece of art. I'll remember that for a while.</span>\n"
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/artgreat
	description = "<span class='nicegreen'>That work of art was so great it made me believe in the goodness of humanity. Says a lot in a place like this.</span>\n"
	mood_change = 6
	timeout = 5 MINUTES

/datum/mood_event/pet_borg
	description = "<span class='nicegreen'>I just love my robotic friends!</span>\n"
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/bottle_flip
	description = "<span class='nicegreen'>The bottle landing like that was satisfying.</span>\n"
	mood_change = 2
	timeout = 3 MINUTES

/datum/mood_event/hope_lavaland
	description = "<span class='nicegreen'>What a peculiar emblem.  It makes me feel hopeful for my future.</span>\n"
	mood_change = 10

/datum/mood_event/nanite_happiness
	description = "<span class='nicegreen robot'>+++++++HAPPINESS ENHANCEMENT+++++++</span>\n"
	mood_change = 7

/datum/mood_event/nanite_happiness/add_effects(message)
	description = "<span class='nicegreen robot'>+++++++[message]+++++++</span>\n"

/datum/mood_event/area
	description = "" //Fill this out in the area
	mood_change = 0

/datum/mood_event/area/add_effects(_mood_change, _description)
	mood_change = _mood_change
	description = _description

/datum/mood_event/confident_mane
	description = "<span class='nicegreen'>I'm feeling confident with a head full of hair.</span>\n"
	mood_change = 2

/datum/mood_event/holy_consumption
	description = "<span class='nicegreen'>Truly, that was the food of the Divine!</span>\n"
	mood_change = 5
	timeout = 3 MINUTES

/datum/mood_event/high_five
	description = "<span class='nicegreen'>I love getting high fives!</span>\n"
	mood_change = 2
	timeout = 45 SECONDS

/datum/mood_event/high_ten
	description = "<span class='nicegreen'>AMAZING! A HIGH-TEN!</span>\n"
	mood_change = 3
	timeout = 45 SECONDS

/datum/mood_event/down_low
	description = "<span class='nicegreen'>HA! What a rube, they never stood a chance...</span>\n"
	mood_change = 4
	timeout = 90 SECONDS

/datum/mood_event/aquarium_positive
	description = "<span class='nicegreen'>Watching fish in an aquarium is calming.</span>\n"
	mood_change = 3
	timeout = 90 SECONDS

/datum/mood_event/gondola
	description = "<span class='nicegreen'>I feel at peace and feel no need to make any sudden or rash actions.</span>\n"
	mood_change = 6

/datum/mood_event/kiss
	description = "<span class='nicegreen'>Someone blew a kiss at me, I must be a real catch!</span>\n"
	mood_change = 1.5
	timeout = 2 MINUTES

/datum/mood_event/kiss/add_effects(mob/beau)
	if(beau)
		description = "<span class='nicegreen'>[beau.name] blew a kiss at me, I must be a real catch!</span>\n"

/datum/mood_event/honorbound
	description = "<span class='nicegreen'>Following my honorbound code is fulfilling!</span>\n"
	mood_change = 4
