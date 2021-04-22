## Final Project Proposal  
**Monica Alicea, Kelton Berry, Andrew Caietti, Asha Silva**  

For our final project we will be analyzing the differences in three songs from three different time periods. The first song, Ave Verum Corpus by The Choir of Liverpool Metropolitan Cathedral, was originally composed in 1791. Our second song, Hotel California by the Eagles, was released in 1976. The final song, Levitating by Dua Lipa featuring DaBaby was released in 2021. These three songs will allow us to investigate how song frequencies have changed over time, as well as how they differ cross-genre.   

Our audio files were originally downloaded as .flac from Tidal. We will begin by converting the files into .mp3 format, which will allow us to read the files into R and convert them into time-series objects. From there, we will analyze the time series object using techniques such as periodograms to identify the dominant frequencies, that were introduced in block one. We anticipate extensively using the “twsge” library from R.  

Hypotheses:
- We hypothesize that Ave Verum will have a longer period and may not have a clear dominant frequency due to the presence of multiple types of singers (ie. soprano, base, tenor, alto…).   
- We anticipate that Hotel California will also have longer periodicity, however less so than Ave Verum, yet a clear dominant frequency should be detectable.   
- Finally, we believe that Levitating will have a strong dominant frequency due to the strong bass in the song. Furthermore, we believe that Levitating will be the fastest song we analyze. 
