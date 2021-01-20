/obj/item/organ/cyberimp/arm/power_cord
	name = "power cord implant"
	desc = "An internal power cord hooked up to a battery. Useful if you run on volts."
	contents = newlist(/obj/item/apc_powercord)
	zone = "l_arm"

/obj/item/apc_powercord
	name = "power cord"
	desc = "An internal power cord hooked up to a battery. Useful if you run on electricity. Not so much otherwise."
	icon = 'icons/obj/power.dmi'
	icon_state = "wire1"

/obj/item/apc_powercord/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!istype(target, /obj/machinery/power/apc) || !ishuman(user) || !proximity_flag)
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)
	var/obj/machinery/power/apc/A = target
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/stomach/robot_ipc/cell = locate(/obj/item/organ/stomach/robot_ipc) in H.internal_organs
	if(!cell)
		to_chat(H, "<span class='warning'>You try to siphon energy from the [A], but your power cell is gone!</span>")
		return

	if(A.cell && A.cell.charge > 0)
		if(H.nutrition >= NUTRITION_LEVEL_WELL_FED)
			to_chat(user, "<span class='warning'>You are already fully charged!</span>")
			return
		else
			powerdraw_loop(A, H)
			return

	to_chat(user, "<span class='warning'>There is no charge to draw from that APC.</span>")

/obj/item/apc_powercord/proc/powerdraw_loop(obj/machinery/power/apc/A, mob/living/carbon/human/H)
	H.visible_message("<span class='notice'>[H] inserts a power connector into the [A].</span>", "<span class='notice'>You begin to draw power from the [A].</span>")
	while(do_after(H, 10, target = A))
		if(loc != H)
			to_chat(H, "<span class='warning'>You must keep your connector out while charging!</span>")
			break
		if(A.cell.charge == 0)
			to_chat(H, "<span class='warning'>The [A] doesn't have enough charge to spare.</span>")
			break
		A.charging = 1
		if(A.cell.charge >= 500)
			do_sparks(1, FALSE, A)
			H.nutrition += 50
			A.cell.charge -= 150
			to_chat(H, "<span class='notice'>You siphon off some of the stored charge for your own use.</span>")
		else
			H.nutrition += A.cell.charge/10
			A.cell.charge = 0
			to_chat(H, "<span class='notice'>You siphon off as much as the [A] can spare.</span>")
			break
		if(H.nutrition > NUTRITION_LEVEL_WELL_FED)
			to_chat(H, "<span class='notice'>You are now fully charged.</span>")
			break
	H.visible_message("<span class='notice'>[H] unplugs from the [A].</span>", "<span class='notice'>You unplug from the [A].</span>")
