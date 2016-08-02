function WC_step1 = f_eeg_data_to_ascii_WC_stp1(EEG)

% Converting .dat file to ascii and Band pass filtering EEG (2-75Hz)

rEEG = EEG;

f_dat_ascii(rEEG); % function that converts .dat to ascii

sample_freq = 4; % in ms
pre_samples = 25; %40 % samples before the spike marker
post_samples = 50; %88 % samples after spike marker
detect_window = 12; % samples of detection window for the maximum
fmin = 2; % low pass cut frequency
fmax = 75; % (may have to go up to 100) % high pass cut frequency
sr = 4/1000; % sampling rate in s


eeg_data_matrix = importdata(['realigned_GFP_filteredEEG_12ms.txt']);

eeg_data_matrix(:,1) = []; %deletes first row of matrix %original


for i = 1:size(eeg_data_matrix,2)

    channel_to_filt = eeg_data_matrix(:,i);

    [b,a]=ellip(2,0.1,40,[fmin fmax]*2*sr);
    filt_eeg_data_matrix(:,i)=filtfilt(b,a,channel_to_filt);
    
end;


%% creating the eeg index vector

A_vhdr = (['realigned_GFP_filteredEEG_12ms.vhdr']);

A_or = textread(A_vhdr,'%s','delimiter', '\n');

ii = 0;

for l = 1:length(A_or)
    
if ~isempty(A_or{l}) && strcmp(A_or{l}(1:2), 'Ch')
    
    ii = ii + 1;
    
    ind = strsplit(A_or{l}, '=');
    
    kar = ind{2};
    
    ind_vect = strrep(kar,',, ','');
    
    Name{ii} = ind_vect; 
    
    ch_name = Name';
    
    eeg_index_vector = char(ch_name);

 
    
end

end

    
eeg_dat_mat = eeg_data_matrix;

eeg_index_vector = eeg_index_vector(1:size(eeg_dat_mat,2),:);
save (['eeg_data'], 'eeg_dat_mat', 'eeg_index_vector');
save (['filt_eeg_data'], 'filt_eeg_data_matrix', 'eeg_index_vector');

end