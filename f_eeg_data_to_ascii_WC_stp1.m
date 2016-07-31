function WC_step1 = f_eeg_data_to_ascii_WC_stp1(EEG)


% patient_name = 'JR';

% dir = (['/Users/nsharma/Desktop/pipeline/gui_test/']);

% cd ([dir]);

rEEG = EEG;

f_dat_ascii(rEEG); % function that converts .dat to ascii

% directory_save_pathway = (['/Users/nsharma/Desktop/PhD/validation/' patient_name '/data_forCP/']);

% cd ([directory_save_pathway]);

sample_freq = 4; % in ms
pre_samples = 25; %40 % samples before the spike marker
post_samples = 50; %88 % samples after spike marker
detect_window = 12; % samples of detection window for the maximum
fmin = 2; % low pass cut frequency
fmax = 75; % (may have to go up to 100) % high pass cut frequency
sr = 4/1000; % sampling rate in s

% filetext = fileread(filename);
% eeg_data_matrix = importdata([patient_name '_val_noindex.txt'])'; %orig

eeg_data_matrix = importdata(['realigned_GFP_filteredEEG_12ms.txt']);

% eeg_data_matrix(1,:) = []; %deletes first row of matrix %original

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

% eeg_index_vector = ['G1  ';	'G2  ';	'G3  ';	'G4  '; ...
%     'G5  ';	'G6  ';	'G7  ';	'G8  '; ...
%     'G9  ';	'G10 ';	'G11 ';	'G12 '; ...
%     'G13 ';	'G14 ';	'G15 ';	'G16 '; ...	
%     'G17 ';	'G18 ';	'G19 ';	'G20 '; ...
%     'G21 ';	'G22 ';	'G23 ';	'G24 '; ...
%     'G25 ';	'G26 ';	'G27 ';	'G28 '; ...
%     'G29 ';	'G30 ';	'G31 ';	'G32 '; ...
%     'G33 ';	'G34 ';	'G35 ';	'G36 '; ...
%     'G37 ';	'G38 ';	'G39 ';	'G40 '; ...
%     'G41 ';	'G42 ';	'G43 ';	'G44 ';	...
%     'G45 ';	'G46 ';	'G47 ';	'G48 ';	...
%     'G49 ';	'G50 ';	'G51 ';	'G52 '; ...	
%     'G53 ';	'G54 ';	'G55 ';	'G56 '; ...
%     'G57 ';	'G58 ';	'G59 ';	'G61 '; ...
%     'G63 ';	'G64 ';	'DA1 ';	'DA2 '; ...
%     'DA3 ';	'DA4 ';	'DP1 ';	'DP2 '; ...
%     'DP3 ';	'DP4 ';	'GA1 ';	'GA2 ';	...
%     'GA3 ';	'GA4 ';	'GA6 ';	'GA7 ';	...
%     'GA9 ';	'GA10';	'GA11';	'GA12'];	



%['Fp1 '; 'Fp2 '; 'F3  '; 'F4  '; ...
    %'C3  ';'C4  ';'P3  ';'P4  '; ...
    %'O1  '; 'O2  ';'F7  ';'F8  '; ...
    %'T7  ';'T8  '; 'P7  '; 'P8  '; ...
    %'Fz  ';'Cz  '; 'Pz  ';'Oz  '; ...
    %'FC1 '; 'FC2 ';'CP1 ';'CP2 '; 'FC5 ';'FC6 '; ...
    %'CP5 '; 'CP6 ';'TP9 ';'TP10'; 'EOG ';'ECG '; ...
    %'AF3 '; 'AF4 ';'FC3 ';'FC4 '; 'CP3 ';'CP4 '; ...
    %'PO3 '; 'PO4 ';'F5  ';'F6  '; 'C5  ';'C6  '; ...
    %'P5  '; 'P6  ';'AF7 ';'AF8 '; 'FT7 ';'FT8 '; ...
    %'TP7 '; 'TP8 ';'PO7 ';'PO8 '; 'FT9 ';'FT10'; ...
    %'P9  '; 'P10 ';'PO9 ';'PO10'; 'O9  ';'O10 '; ...
    %'63  '; 'CPz '];
    
eeg_dat_mat = eeg_data_matrix;

eeg_index_vector = eeg_index_vector(1:size(eeg_dat_mat,2),:);
save (['eeg_data'], 'eeg_dat_mat', 'eeg_index_vector');
save (['filt_eeg_data'], 'filt_eeg_data_matrix', 'eeg_index_vector');

end