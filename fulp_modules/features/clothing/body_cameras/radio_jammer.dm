/obj/item/jammer/disable_radios_on(atom/target, ignore_syndie = TRUE)
	. = ..()
	for(var/obj/item/bodycam_upgrade/bodycamera in target.get_all_contents() + target)
		bodycamera.turn_off()
