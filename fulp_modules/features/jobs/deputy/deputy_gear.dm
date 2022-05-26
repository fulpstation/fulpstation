#define ADD_STEAL_ITEM(Source, Type) GLOB.steal_item_handler.objectives_by_path[Type] += Source

/// Default Deputy
/datum/outfit/job/deputy
	name = "Deputy"
	jobtype = /datum/job/deputy

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/modular_computer/tablet/preset/advanced/security = 1,
	)

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/officer/mallcop
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/flashlight/seclite

	id_trim = /datum/id_trim/job/deputy
	box = /obj/item/storage/box/survival

/// Engineering Deputy
/datum/outfit/job/deputy/engineering
	name = "Deputy - Engineering"

	ears = /obj/item/radio/headset/headset_dep/engineering
	neck = /obj/item/clothing/neck/fulptie/engineering
	id_trim = /datum/id_trim/job/deputy/engineering
	accessory = /obj/item/clothing/accessory/armband/engine
	skillchips = list(/obj/item/skillchip/job/deputy/engineering)

/// Medical Deputy
/datum/outfit/job/deputy/medical
	name = "Deputy - Medical"

	ears = /obj/item/radio/headset/headset_dep/medical
	neck = /obj/item/clothing/neck/fulptie/medical
	id_trim = /datum/id_trim/job/deputy/medical
	accessory = /obj/item/clothing/accessory/armband/medblue
	skillchips = list(/obj/item/skillchip/job/deputy/medical)

/// Science Deputy
/datum/outfit/job/deputy/science
	name = "Deputy - Science"

	neck = /obj/item/clothing/neck/fulptie/science
	ears = /obj/item/radio/headset/headset_dep/science
	id_trim = /datum/id_trim/job/deputy/science
	accessory = /obj/item/clothing/accessory/armband/science
	skillchips = list(/obj/item/skillchip/job/deputy/science)

/// Supply Deputy
/datum/outfit/job/deputy/supply
	name = "Deputy - Supply"

	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	ears = /obj/item/radio/headset/headset_dep/supply
	neck = /obj/item/clothing/neck/fulptie/supply
	id_trim = /datum/id_trim/job/deputy/supply
	accessory = /obj/item/clothing/accessory/armband/cargo
	skillchips = list(/obj/item/skillchip/job/deputy/supply)

/// Service Deputy
/datum/outfit/job/deputy/service
	name = "Deputy - Service"

	//LOCKER EQUIPMENT: They don't get a locker, so spawn with it.
	head = /obj/item/clothing/head/fulpberet/service
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	gloves = /obj/item/clothing/gloves/color/black
	belt = /obj/item/storage/belt/security/deputy
	pda_slot = ITEM_SLOT_LPOCKET
	//END OF LOCKER EQUIPMENT

	ears = /obj/item/radio/headset/headset_dep/service
	neck = /obj/item/clothing/neck/fulptie/service
	id_trim = /datum/id_trim/job/deputy/service
	accessory = /obj/item/clothing/accessory/armband/hydro
	skillchips = list(/obj/item/skillchip/job/deputy/service)

/// Plasmamen Datum
/datum/outfit/plasmaman/deputy
	name = "Deputy Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/security/deputy
	uniform = /obj/item/clothing/under/plasmaman/security/deputy
	gloves = /obj/item/clothing/gloves/color/plasmaman/black

/// Shirt
/obj/item/clothing/under/rank/security/officer/mallcop
	name = "deputy shirt"
	desc = "An awe-inspiring tactical shirt-and-pants combo; because safety never takes a holiday."
	icon_state = "mallcop"
	icon = 'fulp_modules/features/jobs/icons/deputy_clothes.dmi'
	worn_icon = 'fulp_modules/features/jobs/icons/under_worn.dmi'

/obj/item/clothing/under/rank/security/officer/mallcop/skirt
	name = "deputy skirt"
	desc = "An awe-inspiring tactical shirt-and-skirt combo; because safety never takes a holiday."
	icon_state = "mallcop_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/// Ties
