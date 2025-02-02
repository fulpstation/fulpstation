/obj/item/book/manual/wiki/security_space_law
	page_link = "fulp_spacelaw"

/obj/item/book/manual/wiki/security_space_law/display_content(mob/living/user)
	var/wiki_url = "https://wiki.fulp.gg/en"
	if(!wiki_url)
		user.balloon_alert(user, "this book is empty!")
		return
	credit_book_to_reader(user)
	if(user.client.byond_version < 516) //Remove this once 516 is stable
		if(tgui_alert(user, "This book's page will open in your browser. Are you sure?", "Open The Wiki", list("Yes", "No")) != "Yes")
			return
		DIRECT_OUTPUT(user, link("[wiki_url]/[page_link]"))
	else
		DIRECT_OUTPUT(user, browse(WIKI_PAGE_IFRAME(wiki_url, page_link), "window=manual;size=[BOOK_WINDOW_BROWSE_SIZE]")) // if you change this GUARANTEE that it works.
