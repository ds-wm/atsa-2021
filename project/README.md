# Independent Project
As defined in the syllabus and course description, this class has an independent student research project.
This project will stand for the final exam and, therefore, is due by the end of exam period, which based on the [registrar](https://www.wm.edu/offices/registrar/calendarsandexams/examschedules/spring21exam/index.php#start) is 5 PM on Monday, 10 May 2021.
Requests for extensions must be made one full day before the due date both in writing (e.g., email) and in person (e.g., zoom) and cannot be extended past 10 PM on Tuesday, 18 May 2021.

## Overview
This semester, we will examine the application of time series analysis to audio files.

* You may choose the scope of your analysis and the song/composition.
* You may work in group of up to four.

The structure of the independent project follows the same structure and guidelines as a lab; therefore, it should be written up in a Jupyter Notebook, consist of specific sections, include references, and adhere to the Standards for Submitted Work.
Additionally, you will create either a podcast (audio) or vlog (video) not to exceed 10 minutes in length that summarizes your project.

A successful independent research project is measured by:

1. An informative and well-documented introduction to your study. (Introduction)
1. A logical and reproducible methodology (however complete). (Methods)
1. An insightful reflection on your methods, challenges, and what you were able to accomplish. (Discussion/Conclusions)

In addition to the requirements set forth above, the project report should also include:

1. One or more R plots/figures (with appropriate titles, labels and legends)
2. Table of summarized statistics (e.g., for an audio file, the number of samples, the sampling frequency, the Hertz range)
3. Three or more reputable sources (with appropriate in-text citations), including appropriate attribution to the audio file's originator.
4. Brief description on how you handled stereo sound. While most song files today are recorded in stereo (dual channel), it is recommended that you analyze it in mono (single channel). The most common form of doing that is to take only the left channel.

## Proposals
Once you have formed your group (or are working independently) you should submit a <1 page proposal on your final project.
You may choose to use any of the analysis tools or techniques discussed in class and any experimental or out-of-class tools and techniques (so long as they are reproducible).

Upload your proposals to this repository folder.
Give your file name a title (e.g., sound_scraper.md) and be sure to include everyone's names in the document.

Proposals will be weighed based on their originality (i.e., another project is not doing the same thing) and feasibility.

| Topic | Group Members | Approved |
| :---- | :------------ | :------- |
| Music for Plants | Rini, Jaci and Kimya | Yes |
| Audio Over Time | Monica, Kelton, Andrew and Asha | Yes |
| (Tech) House Music Study | Conrad, Matt M and Keagan | Yes |
| Drums | Matthew C, David, and Peter | Yes |
| Africa: Two renditions | John | Yes |
| Key Change | Joe | Yes |
| Good vs. Bad | Alex | Yes |
| Similarities Between Songs | Ray | Yes |
| Untitled | Julian | Yes |
| Right vs. Left | Katherine | Yes |

## Analysis
You will likely find that music files consist of millions of samples, which can take quite a while to process.
To improve processing time you may perform one of the following:

1. Resample your data (i.e., downscale to a smaller frequency)
2. Smooth your data (e.g., using a filter)
3. Clip your data (e.g., isolate specific 10s to 30s sound bites)

A code snippet on Colab ([.ipynb](https://colab.research.google.com/drive/1IuULZkusjNlO-LMrPhNfiq3UGKWauDCi?usp=sharing)) is provided to help you get started.

**Updates**

- The `tuneR` package has a `play` function that will send your audio file (or Wave object) to your default music player (doesn't seem to work on Colab).
- `tuneR` also has a `writeWave` function that allows you to save audio to a wave (.wav) file format, which you can download and play w/ your preferred audio player.
