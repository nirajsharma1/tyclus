
function eeg_polytrode = f_get_eeg_politrode_WC_stp4(EEG)

% patient_name = 'JR';

% directory_save_pathway = (['/Users/nsharma/Desktop/PhD/data_processed/' patient_name '/all/data/']);

% cd([directory_save_pathway]);

filename = (['sel_ch_spk_filt']);

% directory_save_pathway = '/Users/nsharma/Desktop/PhD/EEGLAB/JR/GFP_realignment/all/data/';

% function for creating a "politrode" with the eeg signals
% we should keep track of the origin of the spikes in case we should
% divide them by areas

load (filename)

pre_samples = 25; % 40
post_samples = 50; % 88
channel_num = size(spike_gr_matrix,3);

% this is to initialize each spike to it's first sample
% initial_sample = spike_gr_matrix(:,1,:);
% initial_sample_matrix = repmat(initial_sample,[1 128 1]);
% spike_gr_matrix = spike_gr_matrix-initial_sample_matrix;

pol_spikes = [];
for i = 1:channel_num
    pol_spikes = [pol_spikes, spike_gr_matrix(:,:,i)];
    
end;

spikes = pol_spikes;
out_filename = ['polytrode_' filename];
save(out_filename, 'spikes', 'index');

end