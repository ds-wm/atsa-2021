# Instructions

1. Calculate the half-hourly solar radiation values based on the gap-filling method provided above.
    - You will need to update `solar.R` to provide the half-hourly values as it only calculates $H_o$ in its present form
1. Overlay the values from the AmeriFlux site with the gap-filled values to produce a complete time series.
1. Create a plot that shows original and gap-filled values
    - Use a dotted red line to indicate the gap-filled values 
    - Use a solid blue line to indicate original flux measurements
1. Put everything together in a single R script that reads the data, does the calculations, and plots the two curves together.
    - Be sure to include a title, legend and labels in your plot.
    - If working together, be sure to include everyone's name in the comments at the top of the script
