# processing_audio_offline_fft
a very basic app to export fft audio data to csv files. It handles stereo files and let you export channels separately or joined.


## Setup
1- Install [processing](https://processing.org/) and fire it up.
2- Go to 'sketch' -> 'import library' -> 'add a library'
    - search for 'controlP5' and click install ([controlP5 by Andreas Schlegel](http://www.sojamo.de/libraries/controlP5/))
    - search for 'minim' and click install ([minim by Damien Di Fede and Anderson Mills](http://code.compartmental.net/minim/))
3- You're ready to go : open the "audio_offline_FFT_analysis.pde" file and click on play.

## How-to
1- on startup the program will prompt you to select an audio file to analyze.
    - once it's done, the file path will be displayed in the main window.
2- choose the number of bands you want as a result
3- select an export name (the name will be completed with the options you selected ie number of bands and LEFT, RIGHT or JOIN, and the "csv" extension)
4- click on the analyse you want to perform.
5- you file will be available in the data folder of the sketch.

## Notes

-If you want to analyse Mono files, you can follow the same procedure but be sure to analyse the left channel only.

-Don't forget to name you export !





