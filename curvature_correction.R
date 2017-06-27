################################################################
################################################################
## R code accompanying the paper by
## Théroux-Rancourt et al. (2017) New Phytologist
##   doi:
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## The most up-to-date version of this code can be found at:
## github.com/gtrancourt/curvature_correction
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## IF YOU USE THIS CODE IN A PUBLICATION,
## PLEASE CITE AS:
## Théroux-Rancourt et al. (2017) New Phytologist
##
##
################################################################
################################################################


# Function to integrate for the elliptic integral (Thain 1983, p. 88, last sentence)
elliptic.integral <- function(x, e) sqrt(1-(e^2 * sin(x)^2))

# Compute the eccentricity of the ellipse
eccentricity.ellipse <- function(b, a) sqrt(1 - (b^2/a^2))

# a: Major axis (longest axis or length of the cell)
# b: Minor axis (shortest axis or diameter of the cell)
# Type: "oblate" - most common for spongy mesophyll (wider than tall)
#       "prolate" - most common for palisade (taller than wide)
#       "hemispherical end cylinder"
#       "flat end cylinder"
Thain.F <- function(a, b, type = "oblate") {
  e <- eccentricity.ellipse(b, a)
  E <- integrate(elliptic.integral, lower = 0, upper = pi/2, e=e)
  
  if(type == "oblate") {
    Thain.F = ( 1 + ((b^2/a^2)/(2*e)) * log((1+e)/(1-e))) / E$value
  }
  if(type == "prolate") {
    Thain.F = ((b/a) + (asin(e))/e) / E$value
  }
  if(type == "hemispherical end cylinder") {
    Thain.F =  pi / (2 + (0.467*(b/a)))
  }
  if(type == "flat end cylinder") {
    Thain.F = pi * (2 + (b/a)) / (4 + (pi * (b/a)))
  }
  
  return(Thain.F)
}

## USAGE EXAMPLES
# For an oblate spheroid
Thain.F(14.98, 13.23, "oblate")
