/obj/item/choice_beacon/brigdoc
	name = "medical equipment delivery beacon"
	desc = "Summon a crate with equipment to help you on your medical shift."

/obj/item/choice_beacon/brigdoc/generate_display_names()
	var/static/list/brigdoc_kit_choice
	if(!brigdoc_kit_choice)
		brigdoc_kit_choice = list()
		var/list/templist = typesof(/obj/structure/closet/crate/medical/brigdoc)
		for(var/V in templist)
			var/atom/A = V
			brigdoc_kit_choice[initial(A.name)] = A
	return brigdoc_kit_choice

// SURGERY-READY KIT

/obj/structure/closet/crate/medical/brigdoc
	name = "Surgery-Ready Kit"

/obj/structure/closet/crate/medical/brigdoc/PopulateContents()
	new /obj/item/paper/fluff/surgery_ready_instructions_kit(src)
	new /obj/item/stack/rods/two(src)
	new /obj/item/stack/sheet/mineral/silver(src)
	new /obj/item/stack/sheet/iron/five(src)
	new /obj/item/circuitboard/computer/operating(src)
	new /obj/item/wrench(src)
	new /obj/item/screwdriver(src)
	new /obj/item/stack/cable_coil/five(src)
	new /obj/item/defibrillator/loaded(src)
	new /obj/item/wallframe/defib_mount(src)

// MEDKIT VARIETY KIT

/obj/structure/closet/crate/medical/brigdoc/medkit
	name = "Medkit Variety Kit"

/obj/structure/closet/crate/medical/brigdoc/medkit/PopulateContents()
	new /obj/item/storage/firstaid/fire(src)
	new /obj/item/storage/firstaid/toxin(src)
	new /obj/item/storage/firstaid/brute(src)
	new /obj/item/storage/firstaid/o2(src)

// STRANGE REAGENT KIT

/obj/structure/closet/crate/medical/brigdoc/strange_reagent
	name = "Strange Reagent Kit"

/obj/structure/closet/crate/medical/brigdoc/strange_reagent/PopulateContents()
	new /obj/item/paper/fluff/strange_reagent_and_you(src)
	new /obj/item/storage/pill_bottle/strange_reagent(src)

// The pill bottle

/obj/item/storage/pill_bottle/strange_reagent
	name = "bottle of strange reagent pills"
	desc = "Contains pills, used to bring patients back to life with a very special and rare chemical."

/obj/item/storage/pill_bottle/strange_reagent/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/strange_reagent(src)

// ...And the pill itself.

/obj/item/reagent_containers/pill/strange_reagent
	name = "strange reagent pill"
	desc = "Used to bring back people from the dead through holy means."
	list_reagents = list(/datum/reagent/medicine/strange_reagent = 2)
	icon_state = "pill22"
	rename_with_volume = TRUE

// CHEMICAL KIT

/obj/structure/closet/crate/medical/brigdoc/chemical
	name = "Chemical Kit"

/obj/structure/closet/crate/medical/brigdoc/chemical/PopulateContents()
	new /obj/item/paper/fluff/help_how_do_i_chemical_kit(src)
	new /obj/item/storage/box/brigdoc_chemical_kit(src)

/obj/item/storage/box/pillbottles/brigdoc_chemical_kit
	name = "chemical variety box"

/obj/item/storage/box/brigdoc_chemical_kit/PopulateContents()
	new /obj/item/storage/pill_bottle/paxpsych(src) // For the rowdy prisoners...
	new /obj/item/storage/pill_bottle/mannitol(src) // For the average security...
	new /obj/item/storage/pill_bottle/multiver(src) // For that one engi deputy...
	new /obj/item/storage/pill_bottle/potassiodide(src) // For that one engi deputy... again.
	new /obj/item/reagent_containers/hypospray/medipen/mutadone(src) // For those geneticists...
	new /obj/item/reagent_containers/hypospray/medipen/mutadone(src)
	new /obj/item/reagent_containers/glass/bottle/atropine(src) // And for emergencies.

/obj/item/stack/rods/two
	amount = 2

// Papers explaining what to do with the kits.

/obj/item/paper/fluff/help_how_do_i_chemical_kit
	name = "Chemical Kit Guide"
	desc = "A paper that details information related to the chemicals in the chemical variety box."
	info = {"
<h1>Chemical Variety Kit</h1>
<h2>Chemicals contained:</h2>
<p>Pax - Pacifies anyone who has it in their system. Use to neutralize possible hostile menaces without fear of them harming you. NOTE: Does not stop non-lethal attacks.</p>
<p>Mannitol - Used to heal brain damage. NOTE: Does NOT heal brain traumas.</p>
<p>Multiver - Treats toxin damage and purges chemicals. Does lung damage, with damage effect and purge effectiveness decreasing with the amounts of chemicals in the host.</p>
<p>Potassium Iodide - Heals low level of radiations, does not heal any toxin by itself.</p>
<p>Mutadone - Removes the host's mutations once its in the system.</p>
<p>Atropine - Heals all damage types rapidly if the host is in critical condition.</p>
</ol>
	"}

/obj/item/paper/fluff/surgery_ready_instructions_kit

/obj/item/paper/fluff/strange_reagent_and_you
