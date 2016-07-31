function Plot_polytrode_button(handles)

USER_DATA = get(handles.wave_clus_figure,'userdata');
par = USER_DATA{1};
spikes = USER_DATA{2};
classes = USER_DATA{6};
nclusters = max(classes);
par.to_plot_std = 1;
ls = size(spikes,2); % polytrode spike length
lch = par.w_pre + par.w_post; % spike length
nchannels = ls/lch;
filename = par.filename;

%load ('../chan_list')
%load (filename(11:end),'group_chans')

h_figs=get(0,'children');
h_fig1 = findobj(h_figs,'Name','polytrode');
h_fig2= findobj(h_figs,'Name','polytrode_aux1');
h_fig3= findobj(h_figs,'Name','polytrode_aux2');
h_fig4= findobj(h_figs,'name','polytrode_aux3');
close(h_fig1); close(h_fig2); close(h_fig3); close(h_fig4);
h_fig11 = findobj(h_figs,'Name','polytrode_aux10');
h_fig12= findobj(h_figs,'Name','polytrode_aux11');
h_fig13= findobj(h_figs,'Name','polytrode_aux12');
h_fig14= findobj(h_figs,'name','polytrode_aux13');
close(h_fig11); close(h_fig12); close(h_fig13); close(h_fig14);
h_fig21 = findobj(h_figs,'Name','polytrode_aux20');
h_fig22= findobj(h_figs,'Name','polytrode_aux21');
h_fig23= findobj(h_figs,'Name','polytrode_aux22');
h_fig24= findobj(h_figs,'name','polytrode_aux23');
close(h_fig21); close(h_fig22); close(h_fig23); close(h_fig24);

% PLOT POLYTRODE CLASSES
colors = ['b' 'r' 'g' 'c' 'm' 'y' 'b' 'r' 'g' 'c' 'm' 'y' 'b' 'k' 'b' 'r' 'g' 'c' 'm' 'y' 'b' 'r' 'g' 'c' 'm' 'y' 'b'];

for i = 1:nclusters
    eval(['class' num2str(i) '= find( classes==' num2str(i) ');']);
end
z = nclusters + 1;
eval(['class' num2str(z) '= find( classes==' num2str(0) ');']);
 
