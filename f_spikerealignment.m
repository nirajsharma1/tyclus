%% This script plots each realignment event with all the channels equally seperated. The realignment window is kept small but an overall plot of 1sec around the event is shown and saved so as to understand what is going on around the event %%

function real_EEG = f_spikerealignment(chann_label, spikelabel, EEG)

spiketype = spikelabel;

% patient_name = 'JR';

% set_path = (['/Users/nsharma/Desktop/pipeline/' patient_name '/']);

% cd ([set_path]);

% orEEG = pop_loadset([patient_name '_unfiltered_eeg.set']);

% EEG = evalin('base', 'EEG');

save('spiketype');

orEEG = EEG;

fiEEG = f_filteeg_prerealignment(EEG); % the aggresively filtered EEG that eliminates the slow wave

% prompt = 'realignment time window (secs)?';
% 
% lv = input(prompt);

lv = 0.012; % realignment time window - in seconds

% subject_dir_fi = (['/Users/nsharma/Desktop/PhD/data_processed/' patient_name '/filtered_eeg/']); 
% 
% subject_dir_or = (['/Users/nsharma/Desktop/PhD/data_processed/' patient_name '/unfiltered_eeg/']); 

% cd([subject_dir_fi]);

% fiEEG = filt_EEG

% cd([subject_dir_or]);

% orEEG = pop_loadset([ patient_name '_unfiltered.set']); %obtained by loading the dataset onto the GUI of eeglab then typing in the command 'EEG.history'


% target_dir_JPEGsave = (['/Users/nsharma/Desktop/PhD/data_processed/' patient_name '/all/saved_eeglab_export/allevents_JPEG/']);
% 
% 
% target_dir_eegexport = (['/Users/nsharma/Desktop/PhD/data_processed/' patient_name '/all/saved_eeglab_export/eeg_export/']);

% spiketype_list = f_spikeclass_list(patient_name);

choi = f_coi_test(chann_label, EEG);

% load coi

coi = choi';

lv_ms = lv*1000; %in ms - to be used later on

sample_value = [1/orEEG.srate]*1000;

% diff = 150; % distance used to seperate the channels

%% calculating the time in samples %%

or_lv = 0.05;

ts = [or_lv*2]*1000;

time_sample = [ts/4] + 1;

ii = 0; % NS_ii determines how many spiketype 'B' events have been found. 

for i = 1:length(fiEEG.event)
    
%     for s = length(spiketype_list)
    
    if  isequal(fiEEG.event(i).type, spiketype); %|isequal(fiEEG.event(i).type, spiketype_2 )|isequal(fiEEG.event(i).type, spiketype_3 )|isequal(fiEEG.event(i).type, spiketype_4 )|isequal(fiEEG.event(i).type, spiketype_5 ); %|isequal(fiEEG.event(i).type, spiketype_6 )|isequal(fiEEG.event(i).type, spiketype_7 ); % Note that EEG.event(i).type is the variable where the name of the spike class is available.%NS_'isequal' is used because spiketype 'B' is a string and not a number; isequal is used for analysing strings
        
        ii = ii+1;
        
        short_spikes = fiEEG.data(coi, fiEEG.event(i).latency-[lv]*fiEEG.srate:fiEEG.event(i).latency+[lv]*fiEEG.srate); % Selecting the data around the spike. 35ms before and after.
%
      %% Calculating the GFP %%
        
        GFP_spikes = fiEEG.data(coi, fiEEG.event(i).latency-[lv]*fiEEG.srate:fiEEG.event(i).latency+[lv]*fiEEG.srate); %Calculating the square of all the channels
            
        GFP_square = GFP_spikes.^2;
        
        GFP = sum (GFP_square);
        
%         GFP_spikes_g = fiEEG.data(coi, fiEEG.event(i).latency-[or_lv]*fiEEG.srate:fiEEG.event(i).latency+[or_lv]*fiEEG.srate); %Calculating the square of all the channels
            
