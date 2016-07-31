%% This function aggressively filters the original EEG to eliminate the slow wave - this should help with the spike realignment %%

function filt_EEG = f_filteeg_prerealignment(EEG)

% switch patient_name

% patient_name = 'JR';

% set_path = (['/Users/nsharma/Desktop/pipeline/' patient_name '/']);

% cd([set_path]);

% set_filename = ([patient_name '_unfiltered_eeg.set']);

% orEEG = pop_loadset([set_filename]); %obtained by loading the dataset onto the GUI of eeglab then typing in the command 'EEG.history'

filtEEG = EEG;

data_filter = '6'; % what you want to filter the signal with - (5Hz)

EEG_for_filt = filtEEG.data;

%% Obtaining the B A values from the butterworth filter %%


% [B,A] = butter (5, 0.04, 'high'); % obtaining the butterworth filter values 
                                   % 5 is 10/2 as we are filtering twice
                                   % therefore we use 5 instead of 10
                                   % 0.04 = 5Hz/125Hz - 5Hz is what we
                                   % want to filter the signal with - 125Hz
                                   % is half of the EEG sample rate

[B,A] = butter (5, 0.048, 'high'); % obtaining the butterworth filter values 
                                   % 5 is 10/2 as we are filtering twice
                                   % therefore we use 5 instead of 10
                                   % 0.048 = 6Hz/125Hz - 6Hz is what we
                                   % want to filter the signal with - 125Hz
                                   % is half of the EEG sample rate
                                   
% [B,A] = butter (5, 0.056, 'high'); % obtaining the butterworth filter values 
                                   % 5 is 10/2 as we are filtering twice
                                   % therefore we use 5 instead of 10
                                   % 0.056 = 7Hz/125Hz - 7Hz is what we
                                   % want to filter the signal with - 125Hz
                                   % is half of the EEG sample rate
                                   
% [B,A] = butter (5, 0.064, 'high'); % obtaining the butterworth filter values 
                                   % 5 is 10/2 as we are filtering twice
                                   % therefore we use 5 instead of 10
                                   % 0.064 = 8Hz/125Hz - 8Hz is what we
                                   % want to filter the signal with - 125Hz
                                   % is half of the EEG sample rate                                  

% [B,A] = butter (5, 0.08, 'high'); % obtaining the butterworth filter values 
                                   % 5 is 10/2 as we are filtering twice
                                   % therefore we use 5 instead of 10
                                   % 0.08 = 10Hz/125Hz - 10Hz is what we
                                   % want to filter the signal with - 125Hz
                                   % is half of the EEG sample rate
%% Once B A values obtained we then include them in the filtfilt function %%
                                 
filtEEG.data = FiltFiltM(B,A,EEG_for_filt,2);

% filtered_eeg = FiltFiltM(B,A,EEG_for_filt,2); % Using FiltFiltM function obtained externally from matlab central
                                   % B and A are obtained from previous
                                   % step. 2 is the second dimension - see
                                   % notes for further explanation of why
                                   % we use 2.

%% Saving the filtered EEG in to a .mat file %%
                                   

filtEEG.fdata = filtEEG.data;

% filtEEG.fdata = filtered_eeg; %transfering the new filtered EEG to the new filtEEG structure - structure with 
                              % filtered eeg is called fdata (located at
                              % the bottom of the structure

filtEEG = eeg_checkset (filtEEG);

% cd ([target_dir]); % changing to the directory I want to save the filtered_EEG

% save ('JR_filtEEG_5.mat','filtEEG'); % saving only the filtered_eeg variable

% pop_writebva(filtEEG, [patient_name '_filtereddata' data_filter 'Hz']); % Saving the new eeg data 

filt_EEG = filtEEG;

end

%% 14.07.2015 - NS created script after meeting with Carlos Pedreira
%% 15.07.2015 - NS decided high pass filter at 5Hz after testing it out on data regarding patient JR_spikeC
%% 28.06.2016 - altered to create as a function for pipeline