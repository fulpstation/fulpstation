/// Choice beacon to order your mech kit - Stolen from halloween costumes
/obj/item/choice_beacon/mech_kit
	name = "mech kit delivery beacon"
	desc = "Summon your Mech kit of choice to help you in battle!"
	icon_state = "gangtool-white"

/obj/item/choice_beacon/mech_kit/generate_display_names()
	var/list/choices = list()
	for(var/V in subtypesof(/obj/item/storage/bag/mechs))
		var/obj/item/storage/bag/mechs/A = V
		choices[initial(A.mech_type)] = A
	return choices

/obj/item/choice_beacon/mech_kit/spawn_option(obj/choice,mob/living/M)
	new choice(get_turf(M))
	to_chat(M, span_hear("You hear something crackle from the beacon for a moment before a voice speaks. \"Please stand by for a message from Fulptailoring Broadcasting. Message as follows: <b>Please enjoy your Fulptailoring Broadcasting's Mech Kit!</b> Message ends.\""))
