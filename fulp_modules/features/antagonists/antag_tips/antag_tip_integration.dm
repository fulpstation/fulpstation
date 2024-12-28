/datum/antagonist
	///The antag tip datum that holds our UI.
	var/datum/antag_tip/tips
	///Theme of the antag tip's UI.
	var/tip_theme = "ntos"
	///List of tips shown in the UI.
	var/list/antag_tips = list()

/datum/antagonist/on_gain()
	. = ..()
	if(silent || !antag_tips.len)
		return
	tips = new(name, tip_theme, antag_tips)
	add_verb(owner.current, /mob/living/proc/open_tips)
	if(!owner.current.client?.prefs?.read_preference(/datum/preference/toggle/antag_tips))
		return
	tips.ui_interact(owner.current)

/datum/antagonist/on_removal()
	if(tips)
		QDEL_NULL(tips)
	return ..()

/**
 * Open Tips
 *
 * Tied to the Mob, allows anyone to see their antag tips
 */
/mob/living/proc/open_tips()
	set name = "Open Antag tips"
	set category = "Mentor"

	var/list/datum/antagonist/antag_datum_list = list()

	for(var/datum/antagonist/antag_datum as anything in mind.antag_datums)
		if(isnull(antag_datum.antag_tips))
			continue
		antag_datum_list += antag_datum

	if(!antag_datum_list.len) //none? You shouldn't have this then.
		remove_verb(src, /mob/living/proc/open_tips)
		return
	if(antag_datum_list.len == 1) //only one? skip ui
		for(var/datum/antagonist/antag_datum as anything in antag_datum_list)
			antag_datum.tips.ui_interact(src)
			return

	var/choice = tgui_input_list(src, "What tips are we interested in?", "Antagonist tips", antag_datum_list)
	if(!choice)
		return
	var/datum/antagonist/chosen_datum = choice
	chosen_datum.tips.ui_interact(src)

/**
 * Antag Tip datum
 *
 * Holds the UI we will run to see our TGUI Antag tips.
 */
/datum/antag_tip
	///Name of the Antagonist, used in the UI's title
	var/name
	///Theme of the used UI
	var/theme
	///List of 'Antag tips' that is shown in the UI
	var/list/antag_tips = list()

/datum/antag_tip/New(name, tip_theme, list/antag_tips)
	. = ..()
	src.name = lowertext(name)
	src.theme = tip_theme
	src.antag_tips = antag_tips.Copy()

/datum/antag_tip/ui_state()
	return GLOB.always_state

/datum/antag_tip/ui_static_data(mob/user)
	var/list/data = ..()

	data["name"] = name
	data["theme"] = theme
	data["antag_tips"] = antag_tips

	return data

/datum/antag_tip/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/antagonists),
	)

/datum/antag_tip/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AntagTips", "[name] tips")
		ui.open()

/**
 * Antag tips that would be nice to have:
 * - Obsessed
 * - Blood Brother
 * - IAAs
 * - Infiltrators
 * - Thief
 */

/datum/antagonist/abductor
	tip_theme = "abductor"
	antag_tips = list(
		"You and your teammate have been chosen by the mothership to go and capture some humans.",
		"There's two of you: the scientist, who must oversee the camera and surgery, and the agent, who must go down on the station to stun and cuff people.",
		"The scientist must utilize his console and science tool, to scan disguises and scan the agent for retrieval if neccesary.",
		"The scientist must look for targets and send down the agent, after the target is captured the scientist must go down and use the science tool to mark the teleport target.",
		"After that, he must do the extraterrestrial experimental surgery, which doesn't require any clothing to be removed.",
		"The agent must be sent down by the scientist to stun and cuff a target and drag it into a hidden spot and wait for the scientist.",
	)

/datum/antagonist/changeling
	antag_tips = list(
		"You are a Changeling, a shapeshifting alien assuming the form of a crewmember on Space Station 13.",
		"You have the ability to take genomes, which serve as backup identities. To do this, you must take ANY human, and acquire their DNA through one of two methods.",
		"Use the DNA Extraction Sting and sting a target to stealthily steal their DNA.",
		"You can absorb humans to drain their DNA, husking them and draining them of fluids.",
		"Use the Cellular Emporium to acquire special abilities which will help you achieve your objectives.",
		"Absorbing a body will allow you to readapt and purchase different abilities.",
		"Although you are difficult to kill, stealth and deception is your friend. Be cautious: other changelings could have an objective to absorb you.",
	)

/datum/antagonist/cult
	tip_theme = "spookyconsole"
	antag_tips = list(
		"You are a follower of the geometer of blood, Nar'Sie!",
		"In your bag, you will find some Runed Metal and a Ritual Dagger.",
		"Use your Ritual Dagger to create runes. Each rune has a unique function.",
		"Use the Runed Metal to create cult structures which will produce powerful equipment.",
		"To begin, you should gather converts by placing them over an Offering Rune.",
		"There will be several other cultists on board, communicate with them using the commune button. Find a place to create a base, and keep cult structures hidden.",
		"Before you can summon Nar'Sie, you must first sacrifice a target for her on an offering rune. Check the top right of your screen for information on your target.",
		"NOTE: Your Cult Stun spell will not have full effect on Mindshielded people -- consider using alternative tactics when dealing with them.",
	)

