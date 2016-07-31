function [inspk] = wave_features_pol2(spikes,handles);
%Calculates the spike features

scales = handles.par.scales;
feature = handles.par.features;
inputs = handles.par.inputs;
nspk = size(spikes,1);
ls = size(spikes,2);
single_spk_l = handles.par.w_pre+handles.par.w_post;
nspikes = ls/(single_spk_l);
feat_spk = inputs/nspikes;
%set(handles.file_name,'string','Calculating spike features ...');

% CALCULATES FEATURES
inspk=zeros(nspk,inputs);

for k = 1:nspikes
    switch feature
        case 'wav'
            cc=zeros(nspk,single_spk_l);
            if exist('wavedec')                             % Looks for Wavelets Toolbox
                for i=1:nspk                                % Wavelet decomposition
                    [c,l]=wavedec(spikes(i,(k-1)*single_spk_l+1:k*single_spk_l) ...
                        ,scales,'haar');
                    cc(i,1:single_spk_l)=c(1:single_spk_l);
                end
            else
                for i=1:nspk                                % Replaces Wavelets Toolbox, if not available
                    [c,l]=fix_wavedec(spikes(i,(k-1)*single_spk_l+1:k*single_spk_l)...
                        ,scales);
                    cc(i,1:single_spk_l)=c(1:single_spk_l);
                end
            end
            for i=1:single_spk_l                                  % KS test for coefficient selection   
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
            coeff(1:feat_spk)=ind(single_spk_l:-1:single_spk_l-feat_spk+1);
        case 'pca'
            [C,S,L] = princomp(spikes);
            cc = S;
            inputs = 3; 
            coeff(1:3)=[1 2 3];
    end

    %CREATES INPUT MATRIX FOR SPC
    inspk_k=zeros(nspk,feat_spk);
    for i=1:nspk
        for j=1:feat_spk
            inspk_k(i,j)=cc(i,coeff(j));
        end
    end
    inspk_k(:,feat_spk) = spikes(:,(k-1)*single_spk_l+handles.par.w_pre);
    inspk(:,(k-1)*feat_spk+1:k*feat_spk) = inspk_k;
end;
