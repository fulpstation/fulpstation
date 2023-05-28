#define HUNTER_SCAN_MIN_DISTANCE 8
#define HUNTER_SCAN_MAX_DISTANCE 15
/// 5s update time
#define HUNTER_SCAN_PING_TIME 20

/datum/antagonist/monsterhunter
	name = "\improper Monster Hunter"
	roundend_category = "Monster Hunters"
	antagpanel_category = "Monster Hunter"
	job_rank = ROLE_MONSTERHUNTER
	antag_hud_name = "obsessed"
	preview_outfit = /datum/outfit/monsterhunter
	var/list/datum/action/powers = list()
	var/give_objectives = TRUE
	///how many rabbits have we found
	var/rabbits_spotted = 0
	///the list of white rabbits
	var/list/obj/effect/client_image_holder/white_rabbit/rabbits = list()
	///the red card tied to this trauma if any
	var/obj/item/rabbit_locator/locator
	tip_theme = "spookyconsole"
	antag_tips = list(
		"You are the Monster Hunter, hired to rid this station of several troublesome creatures.",
		"The contract paper provided to you details all the tasks our anonymous employers paid us to complete.",
		"On this station are five white rabbits only you can see, use the accursed queen card to track them down!",
		"One of the rabbits will provide you the gateway to Wonderland.",
		"You can upgrade your weapon in Wonderland by placing it on the weapon forge table and using a rabbit's eye on the table!",
		"Only when all the rabbits are found and the monsters are terminated can we unleash the apocalypse."
	)

/datum/antagonist/monsterhunter/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	ADD_TRAIT(current_mob, TRAIT_NOSOFTCRIT, BLOODSUCKER_TRAIT)
	ADD_TRAIT(current_mob, TRAIT_NOCRITDAMAGE, BLOODSUCKER_TRAIT)
	owner.unconvertable = TRUE

