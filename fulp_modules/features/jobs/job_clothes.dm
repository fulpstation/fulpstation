/obj/item/clothing/under/plasmaman/engineering/signal_tech
	name = "network admins plasma envirosuit"
	desc = "An air-tight suit designed to be used by plasmamen employed as network admins, \
		the usual purple stripes being replaced by a unique bright green. It protects the user from fire and acid damage."
	icon = 'fulp_modules/icons/clothing/obj/plasmaman.dmi'
	worn_icon = 'fulp_modules/icons/clothing/mob/plasmaman.dmi'
	icon_state = "signal_tech_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/engineering/signal_tech
	name = "network admin's plasma envirosuit helmet"
	desc = "A space-worthy helmet specially designed for network admin plasmamen, the usual purple stripes being replaced by a unique bright green."
	icon = 'fulp_modules/icons/clothing/obj/plasmaman_hats.dmi'
	worn_icon = 'fulp_modules/icons/clothing/mob/plasmaman_head.dmi'
	icon_state = "signal_tech_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/under/rank/engineering/signal_tech
	name = "network admin's jumpsuit"
	desc = "It's an orange high visibility jumpsuit with green stripes worn by network admins. Made from fire resistant materials."
	icon = 'fulp_modules/icons/clothing/obj/engineering.dmi'
	worn_icon = 'fulp_modules/icons/clothing/mob/engineering.dmi'
	icon_state = "signal_tech"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/hooded/wintercoat/engineering/signal_tech
	name = "network admin's winter coat"
	desc = "A surprisingly heavy yellow winter coat with reflective green stripes. It has a small antennae for its zipper tab, and the inside layer is covered with a radiation-resistant silver-nylon blend. Because heat insulation is clearly not a priority."
	icon = /obj/item/clothing/suit/hooded/wintercoat/security/pris::icon
	worn_icon = /obj/item/clothing/suit/hooded/wintercoat/security/pris::worn_icon
//	lefthand_file = /obj/item/clothing/suit/hooded/wintercoat/security/pris::lefthand_file -- //NETWORK ADMIN TODO: Add Lefthand icons
//	righthand_file = /obj/item/clothing/suit/hooded/wintercoat/security/pris::righthand_file -- //NETWORK ADMIN TODO: Add Righthand icons
	icon_state = "coat_signal_tech"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering/signal_tech

/obj/item/clothing/head/hooded/winterhood/engineering/signal_tech
	desc = "A yellow winter coat hood. Definitely not enough to keep you warm near the telecommunications servers."
	icon = /obj/item/clothing/head/hooded/winterhood/fulp/security/pris::icon
	worn_icon = /obj/item/clothing/head/hooded/winterhood/fulp/security/pris::worn_icon
	icon_state = "winterhood_signal_tech"

/obj/item/radio/headset/headset_network
	name = "network admins radio headset"
	desc = "When the half-engineer half-scientist wishes to chat to people."
	icon_state = "eng_headset"
	keyslot = /obj/item/encryptionkey/headset_eng

/* Not needed because they don't have science radio here.
/obj/item/encryptionkey/headset_net
	name = "network admin's radio encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/headset_eng"
	post_init_icon_state = "cypherkey_engineering"
	channels = list(RADIO_CHANNEL_ENGINEERING = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_engineering
	greyscale_colors = "#f8d860#dca01b"
*/
