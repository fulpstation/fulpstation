/mob/living/silicon/ai/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	if(stat != DEAD)
		if(lacks_power() && apc_override) //Placing this in Login() in case the AI doesn't have this link for whatever reason.
<<<<<<< HEAD
			to_chat(usr, "[span_warning("Main power is unavailable, backup power in use. Diagnostics scan complete.")] <A HREF='?src=[REF(src)];emergencyAPC=[TRUE]'>Local APC ready for connection.</A>")
=======
			to_chat(usr, "[span_warning("Main power is unavailable, backup power in use. Diagnostics scan complete.")] <A href='byond://?src=[REF(src)];emergencyAPC=[TRUE]'>Local APC ready for connection.</A>")
>>>>>>> 8d3e51612bd571ed06509813a57dacb56807af50
	set_eyeobj_visible(TRUE)
	if(multicam_on)
		end_multicam()
	view_core()
