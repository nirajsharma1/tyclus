%% function determining the number of channels %%

function all_chans = f_channel_number(EEG)

%% reading the .vhdr file %%

% patient_name = 'JR';
% 
% dir = (['/Users/nsharma/Desktop/pipeline/' patient_name '/']);
% 
% cd ([dir]);
% 
% A_vhdr = ([patient_name '_realigned_GFP_12ms.vhdr']);
% 
% A_or = textread(A_vhdr,'%s','delimiter', '\n');
% 
% ii = 0;
% 
% for l = 1:length(A_or)
%     
% if ~isempty(A_or{l}) && strcmp(A_or{l}(1:2), 'Ch')
%     
%     ii = ii + 1;
%     
%     ind = strsplit(A_or{l}, '=');
%     
%     kar = ind{2};
%     
%     ind_vect = strrep(kar,',, ','');
%     
%     Name{ii} = ind_vect; 
%     
%     ch_name = Name';
%     
%         
% end
% 
% end

total_chan = EEG.nbchan;

all_chans = [1:length(total_chan)];

end