for j=1:nchannels
    ylimit = [];
    h_figs = [];
    for i=1:nclusters+1
        eval(['nspikes = length(class' num2str(i) ');'])
        if nspikes
            eval(['av   = mean(spikes(class' num2str(i) ',' num2str(j-1) '*lch + 1 : j*lch ));']);
            eval(['avup = av + par.to_plot_std * std(spikes(class' num2str(i) ',' num2str(j-1) '*lch + 1 : j*lch));']);
            eval(['avdw = av - par.to_plot_std * std(spikes(class' num2str(i) ',' num2str(j-1) '*lch + 1 : j*lch));']);
            eval(['max_spikes=min(length(class' num2str(i) '),par.max_spikes);']);
            eval(['sup_spikes=length(class' num2str(i) ');']);
            permut=randperm(sup_spikes);

            if (i < 6) && (j < 9)
                h_fig1 = 100;
                figure(h_fig1)
                t = strcat(char(filename(1:9)) );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                if nchannels>4
                    subplot(nchannelsj,5,i+5*(j-1))
                else
                    subplot(4,5,i+5*(j-1))
                end
                hold on
                if i==nclusters+1,colors(i)='k'; end;
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
    %             xlim([1 lch])
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==1
                    %ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==1
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end

            elseif (i < 6) && (j < 17)
                h_fig11 = 200;
                figure(h_fig11)
                t = strcat(char(filename(1:9)), '_aux10' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                subplot(nchannelsj,5,i+5*(j-9))
                hold on
                if i==nclusters+1,colors(i)='k'; end;
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
    %             xlim([1 lch])
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==1
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==9
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end
                
            elseif (i < 6) && (j < 25)
                h_fig21 = 300;
                figure(h_fig21)
                t = strcat(char(filename(1:9)), '_aux20' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                subplot(nchannelsj,5,i+5*(j-17))
                hold on
                if i==nclusters+1,colors(i)='k'; end;
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
    %             xlim([1 lch])
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==1
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==17
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end
                
            elseif (i < 11)&&(j<9)
                h_fig2 = 101;
                figure(h_fig2)
                t = strcat(char(filename(1:9)), '_aux1' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                if nchannels>4
                    subplot(nchannelsj,5,i-5+5*(j-1))
                else
                    subplot(4,5,i-5+5*(j-1))
                end
                hold on
                if i==nclusters+1,colors(i)='k'; end
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==6
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==1
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end

             elseif (i < 11) && (j < 17)
                h_fig12 = 201;
                figure(h_fig12)
                t = strcat(char(filename(1:9)), '_aux11' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                subplot(nchannelsj,5,i-5+5*(j-9))
                hold on
                if i==nclusters+1,colors(i)='k'; end;
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==6
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==9
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end
                
             elseif (i < 11) && (j < 25)
                h_fig22 = 301;
                figure(h_fig22)
                t = strcat(char(filename(1:9)), '_aux21' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                subplot(nchannelsj,5,i-5+5*(j-17))
                hold on
                if i==nclusters+1,colors(i)='k'; end;
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==6
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==17
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end
                
            elseif (i < 16)&&(j<9)
                h_fig3 = 102;
                figure(h_fig3)
                t = strcat(char(filename(1:9)), '_aux2' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                if nchannels>4
                    subplot(nchannelsj,5,i-10+5*(j-1))
                else
                    subplot(4,5,i-10+5*(j-1))
                end
                hold on
                if i==nclusters+1,colors(i)='k'; end
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==11
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==1
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end

             elseif (i < 16) && (j < 17)
                h_fig13 = 202;
                figure(h_fig13)
                t = strcat(char(filename(1:9)), '_aux12' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                subplot(nchannelsj,5,i-10+5*(j-9))
                hold on
                if i==nclusters+1,colors(i)='k'; end;
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==11
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==9
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end
                
             elseif (i < 16) && (j < 25)
                h_fig23 = 302;
                figure(h_fig23)
                t = strcat(char(filename(1:9)), '_aux22' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                subplot(nchannelsj,5,i-10+5*(j-17))
                hold on
                if i==nclusters+1,colors(i)='k'; end;
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==11
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==17
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end
                
            elseif (i < 21)&&(j<9)
                h_fig4 = 103;
                figure(h_fig4)
                t = strcat(char(filename(1:9)), '_aux3' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                if nchannels>4
                    subplot(nchannelsj,5,i-15+5*(j-1))
                else
                    subplot(4,5,i-15+5*(j-1))
                end
                hold on
                if i==nclusters+1,colors(i)='k'; end
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==16
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==1
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end
                
            elseif (i < 21)&&(j<17)
                h_fig14 = 203;
                figure(h_fig14)
                t = strcat(char(filename(1:9)), '_aux13' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                subplot(nchannelsj,5,i-15+5*(j-9))
                hold on
                if i==nclusters+1,colors(i)='k'; end
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==16
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==9
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end
                
            elseif (i < 21)&&(j<25)
                h_fig24 = 303;
                figure(h_fig24)
                t = strcat(char(filename(1:9)), '_aux23' );
                set(gcf,'numbertitle','off','name',t)
                nchannelsj = min([nchannels 8]);
                subplot(nchannelsj,5,i-15+5*(j-17))
                hold on
                if i==nclusters+1,colors(i)='k'; end
                eval(['plot(spikes(class' num2str(i) '(permut(1:max_spikes)),' num2str(j-1) '*lch + 1 : j*lch)'',''color'',''' colors(i) ''')']);
                plot(1:lch,av,'k','linewidth',2)
                plot(1:lch,avup,1:lch,avdw,'color' , [.4 .4 .4], 'linewidth' ,0.5)
                axis tight
                axis fill
                if i<nclusters+1, ylimit = [ylimit;get(gca,'YLim')]; end
                h_figs = [h_figs,gca];
                if i==16
%                     ylabel(chan_list(group_chans(j),:),'Fontweight','bold');%, ...
                    eval(['ylabel([''Channel '  num2str(j) '''],''Fontweight'',''bold'')']);
                end
                if j==17
                    if i==nclusters+1, k=0; else k=i; end
                    eval(['aux=num2str(length(class' num2str(i) '));']);
                    eval(['title([''Cluster ' num2str(k) ':  # ' aux '''],''Fontweight'',''bold'')']);
                end
            end
        end;
        
    end
    ymin = min(ylimit(:,1)); ymax = max(ylimit(:,2)); 
    for k=1:length(h_figs), set(h_figs(k),'Ylim',[ymin ymax]),end
end

% SAVE FIGURE
if ~isempty(h_fig1)
    figure(100); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig1,''-djpeg'',''fig2print_ch_' filename(1:end-4) ''')' ]);
end
if ~isempty(h_fig2)
    figure(101); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig2,''-djpeg'',''fig2print_ch_' filename(1:end-4) 'a' ''')' ]);
end
if ~isempty(h_fig3)
    figure(102); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig3,''-djpeg'',''fig2print_ch_' filename(1:end-4) 'b' ''')' ]);
end
if ~isempty(h_fig4)
    figure(103); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig4,''-djpeg'',''fig2print_ch_' filename(1:end-4) 'd' ''')' ]);
end
if ~isempty(h_fig11)
    figure(200); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig11,''-djpeg'',''fig2print_ch_' filename(1:end-4) '-1' ''')' ]);
end
if ~isempty(h_fig12)
    figure(201); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig12,''-djpeg'',''fig2print_ch_' filename(1:end-4) 'a-1' ''')' ]);
end
if ~isempty(h_fig13)
    figure(202); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig13,''-djpeg'',''fig2print_ch_' filename(1:end-4) 'b-1' ''')' ]);
end
if ~isempty(h_fig14)
    figure(203); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig14,''-djpeg'',''fig2print_ch_' filename(1:end-4) 'd-1' ''')' ]);
end
if ~isempty(h_fig21)
    figure(300); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig21,''-djpeg'',''fig2print_ch_' filename(1:end-4) '-2' ''')' ]);
end
if ~isempty(h_fig22)
    figure(301); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig22,''-djpeg'',''fig2print_ch_' filename(1:end-4) 'a-2' ''')' ]);
end
if ~isempty(h_fig23)
    figure(302); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig23,''-djpeg'',''fig2print_ch_' filename(1:end-4) 'b-2' ''')' ]);
end
if ~isempty(h_fig24)
    figure(303); set(gcf,'papertype','usletter','paperorientation','portrait','paperunits','inches')
    set(gcf,'paperposition',[.25 .25 10.5 7.8])
    eval(['print(h_fig24,''-djpeg'',''fig2print_ch_' filename(1:end-4) 'd-2' ''')' ]);
end


 
