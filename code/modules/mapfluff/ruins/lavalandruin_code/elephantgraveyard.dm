//******Decoration objects
//***Bone statues and giant skeleton parts.
/obj/structure/statue/bone
	anchored = TRUE
	max_integrity = 120
	impressiveness = 18 // Carved from the bones of a massive creature, it's going to be a specticle to say the least
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	custom_materials = list(/datum/material/bone=MINERAL_MATERIAL_AMOUNT*5)
	abstract_type = /obj/structure/statue/bone

/obj/structure/statue/bone/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_DEFAULT)

/obj/structure/statue/bone/rib
	name = "colossal rib"
	desc = "It's staggering to think that something this big could have lived, let alone died."
	custom_materials = list(/datum/material/bone=MINERAL_MATERIAL_AMOUNT*4)
	icon = 'icons/obj/art/statuelarge.dmi'
	icon_state = "rib"
	icon_preview = 'icons/obj/previews.dmi'
	icon_state_preview = "rib"

/obj/structure/statue/bone/skull
	name = "colossal skull"
	desc = "The gaping maw of a dead, titanic monster."
	custom_materials = list(/datum/material/bone=MINERAL_MATERIAL_AMOUNT*12)
	icon = 'icons/obj/art/statuelarge.dmi'
	icon_state = "skull"
	icon_preview = 'icons/obj/previews.dmi'
	icon_state_preview = "skull"

/obj/structure/statue/bone/skull/half
	desc = "The gaping maw of a dead, titanic monster. This one is cracked in half."
	custom_materials = list(/datum/material/bone=MINERAL_MATERIAL_AMOUNT*6)
	icon = 'icons/obj/art/statuelarge.dmi'
	icon_state = "skull-half"
	icon_preview = 'icons/obj/previews.dmi'
	icon_state_preview = "halfskull"

//***Wasteland floor and rock turfs here.
/turf/open/misc/asteroid/basalt/wasteland //Like a more fun version of living in Arizona.
	name = "cracked earth"
	icon = 'icons/turf/floors.dmi'
	icon_state = "wasteland"
	base_icon_state = "wasteland"
	baseturfs = /turf/open/misc/asteroid/basalt/wasteland
	dig_result = /obj/item/stack/ore/glass/basalt
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	slowdown = 0.5
	floor_variance = 30

/turf/open/misc/asteroid/basalt/wasteland/break_tile()
	return

/turf/open/misc/asteroid/basalt/wasteland/Initialize(mapload)
	.=..()
	if(prob(floor_variance))
		icon_state = "[base_icon_state][rand(0,6)]"

/turf/closed/mineral/strong/wasteland
	name = "ancient dry rock"
	color = "#B5651D"
	turf_type = /turf/open/misc/asteroid/basalt/wasteland
	baseturfs = /turf/open/misc/asteroid/basalt/wasteland
	icon = 'icons/turf/walls/rock_wall.dmi'
	base_icon_state = "rock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER

/turf/closed/mineral/strong/wasteland/drop_ores()
	if(prob(10))
		new /obj/item/stack/ore/iron(src, 1)
		new /obj/item/stack/ore/glass(src, 1)
		new /obj/effect/decal/remains/human/grave(src, 1)
	else
		new /obj/item/stack/sheet/bone(src, 1)

//***Oil well puddles.
/obj/structure/sink/oil_well //You're not going to enjoy bathing in this...
	name = "oil well"
	desc = "A bubbling pool of oil. This would probably be valuable, had bluespace technology not destroyed the need for fossil fuels 200 years ago."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "puddle-oil"
	dispensedreagent = /datum/reagent/fuel/oil
	pixel_shift = 0

/obj/structure/sink/oil_well/Initialize(mapload)
	.=..()
	create_reagents(20)
	reagents.add_reagent(dispensedreagent, 20)

/obj/structure/sink/oil_well/attack_hand(mob/user, list/modifiers)
	flick("puddle-oil-splash",src)
	reagents.expose(user, TOUCH, 20) //Covers target in 20u of oil.
	to_chat(user, span_notice("You touch the pool of oil, only to get oil all over yourself. It would be wise to wash this off with water."))

