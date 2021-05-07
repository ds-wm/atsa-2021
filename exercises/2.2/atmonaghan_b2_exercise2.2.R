# Alex Monaghan
# Professor Davis
# ATSA
# 9 April 2021

# Applied Time Series Analysis
# Exercise 2.2
# code snippet author: Tyler W. Davis, William & Mary
# created: 2021-03-27
# updated: 2021-03-29
#
# PROBLEM STATEMENT: Calculate the half-hourly solar radiation values based 
# on the gap-filling method provided. Update SPLASH's `solar.R` to provide 
# the half-hourly extraterrestrial values. Overlay the values from the 
# AmeriFlux site with the gap-filled values to produce a complete time series.
# Create a plot that shows original and gap-filled values.
# - use a dotted red line to indicate the gap-filled values
# - use a solid blue line to indicate original flux measurements
# Put everything together in a single R script that reads the data, does the 
# calculations, and plots the two curves together. Be sure to include a title, 
# legend and labels in your plot.
#
# The following is taken from the v1 release of the SPLASH code.
# References: 
# - https://doi.org/10.5194/gmd-10-689-2017
# - https://bitbucket.org/labprentice/splash/src/master/
#
# ---------------------------------------------------------------------------
#                            BEGIN SPLASH CODE
# ---------------------------------------------------------------------------
# GLOBAL VARIABLES
kA <- 107           # constant for Rl (Monteith & Unsworth, 1990)
kalb_sw <- 0.17     # shortwave albedo (Federer, 1968)
kalb_vis <- 0.03    # visible light albedo (Sellers, 1985)
kb <- 0.20          # constant for Rl (Linacre, 1968; Kramer, 1957)
kc <- 0.25          # constant for Rs (Linacre, 1968)
kd <- 0.50          # constant for Rs (Linacre, 1968)
kfFEC <- 2.04       # from-flux-to-energy, umol/J (Meek et al., 1984)
kGsc <- 1360.8      # solar constant, W/m^2 (Kopp & Lean, 2011)
kSecInDay <- 86400  # number of seconds in a day
pir <- pi/180       # pi in radians

# Paleoclimate variables:
ke <- 0.01670       # eccentricity of earth's orbit, 2000CE (Berger 1978)
keps <- 23.44       # obliquity of earth's elliptic, 2000CE (Berger 1978)
komega <- 283       # lon. of perihelion, degrees, 2000CE (Berger, 1978)


# ************************************************************************
# Name:     berger_tls
# Inputs:   - double, day of year (n)
#           - double, days in year (N)
# Returns:  numeric list, true anomaly and true longitude
# Features: Returns true anomaly and true longitude for a given day.
# Depends:  - ke ............. eccentricity of earth's orbit, unitless
#           - komega ......... longitude of perihelion
#  Ref:     Berger, A. L. (1978), Long term variations of daily insolation
#             and quaternary climatic changes, J. Atmos. Sci., 35, 2362-2367.
# ************************************************************************
berger_tls <- function(n, N) {
  # Variable substitutes:
  xee <- ke^2
  xec <- ke^3
  xse <- sqrt(1 - ke^2)
  
  # Mean longitude for vernal equinox:
  xlam <- (ke/2.0 + xec/8.0)*(1 + xse)*sin(komega*pir) -
    xee/4.0*(0.5 + xse)*sin(2.0*komega*pir) +
    xec/8.0*(1.0/3.0 + xse)*sin(3.0*komega*pir)
  xlam <- 2.0*xlam/pir
  
  # Mean longitude for day of year:
  dlamm <- xlam + (n - 80.0)*(360.0/N)
  
  # Mean anomaly:
  anm <- dlamm - komega
  ranm <- anm*pir
  
  # True anomaly (uncorrected):
  ranv <- ranm + (2.0*ke - xec/4.0)*sin(ranm) +
    5.0/4.0*xee*sin(2.0*ranm) +
    13.0/12.0*xec*sin(3.0*ranm)
  anv <- ranv/pir
  
  # True longitude:
  my_tls <- anv + komega
  if (my_tls < 0){
    my_tls <- my_tls + 360
  } else if (my_tls > 360) {
    my_tls <- my_tls - 360
  }
  
  # True anomaly:
  my_nu <- my_tls - komega
  if (my_nu < 0){
    my_nu <- my_nu + 360
  }
  return (c(my_nu, my_tls))
}


# ************************************************************************
# Name:     dcos
# Inputs:   double (d), angle in degrees
# Returns:  double, cosine of angle
# Features: This function calculates the cosine of an angle (d) given
#           in degrees.
# Depends:  pir
# Ref:      This script is based on the Javascript function written by
#           C Johnson, Theoretical Physicist, Univ of Chicago
#           - 'Equation of Time' URL: http://mb-soft.com/public3/equatime.html
#           - Javascript URL: http://mb-soft.com/believe/txx/astro22.js
# ************************************************************************
dcos <- function(d) {
  cos(d*pir)
}


