/proc/get_voice_description(atom/movable/speaker)
	var/voice_description

	if(isobj(speaker))
		voice_description = VOICE_DESCRIPTION_NEUTER
		return voice_description

	//If they're human and their voice isn't their 'real_name' then we'll just default to 'PLURAL'.
	//This isn't ideal at all (and could be metagamed), but no 'voice_gender' exists.
	if(ishuman(speaker))
		var/mob/living/carbon/human/human_speaker = speaker
		if(speaker.get_voice() != human_speaker.real_name)
			voice_description = VOICE_DESCRIPTION_PLURAL //"Their" instead of "its" to be less /obj
			return voice_description

	switch(speaker.gender)
		if(NEUTER)
			voice_description = VOICE_DESCRIPTION_NEUTER
		if(FEMALE)
			voice_description = VOICE_DESCRIPTION_FEMININE
		if(MALE)
			voice_description = VOICE_DESCRIPTION_MASCULINE
		if(PLURAL)
			voice_description =  VOICE_DESCRIPTION_PLURAL

	return voice_description
