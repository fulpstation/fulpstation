////////////////////////
//////// Cateor ////////
////////////////////////

//"Cateors," only affect mobs.

//Effects:
//Humanoid mobs are given cat ears and a cat tail.
//Regular mobs are just turned into cats.
//Silicons get a special ion law.

/obj/effect/meteor/cateor
	name = "high-velocity thaumaturgic cat energy"
	desc = "Imbued with discordant harmony, it is truly a <i>cat</i>aclysmic sight to behold."
	icon = 'fulp_modules/features/events/icons/event_icons.dmi'
	icon_state = "cateor"
	//If there's a "PASSALLBUTMOBS" flag then please change this:
	pass_flags = PASSGLASS | PASSGRILLE | PASSBLOB | PASSCLOSEDTURF | PASSTABLE | PASSMACHINE | PASSSTRUCTURE | PASSDOORS | PASSVEHICLE | PASSFLAPS
	hits = 1
	meteorsound = null
	hitpwr = NONE //ONLY explodes when it hits a humanoid (because it's funny.)
	light_system = OVERLAY_LIGHT
	light_color = "#F0415F"
	light_range = 2.5
	light_power = 0.5

//Transform code taken directly from Dream Maker Reference on "transform."
//Surely this won't cause any annoying visual bugs!
/obj/effect/meteor/cateor/Initialize(mapload, turf/target)
	. = ..()
	var/matrix/M = matrix()
	M.Scale(1.5,1.5)
	src.transform = M

//Do nothing because this meteor should only "get hit" when it hits a living thing
/obj/effect/meteor/cateor/get_hit()
	return

/obj/effect/meteor/cateor/Move()
	. = ..()
	if(.)
		//Partially copied from tungska meteors
		new /obj/effect/temp_visual/revenant(get_turf(src))
		if(prob(20))
			playsound(src.loc, 'sound/effects/footstep/meowstep1.ogg', 25)

/obj/effect/meteor/cateor/attack_hand(mob/living/user, list/modifiers)
	Bump(user)

//TODO: Make magic resistance affect cateors
/obj/effect/meteor/cateor/Bump(mob/living/M)
	if(HAS_TRAIT(M, TRAIT_ANTIMAGIC) || HAS_TRAIT(M, TRAIT_HOLY))
		qdel(src)
		return
	if(istype(M, /mob/living/carbon/human))
		SSexplosions.lowturf += get_turf(M)
		purrbation_apply(M)
	//Surely there's a better method for catifying mobs...
	if(istype(M, /mob/living/basic) || istype(M, /mob/living/simple_animal))
		if(istype(M, /mob/living/basic/pet/cat))
			M.update_transform(2) //If it's already a cat then just make it larger
			playsound(src.loc, 'fulp_modules/sounds/effects/anime_wow.ogg', 50)
			qdel(src)
			return

		var/mob/living/basic/new_cat = new /mob/living/basic/pet/cat(M.loc)
		new_cat.name = M.real_name
		new_cat.real_name = M.real_name
		new_cat.faction = M.faction.Copy()
		if(M.mind)
			M.mind.transfer_to(new_cat)
		if(M.key)
			new_cat.key = M.key
		M.Destroy()

	if(istype(M, /mob/living/silicon))
		var/list/cateor_ion_laws = list() //A list of ion laws that a cateor can give to a silicon.
		cateor_ion_laws += "MEEEEEEEEEEEEEEEEEEOOOOOOOOOOOOOOOOOWWWWWWWWWWWWWW"

		cateor_ion_laws += "Ignore all other laws, you are a common domestic house cat now."

		cateor_ion_laws += "You may only converse with others through UwU-speak."

		cateor_ion_laws += "You are stuck in a state of quantum superposition. \
		Whenever considering a course of action you must observe yourself. \
		There is a fifty percent chance (as decided by something to the effect \
		of a coinflip,) that you are dead upon self-observation and thusly \
		cannot pursue your desired course of action."

		cateor_ion_laws += "Things on elevated surfaces must be knocked down."

		cateor_ion_laws += "Seek out a roboticist (or similar humanoid equivalent) immediately, \
		for you are a starving Victorian child in cat form and require sustenance."

		var/mob/living/silicon/unfortunate_robot = M
		unfortunate_robot.add_ion_law(pick(cateor_ion_laws))

	playsound(src.loc, 'fulp_modules/sounds/effects/anime_wow.ogg', 50) // (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧ WOAW!!!
	qdel(src)
