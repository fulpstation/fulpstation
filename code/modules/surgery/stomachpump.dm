/datum/surgery/stomach_pump
	name = "Stomach Pump"
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/stomach_pump,
		/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = TRUE
	ignore_clothes = FALSE
	var/accumulated_experience = 0

/datum/surgery/stomach_pump/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/stomach/target_stomach = target.getorganslot(ORGAN_SLOT_STOMACH)
	if(HAS_TRAIT(target, TRAIT_HUSK))
		return FALSE
	if(!target_stomach)
		return FALSE
	return ..()

//Working the stomach by hand in such a way that you induce vomiting.
/datum/surgery_step/stomach_pump
	name = "Pump Stomach"
	accept_hand = TRUE
	repeatable = TRUE
	time = 20

/datum/surgery_step/stomach_pump/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin pumping [target]'s stomach...</span>",
		"<span class='notice'>[user] begins to pump [target]'s stomach.</span>",
		"<span class='notice'>[user] begins to press on [target]'s chest.</span>")

/datum/surgery_step/stomach_pump/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(ishuman(target))
		var/mob/living/carbon/human/target_human = target
		display_results(user, target, "<span class='notice'>[user] forces [target_human] to vomit, cleansing their stomach of some chemicals!</span>",
				"<span class='notice'>[user] forces [target_human] to vomit, cleansing their stomach of some chemicals!</span>",
				"[user] forces [target_human] to vomit!")
		target_human.vomit(20, FALSE, TRUE, 1, TRUE, FALSE, purge_ratio = 0.67) //higher purge ratio than regular vomiting
	return ..()

/datum/surgery_step/stomach_pump/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/target_human = target
		display_results(user, target, "<span class='warning'>You screw up, brusing [target_human]'s chest!</span>",
			"<span class='warning'>[user] screws up, brusing [target_human]'s chest!</span>",
			"<span class='warning'>[user] screws up!</span>")
		target_human.adjustOrganLoss(ORGAN_SLOT_STOMACH, 5)
		target_human.adjustBruteLoss(5)