# ************************************************************************
# Name:     dsin
# Inputs:   double (d), angle in degrees
# Returns:  double, sine of angle
# Features: This function calculates the sine of an angle (d) given
#           in degrees.
# Depends:  pir
# ************************************************************************
dsin <- function(d) {
  sin(d*pir)
}


# ************************************************************************
# Name:     calc_daily_solar
# Inputs:   - double, latitude, degrees (lat)
#           - double, day of year (n)
#           - double, elevation (elv)  *optional
#           - double, year (y)         *optional
#           - double, fraction of sunshine hours (sf)        *optional
#           - double, mean daily air temperature, deg C (tc) *optional
# Returns:  list object (et.srad)
#             $nu_deg ............ true anomaly, degrees
#             $lambda_deg ........ true longitude, degrees
#             $dr ................ distance factor, unitless
#             $delta_deg ......... declination angle, degrees
#             $hs_deg ............ sunset angle, degrees
#             $ra_j.m2 ........... daily extraterrestrial radiation, J/m^2
#             $tau ............... atmospheric transmittivity, unitless
#             $ppfd_mol.m2 ....... daily photosyn. photon flux density, mol/m^2
#             $hn_deg ............ net radiation hour angle, degrees
#             $rn_j.m2 ........... daily net radiation, J/m^2
#             $rnn_j.m2 .......... daily nighttime net radiation, J/m^2
# Features: This function calculates daily radiation fluxes.
# Depends:  - kalb_sw ........ shortwave albedo
#           - kalb_vis ....... visible light albedo
#           - kb ............. empirical constant for longwave rad
#           - kc ............. empirical constant for shortwave rad
#           - kd ............. empirical constant for shortwave rad
#           - ke ............. eccentricity
#           - keps ........... obliquity
#           - kfFEC .......... from-flux-to-energy conversion, umol/J
#           - kGsc ........... solar constant
#           - berger_tls() ... calc true anomaly and longitude
#           - dcos() ......... cos(x*pi/180), where x is in degrees
#           - dsin() ......... sin(x*pi/180), where x is in degrees
#           - julian_day() ... date to julian day
# ************************************************************************
calc_daily_solar <- function(lat, n, elv=0, y=0, sf=1, tc=23.0) {
  # ~~~~~~~~~~~~~~~~~~~~~~~~ FUNCTION WARNINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
  if (lat > 90 || lat < -90) {
    stop("Warning: Latitude outside range of validity (-90 to 90)!")
  }
  if (n < 1 || n > 366) {
    stop("Warning: Day outside range of validity (1 to 366)!")
  }
  
  # ~~~~~~~~~~~~~~~~~~~~~~~ FUNCTION VARIABLES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
  solar <- list()
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 01. Calculate the number of days in yeark (kN), days
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  if (y == 0) {
    kN <- 365
  } else {
    kN <- (julian_day(y + 1, 1, 1) - julian_day(y, 1, 1))
  }
  solar$kN <- kN
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 02. Calculate heliocentric longitudes (nu and lambda), degrees
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  my_helio <- berger_tls(n, kN)
  nu <- my_helio[1]
  lam <- my_helio[2]
  solar$nu_deg <- nu
  solar$lambda_deg <- lam
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 03. Calculate distance factor (dr), unitless
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Berger et al. (1993)
  kee <- ke^2
  rho <- (1 - kee)/(1 + ke*dcos(nu))
  dr <- (1/rho)^2
  solar$rho <- rho
  solar$dr <- dr
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 04. Calculate the declination angle (delta), degrees
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Woolf (1968)
  delta <- asin(dsin(lam)*dsin(keps))
  delta <- delta/pir
  solar$delta_deg <- delta
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 05. Calculate variable substitutes (u and v), unitless
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ru <- dsin(delta)*dsin(lat)
  rv <- dcos(delta)*dcos(lat)
  solar$ru <- ru
  solar$rv <- rv
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 06. Calculate the sunset hour angle (hs), degrees
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Note: u/v equals tan(delta) * tan(lat)
  if (ru/rv >= 1.0) {
    hs <- 180  # Polar day (no sunset)
  } else if (ru/rv <= -1.0) {
    hs <- 0 # Polar night (no sunrise)
  } else {
    hs <- acos(-1.0*ru/rv)
    hs <- hs / pir
  }
  solar$hs_deg <- hs
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 07. Calculate daily extraterrestrial radiation (ra_d), J/m^2
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ref: Eq. 1.10.3, Duffy & Beckman (1993)
  ra_d <- (86400/pi)*kGsc*dr*(ru*pir*hs + rv*dsin(hs))
  solar$ra_j.m2 <- ra_d
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 08. Calculate transmittivity (tau), unitless
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ref:  Eq. 11, Linacre (1968); Eq. 2, Allen (1996)
  tau_o <- (kc + kd*sf)
  tau <- tau_o*(1 + (2.67e-5)*elv)
  
  solar$tau_o <- tau_o
  solar$tau <- tau
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 09. Calculate daily photosynthetic photon flux density (ppfd_d), mol/m^2
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ppfd_d <- (1e-6)*kfFEC*(1 - kalb_vis)*tau*ra_d
  solar$ppfd_mol.m2 <- ppfd_d
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 10. Estimate net longwave radiation (rnl), W/m^2
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  rnl <- (kb + (1 - kb)*sf)*(kA - tc)
  solar$rnl_w.m2 <- rnl
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 11. Calculate variable substitue (rw), W/m^2
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  rw <- (1 - kalb_sw)*tau*kGsc*dr
  solar$rw <- rw
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 12. Calculate net radiation cross-over angle (hn), degrees
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  if ((rnl - rw*ru)/(rw*rv) >= 1.0) {
    hn <- 0  # Net radiation is negative all day
  } else if ((rnl - rw*ru)/(rw*rv) <= -1.0) {
    hn <- 180 # Net radiation is positive all day
  } else {
    hn <- acos((rnl - rw*ru)/(rw*rv))
    hn <- hn/pir
  }
  solar$hn_deg <- hn
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 13. Calculate daytime net radiation (rn_d), J/m^2
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  rn_d <- (86400/pi)*(hn*pir*(rw*ru - rnl) + rw*rv*dsin(hn))
  solar$rn_j.m2 <- rn_d
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # 14. Calculate nighttime net radiation (rnn_d), J/m^2
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # fixed iss#13
  rnn_d <- (86400/pi)*(
    rw*rv*(dsin(hs) - dsin(hn)) +
      rw*ru*(hs - hn)*pir -
      rnl*(pi - hn*pir)
  )
  solar$rnn_j.m2 <- rnn_d
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~ RETURN VALUES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
  return(solar)
}


