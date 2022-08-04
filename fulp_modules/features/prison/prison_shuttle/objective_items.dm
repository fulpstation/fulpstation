/**
 * Mail shuttle
 */

// PAPER
/obj/item/paper/prison_paperwork/Initialize(mapload)
	info = pick(GLOB.important_prison_messages)
	. = ..()
	stamp(rand(0, 400), rand(0, 500), rand(0, 360), "paper_stamp-centcom")

// MAIL
/obj/item/mail/junkmail/prison/junk_mail()
	color = pick(department_colors)
	name = "important [initial(name)]"
	new /obj/item/paper/prison_paperwork(src)
	return TRUE

// MAIL BIN
/obj/structure/closet/crate/mail/prison/populate()
	return
/obj/structure/closet/crate/mail/prison/PopulateContents()
	. = ..()
	var/important_mail_placed = FALSE
	for(var/i in 1 to 15)
		if(prob(20 && !important_mail_placed))
			new /obj/item/mail/junkmail/prison(src)
			important_mail_placed = TRUE
		else
			new /obj/item/mail/junkmail(src)
	if(!important_mail_placed)
		new /obj/item/mail/junkmail/prison(src)
