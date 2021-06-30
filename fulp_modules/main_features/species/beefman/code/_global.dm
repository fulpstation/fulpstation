/// Names
GLOBAL_LIST_INIT(russian_names, world.file2list("fulp_modules/main_features/species/beefman/strings/russian_names.txt"))
GLOBAL_LIST_INIT(experiment_names, world.file2list("fulp_modules/main_features/species/beefman/strings/experiment_names.txt"))
GLOBAL_LIST_INIT(beefman_names, world.file2list("fulp_modules/main_features/species/beefman/strings/beefman_names.txt"))

/// Taken from flavor_misc.dm, as used by ethereals (color_list_ethereal)
GLOBAL_LIST_INIT(color_list_beefman, list("Very Rare" = "d93356", "Rare" = "da2e4a", "Medium Rare" = "e73f4e", "Medium" = "f05b68", "Medium Well" = "e76b76", "Well Done" = "d36b75"))

GLOBAL_LIST_INIT(eyes_beefman, subtypesof(/datum/sprite_accessory/beef/eyes))
GLOBAL_LIST_INIT(mouths_beefman, subtypesof(/datum/sprite_accessory/beef/mouth))
