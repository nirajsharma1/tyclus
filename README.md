# TyClus

This document describes how to use TyClus on mac. Tyclus is a Matlab based programme.

Instalation process:

TyClus should be installed with eeglab (https://github.com/jukka/eeglab.git). The bva-io functions (https://github.com/widmann/bva-io.git) should also be addedto the eeglab toolbox.

Description:

Tyclus is a programme that automatically classifies epileptic spikes that have been previously marked by an eeg reviewer.The eeg files to be imported should be in the BrainVision format >> .vhdr, .vmrk and .dat 

Running TyClus:

* Place Tyclus Matlab functions with the eeglab (with bva-io) functions in a directory
* Add the directory to your path >> addpath('full_path here')
* Type >> pipeline_gui into Matlab

