# R code provided in Théroux-Rancourt _et al._ (2017)

You will find in this project the most up-to-date code that was initially provided as supplementary information in Théroux-Rancourt _et al._ (2017) _The bias of a 2D view: Comparing 2D and 3D mesophyll surface area estimates using non-invasive imaging_. New Phytologist.


## Thain (1983) curvature correction methods and accompanying R code

Thain (1983) presents a series of equations to compute a curvature correction factor (_F_), from the measures of height and diameter for cylinder-shaped cells, or from the major and minor axes of spheroid cells. Thain (1983) mixes his abbreviations so that one has different meaning from one equation to another. Here, we avoid this confusion an use:  
   _a_: height or major axis of a cell, and  
   _b_: diameter or minor axis of a cell.

For cylinder-shaped cells, which can be more common in the long palisade layers of _Gossypium hirustum_ (coton) for example, the equations are:

with hemispherical ends:
$$
F = \pi / (2+((\pi^2/4)-2)(b/a) = \pi / (2+0.467*(b/a))
$$

with flat ends:
$$
F = (\pi * (2+(b/a))) / (4 + \pi*(b/a))
$$

For most cells, however, a spheroid shape might be more appropriate because. For an oblate spheroid, common in spongy cells, the equation is:
$$
F = (1 + ((b^2/a^2)/2e)) ln((1+e)/(1-e)) / E
$$

and for a prolate spheroid, common is palisade cells:

$$
F = ((b/a) + (sin^-1 e)/e) / E
$$

where _e_ is the eccentricity of the ellipse:

$$
e = sqrt(1 - (b^2/a^2))
$$

and _E_ is the elliptical integral:


Note that Thain (1983) forgot the square root in the elliptical integral function. The elliptical integral is easy to solve with many statistical software. We present a `R` function to compute the equations above.

## If you use this code in a publication, please cite:

__Theroux-Rancourt G, Earles JM, Gilbert ME, Zwieniecki MA, Boyce CK, McElrone A, Brodersen CR. 2017.__ The bias of a 2D view: Comparing 2D and 3D mesophyll surface area estimates using non-invasive imaging. _New Phytologist_. doi: 10.1111/nph.14687

## References

__Thain JF. 1983.__ Curvature correction factors in the measurement of cell surface areas in plant tissues. _Journal of Experimental Botany_ 34: 87–94.