# ************************************************************************
# Name:     julian_day
# Inputs:   - double, year (y)
#           - double, month (m)
#           - double, day of month (i)
# Returns:  double, Julian day
# Features: This function converts a date in the Gregorian calendar
#           to a Julian day number (i.e., a method of consecutative
#           numbering of days---does not have anything to do with
#           the Julian calendar!)
#           * valid for dates after -4712 January 1 (i.e., jde >= 0)
# Ref:      Eq. 7.1 J. Meeus (1991), Chapter 7 "Julian Day", Astronomical
#             Algorithms
# ************************************************************************
julian_day <- function(y, m, i) {
  if (m <= 2) {
    y <- y - 1
    m <- m + 12
  }
  a <- floor(y/100)
  b <- 2 - a + floor(a/4)
  
  jde <- floor(365.25*(y + 4716)) + floor(30.6001*(m + 1)) + i + b - 1524.5
  return(jde)
}

# ---------------------------------------------------------------------------
#                            END SPLASH CODE
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
#                            BEGIN NEW CODE
# ---------------------------------------------------------------------------


# ************************************************************************
# Name:     spencer_eot
# Input:    - int, day of the year (n)
#           - int, days in current year (N)
# Output:   float, equation of time, hours
# Features: Returns the equation of time
# Depends:  - dcos
#           - dsin
# Ref:      Spencer, J.W. (1971), Fourier series representation of the
#           position of the sun, Search, 2 (5), p. 172.
# ************************************************************************
spencer_eot <- function(n, N) {
  B <- 2.0*pi*(n - 1.0)/N
  my_eot <- (7.5e-6)
  my_eot <- my_eot + (1.868e-3)*dcos(B)
  my_eot <- my_eot - (3.2077e-2)*dsin(B)
  my_eot <- my_eot - (1.4615e-2)*dcos(2.0*B)
  my_eot <- my_eot - (4.0849e-2)*dsin(2.0*B)
  my_eot <- my_eot * (12.0/pi)
  return(my_eot)
}


