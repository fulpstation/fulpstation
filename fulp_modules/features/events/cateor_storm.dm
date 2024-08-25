//A special type of meteor storm that can be triggered by wizards through a certain ritual
//Spawns "cateors" which pass through most objects but turn humanoids into felinids

//Cateor:
/obj/effect/meteor/cateor
	name = "high-velocity thaumaturgic cat energy"
	desc = "Imbued with harmonious discord, it is truly a <i>cat</i>aclysmic sight to behold."
	icon = 'fulp_modules/features/events/icons/event_icons.dmi'
	icon_state = "cateor"
	pass_flags = PASSGLASS | PASSGRILLE | PASSBLOB | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSFLAPS | PASSDOORS | PASSVEHICLE | PASSITEM
	hits = 1
	hitpwr = EXPLODE_LIGHT
	heavy = TRUE
	meteorsound = 'fulp_modules/sounds/effects/anime_wow.ogg' // (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧

/obj/effect/meteor/cateor/Bump(mob/M)
	var/mob/living/carbon/human/human_target = M
	if(!istype(human_target))
		return
	if(M)
		human_target.set_species(/datum/species/human/felinid)
		ram_turf(get_turf(M))
		playsound(src.loc, meteorsound, 40, TRUE)
		get_hit()
