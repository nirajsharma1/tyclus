function coi = f_coi(patient_name)

% Spike classes that are of interest, for each patient.

% patient_code = 'JR';

% spike_class = 'A';

switch patient_name
    
    case 'BS'
        
        coi = [1 2 3 5 6 7 25 26 32 33];
        
    case 'JR'
        
        coi = [4 5 13 20 21 22 23 29 68 69];
        
    case  'HD'
        %         spiketype_list = { 'A', 'B', 'C', 'D', 'E' };
        
        coi = [26 34 35 36 41 42 60 61 68 69 73 74];
        
    case  'IH'
        
        coi = [34 35 36 37 52 53];
        
    case 'CB'
        
        
        
end

end