# ************************************************************************
# Name:     calc_daily_fluxes
# Inputs:   - float, latitude, degrees N (lat)
#           - float, longitude, degrees E (lon)
#           - int, day of year (n)
#           - float, elevation above mean sea level, m (elv)
#           - int, current year (y)
# Returns:  list object (solar)
# Features: Calculates the half-hourly extraterrestrial solar radiation 
#           flux based on the GePiSaT model.
# Depends:  - calc_daily_solar
#           - dcos
#           - spencer_eot
# Ref:      solar.py from the gepisat module of py_version
#           https://bitbucket.org/labprentice/gepisat/src/master/
# ************************************************************************
calc_daily_fluxes <- function(lat, lon, n, elv, y){
  # ~~~~~~~~~~~~~~~~~~~~~~~ FUNCTION VARIABLES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
  solar <- list()
  
  # Take advantage of our existing function
  daily.solar <- calc_daily_solar(lat, n, elv, y)
  dr <- daily.solar$dr
  ru <- daily.solar$ru
  rv <- daily.solar$rv
  kN <- daily.solar$kN
  
  # What do we need?
  # x io_hh (<-- the half-hourly Io values we want!)
  #   x w_hh
  #     x ts_hh
  #       x local_hh
  #       x eot (create spencer_eot function)
  #       x lonc
  #         x lon (added to input)
  #         x tz_hour
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Create local time series, hours
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  local_hh <- seq(from = 0, to = 23.5, by = 0.5)
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Calculate time zone hour, hours
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  if (lon < 0) {
    # Swap sign to "round down" negative numbers:
    temp_lon <- -1.0*lon
    temp_tzh <- floor(temp_lon/15)  # floor makes integers
    tz_hour <- -1.0*temp_tzh        # out of floats
  } else {
    tz_hour <- floor(lon/15)
  }
  solar$tz_hour <- tz_hour
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Calculate the equation of time, hours
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Spencer (1971)
  eot <- spencer_eot(n, kN)
  solar$eot_hour <- eot
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Calculate the longitude correction, hours
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  lonc <- (15.0*tz_hour - lon)/15.0
  solar$lc_hour <- lonc
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Calculate the solar time, hours
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ts_hh <- local_hh + eot - lonc
  solar$ts_hh <- ts_hh
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Calculate the hour angle, degrees
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  w_hh <- (360./24.)*(ts_hh - 12.0)
  solar$w_hh <- w_hh
  
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Calculate the half-hourly solar radiation flux, W/m^2
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  io_hh <- kGsc*dr*(ru + rv*dcos(w_hh))
  io_hh[io_hh < 0] <- 0  # UPDATED FROM numpy.clip
  solar$io_wm2 <- io_hh
  
  return(solar)
}


# ---------------------------------------------------------------------------
#                            TESTING (US-Goo)
# ---------------------------------------------------------------------------

my.lat <- 34.2547
my.lon <- -89.8735
my.elv <- 87
my.n <- 230
my.y <- 2021
my.solar <- calc_daily_fluxes(my.lat, my.lon, my.n, my.elv, my.y)

# Read data into a data frame
flux12.url <- "https://ds-wm.github.io/course/atsa/data/FLX_US-Goo_FLUXNET2015_SUBSET_HH_2003-12_1-4.csv"
flux12.df <- read.csv(flux12.url)

# Extract the variable of interest and fix NA values (-9999)
# see "missing data" here: https://fluxnet.org/data/aboutdata/data-variables/
flux12.ppfd <- flux12.df$PPFD_IN
flux12.ppfd[which(flux12.ppfd == -9999)] <- NA

# Plot the data w/ gaps
options(repr.plot.width=14, repr.plot.height=6, repr.plot.res = 125)
plot(
  flux12.ppfd, 
  type = 'l', 
  xlab = "Half-hourly samples", 
  ylab = bquote("PPFD " ~ mu ~ "mol" ~ m^{-2} ~ s^{-1}),
  main = "Missing Photosynthetic Radiation - AmeriFlux US-Goo (2003-12)"
)

# Data citation: Weedon et al., (2018)
watch.url <- "https://ds-wm.github.io/course/atsa/data/watch_swdown_us-goo.csv"
watch.df <- read.csv(watch.url)

# Subset df for 2003, the year with gap filled values
sw2003 <- watch.df[, c("DayOfMonth", "SWdown_2003.12")]

form <- c()
for (i in seq(1:32)){
  n <- julian_day(2003, 12, i) - julian_day(2003, 1, 1)+1
  sw <- sw2003[i, "SWdown_2003.12"] * kSecInDay
  h0 <- calc_daily_solar(my.lat, n, my.elv, y=2003)$ra_j.m2
  i0 <- calc_daily_fluxes(my.lat, my.lon, n, my.elv, y=2003)$io_wm2
  calc <- 2.04 * (sw/h0) * i0
  form <- c(form, calc)
}

gap <- c()
for (i in 1:length(flux12.ppfd)){
  if (is.na(flux12.ppfd[i])){
    gap <- c(gap, form[i])
  }
  else {
    gap <- c(gap, NA)
  }
}

gap_ts <- ts(gap)
flux12.ppfd_ts <- ts(flux12.ppfd)

par(bg = "grey")
plot(flux12.ppfd_ts, type = 'l', col = "black", xlab = 'Time', ylab = 'Flux Level', main = 'Gap-Filled Solar Data')
lines(gap_ts, col = "red")
legend(925, 750, legend=c("Gap-Filled", "Original"),
       col=c("red", "black"), lty=1)
