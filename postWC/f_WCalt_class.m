function WC_user_class = f_WCalt_class(WC_class, WCc_name, cluster_class)

%% altering the name of the WC class to the user defined class %%


wave_clus_class = cluster_class(:,1); % WC assigned classes

diff_c = unique(wave_clus_class); % the diff no. of classes

ii = 0;

ka = 0;

cell_WC = cellstr(WC_class);

for i = 1:length(diff_c)
    
    loc_WC = find(wave_clus_class == diff_c(i));
    
    for v = 1:length(loc_WC)
       
        
            WC_rep = loc_WC(v);
            
            cell_WC(WC_rep) = WCc_name(i);
            
        end
        
    
    
    
end
    
% WC_user_class = char(cell_WC);

WC_user_class = cell_WC;










end