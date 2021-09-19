#define KIT_RECON "recon"
#define KIT_BLOODY_SPAI "bloodyspai"
#define KIT_STEALTHY "stealth"
#define KIT_SCREWED "screwed"
#define KIT_SABOTAGE "sabotage"
#define KIT_GUN "guns"
#define KIT_MURDER "murder"
#define KIT_IMPLANTS "implant"
#define KIT_HACKER "hacker"
#define KIT_SNIPER "sniper"
#define KIT_NUKEOPS_METAGAME "metaops"
#define KIT_LORD_SINGULOTH "lordsingulo"

#define KIT_JAMES_BOND "bond"
#define KIT_NINJA "ninja"
#define KIT_DARK_LORD "darklord"
#define KIT_WHITE_WHALE_HOLY_GRAIL "white_whale_holy_grail"
#define KIT_MAD_SCIENTIST "mad_scientist"
#define KIT_BEES "bee"
#define KIT_MR_FREEZE "mr_freeze"
#define KIT_TRAITOR_2006 "ancient"

/obj/item/storage/box/syndicate

/obj/item/storage/box/syndicate/bundle_a/PopulateContents()
	switch (pickweight(list(
		KIT_RECON = 2,
		KIT_BLOODY_SPAI = 3,
		KIT_STEALTHY = 2,
		KIT_SCREWED = 2,
		KIT_SABOTAGE = 3,
		KIT_GUN = 2,
		KIT_MURDER = 2,
		KIT_IMPLANTS = 1,
		KIT_HACKER = 3,
		KIT_SNIPER = 1,
		KIT_NUKEOPS_METAGAME = 1
		)))
		if(KIT_RECON)
			new /obj/item/clothing/glasses/thermal/xray(src) // ~8 tc?
			new /obj/item/storage/briefcase/launchpad(src) //6 tc
			new /obj/item/binoculars(src) // 2 tc?
			new /obj/item/encryptionkey/syndicate(src) // 2 tc
			new /obj/item/storage/box/syndie_kit/space(src) //4 tc
			new /obj/item/grenade/frag(src) // ~2 tc each?
			new /obj/item/grenade/frag(src)
			new /obj/item/flashlight/emp(src)

		if(KIT_BLOODY_SPAI)
			new /obj/item/card/id/advanced/chameleon(src) // 2 tc
			new /obj/item/clothing/under/chameleon(src) // 2 tc since it's not the full set
			new /obj/item/clothing/mask/chameleon(src) // Goes with above
			new /obj/item/clothing/shoes/chameleon/noslip(src) // 2 tc
			new /obj/item/camera_bug(src) // 1 tc
			new /obj/item/multitool/ai_detect(src) // 1 tc
			new /obj/item/encryptionkey/syndicate(src) // 2 tc
			new /obj/item/reagent_containers/syringe/mulligan(src) // 4 tc
			new /obj/item/switchblade(src) //I'll count this as 2 tc
			new /obj/item/storage/fancy/cigarettes/cigpack_syndicate (src) // 2 tc this shit heals
			new /obj/item/flashlight/emp(src) // 2 tc
			new /obj/item/chameleon(src) // 7 tc

		if(KIT_STEALTHY)
			new /obj/item/gun/energy/kinetic_accelerator/crossbow(src)
			new /obj/item/pen/sleepy(src)
			new /obj/item/healthanalyzer/rad_laser(src)
			new /obj/item/chameleon(src)
			new /obj/item/soap/syndie(src)
			new /obj/item/clothing/glasses/thermal/syndi(src)
			new /obj/item/flashlight/emp(src)
			new /obj/item/jammer(src)

		if(KIT_GUN)
			new /obj/item/gun/ballistic/revolver(src)
			new /obj/item/ammo_box/a357(src)
			new /obj/item/ammo_box/a357(src)
			new /obj/item/card/emag(src)
			new /obj/item/grenade/c4(src)
			new /obj/item/clothing/gloves/color/latex/nitrile(src)
			new /obj/item/clothing/mask/gas/clown_hat(src)
			new /obj/item/clothing/under/suit/black_really(src)

		if(KIT_SCREWED)
			new /obj/item/sbeacondrop/bomb(src)
			new /obj/item/grenade/syndieminibomb(src)
			new /obj/item/sbeacondrop/powersink(src)
			new /obj/item/clothing/suit/space/syndicate/black/red(src)
			new /obj/item/clothing/head/helmet/space/syndicate/black/red(src)
			new /obj/item/encryptionkey/syndicate(src)

		if(KIT_MURDER)
			new /obj/item/melee/energy/sword/saber(src)
			new /obj/item/clothing/glasses/thermal/syndi(src)
			new /obj/item/card/emag(src)
			new /obj/item/clothing/shoes/chameleon/noslip(src)
			new /obj/item/encryptionkey/syndicate(src)
			new /obj/item/grenade/syndieminibomb(src)

		if(KIT_IMPLANTS)
			new /obj/item/implanter/freedom(src)
			new /obj/item/implanter/uplink/precharged(src)
			new /obj/item/implanter/emp(src)
			new /obj/item/implanter/explosive(src)
			new /obj/item/implanter/storage(src)

		if(KIT_HACKER) //L-L--LOOK AT YOU, HACKER
			new /obj/item/ai_module/syndicate(src)
			new /obj/item/card/emag(src)
			new /obj/item/encryptionkey/binary(src)
			new /obj/item/ai_module/toy_ai(src)
			new /obj/item/multitool/ai_detect(src)
			new /obj/item/storage/toolbox/syndicate(src)
			new /obj/item/camera_bug(src)
			new /obj/item/clothing/glasses/thermal/syndi(src)
			new /obj/item/card/id/advanced/chameleon(src)

		if(KIT_LORD_SINGULOTH) //can't loose the goose anymore without SM :(
			new /obj/item/sbeacondrop(src)
			new /obj/item/clothing/suit/space/syndicate/black/red(src)
			new /obj/item/clothing/head/helmet/space/syndicate/black/red(src)
			new /obj/item/card/emag(src)
			new /obj/item/storage/toolbox/syndicate(src)
			new /obj/item/card/id/advanced/mining(src)
			new /obj/item/stack/spacecash/c10000(src)
			new /obj/item/toy/spinningtoy(src) //lol

		if(KIT_SABOTAGE)
			/obj/item/storage/backpack/duffelbag/syndie/sabotage
			new /obj/item/camera_bug(src)
			new /obj/item/sbeacondrop/powersink(src)
			new /obj/item/cartridge/virus/syndicate(src)
			new /obj/item/storage/toolbox/syndicate(src)
			new /obj/item/pizzabox/bomb(src)
			new /obj/item/storage/box/syndie_kit/emp(src)

		if(KIT_SNIPER) //This shit is unique so can't really balance it around tc, also no silencer because getting killed without ANY indicator on what killed you sucks
			new /obj/item/gun/ballistic/automatic/sniper_rifle(src) // 12 tc
			new /obj/item/ammo_box/magazine/sniper_rounds/penetrator(src)
			new /obj/item/clothing/glasses/thermal/syndi(src)
			new /obj/item/clothing/gloves/color/latex/nitrile(src)
			new /obj/item/clothing/mask/gas/clown_hat(src)
			new /obj/item/clothing/under/suit/black_really(src)

		if(KIT_NUKEOPS_METAGAME)
			new /obj/item/clothing/suit/space/hardsuit/syndi(src) // 8 tc
			new /obj/item/gun/ballistic/shotgun/bulldog/unrestricted(src) // 8 tc
			new /obj/item/implanter/explosive(src) // 2 tc
			new /obj/item/ammo_box/magazine/m12g(src) // 2 tc
			new /obj/item/ammo_box/magazine/m12g(src) // 2 tc
			new /obj/item/grenade/c4 (src) // 1 tc
			new /obj/item/grenade/c4 (src) // 1 tc
			new /obj/item/card/emag(src) // 4 tc
			new /obj/item/card/emag/doorjack(src) // 3 tc

