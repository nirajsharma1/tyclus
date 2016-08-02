function vmrk_postWC_filemod = f_postWC_vmrkalt(EEG, classes)

%% transfers WC classes to realigned EEG to create a new WC classified .vmrk, .vhdr and .dat file %%


WC_EEG = EEG;

WCc_name = classes;

WC_class_name = WCc_name(~cellfun('isempty', WCc_name));

load ('spiketype', 'spiketype'); % loading original spiketype

load ('times_polytrode_sel_ch_spk_filt', 'cluster_class'); % loading WC class

WC_class = num2str(cluster_class(:,1));

WC_user_class = f_WCalt_class(WC_class, WC_class_name, cluster_class);

ii = 0;

for i = 1:length(WC_EEG.event)
    
    if isequal(WC_EEG.event(i).type, spiketype)
        
        ii = ii + 1;
        
        WC_EEG.event(i).type = char(WC_user_class(ii)); % replacing original spike class with new WC spike class
        
        



    end




end

    new_WC_EEG = eeg_checkset(WC_EEG);
    
    WC_rEEG = new_WC_EEG;
    
    WC_filename = ('WC_classified_EEG');
    
    pop_writebva(WC_rEEG, [WC_filename]); % saving the new EEG data
    
    f_postWC_vmrkalt(WC_rEEG, WC_filename, WC_user_class, spiketype, EEG, WC_class_name);


end