%         GFP_square_g = GFP_spikes_g.^2;
%         
%         GFP_g(:,:,ii) = sum (GFP_square_g); % for subplot - it increases the time 
%         
        
        time = (1:length(GFP_spikes))./fiEEG.srate.*1000; % time vector in ms

        ST = 1/fiEEG.srate*1000; % ST - sample time (ms)
    
        time = ST*(1:length(GFP)); %time is 1 until length of x - shows timxe from beginning until the end
        
               
        [minv, minpeak] = min(GFP,[],2);
        [maxv, maxpeak] = max(GFP,[],2);
        [~, chi] = max(max(abs(GFP),[],2)); % Selecting the channel that shows a larger difference between the minimum and the maximum. This is in order to select the channel that shoes the larger amplitude spikes.
        
        aux = size(GFP,2);
      
%         [minv2, minpeak2] = min(short_spikes,[],2);
%         [maxv2, maxpeak2] = max(short_spikes,[],2);
%         
       peak = minpeak;       

%        realignedmarker = maxpeak*ST; % the negative amplitude peak % I choose to peak the minimum, because the larger amplitude peak of these type of spikes is negative.
%        originalmarker = ((aux+1)/2)*ST; % changes from sample to time (ms) 
%         
%        
%        fiEEG.event(i).latency = fiEEG.event(i).latency - ((aux+1)/2-peak); % Actualizing field in EEG struct.
%        fiEEG.event(i).channel = chi+(coi-1); % depends on the 1st row within the global "if"
%        
%       if ii== event_no
          
        rmarker_matrix(:,ii) = maxpeak; % all realigned markers in a 2D matrix
        omarker_matrix(:,ii) = ((aux+1)/2); % all original markers in a 2D matrix
          
%         rmarker_matrix = maxpeak; % all realigned markers in a 2D matrix
%         omarker_matrix = ((aux+1)/2); % all original markers in a 2D matrix


      


    
    end
    end
    
% end

%% original %%

 

realgEEG = orEEG;

or_ii = 0;

or_originalmarker = [54].*[ones(1,ii)]; % 54 results from ((or_aux+1)/2)*ST (see line 134)

