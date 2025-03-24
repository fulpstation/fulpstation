/// List of terms that we filter out of the main VOX list.
GLOBAL_LIST_INIT(vox_filter_list, list(
	"coomer",
	"johnson", // Remove this if "cave" is ever added to VOX.
	"lusty",
))

#endif

/// Override/edit the main VOX terms list.
/world/proc/override_vox()
	if(!GLOB.vox_filter_list || !GLOB.vox_sounds)
		return

	for(var/filtered_term in GLOB.vox_filter_list)
		GLOB.vox_sounds.Remove(filtered_term)
