
function sel_ch_polytrode = f_select_ch_polytrode_WC_stp3(EEG)

% patient_name = 'JR';

% directory_save_pathway = (['/Users/nsharma/Desktop/pipeline/' patient_name '/']);

% cd([directory_save_pathway]);

filename = (['filt_eeg_spikes']);

load ('coi.mat', 'coi');

% directory_save_pathway = '/Users/nsharma/Desktop/PhD/EEGLAB/JR/GFP_realignment/all/data/';


left_chans = [11 41 3 49 25 35 13 43 5 29 51 27 37 15 45 7];
right_chans = [12 42 4 50 26 36 14 44 6 30 52 28 38 16 46 8];
front_chans = [1 2 3 4 17 63 33 34 47 48];
central_chans = [18 21 22 23 24 5 6];
%both_chans = [13 15 27 29 51 12 14 26 28 50];
% both_chans = [11 25 13 27 15 12 26 14];
% all_chans = f_channel_number(patient_name);

all_chans = f_channel_number(EEG);

%group_chan_index = ['L'; 'R'];%; 'F'];
%group_chans = [front_chans(1:5); central_chans(1:5)];
% coi = f_coi(patient_name); %channels you're interested in (up to 8 - maybe 14)

% group_chans = [4 5 13 14]; %channels you're interested in (up to 8)


load (filename)

spike_gr_matrix = spike_matrix(:,:,coi);
% spike_gr_times = spike_times_all(:,group_chans);

out_filename = ['sel_ch_spk_filt'];

save(out_filename, 'index', 'spike_gr_matrix', 'coi')

end