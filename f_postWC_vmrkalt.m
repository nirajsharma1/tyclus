%This script removes the original sample value for spiketype B with the
%realigned sample value of spiketype B and stores it in a .vmrk file

function vmrk_postWC_filemod = f_postWC_vmrkalt(WC_rEEG, WC_filename, WC_user_class, spiketype, EEG, WC_class_name)

% patient_name = 'JR';

% dir = (['/Users/nsharma/Desktop/pipeline/' patient_name '/']);

% realigned_file_dir = (['/Users/nsharma/Desktop/PhD/data_processed/' patient_name '/all/saved_eeglab_export/eeg_export/']);

% original_file_dir = (['/Users/nsharma/Desktop/PhD/data_processed/' patient_name '/unfiltered_eeg/']);

% cd([dir]);

%% extracting original filename %%

o_name = EEG;
o_vmrk = o_name.comments;
orig = o_vmrk(16:end);

%% Changing to .vmrk %%

o_alt = orig(1:[end - 4]); % removing the .dat extension
vmrk = '.vmrk';

filename_or = strcat(o_alt, vmrk); % replacing it with .vmrk

WC_spikeclasses = ([0: length(WC_class_name) - 1]);

% spikelabel = num2str(WC_spikeclasses);

%% transferring num2str of WC classes assigned during WC clustering %%

% for ka = 1:length(WC_class_name)
%
% %     WC_class_name{ka} = num2str(WC_spikeclasses(ka));
%
%       WC_class_name{ka} = num2str(WC_spikeclasses(ka));
%
% end

spikelabel = WC_class_name; % cell that contains all the WC classes

scanstart_type = 'Scanner';
scanstart = 'Scan Start';
sync_on = 'Sync On';
sync_on_type = 'SyncStatus';
spike_label_type = 'interictal';

% define filename original
% filename_or = ([patient_name '_unfiltered.vmrk']);



% spiketype = spikelabel;

% define filename reordered
filename_new = ([WC_filename '.vmrk']);

% cd([original_file_dir]);

% Read in original file into cell
% Will generate one cell for each line
A_or = textread(filename_or,'%s','delimiter', '\n');

% cd([realigned_file_dir]);

% Read in reordered file into cell
% Will generate one cell for each line
A_new = textread(filename_new,'%s','delimiter', '\n');

% % Copy original information into other variable that we will change
A_tmp = A_new;

% a = 1;


% % A_tmp = A_or;
%
% A_tmp = A_new;
%
% A_tmp2 = A_or;
%
%
%

%% Changing spike type for all the spike classes from 'Stimulus' to 'interictal'

for vr = 1:length(spikelabel) %NS added

    % Define variable to keep count of which number of B pulses we are at
    nr_b = 0;
    % Define variable to keep count of which line in modified textfile was last used
    last_b = 1;

%     ii = 0;
% 
%     ka = 0;

% last_b = 1;

    % obtaining character of WC classes to input into rest of script

    spike_WC = spikelabel(vr);

    spiketype_WC = char(spike_WC);
%
    for l = 1:length(A_tmp)

        if ~isempty(strfind(A_tmp{l}, ([',' spiketype_WC ','])))
            
            new_l = strrep(A_tmp{l}, '=Stimulus', '=interictal');
            
            A_tmp{l} = new_l(1:end-2);
            
        end
        
    end
    
end
            

%% Changing Scan Start type to 'Scanner' %%

for k = 1:length(A_tmp)
    
    if ~isempty(strfind(A_tmp{k}, ([',' scanstart ','])))
        
        new_ss = strrep(A_tmp{k}, '=Stimulus', '=Scanner'); 
        
        A_tmp{k} = new_ss(1:end-2);
        
    end
    
end

%% Changing Sync On type to 'SyncStatus' %%


for v = 1:length(A_tmp)
    
    if ~isempty(strfind(A_tmp{v}, ([',' sync_on ','])))
        
        new_so = strrep(A_tmp{v}, '=Stimulus', '=SyncStatus');

        A_tmp{v} = new_so (1:end-2);
        
    end
    
end


% for s = 1:length(A_tmp)
%     
%     if ~isempty(strfind(A_tmp{s}, (['Mk='])))
%         
%         new_lo = A_tmp
            
