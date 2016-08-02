
function coi = f_coi_test(chann_label, EEG)

%% Identifying the channels of interest %%


coi_EEG = EEG;

ch_o_int = chann_label;

ch_o_int = ch_o_int(~cellfun('isempty',ch_o_int));    
    

%% Loading channel name %%

for i = 1:length(coi_EEG.chanlocs)
    
    labels{i} = coi_EEG.chanlocs(i).labels;
    
    ch_labels = labels';
    
end

%% Identifying channel number %%

for v = 1:length(ch_o_int)

ch_loc = strfind(ch_labels, ch_o_int{v});

ii = 0;

for k = 1:length(ch_loc)
    
    ii = ii + 1;
    
    channel = ch_loc{k,1};
    
    if channel == 1
        
        break
    
    end
    
    
    
end
   
co_inter(v,:) = ii;


end

coi = co_inter;

save('coi')

end

