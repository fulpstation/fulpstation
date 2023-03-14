/obj/docking_port/mobile/monastery
	name = "monastery pod"
	shuttle_id = "mining_common" //set so mining can call it down
	launch_status = UNLAUNCHED //required for it to launch as a pod.

/obj/docking_port/mobile/monastery/on_emergency_dock()
	if(launch_status == ENDGAME_LAUNCHED)
		initiate_docking(SSshuttle.getDock("pod_away")) //docks our shuttle as any pod would
		mode = SHUTTLE_ENDGAME
