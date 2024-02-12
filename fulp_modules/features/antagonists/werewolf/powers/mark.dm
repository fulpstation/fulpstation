/obj/effect/decal/werewolf_mark
	name = "Strange mark"
	desc = "You get the feeling you don't want to be here..."
	icon = 'fulp_modules/features/antagonists/werewolf/icons/decals.dmi'
	icon_state = "mark_decal"
	var/datum/antagonist/werewolf/owner_datum

/obj/effect/decal/werewolf_mark/alternative
	icon_state = "mark_decal_alt"

/obj/effect/decal/werewolf_mark/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_EXAMINE, PROC_REF(handle_examine))

/obj/effect/decal/werewolf_mark/Destroy(force)
	UnregisterSignal(src, COMSIG_ATOM_EXAMINE)
	return ..()

/obj/effect/decal/werewolf_mark/proc/handle_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(owner_datum.owner.current == user)
		examine_list += span_notice("This mark was made by you.")
		return

	if(IS_WEREWOLF_ANTAG(user))
		if(!owner_datum)
			examine_list += span_notice("This mark was made by another werewolf, but the den has since been abandoned")
			return

		examine_list += span_bolddanger("This marks this area as being claimed by another werewolf!")
		return

	if(IS_MONSTERHUNTER(user) || IS_BLOODSUCKER(user))
		if(!owner_datum)
			examine_list += span_notice("This mark was made by a werewolf, but the den has since been abandoned")
			return

		examine_list += span_bolddanger("This marks this area as being claimed by a werewolf!")
		return

/datum/action/cooldown/spell/werewolf_mark
	name = "Mark"
	desc = "Claim an area of the station as your den"
	spell_requirements = NONE
	cooldown_time = 5 SECONDS
	var/datum/antagonist/werewolf/werewolf_datum
	var/casting = FALSE
	var/obj/effect/decal/werewolf_mark/mark_decal


/datum/action/cooldown/spell/werewolf_mark/New(antag_datum)
	werewolf_datum = antag_datum
	return ..()


/datum/action/cooldown/spell/werewolf_mark/before_cast(mob/living/carbon/caster)
	if(casting)
		return SPELL_CANCEL_CAST

	var/area/potential_den = get_area(caster)
	if(!werewolf_datum.is_valid_den_area(potential_den))
		return SPELL_CANCEL_CAST

	to_chat(caster, span_notice("You begin marking [potential_den] as your den..."))
	casting = TRUE
	if(!do_after(caster, WP_MARK_TIME))
		casting = FALSE
		return SPELL_CANCEL_CAST

	casting = FALSE
	return ..()

/datum/action/cooldown/spell/werewolf_mark/cast(mob/living/carbon/caster)
	. = ..()
	var/area/potential_den = get_area(caster)
	werewolf_datum.claim_area_as_den(potential_den)
	var/obj/effect/decal/werewolf_mark/ww_mark = new /obj/effect/decal/werewolf_mark(caster.loc)
	ww_mark.owner_datum = werewolf_datum
	if(mark_decal)
		mark_decal.owner_datum = null
		mark_decal.desc = "It looks old and faded."
	mark_decal = ww_mark

	to_chat(caster, span_notice("You've successfully claimed [potential_den] as your den!"))