%
%             for l_n = last_b:length(A_or)
%
%                 if ~isempty(strfind(A_or{l_n}, ([',' spiketype ','])))
%
%                     ii = ii + 1;
%
%                     if ~isempty(strfind(A_new{l_n}, (['' spiketype_WC ','])));
%
%                         ka = ka + 1;
%
%                         %                     elseif
%
%                         txt = A_new{l_n}(strfind(A_new{l_n}, ([',' spiketype_WC ',']))+1:end);
%
%
%                         new_marker_pos = strtok(txt, ',');
%
%                         length_WC = length(new_marker_pos);
%
%                         %                         txt_end = txt([length_WC + 1]:end);
%
%                         txt_end = txt([length_WC + 1]:end - 2);
%
%
%
%                         last_b = l_n + 1;
%
%                         nr_b = nr_b + 1;
%
%                         break
%
%                     end
%                 end
%             end
%
%             start_pos = strfind(A_tmp{l}, ([',' spiketype_WC ',']));
%
%             start_pos_or = strfind(A_or{l}, ([',' spiketype ',']));
%
%             new_line = [A_or{l}(1:start_pos_or) new_marker_pos txt_end];
%
%             clearvars txt
%
%             %             clearvars txt_end
%
%             A_tmp2{l} = new_line;
%
%         end
%
%     end
%
%     clearvars l_n
%
%     clearvars last_b
%
%     clearvars nr_b
%
% end
%
% % for l=1:length(A_tmp)
% %     % For each line in the original textfile, check if it matches the string: ",B,"
% %     if ~isempty(strfind(A_tmp{l}, ([',' spiketype ','])))
% %         % If it matches, search in the new textfile for a similar string with ",B,"
% %         % Start looking from position it last found a ",B," (last_b), or first line
% %         for l_n=last_b:length(A_new)
% %             if ~isempty(strfind(A_new{l_n}, ([',' spiketype_WC ','])))
% %                 % This line that we found (A_new{l_n}) is the line of text from the new
% %                 % textfile that has ",B," in it
% %
% %                 % the variable txt is all text following ",B," in that line
% %                 txt = A_new{l_n}(strfind(A_new{l_n}, ([',' spiketype_WC ',']))+3:end);
% %                 % From that txt variable, get all text before the first comma
% %                 % This is the new marker position
% %                 new_marker_pos  = strtok(txt, ',');
% %                 % Update last visited line (it starts looking from here next time)
% %                 last_b = l_n+1;
% %                 % increase counter of how many B's we've found
% %                 nr_b = nr_b+1;
% %                 % Stop for-loop
% %                 break
% %             end
% %         end
% %
% %         % Now we've got to put the new marker position into where the
% %         % original marker location was
% %
% %         % This original marker location starts at:
% %         start_pos = strfind(A_tmp{l}, ([',' spiketype ',']))+2;
% %         % Now, get all text following ",B," in the original textfile,
% %         % and put it in the variable txt
% %         txt = A_tmp{l}(strfind(A_tmp{l}, ([',' spiketype ',']))+3:end);
% %         % From that txt variable, get all text before the first comma, put
% %         % that in the variable rubbish (because we don't need it), and put
% %         % all text from the first comma onwards into the variable
% %         % rest_of_line
% %         [rubbish rest_of_line]  = strtok(txt, ',');
% %
% %         % Combine all text up until ",B," from the original textfile with the new marker position and
% %         % the rest_of_line variable into what is now the new line of text
% %         new_line = [A_tmp{l}(1:start_pos) new_marker_pos rest_of_line];
% %         % Put that new line of text into the cell in variable A_tmp
% %         A_tmp{l} = new_line;
% %     end
% % end
% %
% % end
%
% %% Changes the DataFilename in the header %%
%
% dat_filename = ([WC_filename '.dat']);
% for l = 1:length(A_tmp2)
%     if ~isempty(A_tmp2{l}) && strcmp(A_tmp2{l}(1:9), 'DataFile=')
%         A_tmp2{l} = ['DataFile=' dat_filename];
%         break
%     end
% end
% % cd ([target_dir]);
%
%%% Write modified cell to vmrk file
% Define new filename
new_filename = ([WC_filename '.vmrk']);
% Open document with that filename
fid = fopen(new_filename, 'w');
% For each line in A_tmp ...
for l = 1:length(A_tmp)
    % ... write that line to the textfile...
    fprintf(fid, '%s\n', A_tmp{l});
end
% ... and close the file
fclose(fid);


end




