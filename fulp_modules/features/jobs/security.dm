/// Guns

/obj/item/gun/ballistic/automatic/pistol/security
	desc = "A small, easily concealable 9mm handgun, issued to Security personnel."
	mag_type = /obj/item/ammo_box/magazine/m9mm/rubber

/obj/item/gun/ballistic/automatic/pistol/aps/security
	desc = "An old Soviet machine pistol, repurposed to be used by high-ranking Security personnel. Uses special 9mm bullets only printed on Nanotrasen Security protolathes."
	mag_type = /obj/item/ammo_box/magazine/m9mm_aps/rubber

/// Magazines

/obj/item/ammo_box/magazine/m9mm/rubber
	name = "pistol magazine (9mm rubber)"
	icon_state = "9x19pH"
	desc = "A gun magazine. Loaded with rubber bullets, extremely effective at stopping someone non-lethally."
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_box/magazine/m9mm_aps/rubber
	name = "stechkin pistol magazine (9mm rubber)"
	icon_state = "9x19p-8"
	base_icon_state = "9x19p"
	ammo_type = /obj/item/ammo_casing/c9mm/aps_rubber
	max_ammo = 15
	caliber = CALIBER_9MM

/obj/item/ammo_box/magazine/m9mm_aps/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? "8" : "0"]"

/// Casings

/obj/item/ammo_casing/c9mm/aps_rubber
	name = "9mm special rubber bullet casing"
	desc = "A 9mm special rubber bullet casing."
	projectile_type = /obj/projectile/bullet/c9mm/aps_rubber

/obj/item/ammo_casing/c9mm/rubber
	name = "9mm rubber bullet casing"
	desc = "A 9mm rubber bullet casing."
	projectile_type = /obj/projectile/bullet/c9mm/rubber

/// Bullets

/obj/projectile/bullet/c9mm/aps_rubber
	name = "9mm special rubber bullet"
	damage = 3
	stamina = 20
	embedding = null

/obj/projectile/bullet/c9mm/rubber
	name = "9mm rubber bullet"
	damage = 5
	stamina = 30
	embedding = null

/// Locker initialize

/obj/structure/closet/secure_closet/security/Initialize()
	new /obj/item/ammo_box/magazine/m9mm/rubber(src)
	new /obj/item/ammo_box/magazine/m9mm/rubber(src)
	return ..()

/obj/structure/closet/secure_closet/warden/Initialize()
	new /obj/item/ammo_box/magazine/m9mm_aps/rubber(src)
	new /obj/item/ammo_box/magazine/m9mm_aps/rubber(src)
	return ..()

/// Outfit overwrite

/datum/outfit/job/security
	uniform = /obj/item/clothing/under/rank/security/officer/beatcop
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	suit_store = /obj/item/gun/ballistic/automatic/pistol/security
	belt = /obj/item/modular_computer/tablet/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/police/security

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	l_pocket = /obj/item/ammo_box/magazine/m9mm/rubber
	r_pocket = /obj/item/restraints/handcuffs

/datum/outfit/job/warden
	uniform = /obj/item/clothing/under/rank/security/officer/beatcop
	suit = /obj/item/clothing/suit/armor/vest/warden
	suit_store = /obj/item/gun/ballistic/automatic/pistol/aps/security
	head = /obj/item/clothing/head/helmet/police/security

	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/ammo_box/magazine/m9mm_aps/rubber

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/datum/outfit/job/hos
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	suit = /obj/item/clothing/suit/armor/vest/hos_police
	suit_store = /obj/item/gun/ballistic/shotgun/riot
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/storage/box/rubbershot = 1,
		)
	head = /obj/item/clothing/head/hos/beret
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/// Clothes

/obj/item/clothing/head/helmet/police/security
	name = "police officer's hat"
	desc = "A police officer's Hat. This hat emphasizes that you are THE LAW."
	icon_state = "policecap_families"
	inhand_icon_state = "policecap_families"
	flags_inv = NONE

/obj/item/clothing/suit/armor/vest/hos_police
	name = "tactical armor vest"
	desc = "A set of the finest mass produced, stamped plasteel armor plates, containing an environmental protection unit for all-condition door kicking."
	icon_state = "marine_command"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 70, ACID = 90, WOUND = 10)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	strip_delay = 80
