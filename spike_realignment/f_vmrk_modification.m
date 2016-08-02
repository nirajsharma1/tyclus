function vmrk_file_modification = f_vmrk_modification(EEG, spikelabel)

%% Altering .vmrk file to remove 'Stimulus' type and replace it with original type %% 


%% extracting original filename %%

o_name = EEG;
o_vmrk = o_name.comments;
orig = o_vmrk(16:end);

%% Changing to .vmrk %%

o_alt = orig(1:[end - 4]); % removing the .dat extension
vmrk = '.vmrk';
filename_or = strcat(o_alt, vmrk); % replacing it with .vmrk


spiketype = spikelabel;

% define filename reordered
filename_new = ('realigned_GFP_filteredEEG_12ms.vmrk');


% Read in original file into cell
% Will generate one cell for each line
A_or = textread(filename_or,'%s','delimiter', '\n');

% cd([realigned_file_dir]);

% Read in reordered file into cell
% Will generate one cell for each line
A_new = textread(filename_new,'%s','delimiter', '\n');


% Copy original information into other variable that we will change
A_tmp = A_or;

% Define variable to keep count of which number of B pulses we are at
nr_b = 0;
% Define variable to keep count of which line in modified textfile was last used
last_b = 1;


for l=1:length(A_tmp)
    % For each line in the original textfile, check if it matches the string: ",B,"
    if ~isempty(strfind(A_tmp{l}, ([',' spiketype ','])))
        % If it matches, search in the new textfile for a similar string with ",B,"
        % Start looking from position it last found a ",B," (last_b), or first line
        for l_n=last_b:length(A_new)
            if ~isempty(strfind(A_new{l_n}, ([',' spiketype ','])))
                % This line that we found (A_new{l_n}) is the line of text from the new
                % textfile that has ",B," in it
                
                % the variable txt is all text following ",B," in that line
                txt = A_new{l_n}(strfind(A_new{l_n}, ([',' spiketype ',']))+3:end);
                % From that txt variable, get all text before the first comma
                % This is the new marker position
                new_marker_pos  = strtok(txt, ',');
                % Update last visited line (it starts looking from here next time)
                last_b = l_n+1;
                % increase counter of how many B's we've found
                nr_b = nr_b+1;
                % Stop for-loop
                break
            end
        end
        
        % Now we've got to put the new marker position into where the
        % original marker location was
        
        % This original marker location starts at:
        start_pos = strfind(A_tmp{l}, ([',' spiketype ',']))+2;
        % Now, get all text following ",B," in the original textfile,
        % and put it in the variable txt
        txt = A_tmp{l}(strfind(A_tmp{l}, ([',' spiketype ',']))+3:end);
        % From that txt variable, get all text before the first comma, put
        % that in the variable rubbish (because we don't need it), and put
        % all text from the first comma onwards into the variable
        % rest_of_line
        [rubbish rest_of_line]  = strtok(txt, ',');
        
        % Combine all text up until ",B," from the original textfile with the new marker position and
        % the rest_of_line variable into what is now the new line of text
        new_line = [A_tmp{l}(1:start_pos) new_marker_pos rest_of_line];
        % Put that new line of text into the cell in variable A_tmp
        A_tmp{l} = new_line;
    end
end

%% Changes the DataFilename in the header %%

dat_filename = ('realigned_GFP_filteredEEG_12ms.dat');
for l = 1:length(A_tmp)
    if ~isempty(A_tmp{l}) && strcmp(A_tmp{l}(1:9), 'DataFile=')
        A_tmp{l} = ['DataFile=' dat_filename];
        break
    end
end
% cd ([target_dir]);

%%% Write modified cell to vmrk file
% Define new filename
new_filename = (['realigned_GFP_filteredEEG_12ms.vmrk']);
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




