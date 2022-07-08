% run se binning
% run enhancement
% run fine mass
% run figure_wetdepo

figure
% subplot(151)
subplot(141)
    plot(median_se_bin1,'color','#fcca03','linewidth',3)
    hold on
    plot(median_se_bin2,'color','#23c221','linewidth',3)
    hold on
    plot(median_se_bin3,'color','#A2142F','linewidth',3)
    hold on 
    plot(median_se_bin4,'color','#a830db','linewidth',3)
    hold on
    plot(median_se_bin5,'color','#db30a2','linewidth',3)
    hold on
    plot(median_se_bin6,'color','#0072BD','linewidth',3)
    ylabel('Se concentration (ng/m^3)')
    set(gca, 'YScale', 'log')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 15;
    ax.YAxis.FontSize = 15;
    ax.YLabel.FontSize = 15;
    ax.XLim = [1 365];
    yticks([0.2:0.2:1.4]);
    axis square
%     lgd = legend('North Northeast','West','Northeast','Midwest','Southwest','Southeast');
%     lgd.Location = 'westoutside';
%     lgd.NumColumns = 2;
%     lgd.FontSize = 16;
    
% subplot(153)
subplot(143)
    plot(median_enh_bin1,'color','#fcca03','linewidth',3)
    hold on
    plot(median_enh_bin2,'color','#23c221','linewidth',3)
    hold on
    plot(median_enh_bin3,'color','#A2142F','linewidth',3)
    hold on 
    plot(median_enh_bin4,'color','#a830db','linewidth',3)
    hold on
    plot(median_enh_bin5,'color','#db30a2','linewidth',3)
    hold on
    plot(median_enh_bin6,'color','#0072BD','linewidth',3)
    ylabel('Se:PM_{2.5}')
    set(gca, 'YScale', 'log')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 15;
    ax.YAxis.FontSize = 15;
    ax.YLabel.FontSize = 15;
    ax.XLim = [1 365];
    axis square    

% subplot(152)
subplot(142)
    plot(median_mf_bin1,'color','#fcca03','linewidth',3)
    hold on
    plot(median_mf_bin2,'color','#23c221','linewidth',3)
    hold on
    plot(median_mf_bin3,'color','#A2142F','linewidth',3)
    hold on 
    plot(median_mf_bin4,'color','#a830db','linewidth',3)
    hold on
    plot(median_mf_bin5,'color','#db30a2','linewidth',3)
    hold on
    plot(median_mf_bin6,'color','#0072BD','linewidth',3)
    ylabel({'Fine mass concentration (\mug/m^3)'}')
    set(gca, 'YScale', 'log')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 15;
    ax.YAxis.FontSize = 15;
    ax.YLabel.FontSize = 15;
    ax.XLim = [1 365];
    %yticks([0.2:0.2:1.4]);
    axis square    

% subplot(154)
subplot(144)
    plot(median_ppt_bin1,'color','#fcca03','linewidth',3)
    hold on
    plot(median_ppt_bin2,'color','#23c221','linewidth',3)
    hold on
    plot(median_ppt_bin3,'color','#A2142F','linewidth',3)
    hold on 
    plot(median_ppt_bin4,'color','#a830db','linewidth',3)
    hold on
    plot(median_ppt_bin5,'color','#db30a2','linewidth',3)
    hold on
    plot(median_ppt_bin6,'color','#0072BD','linewidth',3)
    ylabel('Precipitation (mm)')
    yticks([2 4 6])
    % set(gca, 'YScale', 'log')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 15;
    ax.YAxis.FontSize = 15;
    ax.YLabel.FontSize = 15;
    ax.XLim = [1 365];
    axis square        

% subplot(155)
%     m_proj('lambert','long',[-128 -65],'lat',[24 50]);
%     m_coast('patch',[1 .85 .7]);
%     colormap(flipud(copper));
%     m_grid('box','fancy','tickdir','in','fontsize',12);
%     hold on
% 
% for i = 1:length(station_average_Se)
%     if string(station_average_Se(i).bin) == 'North Northeast'          
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#fcca03','markeredgecolor','#fcca03')    
%         hold on
% 
%     elseif string(station_average_Se(i).bin) == 'West Coast' 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#23c221','markeredgecolor','#23c221')    
%         hold on
% 
%     elseif string(station_average_Se(i).bin) == 'Northeast Coal' 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#A2142F','markeredgecolor','#A2142F')    
%         hold on
% 
%     elseif string(station_average_Se(i).bin) == 'Midwest' 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#a830db','markeredgecolor','#a830db')    
%         hold on
% 
%     elseif string(station_average_Se(i).bin) == 'Dry Southwest' 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#db30a2','markeredgecolor','#db30a2')    
%         hold on
% 
%     elseif string(station_average_Se(i).bin) == 'Florida' 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#0072BD','markeredgecolor','#0072BD')    
%         hold on
% 
%     elseif string(station_average_Se(i).bin) == 'Unbinned' 
%         m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','k','markeredgecolor','k')    
%         hold on
%     end   
% end        
