/datum/surgery/advanced/wing_reconstruction
	name = "Wing Reconstruction"
	desc = "An experimental surgical procedure that reconstructs the damaged wings of moth people. Requires Synthflesh."
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/wing_reconstruction)
	possible_locs = list(BODY_ZONE_CHEST)
	target_mobtypes = list(/mob/living/carbon/human)

/datum/surgery/advanced/wing_reconstruction/can_start(mob/user, mob/living/carbon/target)
	if(!istype(target))
		return FALSE
	var/obj/item/organ/external/wings/moth/wings = target.getorganslot(ORGAN_SLOT_EXTERNAL_WINGS)
	return ..() && wings?.burnt

/datum/surgery_step/wing_reconstruction
	name = "start wing reconstruction"
	implements = list(
		TOOL_HEMOSTAT = 85,
		TOOL_SCREWDRIVER = 35,
		/obj/item/pen = 15)
	time = 200
	chems_needed = list(/datum/reagent/medicine/c2/synthflesh)
	require_all_chems = FALSE

/datum/surgery_step/wing_reconstruction/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to fix [target]'s charred wing membranes..."),
		span_notice("[user] begins to fix [target]'s charred wing membranes."),
		span_notice("[user] begins to perform surgery on [target]'s charred wing membranes."))
	display_pain(target, "Your wings sting like hell!")

/datum/surgery_step/wing_reconstruction/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		display_results(user, target, span_notice("You succeed in reconstructing [target]'s wings."),
			span_notice("[user] successfully reconstructs [target]'s wings!"),
			span_notice("[user] completes the surgery on [target]'s wings."))
		display_pain(target, "You can feel your wings again!")
		var/obj/item/organ/external/wings/moth/wings = target.getorganslot(ORGAN_SLOT_EXTERNAL_WINGS)
		wings?.heal_wings()

		var/obj/item/organ/external/antennae/antennae = target.getorganslot(ORGAN_SLOT_EXTERNAL_ANTENNAE) //i mean we might aswell heal their antennae too
		antennae?.heal_antennae()

		human_target.update_body_parts()
	return ..()
