/obj/item/organ/ears/robot_ipc
	name = "auditory sensors"
	icon = 'fulp_modules/ipc/icons/ipc_organs.dmi'
	icon_state = "ears-ipc"
	desc = "A pair of microphones intended to be installed in an IPC head, that grant the ability to hear."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EARS
	gender = PLURAL
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/ears/robot_ipc/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			owner.Jitter(30)
			owner.Dizzy(30)
			owner.Knockdown(80)
			deaf = 30
			to_chat(owner, "<span class='warning'>Your robotic ears are ringing, uselessly.</span>")
		if(2)
			owner.Jitter(15)
			owner.Dizzy(15)
			owner.Knockdown(40)
			to_chat(owner, "<span class='warning'>Your robotic ears buzz.</span>")
