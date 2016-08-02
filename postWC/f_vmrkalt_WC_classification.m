
function vmrk_WC_alteration = f_vmrkalt_WC_classification(patient_name)

%% Altering the realigned .Markers file to the new WC classification %%
%% With help from Nelly Richard %%


patient_name = 'JR';

WC_classification = {'Nonspike', 'G23', 'G4_5', 'G13_22_DP2_3' ,'G13_21_22_23_25_DP2_3'}; % varies for each patient

target_dir = (['/Users/nsharma/Desktop/pipeline/' patient_name '/']);

cd([target_dir]);

load(['times_polytrode_sel_ch_spk_filt_' patient_name '.mat']);

filename = ([patient_name '_realigned_GFP_12ms.vmrk']);

% A_or = textread(filename,'%s','delimiter', '\n');

A_or = textread(filename,'%s', 'delimiter','\n');

% vri = {'Type', 'Descr', 'Pos', 'Length', 'Chann'};

%% identifying the number of lines in the header %%

vr = 0;

for v = 1:length(A_or)
    
    vr = vr + 1;
    
    if ~isempty(A_or{v}) && strcmp(A_or{v}(1:2), 'Mk')
        
%         vr = vr + 1;
        
        break
        
    end
    
end

A_tmp = A_or(1:[vr - 1]);

%% seperating the information in the .vmrk files %%

ii = 0;

for l = 1:length(A_or)
    
    if ~isempty(A_or{l}) && strcmp(A_or{l}(1:2), 'Mk')
       
    ii = ii + 1;
        
    ind = strsplit(A_or{l},',');
    
    kar(:,ii) = ind;
    
    sar = kar';

       
    end  
    
end

Type = sar(:,1);
Descr = sar(:,2);
Pos = sar(:,3);
Length = sar(:,4);
Chann = sar(:,5);

% [Type Descr Pos Length Chann] = textread(filename,'%s %s %s %s %s', 'delimiter',',');

% for l = 1:lenght()

%% altering the original classification to WC classification and creating a new WC altered .vmrk, .vhdr and .dat file  %%

spike_idx = find(~cellfun(@isempty,regexp(Descr,'^[A-Z]$')));

found_Desc = Descr(spike_idx);

Descr(spike_idx) = cellstr(num2str(cluster_class(:,1)));

for i = 1 : length(spike_idx)
   % Change the name of the marker
   equal_idx = regexp(Type{spike_idx(i)},'=');
%    cl
   Type{spike_idx(i)} = [Type{spike_idx(i)}(1:equal_idx) WC_classification{cluster_class(i,1)+1}];
end

new_file = table(Type, Descr, Pos, Length, Chann);

filename = ([patient_name '_WC_classification.txt']);

writetable(new_file,filename, 'Delimiter',',','WriteVariableNames',0);

movefile(filename, [patient_name '_WC_classification.vmrk']);

new_filename = ([patient_name '_WC_classification.vmrk']);

A_adj = textread(new_filename,'%s', 'delimiter','\n');

WC_vmrk_file = vertcat(A_tmp, A_adj);

WC_filename = ([patient_name '_realigned_GFP_12ms.vmrk']);

fileID = fopen(WC_filename, 'w');

for k = 1:length(WC_vmrk_file)
    
   fprintf(fileID, '%s\n', WC_vmrk_file{k}); 
    
end

fclose(fileID);

end


%% 13.07.2016 %%

