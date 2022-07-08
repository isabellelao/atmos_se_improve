addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data'
addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data/m_map/'

load('station_average_Se_binned.mat')

%% 

all_mean = nan(length(station_average_Se),1);
for i = 1:length(station_average_Se)
    all_mean(i) = mean(station_average_Se(i).all,'omitnan');
end 

mean(all_mean)

%%
currmean = [];
for i = 1:length(station_average_Se)   
    if string(station_average_Se(i).bin) == 'Northeast Coal'
        currmean = [currmean mean(station_average_Se(i).all,'omitnan')];
    end 
end 
mean(currmean)


%%
figure
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    colormap(flipud(copper));
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(station_average_Se,'lon'),extractfield(station_average_Se,'lat'),100,all_mean,'filled')
    colormap(parula)        
    c = colorbar;
    c.Location = 'southoutside';
    c.Label.FontSize = 24;
    c.FontSize = 24; 
    c.Limits = [0 2];
    c.TickDirection = 'out';
    c.Ticks = [0:0.4:2];    
    c.Label.String = 'Average Se Concentration (ng/m^{3})';    

    
    
    
    