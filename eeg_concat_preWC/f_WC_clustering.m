function WC_clustering = f_WC_clustering (EEG)

%% The list of functions to execute prior to processing spike events through Wave Clus %%

f_eeg_data_to_ascii_WC_stp1(EEG);

f_extract_spikes_WC_stp2(EEG);

f_select_ch_polytrode_WC_stp3(EEG);

f_get_eeg_politrode_WC_stp4(EEG);

f_do_clustering_pol_eeg_WC_stp5(EEG);



end