///The amount of time required to make a Blood Spider.
#define CHANGELING_BLOODSPIDER_CREATION_DELAY 15 SECONDS
///The chance of a Central Command announcement of you making spiders.
#define CHANGELING_BLOODSPIDER_ANNOUNCEMENT_CHANCE 10

//This is on the antag datum itself, not the Power.
/datum/antagonist/changeling
	///Amount of Spiders this Changeling has made.
	var/spiders_created = 0


/**
 * Overwrite of /datum/action/changeling/spiders
 * from 'code/modules/antagonists/changeling/powers/spiders.dm'
 * Though not really because we're still calling parent.
 */
/datum/action/changeling/spiders
	desc = "Our form divides and mixes with a spider, creating a cluster of eggs which will grow into a deadly bloody arachnid. Costs 45 chemicals and a Spider reference."
	helptext = "The spiders are ruthless creatures, and may attack their creators when fully grown. Requires at least 3 DNA absorptions and either Spider Eggs or a dead Spiderling."

//Verification that we still have spiders in our hand, and haven't thrown it away.
/datum/action/changeling/spiders/proc/has_spiders(mob/user)
	var/list/hand_items = list(user.get_active_held_item(), user.get_inactive_held_item())
	for(var/obj/held_items in hand_items)
		if(!istype(held_items, /obj/item/food/spidereggs) && !istype(held_items, /obj/item/food/spiderling))
			continue
		return TRUE
	return FALSE

/datum/action/changeling/spiders/sting_action(mob/user)
	var/datum/antagonist/changeling/ling_datum = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(!ling_datum)
		return FALSE
	if(!has_spiders(user))
		to_chat(user, span_notice("You need a Spider egg or spiderling to reference off of!"))
		return FALSE

	user.balloon_alert(user, "creating blood spider...")
	if(!do_after(user, CHANGELING_BLOODSPIDER_CREATION_DELAY, user, NONE, TRUE, extra_checks = CALLBACK(src, .proc/has_spiders, user)))
		user.balloon_alert(user, "spider creation interrupted!")
		return FALSE
	user.balloon_alert(user, "spider created!")

	if(prob(CHANGELING_BLOODSPIDER_ANNOUNCEMENT_CHANCE*ling_datum.spiders_created) && ling_datum.spiders_created >= 1)
		priority_announce("We detect a set of strange spiders appearing out of [get_area(get_turf(user))], please dispatch a security force to investigate.", "Central Command")

	//We created a spider, let us announce this to ourselves.
	ling_datum.spiders_created++

//	new /obj/effect/mob_spawn/spider/bloody(user.loc) // Handled by Parent, so call ..() instead
	return ..()
