
function extract_spike = f_extract_spikes_WC_stp2(EEG)

% patient_name = 'JR';

% data_dir = (['/Users/nsharma/Desktop/pipeline/' patient_name '/']);

% cd([data_dir]);

data_filename = ('filt_eeg_data');

load ('spiketype.mat', 'spiketype');

% markers_dir = (['/Users/nsharma/Desktop/PhD/validation/' patient_name '/data_forCP/']);

% cd([markers_dir]);

markers_filename = (['realigned_GFP_filteredEEG_12ms']);

% directory_save_pathway = (['/Users/nsharma/Desktop/PhD/data_processed/' patient_name '/all/data/']);

% cd([directory_save_pathway]);

sample_freq = 4; % in ms
pre_samples = 25; %40 % samples before the spike marker
post_samples = 50; %88 % samples after spike marker
detect_window = 10; % samples of detection window for the maximum
fmin = 4; % low pass cut frequency
fmax = 50; % high pass cut frequency
sr = 4/1000; % sampling rate in s

pre_samples_gr = repmat(pre_samples,7,1);
post_samples_gr = repmat(post_samples,7,1);
detect_window_gr = repmat(detect_window,7,1);

% channels for 20080729SR_ASD
% left_chans = [11 3 25 13 27 15 7];
% right_chans = [12 4 26 14 28 16 8];

% channels for 20091127_DR
% left_chans = [11 41 3 49 25 35 13 43 5 29 51 27 37 15 45 7];
% right_chans = [12 42 4 50 26 36 14 44 6 30 52 28 38 16 46 8];
% front_chans = [1 2 3 17 4 47 33 34 48];
%both_chans = [13 15 27 29 51 12 14 26 28 50];
% both_chans = [11 25 13 27 15 12 26 14];
all_chans = f_channel_number(EEG);
% group_chan_index = ['L'; 'R'];%; 'F'];
% group_chans = [left_chans; right_chans]; %; front_chans];
% group_chans = [4 5 13 20 21 22 23 29 68 69];

% coi = f_coi(patient_name);


load (data_filename)
filt_eeg_data_matrix = filt_eeg_data_matrix; %filt_eeg_data_matrix is transposed due to (')
% We load the file with the markers of the events in the recording
mrk_filename = [markers_filename '.vmrk'];

fid = fopen(mrk_filename);
m_cell = textscan(fid, '%s','delimiter', '\n');
% markers_cell = textscan(fid, '%s %s %s %d %d %d', 'delimiter', '=,');
fclose(fid);

%% adjusting the .vmrk markers file %%

mrk_cell = m_cell{1,1};

ii = 0;

for l = 1:length(mrk_cell)
    
if ~isempty(mrk_cell{l}) && strcmp(mrk_cell{l}(1:2), 'Mk')
    
    ii = ii + 1;
    
    ind = strsplit(mrk_cell{l}, '=');
    
    ind_p1 = ind{1};
    
%     ind_1 = ind_p1';
    
    ind_p2 = strsplit(ind{2}, ',');
    
%     ind_2 = 
    
    kar = cat(2, ind_p1, ind_p2);
    
    mark_cell = kar;
    
    mkers_cell (:,ii) = mark_cell';
    
    sar = mkers_cell';
     
end

end

for i = 1:length(kar)
    
   markers_cell{i} = sar(:,i);
          
end

% 2 is an extra field out of the date in the first line
markers_cell{1}(2) = [];
markers_cell{2}(2) = [];
markers_cell{3}(2) = [];
markers_cell{4}(2) = [];
markers_cell{5}(2) = [];
markers_cell{6}(2) = [];
marker_label = markers_cell{1};
marker_type = markers_cell{2};
marker_description = markers_cell{3};
marker_position = markers_cell{4}; % in data points
marker_size = markers_cell{5}; % in data points
marker_chann = markers_cell{6}; % 0 -> all channels
marker_chann = str2double(marker_chann); % added by NS

% we select the different types of events we have:

pulse_art_elements = strmatch('Pulse Artifact', marker_type);
syncstatus_elements = strmatch('SyncStatus', marker_type);
%spike_elements = strmatch('Cartool', marker_type);
marker1 = strmatch([spiketype], marker_description);
% marker2 = strmatch('C', marker_description);
% marker3 = strmatch('E', marker_description);
% marker4 = strmatch('D', marker_description);
% marker5 = strmatch('A', marker_description);
% marker6 = strmatch('D', marker_description);
% marker7 = strmatch('G', marker_description);
% spike_elements = sort([marker1;marker2]);
spike_elements = sort([marker1]); %marker2;marker3;marker4;marker5]); %marker6;marker7]);
scan_drift_elements = strmatch('Scan Drift', marker_type);
scanner_elements = strmatch('Scanner', marker_type);
pulse_elements = strmatch('pulse', marker_type);

