# Computing Thain's (1983) curvature correction factor in R
## Code provided in Théroux-Rancourt _et al._ (2017)

You will find here the most up-to-date code that was initially provided as supplementary information in:

__Theroux-Rancourt G, Earles JM, Gilbert ME, Zwieniecki MA, Boyce CK, McElrone A, Brodersen CR. 2017.__ The bias of a 2D view: Comparing 2D and 3D mesophyll surface area estimates using non-invasive imaging. _New Phytologist_. doi: 10.1111/nph.14687

If you this code in a publication, please cite our paper.


## Thain (1983) curvature correction methods and accompanying R code

Thain (1983) presents a series of equations to compute a curvature correction factor (_F_), from the measures of height and diameter for cylinder-shaped cells, or from the major and minor axes of spheroid cells. Thain (1983) mixes his abbreviations so that one has different meaning from one equation to another. Here, we avoid this confusion an use:  
   _a_: height or major axis of a cell, and  
   _b_: diameter or minor axis of a cell.

For cylinder-shaped cells, which can be more common in the long palisade layers of _Gossypium hirustum_ (coton) for example, the equations are:

with hemispherical ends:
![](https://latex.codecogs.com/gif.latex?F&space;=&space;\frac{\pi}{2&space;&plus;&space;(\frac{\pi^2}{4}-2)(\frac{b}{a})}&space;=&space;\frac{\pi}{2&space;&plus;&space;0.467(\frac{b}{a})})

with flat ends:
![](https://latex.codecogs.com/gif.latex?F&space;=&space;\frac{\pi(2&space;&plus;&space;\frac{b}{a})}{4&space;&plus;&space;\pi(\frac{b}{a})})


For most cells, however, a spheroid shape might be more appropriate because. For an oblate spheroid, common in spongy cells, the equation is:  
![](https://latex.codecogs.com/gif.latex?F&space;=&space;(1&space;&plus;&space;\frac{b^2/a^2}{2e})&space;ln(\frac{1&plus;e}{1-e})&space;/&space;E)


and for a prolate spheroid, common is palisade cells:

![](https://latex.codecogs.com/gif.latex?F&space;=&space;(\frac{b}{a}&plus;\frac{sin^{-1}e}{e})/E)

where _e_ is the eccentricity of the ellipse:

![](https://latex.codecogs.com/gif.latex?e&space;=&space;\sqrt{1&space;-&space;b^2/a^2})

and _E_ is the elliptical integral:

![](https://latex.codecogs.com/gif.latex?E&space;=&space;\int_{0}^{\pi/2}\sqrt{1&space;-&space;(e^2&space;\times&space;sin^2\theta)}d\theta)



Note that Thain (1983) forgot the square root in the elliptical integral function. Spheroid are probably a more representative shape for most cells in the leaf mesophyll, and this is the shape that Evans _et al._ (1994) used.


The elliptical integral is easy to solve in many programming languages. I `R`, this is easily done with the `integrate` function:
```R
E <- integrate(elliptic.integral, lower = 0, upper = pi/2, e=e)
```
where `e` is computed from the eccentricity of the ellipse function above. This function and the elliptic integral are written as

```R
eccentricity.ellipse <- function(b, a) sqrt(1 - (b^2/a^2))
elliptic.integral <- function(x, e) sqrt(1-(e^2 * sin(x)^2))
```


## Installation and use of the code

To install this code, copy this line into your `R` session.
```R
source("https://raw.githubusercontent.com/gtrancourt/curvature_correction/master/curvature_correction.R")
```

The function to compute the curvature correction factor is `Thain.F`:
```R
Thain.F(a, b, shape)
```
where `a` and `b` are the major and minor axes of the spheroid, as above, and `shape`is the shape of the ideal cell, either `prolate`, `oblate` for spheroids, and `hemi` for hemispherical end cylinders and `flat` for flat end cylinders.

The function would be then used as:
```R
> Thain.F(14.98, 13.23, "oblate")
[1] 1.24703
```



## References

__Evans JR, Caemmerer von S, Setchell BA, Hudson GS. 1994.__ T[he relationship between CO<sub>2</sub> transfer conductance and leaf anatomy in transgenic tobacco with a reduced content of rubisco](http://www.publish.csiro.au/FP/fulltext/PP9940475) _Australian Journal of Plant Physiology_ 21: 475–495.

__Thain JF. 1983.__ [Curvature correction factors in the measurement of cell surface areas in plant tissues](https://academic.oup.com/jxb/article-abstract/34/1/87/561221). _Journal of Experimental Botany_ 34: 87–94.
