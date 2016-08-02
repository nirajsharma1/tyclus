# Spike realignment

The spike realignment occurs across the channels of interest as determined from those selected from: Spike realignment >> Channels of Interest.

The spike realignment algorithm has a four step process:

* Selecting the time window to realign each pre-defined spike event. The default is +/- 12ms but this can be altered by changing the ‘lv’ variable in the f_spikerealignment function.

* The EEG is the aggressively filtered at 5Hz to eliminate the slow wave. The filtering is carried out using the FilterM_20Jul2011 functions (Copyright (c) 2011, Jan Simon
All rights reserved.).

* For the aggressively filtered EEG, the GFP is calculated across all channels of interest and the spike marker is realigned to the peak of the GFP. 

* The time at which the new spike marker is present is translated to the unfiltered original EEG.

