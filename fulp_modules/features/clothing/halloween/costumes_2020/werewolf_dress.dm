//Vae's Costumes

//--Suits, hardsuits, jackets, bodyarmor and others
/obj/item/clothing/suit/werewolfdress
	name = "Werewolf's dress"
	desc = "A simple dress worn by the last werewolf in Japan. Smells faintly of bamboo and fish."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/werewolfdress_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/werewolfdress_worn.dmi'
	icon_state = "werewolfdress_suit"

//--Box that contains the costumes
/obj/item/storage/box/halloween/edition_20/werewolfdress
	theme_name = "2020's Kagerou's dress"
	illustration = "werewolf"

/obj/item/storage/box/halloween/edition_20/werewolfdress/PopulateContents()
	new /obj/item/clothing/suit/werewolfdress(src)
	new /obj/item/stack/sheet/mineral/bamboo(src)
	new /obj/item/toy/plush/carpplushie(src)
