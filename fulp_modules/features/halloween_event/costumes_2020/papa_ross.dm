//--Papaporo Rossrito?
/obj/item/clothing/under/papa_ross
	name = "Bob Ross jumpsuit"
	desc = "We dont make mistakes. We just have happy accidents."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_worn.dmi'
	icon_state = "papa_ross_jumpsuit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = FEMALE_UNIFORM_FULL
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/head/papa_ross
	name = "Bob Ross wig"
	desc = "Thats a crooked tree. Well send him to Washington."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_worn.dmi'
	icon_state = "papa_ross_wig"
	flags_inv = HIDEHAIR
	dynamic_hair_suffix = "+generic"

/obj/item/clothing/suit/papa_ross
	name = "Bob Ross apron"
	desc = "This is the fun part. We take our brush, and beat the devil out of it."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_worn.dmi'
	icon_state = "papa_ross_apron"

/obj/item/clothing/neck/papa_ross_squirrel
	name = "Peapod the squirrel"
	desc = "This here is my little friend. His name is Peapod and he lives in my garden."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_worn.dmi'
	lefthand_file = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_inhand_left.dmi'
	righthand_file = 'fulp_modules/features/halloween_event/costumes_2020/papa_ross_inhand_right.dmi'
	icon_state = "ross_squirrel_left"
	inhand_icon_state = "ross_squirrel"
	var/flipped = FALSE

/obj/item/clothing/neck/papa_ross_squirrel/dropped()
	icon_state = "ross_squirrel_left"
	flipped = FALSE
	..()

/obj/item/clothing/neck/papa_ross_squirrel/verb/flipcap()
	set category = "Object"
	set name = "Flip Peapod"
	flip(usr)

/obj/item/clothing/neck/papa_ross_squirrel/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	else
		flip(user)

/obj/item/clothing/neck/papa_ross_squirrel/proc/flip(mob/user)
	if(!user.incapacitated())
		flipped = !flipped
		if(flipped)
			icon_state = "ross_squirrel_right"
			to_chat(user, "<span class='notice'>You moved Peapod to your right shoulder.</span>")
		else
			icon_state = "ross_squirrel_left"
			to_chat(user, "<span class='notice'>You moved Peapod to your left shoulder.</span>")
		usr.update_inv_neck()	//so our mob-overlays update

/obj/item/clothing/neck/papa_ross_squirrel/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click the hat to flip it [flipped ? "left" : "right"].</span>"

//--Box that contains the costumes
/obj/item/storage/box/halloween/edition_20/papa_ross
	theme_name = "2020's Bob Ross"
	illustration = "moth"

/obj/item/storage/box/halloween/edition_20/papa_ross/PopulateContents()
	new /obj/item/clothing/under/papa_ross(src)
	new /obj/item/clothing/head/papa_ross(src)
	new /obj/item/clothing/suit/papa_ross(src)
	new /obj/item/clothing/neck/papa_ross_squirrel(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/canvas/nineteen_nineteen(src)
