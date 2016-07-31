
patient_name = 'JR';

target_dir = (['/Users/nsharma/Desktop/pipeline/' patient_name '/']);

cd([target_dir]);

vhdr_filename_or = ([patient_name '_realigned_GFP_12ms.vhdr']);

vhdr_filename_new = ([patient_name '_WC_classification.vhdr']);

vmrk_filename_or = ([patient_name '_realigned_GFP_12ms.vmrk']);

vmrk_filename_new = ([patient_name '_WC_classification.vmrk']);

dat_filename_or = ([patient_name '_realigned_GFP_12ms.dat']);

dat_filename_new = ([patient_name '_WC_classification.dat']);

vmrk_or = textread(vmrk_filename_or, '%s', 'delimiter', '\n');

vhdr_or = textread(vhdr_filename_or, '%s', 'delimiter', '\n');

for l = 1:length(vmrk_or)
    if ~isempty(vmrk_or{l}) && strcmp(vmrk_or{l}(1:9), 'DataFile=')
        vmrk_or{l} = ['DataFile=' dat_filename_new];
        break
    end
end

ii = 0;
for m = 1:length(vhdr_or)
    
    ii = ii + 1;
    
    if ~isempty(vhdr_or{m}) && strcmp(vhdr_or{m}(1:9), 'DataFile=')
        vhdr_or{m} = ['DataFile=' dat_filename_new];
              
%         break
        
        if ~isempty(vhdr_or{ii}) && strcmp(vhdr_or{ii}(1:11), 'MarkerFile=')
          vhdr_or{ii} = ['MarkerFile=' vmrk_filename_new];  
            break
            
        end
    end
end
