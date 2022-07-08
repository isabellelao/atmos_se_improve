addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data'
addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data/m_map/'

load('station_average_Se_binned.mat')
load('station_average_MF.mat')

%% logarithmic

figure
% subplot(3,5,[2 3 4 7 8 9]) 
subplot(3,6,[1 2 7 8])
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    colormap(flipud(copper));
    m_grid('box','fancy','tickdir','in');
    hold on

bin1       = nan(365,1);
count_bin1 = 1;
bin2       = nan(365,1);
count_bin2 = 1;
bin3       = nan(365,1);
count_bin3 = 1;
bin4       = nan(365,1);
count_bin4 = 1;
bin5       = nan(365,1);
count_bin5 = 1;
bin6       = nan(365,1);
count_bin6 = 1;


for i = 1:length(station_average_Se)
    if string(station_average_Se(i).bin) == 'North Northeast'          
%         subplot(3,5,[2 3 4 7 8 9])
        subplot(3,6,[1 2 7 8])
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#fcca03','markeredgecolor','#fcca03')    
        hold on
%         subplot(3,5,5)
        subplot(3,6,[5 6])
        movmean_mf = movmean(station_average_MF(i).all(1:365),30.4,'omitnan');
        plot(movmean_mf,'color','#696969','linewidth',1)
        text(360,13,{'North Northeast'},'fontsize',16,'horizontalalignment','right');
        ylabel({'[Fine mass] (\mug/m^3)'}')
        set(gca, 'YScale', 'log')  
        ax = gca;
        ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
        ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});        
        ax.XAxis.FontSize = 12;
        ax.YAxis.FontSize = 12;
        ax.YLabel.FontSize = 12;   
        ax.XLim = [1 365];     
        hold on
        bin1(:,count_bin1) = movmean_mf;
        count_bin1 = count_bin1+1;

    elseif string(station_average_Se(i).bin) == 'West Coast' 
%         subplot(3,5,[2 3 4 7 8 9]) 
        subplot(3,6,[1 2 7 8])
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#23c221','markeredgecolor','#23c221')    
        hold on
