### Lab Assignment
1. Create a new notebook with a title, your name and date.
1. Review the discussion paper above and provide a brief summary of their objective, methods, and results.
1. Find the data associated with the study (&sect;1.3.3 above) and load them into R data frames. Reproduce Figure 1 from the Lam et al. paper.
1. Correct and/or process the data into a time series
1. Investigate all the data using the sample autocorrelation and periodogram (e.g., create plots, identify patterns such as periodic versus aperiodic behavior, find dominant frequencies)
    * Be sure to include titles, axes labels and legends in your plots
1. Identify El Ni&ntilde;o years (and its dominant frequency) in the datasets you found based on the metrics provided in the paper.
1. Find another time series dataset that may also exhibit El Ni&ntilde;o like patterns: load it into R, analyze it with the tools we have.
1. Describe your conclusions from this lab.
    * What did you do?
    * How did the tools that you used (e.g., sample autocorrelation, periodogram, etc.) work?
    * Were you able to find any patterns in the data?
    * What challenges did you run into (if any) and how did you overcome them?

***

Upload your lab 1 .ipynb (or a .txt file with a share link); note, I need to be able to see it.

Naming scheme:

* username_lab1.ipynb (e.g., dt-woods_lab1.ipynb)
* username_lab1.txt (e.g., dt-woods.lab1.txt)

### Data Files

#### emdat_public.csv / joebarry1_emdat.csv
Source: EM-DAT, CRED / UCLouvain, Brussels, Belgium
www.emdat.be (D. Guha-Sapir)
Version: 2021-02-23
File creation: Tue, 23 Feb 2021 14:10:24
Table type: Custom request
Number of records: 12239

_These data may not be shared outside this class._

#### joebarry1_senatedata.csv
Used for plotting the Democratic proportion of the US Senate from 1865-2018, retrieved from:

- "SENATORS OF THE UNITED STATES." United States Senate, 20 Jan. 2021, www.senate.gov/artandhistory/history/resources/pdf/chronlist.pdf.

#### meiv2.data
Multi-variate ENSO Index (MEI) version 2.
See the [meiv2.data](https://psl.noaa.gov/enso/mei/data/meiv2.data) and [mei.ext](https://psl.noaa.gov/enso/mei.ext/table.ext.html) for complete time series.

#### ONI_data.csv
Tabularized Oceanic Ni&ntilde;o Index (ONI) from NOAA.
_Note the tabular data are truncated to one decimal point._
See [oni.data](https://psl.noaa.gov/data/correlation/oni.data) for complete time series.