/obj/item/clothing/neck/fulptie
	name = "departmental tie"
	desc = "A tie showing off the department colors of a deputy."
	icon = 'fulp_modules/features/jobs/icons/ties_icons.dmi'
	worn_icon = 'fulp_modules/features/jobs/icons/ties_worn.dmi'
	icon_state = "supply_tie"
	inhand_icon_state = ""	//no inhands
	w_class = WEIGHT_CLASS_SMALL
	custom_price = PAYCHECK_EASY
	var/department

/obj/item/clothing/neck/fulptie/Initialize()
	. = ..()
	if(department)
		name = "[department] tie"
		desc = "A tie showing off that the user belongs to the [department] department."
		icon_state = "[department]_tie"

/obj/item/clothing/neck/fulptie/engineering
	department = "engineering"

/obj/item/clothing/neck/fulptie/medical
	department = "medical"

/obj/item/clothing/neck/fulptie/science
	department = "science"

/obj/item/clothing/neck/fulptie/supply
	department = "supply"

/obj/item/clothing/neck/fulptie/service
	department = "service"

/// Plasmamen clothes
/obj/item/clothing/under/plasmaman/security/deputy
	icon = 'fulp_modules/features/jobs/icons/deputy_clothes.dmi'
	worn_icon = 'fulp_modules/features/jobs/icons/under_worn.dmi'
	name = "deputy plasma envirosuit"
	desc = "A plasmaman containment suit designed for deputies, offering a limited amount of extra protection."
	icon_state = "deputy_envirosuit"
	inhand_icon_state = "deputy_envirosuit"

/obj/item/clothing/head/helmet/space/plasmaman/security/deputy
	icon = 'fulp_modules/features/jobs/icons/head_icons.dmi'
	worn_icon = 'fulp_modules/features/jobs/icons/head_worn.dmi'
	name = "deputy envirosuit helmet"
	desc = "A plasmaman containment helmet designed for deputies, protecting them from being flashed and burning alive, alongside other undesirables."
	icon_state = "deputy_envirohelm"
	inhand_icon_state = "deputy_envirohelm"

/// Berets
/obj/item/clothing/head/fulpberet
	worn_icon = 'fulp_modules/features/jobs/icons/head_worn.dmi'
	icon = 'fulp_modules/features/jobs/icons/head_icons.dmi'
	name = "generic deputy beret"
	desc = "You shouldn't be seeing this! File a bug report."
	icon_state = "beret_engi"
	resistance_flags = ACID_PROOF | FIRE_PROOF
	clothing_flags = SNUG_FIT //Prevents being knocked off

/obj/item/clothing/head/fulpberet/engineering
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 40, BIO = 100, FIRE = 100, ACID = 90, WOUND = 5) // CE level
	name = "engineering deputy beret"
	desc = "Perhaps the only thing standing between the supermatter and a station-wide explosive sabotage. Comes with radiation protection."
	icon_state = "beret_engi"

/obj/item/clothing/head/fulpberet/engineering/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/radiation_protected_clothing)

/obj/item/clothing/head/fulpberet/engineering/add_stealing_item_objective()
	ADD_STEAL_ITEM(src, /obj/item/clothing/head/fulpberet/engineering)

/obj/item/clothing/head/fulpberet/medical
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 10, BIO = 100, FIRE = 60, ACID = 75, WOUND = 5) // CMO level
	name = "medical deputy beret"
	desc = "This proud white-blue beret is a welcome sight when the greytide descends on chemistry, or just used as a bio hood."
	icon_state = "beret_medbay"

/obj/item/clothing/head/fulpberet/medical/add_stealing_item_objective()
	ADD_STEAL_ITEM(src, /obj/item/clothing/head/fulpberet/medical)

