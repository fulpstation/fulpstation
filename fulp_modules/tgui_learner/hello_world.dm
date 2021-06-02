/obj/machinery/computer/my_machine
	name = "hello_world"
	var/ui_color = "green"

/obj/machinery/computer/my_machine/interact(mob/user, special_state)
	.=..()
	ui_interact(user,null)

/obj/machinery/computer/my_machine/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SampleInterface")
		ui.open()

/obj/machinery/computer/my_machine/ui_data(mob/living/user)
	var/list/data = list()
	data["health"] = user.bruteloss
	data["color"] = ui_color
	return data

/obj/machinery/computer/my_machine/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(action == "change_color")
		ui_color = params["color"]
		. = TRUE


	update_icon()