/obj/item/storage/box/syndicate/bundle_b/PopulateContents()
	switch (pickweight(list(
		KIT_JAMES_BOND = 2,
		KIT_NINJA = 1,
		KIT_DARK_LORD = 1,
		KIT_WHITE_WHALE_HOLY_GRAIL = 2,
		KIT_MAD_SCIENTIST = 2,
		KIT_BEES = 1,
		KIT_MR_FREEZE = 2,
		KIT_TRAITOR_2006 = 1
		)))
		if(KIT_JAMES_BOND)
			new /obj/item/gun/ballistic/automatic/pistol(src)
			new /obj/item/suppressor(src)
			new /obj/item/ammo_box/magazine/m9mm(src)
			new /obj/item/ammo_box/magazine/m9mm(src)
			new /obj/item/card/id/advanced/chameleon(src)
			new /obj/item/clothing/under/chameleon(src)
			new /obj/item/reagent_containers/hypospray/medipen/stimulants(src)
			new /obj/item/reagent_containers/glass/rag(src)

		if(KIT_NINJA)
			new /obj/item/katana(src) // Unique , hard to tell how much tc this is worth. 8 tc?
			new /obj/item/reagent_containers/hypospray/medipen/stimulants(src) // 5 tc
			for(var/i in 1 to 6)
				new /obj/item/throwing_star(src) // ~5 tc for all 6
			new /obj/item/storage/belt/chameleon(src) // Unique but worth at least 2 tc
			new /obj/item/chameleon(src) // 7 tc
			new /obj/item/card/id/advanced/chameleon(src) // 2 tc

		if(KIT_DARK_LORD)
			new /obj/item/dualsaber(src)
			new /obj/item/dnainjector/telemut/darkbundle(src)
			new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
			new /obj/item/card/id/advanced/chameleon(src)
			new /obj/item/clothing/shoes/chameleon/noslip(src) //because slipping while being a dark lord sucks
			new /obj/item/book/granter/spell/summonitem(src)

		if(KIT_WHITE_WHALE_HOLY_GRAIL) //Unique items that don't appear anywhere else
			new /obj/item/gun/ballistic/rifle/boltaction/harpoon(src)
			new /obj/item/storage/bag/harpoon_quiver(src)
			new /obj/item/clothing/suit/space/hardsuit/carp(src)
			new /obj/item/clothing/mask/gas/carp(src)
			new /obj/item/grenade/spawnergrenade/spesscarp(src)

		if(KIT_MAD_SCIENTIST)
			new /obj/item/clothing/suit/toggle/labcoat/mad(src) // 0 tc
			new /obj/item/clothing/shoes/jackboots(src) // 0 tc
			new /obj/item/megaphone(src) // 0 tc
			new /obj/item/grenade/clusterbuster/random(src) // 10 tc?
			new /obj/item/grenade/clusterbuster/random(src) // 10 tc?
			new /obj/item/grenade/chem_grenade/bioterrorfoam(src) // 5 tc
			new /obj/item/assembly/signaler(src) // 0 tc
			new /obj/item/assembly/signaler(src) // 0 tc
			new /obj/item/assembly/signaler(src) // 0 tc
			new /obj/item/assembly/signaler(src) // 0 tc
			new /obj/item/storage/toolbox/syndicate(src) // 1 tc
			new /obj/item/pen/edagger(src)
			new /obj/item/gun/energy/wormhole_projector/core_inserted(src)
			new /obj/item/gun/energy/decloner/unrestricted(src)

		if(KIT_BEES)
			new /obj/item/paper/fluff/bee_objectives(src) // 0 tc (motivation)
			new /obj/item/clothing/suit/hooded/bee_costume(src) // 0 tc
			new /obj/item/clothing/mask/animal/rat/bee(src) // 0 tc
			new /obj/item/storage/belt/fannypack/yellow(src) // 0 tc
			new /obj/item/grenade/spawnergrenade/buzzkill(src)
			new /obj/item/grenade/spawnergrenade/buzzkill(src)
			new /obj/item/reagent_containers/glass/bottle/beesease(src) // 10 tc?
			new /obj/item/melee/beesword(src) //priceless

		if(KIT_MR_FREEZE)
			new /obj/item/clothing/glasses/cold(src)
			new /obj/item/clothing/gloves/color/black(src)
			new /obj/item/clothing/mask/chameleon(src)
			new /obj/item/clothing/suit/hooded/wintercoat(src)
			new /obj/item/clothing/shoes/winterboots(src)
			new /obj/item/grenade/gluon(src)
			new /obj/item/grenade/gluon(src)
			new /obj/item/grenade/gluon(src)
			new /obj/item/grenade/gluon(src)
			new /obj/item/dnainjector/geladikinesis(src)
			new /obj/item/dnainjector/cryokinesis(src)
			new /obj/item/gun/energy/temperature/security(src)
			new /obj/item/melee/energy/sword/saber/blue(src) //see see it fits the theme bc its blue and ice is blue

		if(KIT_TRAITOR_2006) //A kit so old, it's probably older than you. //This bundle is filled with the entire unlink contents traitors had access to in 2006, from OpenSS13. Notably the esword was not a choice but existed in code.
			new /obj/item/storage/toolbox/emergency/old/ancientbundle(src) //Items fit neatly into a classic toolbox just to remind you what the theme is.

