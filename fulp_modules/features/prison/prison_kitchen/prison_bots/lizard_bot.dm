/// Lizard bot
/datum/customer_data/xarsee
	prefix_file = "strings/names/lizard_male.txt" // I really can't be arsed.
	base_icon = "british"
	clothing_sets = list("iamnotreal")

	friendly_pull_line = "Ho. Uzhuer. Zoiz ukkooir!"
	first_warning_line = "Koazrosariuziksllizsss. Shri he ksak arih!"
	second_warning_line = "Huor zuaaro ze!"
	self_defense_line = "I al oh se ahoah!"
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/grown/korta_nut = 5,
			/obj/item/food/black_eggs = 4,
			/obj/item/food/lizard_dumplings = 4,
			/obj/item/food/breadslice/root = 4,
			/obj/item/food/bread/root = 3,
			/obj/item/food/sauerkraut = 3,
			/obj/item/food/patzikula = 3,
			/obj/item/food/nectar_larvae = 2,
		),
	)
	found_seat_lines = list(
		"I practice learn common just for here.",
		"Lakizusz he osriokso as hoekehossu.",
		"Ih ku uh sh eoz el is ih issrlehs?",
		"Heseauhulalleso kozua zohuol seu ieh. Loza.",
		"Salao el sko a re ok sk. Ksls ra hizuhsohzozsko olahaseskha oz?",
		"Ki szsisrs alhu hi ol ku li orihhsoh keikilhs sski. Eusuruh ul.",
	)
	cant_find_seat_lines = list(
		"Hope I not learn galactic for nothing.",
		"U ohukshussss sh zohi sazszaka ez. Szas?",
		"Eshoil heel er. Us. Li. Az kizsihehlisu ls shsosu s. A zi iri ihsshsrslik sk. Ak?",
		"Ekssiseh skrsslisarss ku ol ik ra slzszoezi.",
	)
	leave_mad_lines = list(
		"S. Aole hi sh ziuouzss liila az. Ise ss az ulssar.",
		"Sr reol re. Ilossaira ira re ahkash za su seikzsuh. Se slsk sa.",
		"U hi oh szukahu. La ruzu uk re urza ki ohikal. Kuoh. Sr ku sk le asu ehkolsrour i. Usra izuzro uor la.",
		"Azer i skls ih sh ke. Luiz aah hs su skzoiz. Ulshuss rele hs sl.",
		"Sl s akikha suizuz ok sh azos uhak el hsak kile.",
		"Do not worry, I come again soon.",
	)
	leave_happy_lines = list(
		"Aehzeurshreriku. Osalusesaku elsk koeszelo zs. Usz!",
		"Thank you for food good again!",
		"Ek sh u ks ek ko li okok hs sshsu ksulal us ho rs!",
		"Zo. Esik ur. Sozo rezs usaekuholss sri ikihaul see. Lu",
		"Usaozsrkiehur ze ri usho ss el ikzoleaaz!",
	)
	wait_for_food_lines = list(
		"Me... hungry...",
		"Sara ss sh kils. Hoisul.",
		"Ursr uikrelu ulekru se ki lauraror zu sz.",
		"Ze ul ih sekhu. Asl uul ki ehsa azorle az irihslailek ke eke ulhe ks alzo?",
		"Isosalo o hs sh uzs hi erlo kiuhi. Si oz el koreoh lo aska skkes ls aza a azsasos hoak ro i elsluorora i. As ku hihe uruu ziileks o li uss arazahu si. Hauz essu.",
		"Ssi uh ro laak skhuziksir zusz soreuzresl shza zisr. Sukialss.",
		"Laasou ok zszsal. Uzaalo aahzeheuz eh e kizo elheza orhuluhashzu. Ar ohs a.",
	)

/datum/customer_data/xarsee/get_overlays(mob/living/simple_animal/robot_customer/customer)
	var/list/underlays = list()
	var/mutable_appearance/lizard_clothes = mutable_appearance(icon = 'fulp_modules/features/prison/icons/bots.dmi', icon_state = "lizard_british")
	lizard_clothes.appearance_flags = RESET_COLOR
	underlays += lizard_clothes
	return underlays
