addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data'
addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data/m_map/'

load('station_average_Se_binned.mat')

%% emissions 

emissions_raw = readtable('Catalogue_Emissions_AMF_corr-2014.xlsx');
emissions_USA = {};
count = 1;
for i = 1:size(emissions_raw,1)  
    if string(emissions_raw{i,7})=='USA'
        if emissions_raw{i,2}>15 & emissions_raw{i,2}<55 & emissions_raw{i,3}>-135 & emissions_raw{i,3}<-60
            emissions_USA(count).latitude  = emissions_raw{i,2};
            emissions_USA(count).longitude = emissions_raw{i,3};    
            emissions_USA(count).type      = emissions_raw{i,5};      
            emissions_USA(count).comment   = emissions_raw{i,8};               
            emissions_USA(count).adj_emi   = mean(emissions_raw{i,11:16});        

            count = count+1;            
        end
    end 
end 

%% 

figure
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    colormap(flipud(copper));
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(emissions_USA,'longitude'),extractfield(emissions_USA,'latitude'),100,extractfield(emissions_USA,'adj_emi'),'filled','s','markeredgecolor','k','linewidth',1)
    colormap(cool)        
    c = colorbar;
    c.Location = 'southoutside';
    c.Label.FontSize = 16;
    c.FontSize = 24; 
    c.Limits = [0 200];
    c.TickDirection = 'out';
    c.Ticks = [0:30:200];    
    c.Label.String = 'Power Plant Emission Flux([SO_{2}]/yr)';    

for i = 1:length(station_average_Se)
    if string(station_average_Se(i).bin) == 'Northeast Coal'          
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#A2142F','markeredgecolor','#A2142F')    
        hold on
    else
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,50,'filled','markerfacecolor','#696969','markeredgecolor','#696969')    
    end 
end            
    