/datum/antagonist/heretic
	antag_tips = list(
		"Eldritch ancient energies surge through you! You have been provided with a Living Heart to start your quest.",
		"Your antagonist UI page lays out your objectives and research paths. Once you choose a path, you are locked in it.",
		"The Living Heart is primarily used to find your targets. Use the ability to track one of your four targets, Right click to track the latest one.",
		"The Mansus Grasp is your starter spell, which can knockdown targets and apply minor burn damage. Certain paths will give your grasp more abilities.",
		"You might find influences around the station, Right-Click one with an empty hand to research them and gain knowledge, at the cost of making the influences visible to normal crew. These influences can be removed entirely using an Anomaly Neutralizer.",
		"With Mansus Grasp in your off-hand, use a pen on the ground to draw your Sacrificial Rune. This is used for all your ritual needs such as sacrificing targets.",
	)

/datum/antagonist/malf_ai
	tip_theme = "hackerman"
	antag_tips = list(
		"Similar to your human counterpart, you have been assigned objectives in your Antagonist Info UI that must be completed",
		"You can use Bots to your advantage by emagging them through their UI, or calling them to locations using Robot Control in your AI modules.",
		"You can hack cyborgs by using the Research Director's cyborg control console.",
		"You have access to the Syndicate radio channel, use the :t radio prefix to access it.",
		"You can use your processing power to purchase abilities through your Antagonist UI, ranging from upgraded cameras, upgraded turrets to even a Doomsday Device, if your objectives allow.",
	)

/datum/antagonist/nukeop
	tip_theme = "syndicate"
	antag_tips = list(
		"The syndicate has provided you with a radio uplink with 25 starting telecrystals, scaling with the crew's population.",
		"You must detonate the nuclear bomb from your ship on the Nanotrasen station. To do that, you must get the nuclear disk.",
		"To get to the nuclear disk, you have a tablet with a program (Fission360) to locate it.",
		"To activate the nuke, you must put in the disk, type in the code, turn off the safety and enable it. You should first unanchor it, move it to the station, re-anchor it and then activate the nuke and take the disk away.",
		"As a Nuclear Operative, you have different options for purchase depending on your strategy, whether stealth or loud. Ranging from combat mechs to Close Quarter Combat.",
		"The leader of the team starts out with a war declaration. If activated, they'll be prompted to write a custom message and declare war.",
		"Declaring war stops you from going to the station for 20 minutes, alerts the crew and gives the entire team telecrystals.",
	)

/datum/antagonist/rev
	antag_tips = list(
		"You are a revolutionary tasked with eliminating the heads of staff. You can accomplish this either by exile or assassination.",
		"There are Head Revolutionaries who are the leaders of the revolution, and MUST stay alive (and on station) at ALL costs.",
		"Head Revolutionaries use flashes to convert people to the revolution, this doesn't work on people with mindshields or flash protection.",
		"People with an 'R' above their heads are your fellow revolutionaries, help them accomplish your objectives.",
		"In the case of being mindshielded or being bashed in the head with blunt weapons, you'll get deconverted. Avoid THIS at all costs.",
	)

/datum/antagonist/traitor
	tip_theme = "syndicate"
	antag_tips = list(
		"The syndicate has provided you with a disguised uplink. It can either be your PDA, your headset, your pen or an internal uplink.",
		"Your uplink contains your objectives and tasks, select one and complete the instructions to get reputation and additional telecrystals.",
		"To utilize your PDA uplink, enter the messenger tab and set the ringtone as the code you have been provided.",
		"To utilize your Headset uplink, change its frequency to the frequency provided.",
		"To utilize the pen uplink, twist it to the first setting, then to the second one.",
		"To utilize the internal uplink, use the action button on the top left of your screen to access the uplink menu.",
		"The uplink starts out with 20 telecrystals (16 if you use the internal uplink) which are utilized to purchase different items to aid you in fulfilling your objectives.",
		"The Syndicate has also given you and any other agents on board code-words which can be used to find eachother. They're highlighted in red and blue.",
	)

/datum/antagonist/wizard
	tip_theme = "wizard"
	antag_tips = list(
		"You are a wizard sent by the Wizard Federation.",
		"You have been granted a spellbook with 10 spellpoints that you can spend to buy new spells. It can only be used on board of the Wizard's den.",
		"Use your scroll of teleportation to get to the station.",
		"The details of your objective are stored within your Antagonist UI, although they are merely a suggestion.",
		"Spells can be upgraded by putting more points into them or refunded.",
		"As a wizard, you have a versatile loadout that can adapt depending on which playstyle you wish to adopt.",
		"You might be an agent of chaos, but how you choose to act is up to you.",
	)

/datum/antagonist/wizard/apprentice
	tip_theme = "wizard"
	antag_tips = list(
		"You are a wizard apprentice, summoned by your master.",
		"Your primary objective is to help your master, depending on which spells they picked for you.",
		"Use your lesser scroll of teleportation to get to the station.",
		"There are 4 loadouts which your master has possibly picked for you:",
		"Destruction: Contains the spells fireball and magic missile. Perfect for a hostile wizard, keep in mind that these can hit your master too.",
		"Bluespace: Contains the spells ethereal jaunt and teleport. Best used to sneak around for your own equipment.",
		"Healing: Contains a healing staff, and the spells charge and forcewall. You can help as a support, able to heal your master's damage.",
		"Robeless: Contains the robeless spells knock and mind transfer. Effective for stealth and impersonating someone."
	)

/datum/antagonist/wizard/apprentice/imposter
	antag_tips = list(
		"You are a wizard imposter, tasked with fooling the crew away from the original wizard.",
		"You have been given 3 spells to accomplish this:",
		"Teleport: Long cooldown spell that lets you teleport to any general area in the station.",
		"Blink: Short cooldown spell that teleports you a few tiles away with a random pattern.",
		"Ethereal Jaunt: A spell that manifests you away from the physical realm, allowing free movement for a few seconds past any structures.",

	)