/datum/antagonist/monsterhunter/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	REMOVE_TRAIT(current_mob, TRAIT_NOSOFTCRIT, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(current_mob, TRAIT_NOCRITDAMAGE, BLOODSUCKER_TRAIT)
	owner.unconvertable = FALSE

/datum/antagonist/monsterhunter/on_gain()
	//Give Hunter Objective
	if(give_objectives)
		find_monster_targets()
	var/datum/map_template/wonderland/wonder = new()
	if(!wonder.load_new_z())
		message_admins("The wonderland failed to load.")
		CRASH("Failed to initialize wonderland!")

	//Teach Stake crafting
	owner.teach_crafting_recipe(/datum/crafting_recipe/hardened_stake)
	owner.teach_crafting_recipe(/datum/crafting_recipe/silver_stake)
	var/mob/living/carbon/criminal = owner.current
	var/obj/item/rabbit_locator/card = new(get_turf(criminal), src)
	var/list/slots = list ("backpack" = ITEM_SLOT_BACKPACK, "left pocket" = ITEM_SLOT_LPOCKET, "right pocket" = ITEM_SLOT_RPOCKET)
	if(!criminal.equip_in_one_of_slots(card, slots))
		var/obj/item/rabbit_locator/droppod_card = new()
		grant_drop_ability(droppod_card)
	var/obj/item/hunting_contract/contract = new(get_turf(criminal), src)
	if(!criminal.equip_in_one_of_slots(contract, slots))
		var/obj/item/hunting_contract/droppod_contract = new()
		grant_drop_ability(droppod_contract)
	RegisterSignal(src, COMSIG_GAIN_INSIGHT, PROC_REF(insight_gained))
	RegisterSignal(src, COMSIG_BEASTIFY, PROC_REF(turn_beast))
	for(var/i in 1 to 5 )
		var/turf/rabbit_hole = get_safe_random_station_turf()
		var/obj/effect/client_image_holder/white_rabbit/cretin =  new(rabbit_hole, owner.current)
		cretin.hunter = src
		rabbits += cretin
	var/obj/effect/client_image_holder/white_rabbit/mask_holder = pick(rabbits)
	var/obj/effect/client_image_holder/white_rabbit/gun_holder = pick(rabbits)
	mask_holder.drop_mask = TRUE
	gun_holder.drop_gun = TRUE

	return ..()

/datum/antagonist/monsterhunter/proc/grant_drop_ability(obj/item/tool)
	var/datum/action/droppod_item/summon_contract = new(tool)
	if(istype(tool, /obj/item/rabbit_locator))
		var/obj/item/rabbit_locator/locator = tool
		locator.hunter = src
	if(istype(tool, /obj/item/hunting_contract))
		var/obj/item/hunting_contract/contract = tool
		contract.owner = src
	summon_contract.Grant(owner.current)


/datum/antagonist/monsterhunter/on_removal()
	UnregisterSignal(src, COMSIG_GAIN_INSIGHT)
	UnregisterSignal(src, COMSIG_BEASTIFY)
	for(var/obj/effect/client_image_holder/white_rabbit/white as anything in rabbits)
		rabbits -= white
		qdel(white)
	if(locator)
		locator.hunter = null
	locator = null
	to_chat(owner.current, span_userdanger("Your hunt has ended: You enter retirement once again, and are no longer a Monster Hunter."))
	return ..()


/datum/antagonist/monsterhunter/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	for(var/datum/action/all_powers as anything in powers)
		all_powers.Remove(old_body)
		all_powers.Grant(new_body)

/datum/antagonist/monsterhunter/get_preview_icon()
	var/mob/living/carbon/human/dummy/consistent/hunter = new
	var/icon/white_rabbit = icon('fulp_modules/features/antagonists/monster_hunter/icons/rabbit.dmi', "white_rabbit")
	var/icon/red_rabbit = icon('fulp_modules/features/antagonists/monster_hunter/icons/rabbit.dmi', "killer_rabbit")
	var/icon/hunter_icon = render_preview_outfit(/datum/outfit/monsterhunter, hunter)

	var/icon/final_icon = hunter_icon
	white_rabbit.Shift(EAST,8)
	white_rabbit.Shift(NORTH,18)
	red_rabbit.Shift(WEST,8)
	red_rabbit.Shift(NORTH,18)
	red_rabbit.Blend(rgb(165, 165, 165, 165), ICON_MULTIPLY)
	white_rabbit.Blend(rgb(165, 165, 165, 165), ICON_MULTIPLY)
	final_icon.Blend(white_rabbit, ICON_UNDERLAY)
	final_icon.Blend(red_rabbit, ICON_UNDERLAY)

	final_icon.Scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)
	qdel(hunter)

	return finish_preview_icon(final_icon)

/datum/outfit/monsterhunter
	name = "Monster Hunter (Preview Only)"

	l_hand = /obj/item/knife/butcher
	mask = /obj/item/clothing/mask/monster_preview_mask
	uniform = /obj/item/clothing/under/suit/black
	suit =  /obj/item/clothing/suit/hooded/techpriest
	gloves = /obj/item/clothing/gloves/color/white

/// Mind version
/datum/mind/proc/make_monsterhunter()
	var/datum/antagonist/monsterhunter/monsterhunterdatum = has_antag_datum(/datum/antagonist/monsterhunter)
	if(!monsterhunterdatum)
		monsterhunterdatum = add_antag_datum(/datum/antagonist/monsterhunter)
		special_role = ROLE_MONSTERHUNTER
	return monsterhunterdatum

/datum/mind/proc/remove_monsterhunter()
	var/datum/antagonist/monsterhunter/monsterhunterdatum = has_antag_datum(/datum/antagonist/monsterhunter)
	if(monsterhunterdatum)
		remove_antag_datum(/datum/antagonist/monsterhunter)
		special_role = null

/// Called when using admin tools to give antag status
/datum/antagonist/monsterhunter/admin_add(datum/mind/new_owner, mob/admin)
	message_admins("[key_name_admin(admin)] made [key_name_admin(new_owner)] into [name].")
	log_admin("[key_name(admin)] made [key_name(new_owner)] into [name].")
	new_owner.add_antag_datum(src)

/// Called when removing antagonist using admin tools
/datum/antagonist/monsterhunter/admin_remove(mob/user)
	if(!user)
		return
	message_admins("[key_name_admin(user)] has removed [name] antagonist status from [key_name_admin(owner)].")
	log_admin("[key_name(user)] has removed [name] antagonist status from [key_name(owner)].")
	on_removal()

