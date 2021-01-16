/obj/item/documents
	name = "secret documents"
	desc = "\"Top Secret\" documents."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "docs_generic"
	inhand_icon_state = "paper"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 1
	throw_speed = 1
	layer = MOB_LAYER
	pressure_resistance = 2
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/documents/nanotrasen
	desc = "\"Top Secret\" Nanotrasen documents, filled with complex diagrams and lists of names, dates and coordinates."
	icon_state = "docs_verified"

/obj/item/documents/syndicate
	desc = "\"Top Secret\" documents detailing sensitive Syndicate operational intelligence."

/obj/item/documents/syndicate/red
	name = "red secret documents"
	desc = "\"Top Secret\" documents detailing sensitive Syndicate operational intelligence. These documents are verified with a red wax seal."
	icon_state = "docs_red"

/obj/item/documents/syndicate/blue
	name = "blue secret documents"
	desc = "\"Top Secret\" documents detailing sensitive Syndicate operational intelligence. These documents are verified with a blue wax seal."
	icon_state = "docs_blue"

/obj/item/documents/syndicate/mining
	desc = "\"Top Secret\" documents detailing Syndicate plasma mining operations."

/obj/item/documents/photocopy
	desc = "A copy of some top-secret documents. Nobody will notice they aren't the originals... right?"
	var/forgedseal = 0
	var/copy_type = null

/obj/item/documents/photocopy/New(loc, obj/item/documents/copy=null)
	..()
	if(copy)
		copy_type = copy.type
		if(istype(copy, /obj/item/documents/photocopy)) // Copy Of A Copy Of A Copy
			var/obj/item/documents/photocopy/C = copy
			copy_type = C.copy_type

/obj/item/documents/photocopy/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/toy/crayon/red) || istype(O, /obj/item/toy/crayon/blue))
		if (forgedseal)
			to_chat(user, "<span class='warning'>You have already forged a seal on [src]!</span>")
		else
			var/obj/item/toy/crayon/C = O
			name = "[C.crayon_color] secret documents"
			icon_state = "docs_[C.crayon_color]"
			forgedseal = C.crayon_color
			to_chat(user, "<span class='notice'>You forge the official seal with a [C.crayon_color] crayon. No one will notice... right?</span>")
			update_icon()

/obj/item/inspector
	name = "in-spect scanner"
	desc = "Cental commmand issued inspection device. Does company grade station inspection protocols when activated, and prints encripted sheets of paper regarding the mainenance of the station. Hard to Replace."
	icon = 'icons/obj/device.dmi'
	icon_state = "inspector"
	worn_icon_state = "salestagger"
	inhand_icon_state = "electronic"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 1
	throw_speed = 1

/obj/item/inspector/attack(mob/living/M, mob/living/user)
	. = ..()
	print_report()

/obj/item/inspector/attack_self(mob/user)
	. = ..()
	print_report()

///Prints out a report for bounty purposes, and plays a short audio blip.
/obj/item/inspector/proc/print_report()
	// Create our report
	var/obj/item/report/slip = new(get_turf(src))
	slip.scanned_area = get_area(src)
	playsound(src, 'sound/items/biddledeep.ogg', 50, FALSE)

/obj/item/report
	name = "encrypted station inspection"
	desc = "Contains detailed information about the station's current status, too bad you can't really read it. You can almost make out some of the words..."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "slipfull"
	///What area the inspector scanned when the report was made. Used to verify the security bounty.
	var/area/scanned_area

/obj/item/report/examine_more(mob/user)
	. = ..()
	var/list/msg = list("<span class='notice'><i>You examine [src] closer, and note the following...</i></span>")
	if(scanned_area?.name)
		msg += "\the [src] contains data on [scanned_area.name]."
	else if(scanned_area)
		msg += "\the [src] contains data on an vague area on station, you should throw it away."
	else
		msg += "Wait a minute, this thing's blank! You should throw it away."
	return msg
