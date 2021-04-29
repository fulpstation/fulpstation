/*
 * This file is overwriting TG's obj/item examine to expand existing capabilities
 *  > 'obj/items.dm'
 *
 */

/**
 *
 * Adds a Tag to Relevant Examined Objects
 *
 * Adds a tag to objects with a high enough force. This
 * tag hyperlinks to /obj/item/Topic , which details the
 * offensive capabilities of the examined item.
 * Arguments:
 * * mob/user: Unused
 *
 */

/obj/item/examine(mob/user)

	. = ..()

	if(force && force >= 5) /// Only show this tag for items that could feasibly be weapons
		. += "<span class='notice'>It has a <a href='?src=[REF(src)];examine=s'>tag</a> detailing its offensive capabilities.</span>"

/**
 *
 * Details the stats of the examined weapon
 *
 * This function is called when the user clicks the hyperlink in
 * /obj/item/examine. This function simply compiles some relevant
 * weapon data and outputs it to the user.
 * Arguments:
 *  * href - Unused
 *  * href-list - List provided by the href of input values, used to know an examination is being attempted
 */

/obj/item/Topic(href, href_list)
	if(href_list["examine"])
		/// Readout is used to store the text block output to the user so it all can be sent in one message
		var/readout = ""
		readout += "DMG: [force]\n"
		readout += uppertext("TYPE: [damtype]\n")
		readout += "TDMG: [throwforce]\n"
		readout += "AP: [armour_penetration]%\n"
		readout += "BLOC: [block_chance]%"
		to_chat(usr, "<span class='notice'>[readout]</span>")