for o = 1:length(orEEG.event)
    
      if  isequal(orEEG.event(o).type, spiketype); %|isequal(orEEG.event(o).type, spiketype_2 )|isequal(orEEG.event(o).type, spiketype_3 )|isequal(orEEG.event(o).type, spiketype_4 )|isequal(orEEG.event(o).type, spiketype_5); %|isequal(orEEG.event(o).type, spiketype_6 )|isequal(orEEG.event(o).type, spiketype_7 );% Note that EEG.event(i).type is the variable where the name of the spike class is available.%NS_'isequal' is used because spiketype 'B' is a string and not a number; isequal is used for analysing strings
        
                  
          or_ii = or_ii + 1;
        
        or_spikes = orEEG.data(coi, orEEG.event(o).latency-[or_lv]*orEEG.srate:orEEG.event(o).latency+[or_lv]*orEEG.srate); % original unfiltered data 
          
        zero_mean_or_spikes = or_spikes - mean(or_spikes,2)*ones(1,size(or_spikes,2)); %figure; plot(zero_mean_short_spikes')
        
        ST = 1/orEEG.srate*1000; % ST - sample time (ms)
    
        time_or = ST*(1:time_sample); %time is 1 until length of x - shows timxe from beginning until the end
        
        or_aux = size(zero_mean_or_spikes,2);
        
%         or_originalmarker = ((or_aux+1)/2)*ST; % changes from sample to time (ms) 

        minus_marker_matrix = (omarker_matrix - rmarker_matrix)*ST;
        
        or_realignedmarker = or_originalmarker - minus_marker_matrix;
        
        ro_diff = or_realignedmarker - or_originalmarker; % difference between the realigned and original marker 
        
%         GFP_fg = GFP_g(:,:,or_ii); % for subplot - it increases the time 

        
        %% Determining whether the realigned marker has moved in a negative or positive direction %%
        
        if ro_diff(or_ii) < 0 % This information will be used when saving the figure as a JPEG file
            sign = 'negative';
            
        elseif ro_diff(or_ii) > 0
                
                sign = 'positive';
                
            else
                
                sign = 'zero';
                
        end
            
        abs_ro_diff = abs(ro_diff(or_ii)); % obtaining the absolute value of ro_diff (to be used when saving the figure)
        
        channel_vector(:,or_ii) = orEEG.event(o).channel;
        
        [or_minv2, or_minpeak2] = min(or_spikes,[],2);
        [or_maxv2, or_maxpeak2] = max(or_spikes,[],2);
        
        event_no = or_ii;
        

%% Seperating the EEG channels equally %%

     

       %% original eeg channels %%
       
%         e1 = or_spikes(1,:);
%         e2 = or_spikes(2,:);
%         e3 = or_spikes(3,:);
%         e4 = or_spikes(4,:);
%         e5 = or_spikes(5,:);
%         e6 = or_spikes(6,:);
%         e7 = or_spikes(7,:);
%         e8 = or_spikes(8,:);
%         e9 = or_spikes(9,:);
%         e10 = or_spikes(10,:);
%         e11 = or_spikes(11,:);
%         e12 = or_spikes(12,:);
%         e13 = or_spikes(13,:);
%         e14 = or_spikes(14,:);
%         e15 = or_spikes(15,:);
%         e16 = or_spikes(16,:);
%         e17 = or_spikes(17,:);
%         e18 = or_spikes(18,:);
%         e19 = or_spikes(19,:);
%         e20 = or_spikes(20,:);
        
        %% equally seperated eeg channels %%
        
%         oe1 = e1(1) - [diff];
%         ore1 = oe1 - e2(1);
%         ne2 = e2 + ore1; 
%        
%         oe2 = ne2(1) - [diff];
%         ore2 = oe2 - e3(1);
%         ne3 = e3 + ore2;
%                
%         oe3 = ne3(1) - [diff];
%         ore3 = oe3 - e4(1);
%         ne4 = e4 + ore3;    
%         
%         oe4 = ne4(1) - [diff];
%         ore4 = oe4 - e5(1);
%         ne5 = e5 + ore4;     
%         
%         oe5 = ne5(1) - [diff];
%         ore5 = oe5 - e6(1);
%         ne6 = e6 + ore5;      
%         
%         oe6 = ne6(1) - [diff];
%         ore6 = oe6 - e7(1);
%         ne7 = e7 + ore6; 
%         
%         oe7 = ne7(1) - [diff];
%         ore7 = oe7 - e8(1);
%         ne8 = e8 + ore7;     
%         
%         oe8 = ne8(1) - [diff];
%         ore8 = oe8 - e9(1);
%         ne9 = e9 + ore8;    
%         
%         oe9 = ne9(1) - [diff];
%         ore9 = oe9 - e10(1);
%         ne10 = e10 + ore9;   
%         
%         oe10 = ne10(1) - [diff];
%         ore10 = oe10 - e11(1);
%         ne11 = e11 + ore10;    
%         
%         oe11 = ne11(1) - [diff];
%         ore11 = oe11 - e12(1);
%         ne12 = e12 + ore11;    
%         
%         oe12 = ne12(1) - [diff];
%         ore12 = oe12 - e13(1);
%         ne13 = e13 + ore12;    
%         
%         oe13 = ne13(1) - [diff];
%         ore13 = oe13 - e14(1);
%         ne14 = e14 + ore13;    
%         
%         oe14 = ne14(1) - [diff];
%         ore14 = oe14 - e15(1);
%         ne15 = e15 + ore14;    
%         
%         oe15 = ne15(1) - [diff];
%         ore15 = oe15 - e16(1);
%         ne16 = e16 + ore15;     
%         
%         oe16 = ne16(1) - [diff];
%         ore16 = oe16 - e17(1);
%         ne17 = e17 + ore16;     
%         
%         oe17 = ne17(1) - [diff];
%         ore17 = oe17 - e18(1);
%         ne18 = e18 + ore17;     
%         
%         oe18 = ne18(1) - [diff];
%         ore18 = oe18 - e19(1);
%         ne19 = e19 + ore18;    
%         
%         oe19 = ne19(1) - [diff];
%         ore19 = oe19 - e20(1);
%         ne20 = e20 + ore19; 
        
                    
%         if or_ii == event_no
            
%           newor_eeg = [e1;ne2;ne3;ne4;ne5;ne6;ne7;ne8;ne9;ne10]; %ne10;ne11;ne12;ne13;ne14;ne15;ne16;ne17;ne18;ne19;ne20];
%           
% %           channel = orEEG.event(o).channel(or_ii); % Determining which channel this event was originally marked in
% 
%           x1 = [or_originalmarker(or_ii), or_originalmarker(or_ii)];
%           y1 = [[e1(1)+200], [ne10(1)-750]];
% 
%           x2 = [or_realignedmarker(or_ii), or_realignedmarker(or_ii)];
% %           y2 = [e1(1), ne8(1)];
          
          %% Creating a vector to show the original realignment time window in order to create a border showing the time window the realignment took place %%
          
          o_latency_minus = (or_originalmarker(or_ii) - [lv_ms]); 
          
          o_latency_plus = (or_originalmarker(or_ii) + [lv_ms]);
          
          original_latency = [o_latency_minus:sample_value:o_latency_plus];
          