/obj/item/storage/toolbox/emergency/old/ancientbundle/ //So the subtype works

/obj/item/storage/toolbox/emergency/old/ancientbundle/PopulateContents()
	new /obj/item/card/emag(src)
	new /obj/item/pen/sleepy(src)
	new /obj/item/reagent_containers/pill/cyanide(src)
	new /obj/item/chameleon(src) //its not the original cloaking device, but it will do.
	new /obj/item/gun/ballistic/revolver(src)
	new /obj/item/implanter/freedom(src)
	new /obj/item/stack/telecrystal(src) //The failsafe/self destruct isn't an item we can physically include in the kit, but 1 TC is technically enough to buy the equivalent.

/obj/item/storage/box/syndicate/contract_kit
	name = "Contract Kit"
	desc = "Supplied to Syndicate contractors."
	icon_state = "syndiebox"
	illustration = "writing_syndie"

/obj/item/storage/box/syndicate/contractor_loadout
	name = "Standard Loadout"
	desc = "Supplied to Syndicate contractors, providing their specialised space suit and chameleon uniform."
	icon_state = "syndiebox"
	illustration = "writing_syndie"

/obj/item/paper/contractor_guide
	name = "Contractor Guide"

/obj/item/paper/contractor_guide/Initialize()
	info = {"<p>Welcome agent, congratulations on your new position as contractor. On top of your already assigned objectives,
			this kit will provide you contracts to take on for TC payments.</p>

			<p>Provided within, we give your specialist contractor space suit. It's even more compact, being able to fit into a pocket, and faster than the
			Syndicate space suit available to you on the uplink. We also provide your chameleon jumpsuit and mask, both of which can be changed
			to any form you need for the moment. The cigarettes are a special blend - it'll heal your injuries slowly overtime.</p>

			<p>Your standard issue contractor baton hits harder than the ones you might be used to, and likely be your go to weapon for kidnapping your
			targets. The three additional items have been randomly selected from what we had available. We hope they're useful to you for your mission.</p>

			<p>The contractor hub, available at the top right of the uplink, will provide you unique items and abilities. These are bought using Contractor Rep,
			with two Rep being provided each time you complete a contract.</p>

			<h3>Using the tablet</h3>
			<ol>
				<li>Open the Syndicate Contract Uplink program.</li>
				<li>Here, you can accept a contract, and redeem your TC payments from completed contracts.</li>
				<li>The payment number shown in brackets is the bonus you'll receive when bringing your target <b>alive</b>. You receive the
				other number regardless of if they were alive or dead.</li>
				<li>Contracts are completed by bringing the target to designated dropoff, calling for extraction, and putting them
				inside the pod.</li>
			</ol>

			<p>Be careful when accepting a contract. While you'll be able to see the location of the dropoff point, cancelling will make it
			unavailable to take on again.</p>
			<p>The tablet can also be recharged at any cell charger.</p>
			<h3>Extracting</h3>
			<ol>
				<li>Make sure both yourself and your target are at the dropoff.</li>
				<li>Call the extraction, and stand back from the drop point.</li>
				<li>If it fails, make sure your target is inside, and there's a free space for the pod to land.</li>
				<li>Grab your target, and drag them into the pod.</li>
			</ol>
			<h3>Ransoms</h3>
			<p>We need your target for our own reasons, but we ransom them back to your mission area once their use is served. They will return back
			from where you sent them off from in several minutes time. Don't worry, we give you a cut of what we get paid. We pay this into whatever
			ID card you have equipped, on top of the TC payment we give.</p>

			<p>Good luck agent. You can burn this document with the supplied lighter.</p>"}

	return ..()

/obj/item/storage/box/syndicate/contractor_loadout/PopulateContents()
	new /obj/item/clothing/head/helmet/space/syndicate/contract(src)
	new /obj/item/clothing/suit/space/syndicate/contract(src)
	new /obj/item/clothing/under/chameleon(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_syndicate(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/lighter(src)

/obj/item/storage/box/syndicate/contract_kit/PopulateContents()
	new /obj/item/modular_computer/tablet/syndicate_contract_uplink/preset/uplink(src)
	new /obj/item/storage/box/syndicate/contractor_loadout(src)
	new /obj/item/melee/baton/telescopic/contractor_baton(src)

	// All about 4 TC or less - some nukeops only items, but fit nicely to the theme.
	var/list/item_list = list(
		/obj/item/storage/backpack/duffelbag/syndie/x4,
		/obj/item/storage/box/syndie_kit/throwing_weapons,
		/obj/item/gun/syringe/syndicate,
		/obj/item/pen/edagger,
		/obj/item/pen/sleepy,
		/obj/item/flashlight/emp,
		/obj/item/reagent_containers/syringe/mulligan,
		/obj/item/clothing/shoes/chameleon/noslip,
		/obj/item/storage/firstaid/tactical,
		/obj/item/encryptionkey/syndicate,
		/obj/item/clothing/glasses/thermal/syndi,
		/obj/item/slimepotion/slime/sentience/nuclear,
		/obj/item/storage/box/syndie_kit/imp_radio,
		/obj/item/storage/box/syndie_kit/imp_uplink,
		/obj/item/clothing/gloves/krav_maga/combatglovesplus,
		/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot,
		/obj/item/reagent_containers/hypospray/medipen/stimulants,
		/obj/item/storage/box/syndie_kit/imp_freedom,
		/obj/item/toy/eightball/haunted
	)

	var/obj/item1 = pick_n_take(item_list)
	var/obj/item2 = pick_n_take(item_list)
	var/obj/item3 = pick_n_take(item_list)

	// Create two, non repeat items from the list.
	new item1(src)
	new item2(src)
	new item3(src)

	// Paper guide
	new /obj/item/paper/contractor_guide(src)

/obj/item/storage/box/syndie_kit
	name = "box"
	desc = "A sleek, sturdy box."
	icon_state = "syndiebox"
	illustration = "writing_syndie"

/obj/item/storage/box/syndie_kit/origami_bundle
	name = "origami kit"
	desc = "A box full of a number of rather masterfully engineered paper planes and a manual on \"The Art of Origami\"."

/obj/item/storage/box/syndie_kit/origami_bundle/PopulateContents()
	new /obj/item/book/granter/action/origami(src)
	for(var/i in 1 to 5)
		new /obj/item/paper(src)

/obj/item/storage/box/syndie_kit/imp_freedom
	name = "freedom implant box"

/obj/item/storage/box/syndie_kit/imp_freedom/PopulateContents()
	new /obj/item/implanter/freedom(src)

/obj/item/storage/box/syndie_kit/imp_microbomb
	name = "microbomb implant box"

/obj/item/storage/box/syndie_kit/imp_microbomb/PopulateContents()
	new /obj/item/implanter/explosive(src)

/obj/item/storage/box/syndie_kit/imp_macrobomb
	name = "macrobomb implant box"

/obj/item/storage/box/syndie_kit/imp_macrobomb/PopulateContents()
	new /obj/item/implanter/explosive_macro(src)

/obj/item/storage/box/syndie_kit/imp_uplink
	name = "uplink implant box"

/obj/item/storage/box/syndie_kit/imp_uplink/PopulateContents()
	new /obj/item/implanter/uplink(src)

/obj/item/storage/box/syndie_kit/bioterror
	name = "bioterror syringe box"

/obj/item/storage/box/syndie_kit/bioterror/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/syringe/bioterror(src)

/obj/item/storage/box/syndie_kit/clownpins
	name = "ultra hilarious firing pin box"

/obj/item/storage/box/syndie_kit/clownpins/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/firing_pin/clown/ultra(src)

/obj/item/storage/box/syndie_kit/imp_storage
	name = "storage implant box"

/obj/item/storage/box/syndie_kit/imp_storage/PopulateContents()
	new /obj/item/implanter/storage(src)

/obj/item/storage/box/syndie_kit/imp_stealth
	name = "stealth implant box"

/obj/item/storage/box/syndie_kit/imp_stealth/PopulateContents()
	new /obj/item/implanter/stealth(src)

/obj/item/storage/box/syndie_kit/imp_radio
	name = "syndicate radio implant box"

/obj/item/storage/box/syndie_kit/imp_radio/PopulateContents()
	new /obj/item/implanter/radio/syndicate(src)

/obj/item/storage/box/syndie_kit/space
	name = "boxed space suit and helmet"

/obj/item/storage/box/syndie_kit/space/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(/obj/item/clothing/suit/space/syndicate, /obj/item/clothing/head/helmet/space/syndicate))

/obj/item/storage/box/syndie_kit/space/PopulateContents()
	if(prob(50))
		new /obj/item/clothing/suit/space/syndicate/black/red(src) // Black and red is so in right now
		new /obj/item/clothing/head/helmet/space/syndicate/black/red(src)

	else
		new /obj/item/clothing/head/helmet/space/syndicate(src)
		new /obj/item/clothing/suit/space/syndicate(src)

/obj/item/storage/box/syndie_kit/emp
	name = "EMP kit"

/obj/item/storage/box/syndie_kit/emp/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/grenade/empgrenade(src)
	new /obj/item/implanter/emp(src)

/obj/item/storage/box/syndie_kit/chemical
	name = "chemical kit"

/obj/item/storage/box/syndie_kit/chemical/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 14

/obj/item/storage/box/syndie_kit/chemical/PopulateContents()
	new /obj/item/reagent_containers/glass/bottle/polonium(src)
	new /obj/item/reagent_containers/glass/bottle/venom(src)
	new /obj/item/reagent_containers/glass/bottle/fentanyl(src)
	new /obj/item/reagent_containers/glass/bottle/formaldehyde(src)
	new /obj/item/reagent_containers/glass/bottle/spewium(src)
	new /obj/item/reagent_containers/glass/bottle/cyanide(src)
	new /obj/item/reagent_containers/glass/bottle/histamine(src)
	new /obj/item/reagent_containers/glass/bottle/initropidril(src)
	new /obj/item/reagent_containers/glass/bottle/pancuronium(src)
	new /obj/item/reagent_containers/glass/bottle/sodium_thiopental(src)
	new /obj/item/reagent_containers/glass/bottle/coniine(src)
	new /obj/item/reagent_containers/glass/bottle/curare(src)
	new /obj/item/reagent_containers/glass/bottle/amanitin(src)
	new /obj/item/reagent_containers/syringe(src)

/obj/item/storage/box/syndie_kit/nuke
	name = "nuke core extraction kit"
	desc = "A box containing the equipment and instructions for extracting the plutonium cores of most Nanotrasen nuclear explosives."

/obj/item/storage/box/syndie_kit/nuke/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/nuke_core_container(src)
	new /obj/item/paper/guides/antag/nuke_instructions(src)

/obj/item/storage/box/syndie_kit/supermatter
	name = "supermatter sliver extraction kit"
	desc = "A box containing the equipment and instructions for extracting a sliver of supermatter."

/obj/item/storage/box/syndie_kit/supermatter/PopulateContents()
	new /obj/item/scalpel/supermatter(src)
	new /obj/item/hemostat/supermatter(src)
	new /obj/item/nuke_core_container/supermatter(src)
	new /obj/item/paper/guides/antag/supermatter_sliver(src)

/obj/item/storage/box/syndie_kit/tuberculosisgrenade
	name = "virus grenade kit"

/obj/item/storage/box/syndie_kit/tuberculosisgrenade/PopulateContents()
	new /obj/item/grenade/chem_grenade/tuberculosis(src)
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/hypospray/medipen/tuberculosiscure(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/glass/bottle/tuberculosiscure(src)

/obj/item/storage/box/syndie_kit/chameleon
	name = "chameleon kit"

/obj/item/storage/box/syndie_kit/chameleon/PopulateContents()
	new /obj/item/clothing/under/chameleon(src)
	new /obj/item/clothing/suit/chameleon(src)
	new /obj/item/clothing/gloves/chameleon(src)
	new /obj/item/clothing/shoes/chameleon(src)
	new /obj/item/clothing/glasses/chameleon(src)
	new /obj/item/clothing/head/chameleon(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/clothing/neck/chameleon(src)
	new /obj/item/storage/backpack/chameleon(src)
	new /obj/item/storage/belt/chameleon(src)
	new /obj/item/radio/headset/chameleon(src)
	new /obj/item/stamp/chameleon(src)
	new /obj/item/pda/chameleon(src)

//5*(2*4) = 5*8 = 45, 45 damage if you hit one person with all 5 stars.
//Not counting the damage it will do while embedded (2*4 = 8, at 15% chance)
/obj/item/storage/box/syndie_kit/throwing_weapons/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/throwing_star(src)
	for(var/i in 1 to 2)
		new /obj/item/paperplane/syndicate(src)
	new /obj/item/restraints/legcuffs/bola/tactical(src)
	new /obj/item/restraints/legcuffs/bola/tactical(src)

/obj/item/storage/box/syndie_kit/cutouts/PopulateContents()
	for(var/i in 1 to 3)
		new/obj/item/cardboard_cutout/adaptive(src)
	new/obj/item/toy/crayon/rainbow(src)

/obj/item/storage/box/syndie_kit/romerol/PopulateContents()
	new /obj/item/reagent_containers/glass/bottle/romerol(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/dropper(src)

/obj/item/storage/box/syndie_kit/ez_clean/PopulateContents()
	for(var/i in 1 to 3)
		new/obj/item/grenade/chem_grenade/ez_clean(src)

/obj/item/storage/box/hug/reverse_revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/reverse(src)

/obj/item/storage/box/syndie_kit/mimery/PopulateContents()
	new /obj/item/book/granter/spell/mimery_blockade(src)
	new /obj/item/book/granter/spell/mimery_guns(src)

/obj/item/storage/box/syndie_kit/centcom_costume/PopulateContents()
	new /obj/item/clothing/under/rank/centcom/officer(src)
	new /obj/item/clothing/shoes/sneakers/black(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/radio/headset/headset_cent/empty(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/storage/backpack/satchel(src)
	new /obj/item/pda/heads(src)
	new /obj/item/clipboard(src)

/obj/item/storage/box/syndie_kit/chameleon/broken/PopulateContents()
	new /obj/item/clothing/under/chameleon/broken(src)
	new /obj/item/clothing/suit/chameleon/broken(src)
	new /obj/item/clothing/gloves/chameleon/broken(src)
	new /obj/item/clothing/shoes/chameleon/noslip/broken(src)
	new /obj/item/clothing/glasses/chameleon/broken(src)
	new /obj/item/clothing/head/chameleon/broken(src)
	new /obj/item/clothing/mask/chameleon/broken(src)
	new /obj/item/clothing/neck/chameleon/broken(src)
	new /obj/item/storage/backpack/chameleon/broken(src)
	new /obj/item/storage/belt/chameleon/broken(src)
	new /obj/item/radio/headset/chameleon/broken(src)
	new /obj/item/stamp/chameleon/broken(src)
	new /obj/item/pda/chameleon/broken(src)
	// No chameleon laser, they can't randomise for //REASONS//

/obj/item/storage/box/syndie_kit/bee_grenades
	name = "buzzkill grenade box"
	desc = "A sleek, sturdy box with a buzzing noise coming from the inside. Uh oh."

/obj/item/storage/box/syndie_kit/bee_grenades/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/grenade/spawnergrenade/buzzkill(src)

/obj/item/storage/box/syndie_kit/sleepytime/PopulateContents()
	new /obj/item/clothing/under/syndicate/bloodred/sleepytime(src)
	new /obj/item/reagent_containers/food/drinks/mug/coco(src)
	new /obj/item/toy/plush/carpplushie(src)
	new /obj/item/bedsheet/syndie(src)

///Subtype for the sabotage bundle. Contains three C4, two X4 and 6 signalers
/obj/item/storage/backpack/duffelbag/syndie/sabotage

/obj/item/storage/backpack/duffelbag/syndie/sabotage/PopulateContents()
	new /obj/item/grenade/c4(src)
	new /obj/item/grenade/c4(src)
	new /obj/item/grenade/c4(src)
	new /obj/item/grenade/c4/x4(src)
	new /obj/item/grenade/c4/x4(src)
	new /obj/item/storage/box/syndie_kit/signaler(src)

/obj/item/storage/box/syndie_kit/signaler
	name = "signaler box"
	desc = "Contains everything an agent would need to remotely detonate their bombs."

/obj/item/storage/box/syndie_kit/signaler/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/assembly/signaler(src)

/obj/item/storage/box/syndie_kit/imp_deathrattle
	name = "deathrattle implant box"
	desc = "Contains eight linked deathrattle implants."

/obj/item/storage/box/syndie_kit/imp_deathrattle/PopulateContents()
	new /obj/item/implanter(src)

	var/datum/deathrattle_group/group = new

	var/implants = list()
	for(var/j in 1 to 8)
		var/obj/item/implantcase/deathrattle/case = new (src)
		implants += case.imp

	for(var/i in implants)
		group.register(i)
	desc += " The implants are registered to the \"[group.name]\" group."

#undef KIT_RECON
#undef KIT_BLOODY_SPAI
#undef KIT_STEALTHY
#undef KIT_SCREWED
#undef KIT_SABOTAGE
#undef KIT_GUN
#undef KIT_MURDER
#undef KIT_IMPLANTS
#undef KIT_HACKER
#undef KIT_SNIPER
#undef KIT_NUKEOPS_METAGAME
#undef KIT_LORD_SINGULOTH

#undef KIT_JAMES_BOND
#undef KIT_NINJA
#undef KIT_DARK_LORD
#undef KIT_WHITE_WHALE_HOLY_GRAIL
#undef KIT_MAD_SCIENTIST
#undef KIT_BEES
#undef KIT_MR_FREEZE
#undef KIT_TRAITOR_2006
