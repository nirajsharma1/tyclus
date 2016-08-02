

function dat_ascii = f_dat_ascii(rEEG)

%% converts the .dat file to an ascii file and removes the header from the .txt file %%


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