%           x3 = [o_latency_minus, o_latency_minus];
% %           y3 = [e1(1), [ne8(1)-200]];
%           
%           x4 = [o_latency_plus, o_latency_plus];
% %           y4 = [e1(1), [ne8(1)-200]];
%           
%           y2 = [max(GFP_fg), 0]; % for GFP subplot
          
          
          
                   

           %% Plotting the graph with altered time window %%
           
%            figure('visible','off'); 
%            
%            % Plotting the GFP %
%            
%            subplot(1,2,1); hold on; plot(x3,y2, '-.k'); hold on; plot (x4,y2,'-.k'); plot(time_or, GFP_fg');
%            
%            ylabel('GFP'); xlabel ('Time(ms)');
%            
%            legend('Spike realignment time window (-20ms)','Spike realignment time window (+20ms)','GFP','Location','southwest');
%            
%            axis tight;
%            
%            % Plotting the EEG %
%            
%            subplot(1,2,2); hold on;
%            
%             plot (x2,y1, '-r','Linewidth',2);
%          
%            plot (x1,y1,'--g');
%            
%                                
%            plot (time_or, newor_eeg'); 
%            
%            plot(x3,y1, '-.k'); hold on; plot (x4,y1,'-.k');
%            
%           plot(or_realignedmarker(or_ii), 0, '*k'); plot(or_originalmarker(or_ii), 0, 'ko'); 
%            
%                   
%          
%          xlabel ('Time(ms)'); %ylabel ('Amplitude (uV)'); %hold on; plot(peak, 0, '*k'); plot((aux+1)/2, 0, 'ko'); % Plotting the te markers.
% 
%          set (gca, 'YTickLabel',[]);
%          
% %          legend('Realigned marker','Original marker','ChG4','ChG5','ChG13','ChG14','ChG21','ChG22','ChG23','DP3','DP4','Location','southeast');
%          
%          legend('Realigned marker','Original marker','G4','G5','G13','G20','G21','G22','G23','G29','DP2','DP3','Location','southeast');
%          
%          axis tight;
          
          %% Saving as a JPEG %%

%          cd ([target_dir_JPEGsave]);

         minus_marker_s = num2str(abs_ro_diff); % converting number to string

         event_no_s = num2str(event_no);
         
         channel_s = num2str(channel_vector(or_ii));

%          saveas(gcf, ['event' event_no_s '_' minus_marker_s 'ms' '_' sign '_channel' channel_s], 'jpg');
          
         realgEEG.event(o).latency = orEEG.event(o).latency + ro_diff(or_ii)./ST; % Actualizing field in EEG struct.

        end
               end
      
% end

realgEEG.uevent = realgEEG.event;

realgEEG = eeg_checkset( realgEEG );

real_EEG = realgEEG;

real_filename = ('realigned_GFP_filteredEEG_12ms');

pop_writebva(realgEEG, [real_filename]); % Saving the new eeg data 

f_vmrk_modification(EEG, spikelabel);


end

% cd([target_dir_eegexport])

% pop_writebva(realgEEG, ['patient' patient_name '_realigned' coi_save '_GFP_filteredEEG_12ms_2']); % Saving the new eeg data 
     
% end

