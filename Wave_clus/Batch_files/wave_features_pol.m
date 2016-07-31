function [inspk] = wave_features_pol(spikes,handles);
%Calculates the spike features

scales = handles.par.scales;
feature = handles.par.features;
inputs = handles.par.inputs;
nspk = size(spikes,1);
ls = size(spikes,2);
pre_samp = handles.par.w_pre;
post_samp = handles.par.w_post;
spk_length = pre_samp+ post_samp;
ch_number = floor(ls/spk_length);
include_time = handles.par.include_time;
if strcmp(include_time,'y')
    wave_inputs = inputs - 2*ch_number;
    load rel_time_spikes
else
    wave_inputs = inputs - ch_number;
end;
% feat_spk = inputs/nspkes;
%set(handles.file_name,'string','Calculating spike features ...');

% CALCULATES FEATURES
switch feature
    case 'wav'
        cc=zeros(nspk,ls);
        if exist('wavedec')                             % Looks for Wavelets Toolbox
            for i=1:nspk                                % Wavelet decomposition
                [c,l]=wavedec(spikes(i,:),scales,'haar');
                cc(i,1:ls)=c(1:ls);
            end
        else
            for i=1:nspk                                % Replaces Wavelets Toolbox, if not available
                [c,l]=fix_wavedec(spikes(i,:),scales);
                cc(i,1:ls)=c(1:ls);
            end
        end
        for i=1:ls                                  % KS test for coefficient selection   
            thr_dist = std(cc(:,i)) * 3;
            thr_dist_min = mean(cc(:,i)) - thr_dist;
            thr_dist_max = mean(cc(:,i)) + thr_dist;
            aux = cc(find(cc(:,i)>thr_dist_min & cc(:,i)<thr_dist_max),i);
            if length(aux) > 10;
                [ksstat]=test_ks(aux);
                sd(i)=ksstat;
            else
                sd(i)=0;
            end
        end
        [max ind]=sort(sd);
        coeff(1:wave_inputs)=ind(ls:-1:ls-wave_inputs+1);
    case 'pca'
        [C,S,L] = princomp(spikes);
        cc = S;
        inputs = 3; 
        coeff(1:3)=[1 2 3];
end

%CREATES INPUT MATRIX FOR SPC
inspk=zeros(nspk,inputs);
for i=1:nspk
    for j=1:wave_inputs
        inspk(i,ch_number+j)=cc(i,coeff(j));
    end
    for k= 1:ch_number
        inspk(i,k) = spikes(i,pre_samp+(k-1)*spk_length);
    end;
    if strcmp(include_time,'y')
        for p = 1:ch_number
            inspk(i,end-ch_number+p) = spike_times_gr(i,p);
        end;
    end;
end

