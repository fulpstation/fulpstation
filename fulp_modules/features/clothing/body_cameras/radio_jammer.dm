/obj/item/jammer/disable_radios_on(atom/target)
	. = ..()
	for(var/obj/item/bodycam_upgrade/bodycamera in target.get_all_contents() + target)
		bodycamera.turn_off()
