# ATSA Final Project Proposal
##### Matthew Cheng, David Huang, and Peter Woo
The goal of this project is to try and create a basic music transcription software. The input would be an audio file and the output would be the times at which each different part plays.

  

We will be focusing on a much simpler scenario first by trying to distinguish the sounds of two drums being played at different rhythms in a single audio file.

#### Methodology 
-   First we will examine the audio recordings (with the same sampling rates for the different audio files) of the drums separately and identify the respective frequencies. Since pitch is determined by frequency, this should be enough for us to tell the drums apart.
    
-   Using our knowledge of the individual drums, we will then examine an audio recording of the two drums being played simultaneously. Using a filter, we will try to separate the two different sounds being played based off of their frequencies and spectral signatures.
    
-   Once we have accomplished this, we will attempt to measure our success by comparing the output to what was expected based on the given input. Basically, inspect to see which beats the two different drums were played at to produce the audio file and then compare that with the output. If the two are the same, then we have succeeded.