%         subplot(3,5,1)
        subplot(3,6,[3 4])
        movmean_mf = movmean(station_average_MF(i).all(1:365),30.4,'omitnan');
        plot(movmean_mf,'color','#696969','linewidth',1)        
        text(360,17,{'West'},'fontsize',16,'horizontalalignment','right');
        ylabel({'[Fine mass] (\mug/m^3)'}')
        set(gca, 'YScale', 'log')  
        ax = gca;
        ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
        ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
        ax.XAxis.FontSize = 12;
        ax.YAxis.FontSize = 12;
        ax.YLabel.FontSize = 12;   
        ax.XLim = [1 365];    
%         yticks([0.25 0.5 0.75 1]);            
        hold on
        bin2(:,count_bin2) = movmean_mf;
        count_bin2 = count_bin2+1;

    elseif string(station_average_Se(i).bin) == 'Northeast Coal' 
%         subplot(3,5,[2 3 4 7 8 9]) 
        subplot(3,6,[1 2 7 8])
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#A2142F','markeredgecolor','#A2142F')    
        hold on
%         subplot(3,5,10)
        subplot(3,6,[11 12])
        movmean_mf = movmean(station_average_MF(i).all(1:365),30.4,'omitnan');
        plot(movmean_mf,'color','#696969','linewidth',1)
        text(360,22,{'Northeast'},'fontsize',16,'horizontalalignment','right');
        ylabel({'[Fine mass] (\mug/m^3)'}')
        set(gca, 'YScale', 'log')  
        ax = gca;
        ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
        ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
        ax.XAxis.FontSize = 12;
        ax.YAxis.FontSize = 12;
        ax.YLabel.FontSize = 12;   
        ax.XLim = [1 365];           
        hold on
        bin3(:,count_bin3) = movmean_mf;
        count_bin3 = count_bin3+1;

    elseif string(station_average_Se(i).bin) == 'Midwest' 
%         subplot(3,5,[2 3 4 7 8 9]) 
        subplot(3,6,[1 2 7 8])
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#a830db','markeredgecolor','#a830db')    
        hold on
%         subplot(3,5,15)
        subplot(3,6,[15 16])
        movmean_mf = movmean(station_average_MF(i).all(1:365),30.4,'omitnan');
        plot(movmean_mf,'color','#696969','linewidth',1)
        text(360,23,{'Midwest'},'fontsize',16,'horizontalalignment','right');
        ylabel({'[Fine mass] (\mug/m^3)'}')
        set(gca, 'YScale', 'log')  
        ax = gca;
        ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
        ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
        ax.XAxis.FontSize = 12;
        ax.YAxis.FontSize = 12;
        ax.YLabel.FontSize = 12;   
        ax.XLim = [1 365];  
%         yticks([0.3 0.6 0.9 1.2]);               
        hold on 
        bin4(:,count_bin4) = movmean_mf;
        count_bin4 = count_bin4+1;

    elseif string(station_average_Se(i).bin) == 'Dry Southwest' 
%         subplot(3,5,[2 3 4 7 8 9]) 
        subplot(3,6,[1 2 7 8])
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#db30a2','markeredgecolor','#db30a2')    
        hold on
%         subplot(3,5,6)
        subplot(3,6,[9 10])
        movmean_mf = movmean(station_average_MF(i).all(1:365),30.4,'omitnan');
        plot(movmean_mf,'color','#696969','linewidth',1)
        text(360,18,{'Southwest'},'fontsize',16,'horizontalalignment','right');
        ylabel({'[Fine mass] (\mug/m^3)'}')
        set(gca, 'YScale', 'log') 
        ax = gca;
        ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
        ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
        ax.XAxis.FontSize = 12;
        ax.YAxis.FontSize = 12;
        ax.YLabel.FontSize = 12;   
        ax.XLim = [1 365];  
        hold on 
        bin5(:,count_bin5) = movmean_mf;
        count_bin5 = count_bin5+1;

    elseif string(station_average_Se(i).bin) == 'Florida' 
%         subplot(3,5,[2 3 4 7 8 9]) 
        subplot(3,6,[1 2 7 8])
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#0072BD','markeredgecolor','#0072BD')    
        hold on
%         subplot(3,5,13)
        subplot(3,6,[17 18])
        movmean_mf = movmean(station_average_MF(i).all(1:365),30.4,'omitnan');
        plot(movmean_mf,'color','#696969','linewidth',1)
        text(360,14,{'Southeast'},'fontsize',16,'horizontalalignment','right');
        ylabel({'[Fine mass] (\mug/m^3)'}')
        set(gca, 'YScale', 'log')  
        ax = gca;
        ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
        ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
        ax.XAxis.FontSize = 12;
        ax.YAxis.FontSize = 12;
        ax.YLabel.FontSize = 12;   
        ax.XLim = [1 365];   
%         yticks([0.25 0.5 0.75 1]);
        hold on
        bin6(:,count_bin6) = movmean_mf;
        count_bin6 = count_bin6+1;

    elseif string(station_average_Se(i).bin) == 'Unbinned' 
%         subplot(3,5,[2 3 4 7 8 9])
        subplot(3,6,[1 2 7 8])
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','k','markeredgecolor','k')    
        hold on
%         subplot(3,5,11)
        subplot(3,6,[13 14])
        movmean_mf = movmean(station_average_MF(i).all(1:365),30.4,'omitnan');
        plot(movmean_mf,'color','#696969','linewidth',1)
        text(360,17,{'Unclassified'},'fontsize',16,'horizontalalignment','right');
        ylabel({'[Fine mass] (\mug/m^3)'}')
        set(gca, 'YScale', 'log')  
        ax = gca;
        ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
        ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
        ax.XAxis.FontSize = 12;
        ax.YAxis.FontSize = 12;
        ax.YLabel.FontSize = 12;   
        ax.XLim = [1 365];   
%         yticks([0.25 0.5 0.75 1]); 
        hold on
    end   
end        


% subplot(3,5,5)
% plot(median(bin1,2),'color','#fcca03','linewidth',2.5)
% subplot(3,5,1)
% plot(median(bin2,2),'color','#23c221','linewidth',2.5)
% subplot(3,5,10)
% plot(median(bin3,2),'color','#A2142F','linewidth',2.5)
% subplot(3,5,15)
% plot(median(bin4,2),'color','#a830db','linewidth',2.5)
% subplot(3,5,6)
% plot(median(bin5,2),'color','#db30a2','linewidth',2.5)
% subplot(3,5,13)
% plot(median(bin6,2),'color','#0072BD','linewidth',2.5)

subplot(3,6,[5 6])
plot(median(bin1,2),'color','#fcca03','linewidth',3)
subplot(3,6,[3 4])
plot(median(bin2,2),'color','#23c221','linewidth',3)
subplot(3,6,[11 12])
plot(median(bin3,2),'color','#A2142F','linewidth',3)
subplot(3,6,[15 16])
plot(median(bin4,2),'color','#a830db','linewidth',3)
subplot(3,6,[9 10])
plot(median(bin5,2),'color','#db30a2','linewidth',3)
subplot(3,6,[17 18])
plot(median(bin6,2),'color','#0072BD','linewidth',3)


%% variable save for all_medians
median_mf_bin1 = median(bin1,2);
median_mf_bin2 = median(bin2,2);
median_mf_bin3 = median(bin3,2);
median_mf_bin4 = median(bin4,2);
median_mf_bin5 = median(bin5,2);
median_mf_bin6 = median(bin6,2);


%% linear

% figure(1)
% % subplot(4,4,[2 3 6 7 10 11 14 15])
% subplot(3,5,[2 3 4 7 8 9]) 
%     m_proj('lambert','long',[-128 -65],'lat',[24 50]);
%     m_coast('patch',[1 .85 .7]);
%     colormap(flipud(copper));
%     m_grid('box','fancy','tickdir','in');
%     hold on
% for i = 1:length(station_average_Se)
%     if string(station_average_Se(i).bin) == 'North Northeast'  
% %         subplot(241)
% %         subplot(4,4,[2 3 6 7 10 11 14 15])
%         subplot(3,5,[2 3 4 7 8 9]) 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#fcca03','markeredgecolor','#fcca03')    
%         hold on
%         
% %         subplot(242)
% %         subplot(4,4,4)
%         subplot(3,5,5)
%         movmean_se = movmean(station_average_Se(i).all,30.4,'omitnan');
%         plot(movmean_se,'color','#fcca03','linewidth',2)
%         text(360,1.05,{'North Northeast'},'fontsize',12,'horizontalalignment','right');
%         ylabel('{'[Fine mass]', '(\mug/m^3)'}')
% %         set(gca, 'YScale', 'log')  
%         ax = gca;
%         ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
%         ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});        
%         ax.XAxis.FontSize = 12;
%         ax.YAxis.FontSize = 12;
%         ax.YLabel.FontSize = 12;   
%         ax.XLim = [1 365];     
% %         ax.YLim = [0.01 10];
% %         ax.YTick = [0.01 0.1 1 10];
% %         ax.YTickLabel = {'10^{-2}', '10^{-1}', '10^0', '10^1'};   
% %         axis square
%         hold on
%     elseif string(station_average_Se(i).bin) == 'West Coast' 
% %         subplot(241)
% %         subplot(4,4,[2 3 6 7 10 11 14 15])
%         subplot(3,5,[2 3 4 7 8 9]) 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#23c221','markeredgecolor','#23c221')    
%         hold on
%         
% %         subplot(244)
% %         subplot(4,4,1)
%         subplot(3,5,1)
%         movmean_se = movmean(station_average_Se(i).all,30.4,'omitnan');
%         plot(movmean_se,'color','#23c221','linewidth',2)
%         text(360,1.05,{'West Coast'},'fontsize',12,'horizontalalignment','right');
%         ylabel('{'[Fine mass]', '(\mug/m^3)'}')
% %         set(gca, 'YScale', 'log')  
%         ax = gca;
%         ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
%         ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
%         ax.XAxis.FontSize = 12;
%         ax.YAxis.FontSize = 12;
%         ax.YLabel.FontSize = 12;   
%         ax.XLim = [1 365];    
%         yticks([0 0.2 0.4 0.6 0.8 1]);        
% %         ax.YLim = [0.01 10];
% %         ax.YTick = [0.01 0.1 1 10];   
% %         ax.YTickLabel = {'10^{-2}', '10^{-1}', '10^0', '10^1'};        
% %         axis square        
%         hold on
%     elseif string(station_average_Se(i).bin) == 'Northeast Coal' 
% %         subplot(241)
% %         subplot(4,4,[2 3 6 7 10 11 14 15])
%         subplot(3,5,[2 3 4 7 8 9]) 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#A2142F','markeredgecolor','#A2142F')    
%         hold on
%         
% %         subplot(243)
% %         subplot(4,4,8)
%         subplot(3,5,10)
%         movmean_se = movmean(station_average_Se(i).all,30.4,'omitnan');
%         plot(movmean_se,'color','#A2142F','linewidth',2)
%         text(360,3.1,{'Northeast Coal'},'fontsize',12,'horizontalalignment','right');
%         ylabel('{'[Fine mass]', '(\mug/m^3)'}')
% %         set(gca, 'YScale', 'log')  
%         ax = gca;
%         ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
%         ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
%         ax.XAxis.FontSize = 12;
%         ax.YAxis.FontSize = 12;
%         ax.YLabel.FontSize = 12;   
%         ax.XLim = [1 365];        
% %         ax.YLim = [0.01 10];
% %         ax.YTick = [0.01 0.1 1 10];   
% %         ax.YTickLabel = {'10^{-2}', '10^{-1}', '10^0', '10^1'};      
% %         axis square        
%         hold on
%     elseif string(station_average_Se(i).bin) == 'Midwest' 
% %         subplot(241)
% %         subplot(4,4,[2 3 6 7 10 11 14 15])
%         subplot(3,5,[2 3 4 7 8 9]) 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#a830db','markeredgecolor','#a830db')    
%         hold on
%         
% %         subplot(245)
% %         subplot(4,4,12)
%         subplot(3,5,15)
%         movmean_se = movmean(station_average_Se(i).all,30.4,'omitnan');
%         plot(movmean_se,'color','#a830db','linewidth',2)
%         text(360,1.25,{'Midwest'},'fontsize',12,'horizontalalignment','right');
%         ylabel('{'[Fine mass]', '(\mug/m^3)'}')
% %         set(gca, 'YScale', 'log')  
%         ax = gca;
%         ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
%         ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
%         ax.XAxis.FontSize = 12;
%         ax.YAxis.FontSize = 12;
%         ax.YLabel.FontSize = 12;   
%         ax.XLim = [1 365];  
%         yticks([0 0.3 0.6 0.9 1.2]);        
% %         ax.YLim = [0.01 10];
% %         ax.YTick = [0.01 0.1 1 10];  
% %         ax.YTickLabel = {'10^{-2}', '10^{-1}', '10^0', '10^1'};      
% %         axis square        
%         hold on 
%     elseif string(station_average_Se(i).bin) == 'Dry Southwest' 
% %         subplot(241)
% %         subplot(4,4,[2 3 6 7 10 11 14 15])
%         subplot(3,5,[2 3 4 7 8 9]) 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#db30a2','markeredgecolor','#db30a2')    
%         hold on
%         
% %         subplot(246)
% %         subplot(4,4,5)
%         subplot(3,5,6)
%         movmean_se = movmean(station_average_Se(i).all,30.4,'omitnan');
%         plot(movmean_se,'color','#db30a2','linewidth',2)
%         text(360,0.52,{'Dry Southwest'},'fontsize',12,'horizontalalignment','right');
%         ylabel('{'[Fine mass]', '(\mug/m^3)'}')
% %         set(gca, 'YScale', 'log') 
%         ax = gca;
%         ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
%         ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
%         ax.XAxis.FontSize = 12;
%         ax.YAxis.FontSize = 12;
%         ax.YLabel.FontSize = 12;   
%         ax.XLim = [1 365];       
%         hold on
% %         ax.YLim = [0.01 10];
% %         ax.YTick = [0.01 0.1 1 10];   
% %         ax.YTickLabel = {'10^{-2}', '10^{-1}', '10^0', '10^1'};     
% %         axis square        
%         hold on 
%     elseif string(station_average_Se(i).bin) == 'Florida' 
% %         subplot(241)
% %         subplot(4,4,[2 3 6 7 10 11 14 15])
%         subplot(3,5,[2 3 4 7 8 9]) 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#0072BD','markeredgecolor','#0072BD')    
%         hold on
%         
% %         subplot(247)
% %         subplot(4,4,16)
%         subplot(3,5,13)
%         movmean_se = movmean(station_average_Se(i).all,30.4,'omitnan');
%         plot(movmean_se,'color','#0072BD','linewidth',2)
%         text(360,1.3,{'Florida'},'fontsize',12,'horizontalalignment','right');
%         ylabel('{'[Fine mass]', '(\mug/m^3)'}')
% %         set(gca, 'YScale', 'log')  
%         ax = gca;
%         ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
%         ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
%         ax.XAxis.FontSize = 12;
%         ax.YAxis.FontSize = 12;
%         ax.YLabel.FontSize = 12;   
%         ax.XLim = [1 365];   
%         yticks([0 0.3 0.6 0.9 1.2]);
%         
% %         ax.YLim = [0.01 10];
% %         ax.YTick = [0.01 0.1 1 10];    
% %         ax.YTickLabel = {'10^{-2}', '10^{-1}', '10^0', '10^1'};     
% %         axis square        
%         hold on
%     elseif string(station_average_Se(i).bin) == 'Unbinned' 
% %         subplot(241)
% %         subplot(4,4,[2 3 6 7 10 11 14 15])
%         subplot(3,5,[2 3 4 7 8 9]) 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','k','markeredgecolor','k')    
%         hold on
%         
% %         subplot(248)
% %         subplot(4,4,9)
%         subplot(3,5,11)
%         movmean_se = movmean(station_average_Se(i).all,30.4,'omitnan');
%         plot(movmean_se,'color','k','linewidth',2)
%         text(360,1.6,{'Unclassified'},'fontsize',12,'horizontalalignment','right');
%         ylabel('{'[Fine mass]', '(\mug/m^3)'}')
% %         set(gca, 'YScale', 'log')  
%         ax = gca;
%         ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
%         ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});           
%         ax.XAxis.FontSize = 12;
%         ax.YAxis.FontSize = 12;
%         ax.YLabel.FontSize = 12;   
%         ax.XLim = [1 365];   
%         yticks([0 0.3 0.6 0.9 1.2]);
%         
% %         ax.YLim = [0.01 10];
% %         ax.YTick = [0.01 0.1 1 10];     
% %         ax.YTickLabel = {'10^{-2}', '10^{-1}', '10^0', '10^1'};        
% %         axis square        
%         hold on
%     end   
% end
% 
