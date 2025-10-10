// THIS IS ALL COPIED FROM WIKI BOOKS, PLEASE KEEP IT COMPATIBLE WITH IT.


/// The size of the window that the wiki books open in.
#define BOOK_WINDOW_BROWSE_SIZE "970x710"
/// This macro will resolve to code that will open up the associated wiki page in the window.
#define WIKI_PAGE_IFRAME(wikiurl, link_identifier) {"
	<html>
	<head>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<style>
		iframe {
			display: none;
		}
	</style>
	</head>
	<body>
	<script type="text/javascript">
		function pageloaded(myframe) {
			document.getElementById("loading").style.display = "none";
			myframe.style.display = "inline";
	}
	</script>
	<p id='loading'>You start skimming through the manual...</p>
	<iframe width='100%' height='97%' onload="pageloaded(this)" src="[##wikiurl]/[##link_identifier]?printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
	</body>
	</html>
	"}

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

#undef BOOK_WINDOW_BROWSE_SIZE
#undef WIKI_PAGE_IFRAME
