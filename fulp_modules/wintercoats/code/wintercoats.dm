// This is a code file for everything to do with wintercoats made by fulp.
// The sprites will have credits next to each of their names, all code here is made by Homingpenguins, with some code stolen from Cosmic Phoenix.

/obj/item/clothing/suit/hooded/wintercoat/fulp //the baseline fulp wintercoat, so i dont have to repete the same exact lines every 5 seconds.
	name = "fulp"
	desc = "fulp"
	icon = 'fulp_modules/wintercoats/icons/wintercoats_icons.dmi'
	worn_icon = 'fulp_modules/wintercoats/icons/wintercoats.dmi'
	lefthand_file = 'fulp_modules/wintercoats/icons/wintercoat_lefthand.dmi'
	righthand_file = 'fulp_modules/wintercoats/icons/wintercoat_righthand.dmi'
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	strip_delay = 80 // Anti-ERP Technology
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp

//All head of staff wintercoats were made by Papaporo Paprito

/obj/item/clothing/head/hooded/winterhood/fulp
	worn_icon = 'fulp_modules/wintercoats/icons/wintercoats.dmi'
	icon = 'fulp_modules/wintercoats/icons/wintercoathoods.dmi'

/obj/item/clothing/suit/hooded/wintercoat/fulp/security/head
	name = "\improper head of security's winter coat"
	desc = "This is the Head of Security's personal winter coat. Although it looks like a normal coat, it actually has armor woven inside."
	icon_state = "wintercoat_hos"
	inhand_icon_state = "wintercoat_hos"
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 90) // Same as the HoS trench coat
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/security/head

/obj/item/clothing/head/hooded/winterhood/fulp/security/head
	icon_state = "winterhood_hos"

/obj/structure/closet/secure_closet/hos/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/security/head(src)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/head
	name = "\improper chief medical officer's winter coat"
	desc = "This is the Chief Medical Officer's personal winter coat."
	icon_state = "wintercoat_cmo"
	inhand_icon_state = "wintercoat_cmo"
	allowed = list(/obj/item/analyzer, /obj/item/sensor_device, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/assembly/flash/handheld)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50) // Same as CMO's labcoat.
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/medical/head

/obj/item/clothing/head/hooded/winterhood/fulp/medical/head
	icon_state = "winterhood_cmo"

/obj/structure/closet/secure_closet/chief_medical/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/medical/head(src)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/science/head
	name = "\improper research director's winter coat"
	desc = "This is the Research Director's personal winter coat."
	icon_state = "wintercoat_rd"
	inhand_icon_state = "wintercoat_rd"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/assembly/flash/handheld)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 10, "bio" = 40, "rad" = 0, "fire" = 40, "acid" = 40) // -10 from normal labcoat, +10 to bomb from Sci winter coat.
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/science/head

/obj/item/clothing/head/hooded/winterhood/fulp/science/head
	icon_state = "winterhood_rd"

/obj/structure/closet/secure_closet/research_director/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/science/head(src)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/engineering/head
	name = "\improper chief engineer's winter coat"
	desc = "This is the Chief Engineer's personal winter coat."
	icon_state = "wintercoat_ce"
	inhand_icon_state = "wintercoat_ce"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 40, "fire" = 30, "acid" = 45) // 20 extra rad protection. Why not?
	allowed = list(/obj/item/flashlight, /obj/item/assembly/flash/handheld, /obj/item/melee/classic_baton/telescopic, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/engineering/head

/obj/item/clothing/head/hooded/winterhood/fulp/engineering/head
	icon_state = "winterhood_ce"

/obj/structure/closet/secure_closet/engineering_chief/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/engineering/head(src)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/captain/hop
	name = "\improper head of personel's winter coat"
	desc = "This is the Head of Personel's personal winter coat. It has a small armor vest woven inside."
	icon_state = "wintercoat_hop"
	inhand_icon_state = "wintercoat_hop"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50) // Weaker armor vest. (-5% Melee, Bullet, Laser)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/captain/hop

/obj/item/clothing/head/hooded/winterhood/fulp/captain/hop
	icon_state = "winterhood_hop"

/obj/structure/closet/secure_closet/hop/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/captain/hop(src)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/cargo/head // :(
	name = "\improper quartermaster's cargo winter coat"
	desc = "It's just a regular cargo winter coat... it seems the Quarter Master still isn't a head of staff..."

/obj/structure/closet/secure_closet/quartermaster/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/cargo/head(src)
	. = ..()

//This starts normal job related wintercoats that TG decided not to put into the game
//The code here is purly mine, and the credits to the sprites go to diffrent people, if there isnt any credits beside the obj path, i made them.

/obj/item/clothing/suit/hooded/wintercoat/fulp/security/lawyer //credit to this wintercoat goes to Jo (not to be confused with beardless jo)
	name = "\improper lawyer's winter coat"
	desc = "This is a winter coat custom tailored for the lawyer."
	icon_state = "wintercoat_law"
	inhand_icon_state = "wintercoat_law"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/security/law