% marker1 = strmatch('Right_frontal', marker_type);

% marker1 = strmatch('"ParietalL"', marker_description);
% marker2 = strmatch('"ParietalL_sharp"', marker_description);
%marker3 = strmatch('"Fronto_centralR"', marker_description);

% spike_sample = double(marker_position(spike_elements)); % original
% spike_chann = double(marker_chann(spike_elements)); % original

spike_sample = marker_position(spike_elements); 
spike_sample = str2double(spike_sample); % added by NS
spike_chann = marker_chann(spike_elements);
spike_chann = str2double(spike_chann); % added by NS

spike_matrix = zeros(length(spike_elements),pre_samples+post_samples, length(eeg_index_vector));

for i = 1:length(spike_elements)
    spike_matrix(i,:,:) = filt_eeg_data_matrix(spike_sample(i)-pre_samples+1:spike_sample(i)+post_samples,:);
end;

% This is old code for re-aligning each channel independently around a
% common marker. PROBLEM: This process losses temporal information of the
% spike wave movement across channels
% for i = 1:length(spike_elements)
% 
%     spike_temp(:,:) = filt_eeg_data_matrix(...
%         spike_sample(i)-detect_window:spike_sample(i)+detect_window, ...
%         :)';
%     [max_spike_val, max_spike_index] = min(spike_temp,[],2);
%     spike_sample_temp = repmat(spike_sample(i),64,1);
%     for j= 1:size(filt_eeg_data_matrix,2)
%         spike_matrix(i,:,j) = filt_eeg_data_matrix(...
%             spike_sample(i)-(pre_samples+detect_window-max_spike_index(j)): ...
%             spike_sample(i)+post_samples-(1+detect_window-max_spike_index(j)), ...
%             j);
%     end;
%     % We refer the times of the spikes to the Cz electrode
%     spike_times_all(i,:) = max_spike_index-max_spike_index(18);
%     % spike_times_gr(i,:)
% 
%     % Saving of the original labels (side)
%     
% end;

% index = spike_sample*4;

index = spike_sample;

out_data_file = ['filt_eeg_spikes'];

save(out_data_file, 'spike_matrix', 'spike_chann', 'spike_sample', ...
    'eeg_index_vector', 'index');
%    'spike_sites', 'spike_gr_matrix', 'group_chans', ...
%    'group_chan_index', 'spikes', 'index', 'spike_gr_matrix_both', ...
%    'both_chans', 'eeg_index_vector', 'spike_times_all', 'spike_times_gr')

% we save the original labels for left and right spikes

marker1_times = marker_position(marker1);
%marker2_times = marker_position(marker2);
%marker3_times = marker_position(marker3);

% left_sp_chan = marker_chann(left_marker);
% right_sp_chan = marker_chann(right_marker);

markers_datafile = ['spikes_markers'];
%save spikes_markers marker1_times marker2_times left_sp_chan right_sp_chan
save (markers_datafile, 'marker1_times');% , 'marker2_times');%, ...
%    'marker3_times');

% save of the details of the spikes we have (time, channel and description)

for i = 1:length(spike_elements)
    spike_description{i} = marker_description{spike_elements(i)};
    spike_position(i) = marker_position(spike_elements(i)); % in data points
    spike_size(i) = marker_size(spike_elements(i)); % in data points
    spike_chann(i) = marker_chann (spike_elements(i)); % 0 -> all channels
end

details_file = ['spike_details'];
save (details_file, 'spike_description', 'spike_position', ...
    'spike_size', 'spike_chann');

end


