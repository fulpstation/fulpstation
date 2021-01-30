// This is the file for the small improvements I made to Minebots.
// It's meant to be fully modular and to be a good example of how to
// implement such modularity. Enjoy.

// Starting off by adding some stuff to the initial definition of minebots
/mob/living/simple_animal/hostile/mining_drone
	..()
	var/gpstag // Adding this here so it doesn't cause any issues later


// Making small changes to the Initialize() proc means that when it gets created, whatever is in
// here gets called. In this case, we give it a name with a serial number and a GPS signal!
/mob/living/simple_animal/hostile/mining_drone/Initialize()
	. = ..()  // This makes it so it does whatever the original Initialize() in the minebot.dm file does before anything that comes after this.
	name = "[name] #[rand(1,999)]"
	gpstag = name
	AddComponent(/datum/component/gps, gpstag)
	weather_immunities = list("ash") // Makes them ash-proof by default. This makes them more viable
	maxbodytemp = INFINITY // To avoid problems with temperature, since they're ash-proof.
	wanted_objects += /obj/item/stack/ore/bluespace_crystal

// Here I just made it so it would drop its ore on death, instead of not doing so for some reason.
/mob/living/simple_animal/hostile/mining_drone/death()
	DropOre()
	..()

// Lava-proofing Upgrade
/obj/item/mine_bot_upgrade/lavaproof
	name = "minebot lava-proofing upgrade"

/obj/item/mine_bot_upgrade/lavaproof/upgrade_bot(mob/living/simple_animal/hostile/mining_drone/M, mob/user)
	if ("lava" in M.weather_immunities)
		to_chat(user, "<span class='warning'>[M] already has lava-proof plating installed!</span>")
		return
	M.weather_immunities += list("lava")
	to_chat(user, "<span class='notice'>You apply the lava-proof plating on [M].</span>")
	qdel(src)


// Speed Upgrade
/obj/item/mine_bot_upgrade/speed
	name = "minebot speed upgrade"

/obj/item/mine_bot_upgrade/speed/upgrade_bot(mob/living/simple_animal/hostile/mining_drone/M, mob/user)
	if(M.cached_multiplicative_slowdown != 2.5)  //Checks for the current slowdown of the Minebot, to see if it's not different from the default value, which is 3.
		to_chat(user, "<span class='warning'>[M] already has a speed upgrade installed!</span>")
		return
	M.add_movespeed_modifier(/datum/movespeed_modifier/minebot_speedupgrade)  //This makes it so a normal miner would still go twice as fast, but this would still be a significant speed upgrade for the Minebots, going from a slowdown of 3 to a slowdown of 2.
	to_chat(user, "<span class='notice'>You apply the speed upgrade on [M].</span>")
	qdel(src)


// Name Change
/obj/item/mine_bot_upgrade/renaming
	name = "minebot reclassification board"
	desc = "A Minebot upgrade that allows you to rename your Minebot!"
	icon_state = "door_electronics"
	icon = 'icons/obj/module.dmi'

	var/being_used = FALSE

/obj/item/mine_bot_upgrade/renaming/attack(mob/living/simple_animal/hostile/mining_drone/M, mob/user)
	. = ..()
	if(being_used || !istype(M, /mob/living/simple_animal/hostile/mining_drone))
		return
	being_used = TRUE

	to_chat(user, "<span class='notice'>You start changing your Minebot's name...</span>")

	var/new_name = stripped_input(user, "What would you like your Minebot's new name to be?", "Input a name", M.real_name, MAX_NAME_LEN)

	if(!new_name || QDELETED(src) || QDELETED(M) || new_name == M.real_name || !M.Adjacent(user))
		being_used = FALSE
		return

	M.visible_message("<span class='notice'><span class='name'>[M]</span> has a new name, <span class='name'>[new_name]</span>.</span>", "<span class='notice'>Your old name of <span class='name'>[M.real_name]</span> fades away, and your new name <span class='name'>[new_name]</span> anchors itself in your mind.</span>")
	message_admins("[ADMIN_LOOKUPFLW(user)] used [src] on [ADMIN_LOOKUPFLW(M)], renaming them into [new_name].")
	var/datum/component/gps/gps = M.GetComponent(/datum/component/gps, M.gpstag) // This is how components work, but I was told there's better ways to do it with signals, might change it later, but hey, it works now at long last.
	gps.gpstag = "[new_name] - Minebot"

	// pass null as first arg to not update records or ID/PDA
	M.fully_replace_character_name(null, new_name)

	qdel(src)


// Here's the movespeed_modifier that goes for the minebot's speed upgrade
/datum/movespeed_modifier/minebot_speedupgrade
	variable = TRUE
	multiplicative_slowdown = -0.5


// Finally, here's how you add to the mining vendor for the new upgrade boards.
/obj/machinery/mineral/equipment_vendor/Initialize()
	var/current_minebot_ai_upgrade_index = 42 // To change if there's changes to the vendor, because I tried using Find() to find the position of it, but it doesn't work due to the use of new in front of the datum.
	prize_list.Insert(current_minebot_ai_upgrade_index,
		new /datum/data/mining_equipment("Minebot Lava-Proofing Upgrade",	/obj/item/mine_bot_upgrade/lavaproof,				     		750),
		new /datum/data/mining_equipment("Minebot Speed Upgrade",			/obj/item/mine_bot_upgrade/speed,								750),
		new /datum/data/mining_equipment("Minebot Renaming Board",	 		/obj/item/mine_bot_upgrade/renaming,							200)
	)
	. = ..() // This needs to be at the end, otherwise the icons of the stuff you add to the vendor won't display, they'll be drinking glasses instead.