/obj/item/clothing/head/fulpberet/science
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 100, BIO = 100, FIRE = 60, ACID = 80, WOUND = 5) // RD level
	name = "science deputy beret"
	desc = "This loud purple beret screams 'Dont mess with his matter manipulator!'. Fairly bomb resistant."
	icon_state = "beret_science"

/obj/item/clothing/head/fulpberet/science/add_stealing_item_objective()
	ADD_STEAL_ITEM(src, /obj/item/clothing/head/fulpberet/science)

/obj/item/clothing/head/fulpberet/supply
	armor = list(MELEE = 20, BULLET = 60, LASER = 10, ENERGY = 10, BOMB = 30, BIO = 10, FIRE = 50, ACID = 60, WOUND = 5) /// Bulletproof helmet level
	name = "supply deputy beret"
	desc = "The headwear for only the most eagle-eyed Deputy, able to watch both Cargo and Mining. It looks like it's been reinforced due to 'Cargonian' problems."
	icon_state = "beret_supply"

/obj/item/clothing/head/fulpberet/supply/add_stealing_item_objective()
	ADD_STEAL_ITEM(src, /obj/item/clothing/head/fulpberet/supply)

/obj/item/clothing/head/fulpberet/service
	armor = list(MELEE = 40, BULLET = 50, LASER = 50, ENERGY = 60, BOMB = 50, BIO = 100, FIRE = 100, ACID = 100, WOUND = 15) // Captain level
	name = "service deputy beret"
	desc = "The beret of the one able to defeat the Chef in his own kitchen. Can be used to protect you against BEES."
	icon_state = "beret_service"
	clothing_flags = THICKMATERIAL | SNUG_FIT

/// Headsets - Base
/obj/item/radio/headset/headset_dep
	icon = 'fulp_modules/features/jobs/icons/radio.dmi'
	worn_icon = 'icons/mob/clothing/ears.dmi'
	worn_icon_state = "sec_headset_alt"

	name = "generic deputy headset"
	desc = "You shouldn't be seeing this! File a bug report."
	icon_state = "eng_headset"

/obj/item/radio/headset/headset_dep/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/// Engineering
/obj/item/radio/headset/headset_dep/engineering
	name = "engineering bowman headset"
	desc = "The best way to stay alert of any possible sabotage."
	icon_state = "eng_headset"
	keyslot = new /obj/item/encryptionkey/headset_eng

/// Medical
/obj/item/radio/headset/headset_dep/medical
	name = "medical bowman headset"
	desc = "Looks a little worn out from all the chemistry explosions."
	icon_state = "med_headset"
	keyslot = new /obj/item/encryptionkey/headset_med

/// Science
/obj/item/radio/headset/headset_dep/science
	name = "science bowman headset"
	desc = "Suddenly turns off when the Research Director starts yelling Malf."
	icon_state = "sci_headset"
	keyslot = new /obj/item/encryptionkey/headset_sci

/// Supply
/obj/item/radio/headset/headset_dep/supply
	name = "supply bowman headset"
	desc = "Looks half destroyed, probably from all the Cargonia attempts."
	icon_state = "cargo_headset"
	keyslot = new /obj/item/encryptionkey/headset_cargo

/// Service
/obj/item/radio/headset/headset_dep/service
	name = "service bowman headset"
	desc = "For the one constantly recieving calls from the Law office to Botany, Service comms are the most well organized."
	icon_state = "service_headset"
	keyslot = new /obj/item/encryptionkey/headset_service

/// Used for Science Deputies and Brig doctor's Chemical kit.
/obj/item/reagent_containers/hypospray/medipen/mutadone
	name = "mutadone medipen"
	desc = "Contains a chemical that will remove all of an injected target's mutations."
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	volume = 10
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/medicine/mutadone = 10)

/obj/item/storage/belt/security/deputy/PopulateContents()
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/holosign_creator/security(src)
	update_appearance()

#undef ADD_STEAL_ITEM
