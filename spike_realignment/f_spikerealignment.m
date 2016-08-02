
function real_EEG = f_spikerealignment(chann_label, spikelabel, EEG)

% Realignment of original spike marking to the peak of the 'spiky' component%%
% This is carried out by realigning to the peak of the GFP %%

spiketype = spikelabel;

save('spiketype');

orEEG = EEG;

fiEEG = f_filteeg_prerealignment(EEG); % the aggresively filtered EEG that eliminates the slow wave

lv = 0.012; % realignment time window - in seconds

choi = f_coi_test(chann_label, EEG);

% load coi

coi = choi';

lv_ms = lv*1000; %in ms - to be used later on

sample_value = [1/orEEG.srate]*1000;

%% calculating the time in samples %%

or_lv = 0.05;

ts = [or_lv*2]*1000;

time_sample = [ts/4] + 1;

ii = 0;  

for i = 1:length(fiEEG.event)
    
    
    if  isequal(fiEEG.event(i).type, spiketype); %|isequal(fiEEG.event(i).type, spiketype_2 )|isequal(fiEEG.event(i).type, spiketype_3 )|isequal(fiEEG.event(i).type, spiketype_4 )|isequal(fiEEG.event(i).type, spiketype_5 ); %|isequal(fiEEG.event(i).type, spiketype_6 )|isequal(fiEEG.event(i).type, spiketype_7 ); % Note that EEG.event(i).type is the variable where the name of the spike class is available.%NS_'isequal' is used because spiketype 'B' is a string and not a number; isequal is used for analysing strings
        
        ii = ii+1;
        
        short_spikes = fiEEG.data(coi, fiEEG.event(i).latency-[lv]*fiEEG.srate:fiEEG.event(i).latency+[lv]*fiEEG.srate); % Selecting the data around the spike.

      %% Calculating the GFP %%
        
        GFP_spikes = fiEEG.data(coi, fiEEG.event(i).latency-[lv]*fiEEG.srate:fiEEG.event(i).latency+[lv]*fiEEG.srate); %Calculating the square of all the channels
            
        GFP_square = GFP_spikes.^2;
        
        GFP = sum (GFP_square);
         
        time = (1:length(GFP_spikes))./fiEEG.srate.*1000; % time vector in ms

        ST = 1/fiEEG.srate*1000; % ST - sample time (ms)
    
        time = ST*(1:length(GFP)); %time is 1 until length of x - shows timxe from beginning until the end
        
               
        [minv, minpeak] = min(GFP,[],2);
        [maxv, maxpeak] = max(GFP,[],2);
        [~, chi] = max(max(abs(GFP),[],2)); % Selecting the channel that shows a larger difference between the minimum and the maximum. This is in order to select the channel that shoes the larger amplitude spikes.
        
        aux = size(GFP,2);
      
       peak = minpeak;       

        rmarker_matrix(:,ii) = maxpeak; % all realigned markers in a 2D matrix
        omarker_matrix(:,ii) = ((aux+1)/2); % all original markers in a 2D matrix
          

      


    
    end
    end
    


realgEEG = orEEG;

or_ii = 0;

or_originalmarker = [54].*[ones(1,ii)]; % 54 results from ((or_aux+1)/2)*ST (see line 134)

%% Original %%

for o = 1:length(orEEG.event)
    
      if  isequal(orEEG.event(o).type, spiketype); 
        
                  
          or_ii = or_ii + 1;
        
        or_spikes = orEEG.data(coi, orEEG.event(o).latency-[or_lv]*orEEG.srate:orEEG.event(o).latency+[or_lv]*orEEG.srate); % original unfiltered data 
          
        zero_mean_or_spikes = or_spikes - mean(or_spikes,2)*ones(1,size(or_spikes,2)); %figure; plot(zero_mean_short_spikes')
        
        ST = 1/orEEG.srate*1000; % ST - sample time (ms)
    
        time_or = ST*(1:time_sample); %time is 1 until length of x - shows timxe from beginning until the end
        
        or_aux = size(zero_mean_or_spikes,2);
        
        minus_marker_matrix = (omarker_matrix - rmarker_matrix)*ST;
        
        or_realignedmarker = or_originalmarker - minus_marker_matrix;
        
        ro_diff = or_realignedmarker - or_originalmarker; % difference between the realigned and original marker 
        
        
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
        

          
          %% Creating a vector to show the original realignment time window in order to create a border showing the time window the realignment took place %%
          
          o_latency_minus = (or_originalmarker(or_ii) - [lv_ms]); 
          
          o_latency_plus = (or_originalmarker(or_ii) + [lv_ms]);
          
          original_latency = [o_latency_minus:sample_value:o_latency_plus];
          

          
               

         minus_marker_s = num2str(abs_ro_diff); % converting number to string

         event_no_s = num2str(event_no);
         
         channel_s = num2str(channel_vector(or_ii));
          
         realgEEG.event(o).latency = orEEG.event(o).latency + ro_diff(or_ii)./ST; % Actualizing field in EEG struct.

        end
               end
      


realgEEG.uevent = realgEEG.event;

realgEEG = eeg_checkset( realgEEG );

real_EEG = realgEEG;

real_filename = ('realigned_GFP_filteredEEG_12ms');

pop_writebva(realgEEG, [real_filename]); % Saving the new eeg data 

f_vmrk_modification(EEG, spikelabel);


end



