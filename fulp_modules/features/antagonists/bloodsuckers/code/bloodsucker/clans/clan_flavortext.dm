/datum/bloodsucker_clan/gangrel
	name = CLAN_GANGREL
	description = "Gangrel Clan <br> \
		Closer to Animals than Bloodsuckers, known as Werewolves waiting to happen, <br> \
		these are the most fearful of True Faith, being the most lethal thing they would ever see the night of. <br> \
		Full Moons do not seem to have an effect, despite common-told stories. <br> \
		The Favorite Vassal turns into a Werewolf whenever their Master does."
	joinable_clan = FALSE
	frenzy_stun_immune = TRUE
	blood_drink_type = BLOODSUCKER_DRINK_INHUMANELY

/datum/bloodsucker_clan/gangrel/handle_clan_life(atom/source, datum/antagonist/bloodsucker/bloodsuckerdatum)
	. = ..()
	var/area/current_area = get_area(bloodsuckerdatum.owner.current)
	if(istype(current_area, /area/station/service/chapel))
		to_chat(bloodsuckerdatum.owner.current, span_warning("You don't belong in holy areas! The Faith burns you to a crisp!"))
		bloodsuckerdatum.owner.current.adjustFireLoss(20)
		bloodsuckerdatum.owner.current.adjust_fire_stacks(2)
		bloodsuckerdatum.owner.current.ignite_mob()

/datum/bloodsucker_clan/toreador
	name = CLAN_TOREADOR
	description = "Toreador Clan <br> \
		The most charming Clan of them all, allowing them to very easily disguise among the crew. <br> \
		More in touch with their morals, they suffer and benefit more strongly from humanity cost or gain of their actions. <br> \
		Known as 'The most humane kind of vampire', they have an obsession with perfectionism and beauty <br> \
		The Favorite Vassal gains the Mesmerize ability."
	joinable_clan = FALSE
	blood_drink_type = BLOODSUCKER_DRINK_SNOBBY
