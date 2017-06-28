################################################################################
################################################################################
## R code accompanying the paper by
## Théroux-Rancourt et al. (2017) New Phytologist, doi: 10.1111/nph.14687
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## The most up-to-date version of this code can be found at:
## github.com/gtrancourt/curvature_correction
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## IF YOU USE THIS CODE IN A PUBLICATION,
## PLEASE CITE AS:
##  Theroux-Rancourt G, Earles JM, Gilbert ME, Zwieniecki MA, Boyce CK, 
##  McElrone A, Brodersen CR. 2017. The bias of a 2D view: Comparing 2D and 3D
##  mesophyll surface area estimates using non-invasive imaging.
##  New Phytologist, doi: 10.1111/nph.14687
##
################################################################################
################################################################################


# Function to integrate for the elliptic integral 
# (Thain 1983, p. 88, last sentence)
elliptic.integral <- function(x, e) sqrt(1-(e^2 * sin(x)^2))

# Compute the eccentricity of the ellipse
eccentricity.ellipse <- function(b, a) sqrt(1 - (b^2/a^2))

# a: Major axis (longest axis or length of the cell)
# b: Minor axis (shortest axis or diameter of the cell)
# Type: "oblate" - most common for spongy mesophyll (wider than tall)
#       "prolate" - most common for palisade (taller than wide)
#       "hemi" - hemispherical end cylinder
#       "flat" - flat end cylinder
Thain.F <- function(a, b, shape = "oblate") {
  e <- eccentricity.ellipse(b, a)
  E <- integrate(elliptic.integral, lower = 0, upper = pi/2, e=e)
  
  if(type == "oblate") {
    Thain.F = ( 1 + ((b^2/a^2)/(2*e)) * log((1+e)/(1-e))) / E$value
  }
  if(type == "prolate") {
    Thain.F = ((b/a) + (asin(e))/e) / E$value
  }
  if(type == "hemi") {
    Thain.F =  pi / (2 + (0.467*(b/a)))
  }
  if(type == "flat") {
    Thain.F = pi * (2 + (b/a)) / (4 + (pi * (b/a)))
  }
  
  return(Thain.F)
}

## USAGE EXAMPLES
# For an oblate spheroid
Thain.F(14.98, 13.23, "oblate")