/datum/antagonist/monsterhunter/proc/add_objective(datum/objective/added_objective)
	objectives += added_objective

/datum/antagonist/monsterhunter/proc/remove_objectives(datum/objective/removed_objective)
	objectives -= removed_objective

/datum/antagonist/monsterhunter/greet()
	. = ..()
	to_chat(owner.current, span_userdanger("After witnessing recent events on the station, we return to your old profession, we are a Monster Hunter!"))
	to_chat(owner.current, span_announce("While we can kill anyone in our way to destroy the monsters lurking around, <b>causing property damage is unacceptable</b>."))
	to_chat(owner.current, span_announce("However, security WILL detain us if they discover our mission."))
	to_chat(owner.current, span_announce("In exchange for our services, it shouldn't matter if a few items are gone missing for our... personal collection."))
	owner.current.playsound_local(null, 'fulp_modules/features/antagonists/monster_hunter/sounds/monsterhunterintro.ogg', 100, FALSE, pressure_affected = FALSE)
	owner.announce_objectives()

/datum/antagonist/monsterhunter/proc/insight_gained()
	SIGNAL_HANDLER

	var/description
	var/datum/objective/assassinate/obj
	if(objectives.len)
		obj = pick(objectives)
	if(obj)
		var/datum/antagonist/heretic/heretic_target = IS_HERETIC(obj.target.current)
		if(heretic_target)
			description = "your target [heretic_target.owner.current.real_name] follows the [heretic_target.heretic_path], dear hunter."
		else
			description = "O' hunter, your target [obj.target.current.real_name] bears these lethal abilities:  "
			for(var/datum/action/ability in obj.target.current.actions)
				if(!ability)
					continue
				if(!istype(ability, /datum/action/changeling) && !istype(ability, /datum/action/cooldown/bloodsucker))
					continue
				description += "[ability.name], "

	rabbits_spotted++
	to_chat(owner.current,span_notice("[description]"))

/datum/antagonist/monsterhunter/proc/find_monster_targets()
	var/list/possible_targets = list()
	for(var/datum/antagonist/victim in GLOB.antagonists)
		if(!victim.owner)
			continue
		if(!victim.owner.current)
			continue
		if(victim.owner.current.stat == DEAD || victim.owner == owner)
			continue
		if(istype(victim, /datum/antagonist/changeling) || istype(victim, /datum/antagonist/heretic) || istype(victim, /datum/antagonist/bloodsucker))
			possible_targets += victim.owner

	for(var/i in 1 to 3) //we get 3 targets
		if(!(possible_targets.len))
			break
		var/datum/objective/assassinate/kill_monster = new
		kill_monster.owner = owner
		var/datum/mind/target = pick(possible_targets)
		possible_targets -= target
		kill_monster.target = target
		kill_monster.update_explanation_text()
		objectives += kill_monster


/datum/antagonist/monsterhunter/proc/turn_beast()
	SIGNAL_HANDLER
	var/datum/round_event_control/wonderlandapocalypse/invasion = new
	invasion.run_event()

/obj/item/clothing/mask/monster_preview_mask
	name = "Monster Preview Mask"
	worn_icon = 'fulp_modules/features/antagonists/monster_hunter/icons/worn_mask.dmi'
	worn_icon_state = "monoclerabbit"

/datum/action/droppod_item
	name = "Summon Monster Hunter tools"
	desc = "Summon specific monster hunter tools that will aid us with our hunt."
	button_icon = 'icons/obj/device.dmi'
	button_icon_state = "beacon"
	///path of item we are spawning
	var/item_path

/datum/action/droppod_item/New(obj/item/tool)
	. = ..()
	button_icon = tool.icon
	button_icon_state = tool.icon_state
	build_all_button_icons(UPDATE_BUTTON_ICON)
	item_path = tool

/datum/action/droppod_item/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	podspawn(list(
		"target" = get_turf(owner),
		"style" = STYLE_SYNDICATE,
		"spawn" = item_path,
		))
	qdel(src)
	return TRUE