/obj/structure/sink/oil_well/attackby(obj/item/O, mob/living/user, params)
	flick("puddle-oil-splash",src)
	if(O.tool_behaviour == TOOL_SHOVEL && !(flags_1 & NODECONSTRUCT_1)) //attempt to deconstruct the puddle with a shovel
		to_chat(user, "You fill in the oil well with soil.")
		O.play_tool_sound(src)
		deconstruct()
		return 1
	if(is_reagent_container(O)) //Refilling bottles with oil
		var/obj/item/reagent_containers/RG = O
		if(RG.is_refillable())
			if(!RG.reagents.holder_full())
				RG.reagents.add_reagent(dispensedreagent, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
				to_chat(user, span_notice("You fill [RG] from [src]."))
				return TRUE
			to_chat(user, span_notice("\The [RG] is full."))
			return FALSE
	if(!user.combat_mode)
		to_chat(user, span_notice("You won't have any luck getting \the [O] out if you drop it in the oil."))
		return 1
	else
		return ..()

/obj/structure/sink/oil_well/drop_materials()
	new /obj/effect/decal/cleanable/oil(loc)

//***Grave mounds.
/// has no items inside unless you use the filled subtype
/obj/structure/closet/crate/grave
	name = "burial mound"
	desc = "A marked patch of soil, showing signs of a burial long ago. You wouldn't disturb a grave... right?"
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "grave"
	dense_when_open = TRUE
	material_drop = /obj/item/stack/ore/glass/basalt
	material_drop_amount = 5
	anchorable = FALSE
	anchored = TRUE
	locked = TRUE
	divable = FALSE //As funny as it may be, it would make little sense how you got yourself inside it in first place.
	breakout_time = 90 SECONDS
	open_sound = 'sound/effects/shovel_dig.ogg'
	close_sound = 'sound/effects/shovel_dig.ogg'
	cutting_tool = /obj/item/shovel
	var/lead_tomb = FALSE
	var/first_open = FALSE
	can_install_electronics = FALSE

/obj/structure/closet/crate/grave/filled/PopulateContents()  //GRAVEROBBING IS NOW A FEATURE
	..()
	new /obj/effect/decal/remains/human/grave(src)
	switch(rand(1,8))
		if(1)
			new /obj/item/coin/gold(src)
			new /obj/item/storage/wallet(src)
		if(2)
			new /obj/item/clothing/glasses/meson(src)
		if(3)
			new /obj/item/coin/silver(src)
			new /obj/item/shovel/spade(src)
		if(4)
			new /obj/item/storage/book/bible/booze(src)
		if(5)
			new /obj/item/clothing/neck/stethoscope(src)
			new /obj/item/scalpel(src)
			new /obj/item/hemostat(src)

		if(6)
			new /obj/item/reagent_containers/cup/beaker(src)
			new /obj/item/clothing/glasses/science(src)
		if(7)
			new /obj/item/clothing/glasses/sunglasses(src)
			new /obj/item/clothing/mask/cigarette/rollie(src)
		else
			//empty grave
			return

/obj/structure/closet/crate/grave/open(mob/living/user, obj/item/S, force = FALSE)
	if(!opened)
		to_chat(user, span_notice("The ground here is too hard to dig up with your bare hands. You'll need a shovel."))
	else
		to_chat(user, span_notice("The grave has already been dug up."))

/obj/structure/closet/crate/grave/closet_update_overlays(list/new_overlays)
	return

/obj/structure/closet/crate/grave/tool_interact(obj/item/S, mob/living/carbon/user)
	if(!user.combat_mode) //checks to attempt to dig the grave, must be done with combat mode off only.
		if(!opened)
			if(istype(S,cutting_tool) && S.tool_behaviour == TOOL_SHOVEL)
				to_chat(user, span_notice("You start start to dig open \the [src]  with \the [S]..."))
				if (do_after(user,20, target = src))
					opened = TRUE
					locked = TRUE
					dump_contents()
					update_appearance()
					user.add_mood_event("graverobbing", /datum/mood_event/graverobbing)
					if(lead_tomb == TRUE && first_open == TRUE)
						user.gain_trauma(/datum/brain_trauma/magic/stalker)
						to_chat(user, span_boldwarning("Oh no, no no no, THEY'RE EVERYWHERE! EVERY ONE OF THEM IS EVERYWHERE!"))
						first_open = FALSE
					return 1
				return 1
			else
				to_chat(user, span_notice("You can't dig up a grave with \the [S.name]."))
				return 1
		else
			to_chat(user, span_notice("The grave has already been dug up."))
			return 1

	else if((user.combat_mode) && opened) //checks to attempt to remove the grave entirely.
		if(istype(S,cutting_tool) && S.tool_behaviour == TOOL_SHOVEL)
			to_chat(user, span_notice("You start to remove \the [src]  with \the [S]."))
			if (do_after(user,15, target = src))
				to_chat(user, span_notice("You remove \the [src]  completely."))
				user.add_mood_event("graverobbing", /datum/mood_event/graverobbing)
				deconstruct(TRUE)
				return 1
	return

/obj/structure/closet/crate/grave/bust_open()
	..()
	opened = TRUE
	update_appearance()
	dump_contents()
	return

/obj/structure/closet/crate/grave/filled/lead_researcher
	name = "ominous burial mound"
	desc = "Even in a place filled to the brim with graves, this one shows a level of preperation and planning that fills you with dread."
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "grave_lead"
	lead_tomb = TRUE
	first_open = TRUE

/obj/structure/closet/crate/grave/filled/lead_researcher/PopulateContents()  //ADVANCED GRAVEROBBING
	..()
	new /obj/effect/decal/cleanable/blood/gibs/old(src)
	new /obj/item/book/granter/crafting_recipe/boneyard_notes(src)

/obj/effect/decal/remains/human/grave
	turf_loc_check = FALSE

//***Fluff items for lore/intrigue
/obj/item/paper/crumpled/muddy/fluff/elephant_graveyard
	name = "posted warning"
	desc = "It seems to be smudged with mud and... oil?"
	default_raw_text = "<B>TO WHOM IT MAY CONCERN</B><BR><BR>This area is property of the Nanotrasen Mining Division.<BR><BR>Trespassing in this area is illegal, highly dangerous, and subject to several NDAs.<br><br>Please turn back now, under intergalactic law section 48-R."

/obj/item/paper/crumpled/muddy/fluff/elephant_graveyard/rnd_notes
	name = "Research Findings: Day 26"
	desc = "Huh, this one page looks like it was torn out of a full book. How odd."
	icon_state = "docs_part"
	default_raw_text = "<b>Researcher name:</b> B--*--* J--*s.<BR><BR>Detailed findings:<i>Today the camp site's cond-tion has wor--ene*. The ashst--ms keep blocking us off from le-ving the sit* for m-re supplies, and it's lo-king like we're out of pl*sma to p-wer the ge-erat*r. Can't rea-*y study c-*bon *ating with no li--ts, ya know? Da-*y's been going -*f again and ag-*n a-*ut h*w the company's left us to *ie here, but I j-s* keep tell-ng him to stop che*-in* out these damn graves. We m-y b*  archaeologists, but -e sho*ld have t-e dec-**cy to know these grav-s are *-l NEW.</i><BR><BR><b>The rest of the page is just semantics about carbon dating methods.</b>"

/obj/item/paper/crumpled/muddy/fluff/elephant_graveyard/mutiny
	name = "hastily scribbled note"
	desc = "Seems like someone was in a hurry."
	default_raw_text = "Alright, we all know that stuck up son a bitch is just doing this to keep us satisifed. Who the hell does he think he is, taking extra rations? We're OUT OF FOOD, CARL. Tomorrow at noon, we're going to try and take the ship by force. He HAS to be lying about the engine cooling down. He HAS TO BE. I'm tellin ya, with this implant I lifted off that last supply ship, I got the smarts to get us offa this shithole. Keep your knife handy carl."

/obj/item/paper/fluff/ruins/elephant_graveyard/hypothesis
	name = "research document"
	desc = "Standard Nanotrasen typeface for important research documents."
	default_raw_text = "<b>Day 9: Tenative Conclusions</b><BR><BR>While the area appears to be of significant cultural importance to the lizard race, outside of some sparce contact with native wildlife, we're yet to find any exact reasoning for the nature of this phenomenon. It seems that organic life is communally drawn to this planet as though it functions as a final resting place for intelligent life. As per company guidelines, this site shall be given the following classification: 'LZ-0271 - Elephant Graveyard' <BR><BR><u>Compiled list of Artifact findings (Currently Sent Offsite)</u><BR>Cultist Blade Fragments: x8<BR>Brass Multiplicative Ore Sample: x105<BR>Syndicate Revolutionary Leader Implant (Broken) x1<BR>Extinct Cortical Borer Tissue Sample x1<BR>Space Carp Fossil x3"

/obj/item/paper/fluff/ruins/elephant_graveyard/final_message
	name = "important-looking note"
	desc = "This note is well written, and seems to have been put here so you'd find it."
	default_raw_text = "If you find this... you don't need to know who I am.<BR><BR>You need to leave this place. I dunno what shit they did to me out here, but I don't think I'm going to be making it out of here.<BR><BR>This place... it wears down your psyche. The other researchers out here laughed it off but... They were the first to go.<BR><BR>One by one they started turning on each other. The more they found out, the more they started fighting and arguing...<BR>As I speak now, I had to... I wound up having to put most of my men down. I know what I had to do, and I know there's no way left for me to live with myself.<BR> If anyone ever finds this, just don't touch the graves.<BR><BR>DO NOT. TOUCH. THE GRAVES. Don't be a dumbass, like we all were."