/obj/item/clothing/head/hooded/winterhood/fulp/security/law
	icon_state = "winterhood_law"

/obj/machinery/vending/wardrobe/law_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/security/lawyer = 2)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/service/bartender //credit to this wintercoat goes to YouTubeBoy
	name = "\improper bartender's winter coat"
	desc = "This is a winter coat made to look like a butler's suit."
	icon_state = "wintercoat_bar"
	inhand_icon_state = "wintercoat_bar"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/service/bar

/obj/item/clothing/head/hooded/winterhood/fulp/service/bar
	icon_state = "winterhood_bar"

/obj/machinery/vending/wardrobe/bar_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/service/bartender = 2)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/chem
	name = "\improper chemist's winter coat"
	desc = "This is a winter coat made to protect from minor chemical spills and to have a stylish orange theme."
	icon_state = "wintercoat_chem"
	inhand_icon_state = "wintercoat_chem"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/medical/chem

/obj/item/clothing/head/hooded/winterhood/fulp/medical/chem
	icon_state = "winterhood_chem"

/obj/machinery/vending/wardrobe/chem_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/chem = 3)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/gen //credit to this wintercoat goes to beardlessjoe (not to be confused with jo)
	name = "\improper geneticist's winter coat"
	desc = "This winter coat is made out of a comfortable material and dyed to the geneticist's color scheme."
	icon_state = "wintercoat_gen"
	inhand_icon_state = "wintercoat_gen"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/medical/gen

/obj/item/clothing/head/hooded/winterhood/fulp/medical/gen
	icon_state = "winterhood_gen"

/obj/machinery/vending/wardrobe/gene_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/gen = 3)
	. = ..()


/obj/item/clothing/suit/hooded/wintercoat/fulp/security/pris
	name = "\improper prisioner's winter coat"
	desc = "Made just for the times when the prison runs out of working space heaters."
	icon_state = "wintercoat_pris"
	inhand_icon_state = "wintercoat_pris"
	allowed = list(/obj/item/paper, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/security/pris

/obj/item/clothing/head/hooded/winterhood/fulp/security/pris
	icon_state = "winterhood_pris"

/obj/structure/closet/secure_closet/brig/Initialize()
	new /obj/item/clothing/suit/hooded/wintercoat/fulp/security/pris(src)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/para
	name = "\improper paramedic's winter coat"
	desc = "Comfy alternitive to the paramedic's vest."
	icon_state = "wintercoat_para"
	inhand_icon_state = "wintercoat_para"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/medical/para

/obj/item/clothing/head/hooded/winterhood/fulp/medical/para
	icon_state = "winterhood_para"

/obj/machinery/vending/wardrobe/medi_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/para = 3)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/service/chap
	name = "\improper chaplins's winter coat"
	desc = "Warm, Stylish, approved by the pope. Everything you need in a winter coat."
	icon_state = "wintercoat_chap"
	inhand_icon_state = "wintercoat_chap"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/service/chap

/obj/item/clothing/head/hooded/winterhood/fulp/service/chap
	icon_state = "winterhood_chap"

/obj/machinery/vending/wardrobe/chap_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/service/chap = 2)
	. = ..()

/*
/obj/item/clothing/suit/hooded/wintercoat/fulp/engineering/mech
	name = "\improper mechanicists's winter coat"
	desc = "A warm alternitive to the workers jumpsuit, it not only provides protection from explosions, but is also warm just in case you get spaced.."
	icon_state = "wintercoat_mech"
	inhand_icon_state = "wintercoat_mech"
	allowed = list()
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0,"energy" = 40, "bomb" = 20, "bio" = 0, "rad" = 20, "fire" = 30, "acid" = 80)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/engineering/mech

/obj/item/clothing/head/hooded/winterhood/fulp/engineering/mech
	icon_state = "winterhood_mech"
*/

/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/viro
	name = "\improper virologist's winter coat"
	desc = "forget the plain old labcoat, wear a work approved coat that still protects you while showing your job off."
	icon_state = "wintercoat_viro"
	inhand_icon_state = "wintercoat_viro"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/medical/viro

/obj/item/clothing/head/hooded/winterhood/fulp/medical/viro
	icon_state = "winterhood_viro"

/obj/machinery/vending/wardrobe/viro_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/viro = 2)
	. = ..()

/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/psych
	name = "\improper psychologist's winter coat"
	desc = "A simple white coat with a brown trim, perfect for its job. Just a tad bit resistant to chemicals."
	icon_state = "wintercoat_psych"
	inhand_icon_state = "wintercoat_psych"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 10)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/fulp/medical/psych

/obj/item/clothing/head/hooded/winterhood/fulp/medical/psych
	icon_state = "winterhood_viro"

/obj/machinery/vending/wardrobe/viro_wardrobe/Initialize()
	products += list(/obj/item/clothing/suit/hooded/wintercoat/fulp/medical/psych = 2)
	. = ..()
