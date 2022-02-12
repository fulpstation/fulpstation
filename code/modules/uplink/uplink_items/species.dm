/datum/uplink_category/species
	name = "Species Restricted"
	weight = 1

/datum/uplink_item/species_restricted
	category = /datum/uplink_category/species
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/species_restricted/moth_lantern
	name = "Extra-Bright Lantern"
	desc = "We heard that moths such as yourself really like lamps, so we decided to grant you early access to a prototype \
	Syndicate brand \"Extra-Bright Lantern™\". Enjoy."
	cost = 2
	item = /obj/item/flashlight/lantern/syndicate
	restricted_species = list(SPECIES_MOTH)

/datum/uplink_item/race_restricted/syndibeefplushie
	name = "Living Beefplushie"
	desc = "A living beefplushie specimen. It looks very simmilar to a normal beefman plushie, use this to your advantage. Pet it to make the specimen produce the meat, \
	providing it has gotten time to get ready again. Upon investigating beefman origins, we stumbled upon a new method to effectively generate infinite meat. \
	With the help of cytology and beefman cells we managed to create specimens able to generate meat if given the time to produce it. \
	They are in very limited number however, so we are only distributing them to beefman operatives in hopes of getting the most use out of them."
	cost = 3
	item = /obj/item/toy/plush/beefplushie/living
	restricted_species = list(SPECIES_BEEFMAN)
