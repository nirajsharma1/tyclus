%% this function converts the .dat file to an ascii file and removes the header from the .txt file %%

function dat_ascii = f_dat_ascii(rEEG)

% patient_name = 'JR';

% dir = (['/Users/nsharma/Desktop/pipeline/gui_test/']);

% cd(dir);

%% converting .dat to ascii %%

% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab('visible','off');

% EEG = pop_loadset('filename', [patient_name '_unfiltered_eeg.set'],'filepath',['/Users/nsharma/Desktop/pipeline/' patient_name '/']);

%  EEG = pop_loadbv('realigned_GFP_filteredEEG_12ms.vhdr'); % loads EEG struct

EEG = rEEG;


% [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

EEG = eeg_checkset(EEG);

pop_export(EEG,['realigned_GFP_filteredEEG_12ms.txt'],'transpose','on','precision',4);

filename = (['realigned_GFP_filteredEEG_12ms.txt']);

%% removing the header of the .txt file %%

txt_mat = importdata(filename);

mat_dat = txt_mat.data;

save(['realigned_GFP_filteredEEG_12ms.txt'], 'mat_dat', '-ascii');



end
