addpath /Users/isabellelao/Desktop/atmos_se_improve_figures/
addpath /Users/isabellelao/Desktop/atmos_se_improve_figures/data/
addpath /Users/isabellelao/Desktop/atmos_se_improve_figures/data/m_map/

load('station_average_Se_binned.mat')
load('Se_data.mat')

%%
for i = 1:length(Se_data)
    curr_time = Se_data(i).dates;
    curr_conc = Se_data(i).values;
    curr_movmean = movmean(curr_conc,30.4);
    scatter(curr_time,curr_conc,1,'k','filled')
    hold on 
    plot(curr_time,curr_movmean,'color','#A2142F','linewidth',3)
    hold on
    xline(datetime('01-Jan-2011'),'--')
    ylabel('Se concentration (ng/m^3)')
    title(string(Se_data(i).name),'fontsize',12)
    set(gca, 'YScale', 'log')  
    ax = gca;
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;   
    ax.YLim = [0.01 10];
    ax.YTick = [0.01 0.1 1 10];
    saveas(gcf,strcat(string(Se_data(i).name),'_long.png'))
    close all
end 

%%
figure
% subplot(3,4,[1 2 5 6])
subplot(2,4,[1 2 5 6])
% subplot(3,2,[3 4])
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    colormap(flipud(copper));
    m_grid('box','fancy','tickdir','in');
    hold on
    m_scatter(extractfield(station_average_Se,'lon'),extractfield(station_average_Se,'lat'),50,'filled','markerfacecolor','#696969','markeredgecolor','#696969')
    hold on 
    m_scatter(Se_data(15).lon,Se_data(15).lat,100,'filled','markerfacecolor','#A2142F','markeredgecolor','#A2142F')    
    hold on
    m_scatter(Se_data(14).lon,Se_data(14).lat,100,'filled','markerfacecolor','#23c221','markeredgecolor','#23c221')    
    hold on
    m_scatter(Se_data(19).lon,Se_data(19).lat,100,'filled','markerfacecolor','#db30a2','markeredgecolor','#db30a2')    
    hold on    
    m_scatter(Se_data(23).lon,Se_data(23).lat,100,'filled','markerfacecolor','#0072BD','markeredgecolor','#0072BD')    
    hold on
    title('(a)','fontsize',16,'fontweight','normal')
    
% subplot(3,4,[3 4])
subplot(2,4,4)
% subplot(3,2,2)
    time_BRIG1 = Se_data(15).dates;
    conc_BRIG1 = Se_data(15).values;
    movmean_BRIG1 = movmean(conc_BRIG1,30.4);
    scatter(time_BRIG1,conc_BRIG1,1,'k','filled')
    hold on 
    plot(time_BRIG1(1:1145),movmean_BRIG1(1:1145),'color','#A2142F','linewidth',3)
    hold on
    plot(time_BRIG1(1147:end),movmean_BRIG1(1147:end),'color','#A2142F','linewidth',3)
    hold on
    text(time_BRIG1(end),4,{'(c) Brigantine National Wildlife Refuge', 'NJ'},'fontsize',11,'horizontalalignment','right');
    xline(datetime('01-Jan-2011'),'--')
    ylabel('Se concentration (ng/m^3)')
    set(gca, 'YScale', 'log')  
    ax = gca;
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;   
    ax.YLim = [0.01 10];
    ax.YTick = [0.01 0.1 1 10];
    
subplot(2,4,3)
% subplot(3,2,5)
    time_AGTI1 = Se_data(14).dates;
    conc_AGTI1 = Se_data(14).values;
    movmean_AGTI1 = movmean(conc_AGTI1,30.4,'omitnan');
    scatter(time_AGTI1,conc_AGTI1,1,'k','filled')
    hold on 
    plot(time_AGTI1,movmean_AGTI1,'color','#23c221','linewidth',3)
    hold on
    text(time_AGTI1(end),4,{'(b) Bridger Wilderness', 'WY'},'fontsize',12,'horizontalalignment','right');    
    xline(datetime('01-Jan-2011'),'--')    
    ylabel('Se concentration (ng/m^3)')
    set(gca, 'YScale', 'log')
    ax = gca;
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;   
    ax.YLim = [0.01 10];
    ax.YTick = [0.01 0.1 1 10];
        
subplot(2,4,7)
% subplot(3,2,1)
    time_CANY1 = Se_data(19).dates;
    conc_CANY1 = Se_data(19).values;
    movmean_CANY1 = movmean(conc_CANY1,30.4,'omitnan');
    scatter(time_CANY1,conc_CANY1,1,'k','filled')
    hold on 
    plot(time_CANY1,movmean_CANY1,'color','#db30a2','linewidth',3)
    hold on
    text(time_CANY1(end),4,{'(d) Canyonlands National Park', 'UT'},'fontsize',12,'horizontalalignment','right');        
    xline(datetime('01-Jan-2011'),'--')    
    ylabel('Se concentration (ng/m^3)')
    set(gca, 'YScale', 'log')    
    ax = gca;
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;   
    ax.YLim = [0.01 10];
    ax.YTick = [0.01 0.1 1 10];
        
subplot(2,4,8)
% subplot(3,2,6)
    time_CHAS1 = Se_data(23).dates;
    conc_CHAS1 = Se_data(23).values;
    movmean_CHAS1 = movmean(conc_CHAS1,30.4,'omitnan');
    scatter(time_CHAS1,conc_CHAS1,1,'k','filled')
    hold on 
    plot(time_CHAS1(1:691),movmean_CHAS1(1:691),'color','#0072BD','linewidth',3)
    hold on
    plot(time_CHAS1(693:970),movmean_CHAS1(693:970),'color','#0072BD','linewidth',3)
    hold on
    plot(time_CHAS1(971:end),movmean_CHAS1(971:end),'color','#0072BD','linewidth',3)    
    hold on
    text(time_CANY1(end),4,{'(e) Chassahowitzka National Wildlife Refuge', 'FL'},'fontsize',10,'horizontalalignment','right');            
    xline(datetime('01-Jan-2011'),'--')    
    ylabel('Se concentration (ng/m^3)')
    set(gca, 'YScale', 'log')       
    ax = gca;
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;   
    ax.YLim = [0.01 10];
    ax.YTick = [0.01 0.1 1 10];
           
