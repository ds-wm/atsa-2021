# Block 2 - Exercise 2.1: Utility Script
# Name: Katherine Lannen
# Class: DATA 330
# Date: 2021-03-26

# ************************************************************************
# Name:     calcSwp
# Inputs:   - double, raw soil water potential in mv (rawWP)
# Returns:  double, soil water potential in kilo Pascals (kPa)
# Features: Calculates and returns soil water potential in kilo Pascals (kPa) from raw (mv).
# ************************************************************************
calcSwp <- function(rawWP){
  a = 0.000048;
  b = 0.0846;
  c = 39.45;
  calWP = 0
  if(rawWP >= 591 & rawWP <= 841){
    calWP = -1.0*exp((a * rawWP * rawWP) - (b * rawWP) + c)
  }
  return(calWP)
}

# ************************************************************************
# Name:     calcVwc
# Inputs:   - double, raw soil moisture in mV (rawSM)
# Returns:  double, soil moisture volumetric (m^3/m^3)
# Features: Calculates and returns soil moisture volumetric (m^3/m^3) from raw (mV).
# ************************************************************************
calcVwc <- function(rawSM){
  A = 0.00119
  B = 0.401
  calSM = 0
  if (rawSM >= 337 & rawSM <= 841){
    calSM = A * rawSM - B
  }
  return(calSM)
}