/obj/structure/flora/tree/cherry
	name = "cherry tree"
	desc = "A cherry tree that has been bio-engineered to keep its pink flowers year-round."
	icon = 'fulp_modules/icons/mapping/cherry.dmi'
	icon_state = "cherry"
	pixel_x = -68
	pixel_y = -20

/*Copied from '/obj/effect/decal/hammerandsickle/shuttleRotate(rotation)' under 'code/modules/shuttle/special.dm'
  Quoting the comment for that proc directly:
  " No parentcall, rest of the rotate code breaks the pixel offset." */
/obj/structure/flora/tree/cherry/shuttleRotate(rotation, params)
	setDir(angle2dir(rotation+dir2angle(dir)))

//Railings have the 'ABOVE_TREE_LAYER' layer, but in order for the xmas tree on Theia Station
//to render properly we'll need to rail against the railings trying to rail against (or perhaps above) it.
#define ABOVE_RAILING_LAYER 5.03
/obj/structure/flora/tree/pine/xmas/presents
	layer = ABOVE_RAILING_LAYER
