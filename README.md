**Application Brief**

**Our Main Work**

- Building an Android application using Android Studio, including – threading and paralleling, graphics and UI, options menus and etc.
- Creating a collection of real popcorn recordings, marking pops manually and creating histograms.
- Testing several algorithms for pops detections in matlab, extracting recoil and precision marks for each.
- Implementing the 2 top algorithms in Java and testing them on Android environment real time, finding its best parameters and comparing results with real recordings.
- Based on experiments, understanding the best way to detect when the bag done. We combined two method we studied, counting method and interval method (will be explained later), in order to achieve best results.
- Making the application suitable for different kind of microwave power options.
- Testing and improving performances, finding and fixing bugs in the application

**Major Remarks**

- The Application has 3 stages in order to detect when the popcorn is done. It combines 2 methodologies – one based on counting pops and the other based on the interval between pops.
- We found that there is a major difference in detection when using high power microwave over low power microwave – so the application handles both conditions (and a medium power microwave too).
- The application records chunks (windows) of 4 seconds and then processes the information. In parallel to processing the previous chunk, the next one is being recorded. Experiments showed it is a sufficient window size.
- The two algorithms used to detect pops are Moving Average and ZamirBerendorf. Moving Average used ongoing average calculation in order to detect large deviations (pops) from the recorded signal, while ZamirBerendorf applies second derivative on the recorded signal in order to detect those deviations. 



**Stages of Operation**

![](docs/imgs/Aspose.Words.72ed42dc-39c9-420a-9082-da4a1e312283.001.png)

1. Idle 
   1. At this stage the application does nothing with the recorded information. The assumption is that at this stage there is no valuable information, so the application is waiting until the major popping activity starts. 
   1. The length of this stage (how much time the app is in idle) is determined by the user's input of the microwave power (low, medium of high). The length for each condition was determined based on experiments.
1. Look for Peak
   1. At this stage the application searches for the peak of the pops activity. The Assumption is that there is that the bag will be done always after a peak, so it is necessary to detect the peak first. 
   1. There are 2 algorithms of detecting peaks – Moving Average and ZamirBerendorf (derivative based). Experiments showed that ZamirBerendorf shows better results for low power microwaves, when popping distribution is less sparse. In contrast, Moving Average shows better results for high power microwaves, when popping distribution in sparser. Hence, the algorithm to be used is determined by the user's input of the microwave power (low, medium of high).
   1. How the peak is found – the application compares the number of pops in each chunk to the previous peak found. If no larger peak found for 5 windows, the application assumes it has passed the peak and move to the next stage. This method resembles finding a maximum in an array by checking if each cell is larger than the previous maximum found.
   1. As a result, the application "knows" it passed the peak only 5 chunks after the peak, but it is a sufficient enough.
   1. This stage uses counting method of pops in a window, so the quality of the detection is less important. We care mainly about detecting the same popping distribution as the in the reality.
1. Look for 2 Sec Interval
   1. At this stage the application searches for a 2 second interval between pops.
   1. This stage uses the same popping detection algorithm as determined in the second stage.
   1. This stage uses interval searching method on the detected pops, as the bag's manufacturer recommends.
   1. When the condition is satisfied, the application notifies the user by playing a sound. This sound can be selected from a list of sounds in the setting menu.

**Real Time Stages Debugging**

![](docs/imgs/Aspose.Words.72ed42dc-39c9-420a-9082-da4a1e312283.002.png)
**


**Screenshots – Startup Screen**


![](docs/imgs/Aspose.Words.72ed42dc-39c9-420a-9082-da4a1e312283.003.png "StartupActivity")


![](docs/imgs/Aspose.Words.72ed42dc-39c9-420a-9082-da4a1e312283.004.png "PowerSoundMenues")

**Screenshots – Recording and Detecting Screen**

![](docs/imgs/Aspose.Words.72ed42dc-39c9-420a-9082-da4a1e312283.005.png "MainActivity")

**Full flow of this sceen:**

![](docs/imgs/Aspose.Words.72ed42dc-39c9-420a-9082-da4a1e312283.006.png "MainActivityScreen")


