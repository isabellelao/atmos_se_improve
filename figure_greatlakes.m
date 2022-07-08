addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data'
addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data/m_map/'

load('station_average_Se_binned.mat')
load('station_average_MF.mat')
load('gridpt_average_socolaer.mat')

ncid            = netcdf.open('precip.V1.0.day.1981-2010.ltm.nc');
    precip_lon  = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lon')); % deg E, 20x1
    precip_lat  = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lat')); % deg N, 38x1
    precip_data = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'precip')); % anthropogenic (lon, lat, height, time)
    netcdf.close(ncid)

%% 

greatlakes = {};
count = 1;

for i = [10 37 46 66 77];

    curr_lat             = station_average_Se(i).lat;
    curr_lon             = station_average_Se(i).lon;
    se_smooth            = movmean(station_average_Se(i).all,30,'omitnan');    
    
    % precip
    [~,minlat_idx]       = min(abs(precip_lat-curr_lat));
    [~,minlon_idx]       = min(abs(precip_lon-(curr_lon+360)));
    rain_alltime_average = squeeze(precip_data(minlon_idx,minlat_idx,:));
    rain_smooth          = movmean(rain_alltime_average,30.4,'omitnan');        

    % socol-aer
    [~,minlat_idx]       = min(abs(extractfield(gridpt_average_socolaer,'lat')-curr_lat));
    [~,minlon_idx]       = min(abs(extractfield(gridpt_average_socolaer,'lon')-(curr_lon+360)));
    minlat_val           = gridpt_average_socolaer(minlat_idx).lat;
    minlon_val           = gridpt_average_socolaer(minlon_idx).lon;
    all_minlat           = find(extractfield(gridpt_average_socolaer,'lat')==minlat_val);
    all_minlon           = find(extractfield(gridpt_average_socolaer,'lon')==minlon_val);
    socol_idx            = intersect(all_minlat,all_minlon);
    curr_ant             = gridpt_average_socolaer(socol_idx).ant;
    curr_vol             = gridpt_average_socolaer(socol_idx).vol;
    curr_mar             = gridpt_average_socolaer(socol_idx).mar;
    curr_terr            = gridpt_average_socolaer(socol_idx).terr;


    greatlakes(count).name      = station_average_Se(i).name;        
    greatlakes(count).lat       = curr_lat;  
    greatlakes(count).lon       = curr_lon;        
    greatlakes(count).se        = se_smooth;
    greatlakes(count).enh       = station_average_MF(i).enhancement;    
    greatlakes(count).ppt       = rain_smooth;
    greatlakes(count).allemi    = (curr_ant + curr_vol + curr_mar + curr_terr)*1.311628e-7 ;        
    greatlakes(count).ant       = curr_ant*1.311628e-7;    
    greatlakes(count).vol       = curr_vol*1.311628e-7;    
    greatlakes(count).mar       = curr_mar*1.311628e-7;    
    greatlakes(count).terr      = curr_terr*1.311628e-7;       
    
    count = count + 1;
end 


%% emissions 

emissions_raw = readtable('Catalogue_Emissions_AMF_corr-2014.xlsx');
emissions_florida = {};
count = 1;
for i = 1:size(emissions_raw,1)  
    if string(emissions_raw{i,7})=='USA'
        if emissions_raw{i,2}>24 & emissions_raw{i,2}<34 & emissions_raw{i,3}>-84 & emissions_raw{i,3}<-78
            emissions_florida(count).latitude  = emissions_raw{i,2};
            emissions_florida(count).longitude = emissions_raw{i,3};    
            emissions_florida(count).type      = emissions_raw{i,5};      
            emissions_florida(count).comment   = emissions_raw{i,8};               
            emissions_florida(count).adj_emi   = mean(emissions_raw{i,11:16});        

            count = count+1;            
        end
    end 
end 


%% 

figure(1)
subplot(5,5,[1 6 11 16 21])
    m_proj('lambert','long',[-96 -75],'lat',[39 50]);
    m_coast('patch',[1 .85 .7]);
    colormap(flipud(copper));
    m_grid('box','fancy','tickdir','in','fontsize',12);
    hold on
%     m_scatter(extractfield(emissions_USA,'longitude'),extractfield(emissions_USA,'latitude'),100,extractfield(emissions_USA,'adj_emi'),'filled','s')    
%     colormap(cool)  
    m_scatter(extractfield(emissions_florida,'longitude'),extractfield(emissions_florida,'latitude'),100,'filled','s','markerfacecolor','w','markeredgecolor','k')  
    hold on
    m_scatter(greatlakes(1).lon,greatlakes(1).lat,150,'filled','o','markerfacecolor','#0072BD','markeredgecolor','#0072BD')  
    hold on
    m_scatter(greatlakes(2).lon,greatlakes(2).lat,150,'filled','d','markerfacecolor','#0072BD','markeredgecolor','#0072BD')  
    hold on
    m_scatter(greatlakes(3).lon,greatlakes(3).lat,150,'filled','h','markerfacecolor','#0072BD','markeredgecolor','#0072BD')  
    hold on
    m_scatter(greatlakes(4).lon,greatlakes(4).lat,150,'filled','^','markerfacecolor','#0072BD','markeredgecolor','#0072BD')  
    hold on
    m_scatter(greatlakes(5).lon,greatlakes(5).lat,150,'filled','v','markerfacecolor','#0072BD','markeredgecolor','#0072BD')      
    hold on    
    
subplot(5,5,2)
    movmean_se = movmean(greatlakes(5).se,30.4,'omitnan');
    plot(movmean_se,'color','#0072BD','linewidth',2)
    hold on
    scatter(340,0.5,200,'filled','v','markerfacecolor','#0072BD','markeredgecolor','#0072BD') 
    ylabel('[Se] (ng/m^3)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 0.6];
    text(200,0.5,'Voyageurs','FontSize',12)
    
subplot(5,5,3)
    plot(greatlakes(5).allemi,'--','color','#696969','linewidth',2)
    hold on
    plot(greatlakes(5).ant,'r--','linewidth',2)
    hold on 
    plot(greatlakes(5).mar,'b--','linewidth',2)
    hold on     
    plot(greatlakes(5).terr,'g--','linewidth',2)
    hold on
    ylabel({'Model [emission]', '(ng/m^3)'})
    xlim([1 365])       
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});     
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 1.5];
    
subplot(5,5,4)
    plot(greatlakes(5).enh,'color','b','linewidth',2)
    ylabel('Se enhancement')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 1.2e-4];    

subplot(5,5,5)
    plot(greatlakes(5).ppt,'color','#4DBEEE','linewidth',2)
    ylabel('precipitation (mm)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];    
    ax.YLim = [0 5];    
    

subplot(5,5,7)
    movmean_se = movmean(greatlakes(1).se,30.4,'omitnan');
    plot(movmean_se,'color','#0072BD','linewidth',2)
    hold on
    scatter(340,0.5,200,'filled','o','markerfacecolor','#0072BD','markeredgecolor','#0072BD') 
    ylabel('[Se] (ng/m^3)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 0.6];
    text(120,0.5,'Boundary Waters','FontSize',12)    
    
subplot(5,5,8)
    plot(greatlakes(1).allemi,'--','color','#696969','linewidth',2)
    hold on
    plot(greatlakes(1).ant,'r--','linewidth',2)
    hold on 
    plot(greatlakes(1).mar,'b--','linewidth',2)
    hold on     
    plot(greatlakes(1).terr,'g--','linewidth',2)
    hold on
    ylabel({'Model [emission]', '(ng/m^3)'})
    xlim([1 365])       
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});     
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 1.5];
        
subplot(5,5,9)
    plot(greatlakes(1).enh,'color','b','linewidth',2)
    ylabel('Se enhancement')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 1.2e-4];    

subplot(5,5,10)
    plot(greatlakes(1).ppt,'color','#4DBEEE','linewidth',2)
    ylabel('precipitation (mm)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 5];    

subplot(5,5,12)
    movmean_se = movmean(greatlakes(2).se,30.4,'omitnan');
    plot(movmean_se,'color','#0072BD','linewidth',2)
    hold on
    scatter(340,0.5,200,'filled','d','markerfacecolor','#0072BD','markeredgecolor','#0072BD')
    ylabel('[Se] (ng/m^3)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 0.6];
    text(190,0.5,'Isle Royale','FontSize',12)    
    
    
subplot(5,5,13)
    plot(greatlakes(2).allemi,'--','color','#696969','linewidth',2)
    hold on
    plot(greatlakes(2).ant,'r--','linewidth',2)
    hold on 
    plot(greatlakes(2).mar,'b--','linewidth',2)
    hold on     
    plot(greatlakes(2).terr,'g--','linewidth',2)
    hold on
    ylabel({'Model [emission]', '(ng/m^3)'})
    xlim([1 365])       
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});     
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 1.5];

subplot(5,5,14)
    plot(greatlakes(2).enh,'color','b','linewidth',2)
    ylabel('Se enhancement')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 1.2e-4];    

subplot(5,5,15)
    plot(greatlakes(2).ppt,'color','#4DBEEE','linewidth',2)
    ylabel('precipitation (mm)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 5];    
    
subplot(5,5,17)
    movmean_se = movmean(greatlakes(4).se,30.4,'omitnan');
    plot(movmean_se,'color','#0072BD','linewidth',2)
    hold on
    scatter(340,0.5,200,'filled','^','markerfacecolor','#0072BD','markeredgecolor','#0072BD') 
    ylabel('[Se] (ng/m^3)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 0.6];
    % text(290,0.05,'Seney','FontSize',12)    
    text(250,0.5,'Seney','FontSize',12)    
    
    
    
subplot(5,5,18)
    plot(greatlakes(4).allemi,'--','color','#696969','linewidth',2)
    hold on
    plot(greatlakes(4).ant,'r--','linewidth',2)
    hold on 
    plot(greatlakes(4).mar,'b--','linewidth',2)
    hold on     
    plot(greatlakes(4).terr,'g--','linewidth',2)
    hold on
    ylabel({'Model [emission]', '(ng/m^3)'})
    xlim([1 365])       
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});     
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 1.5];

subplot(5,5,19)
    plot(greatlakes(4).enh,'color','b','linewidth',2)
    ylabel('Se enhancement')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 1.2e-4];    

subplot(5,5,20)
    plot(greatlakes(4).ppt,'color','#4DBEEE','linewidth',2)
    ylabel('precipitation (mm)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];    
    ax.YLim = [0 5];    
   
subplot(5,5,22)
    movmean_se = movmean(greatlakes(3).se,30.4,'omitnan');
    plot(movmean_se,'color','#0072BD','linewidth',2)
    hold on
    scatter(340,2.3,200,'filled','h','markerfacecolor','#0072BD','markeredgecolor','#0072BD') 
    ylabel('[Se] (ng/m^3)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 2.7];
    text(160,2.3,'M.K. Goddard','FontSize',12)    
    
    
subplot(5,5,23)
    plot(greatlakes(3).allemi,'--','color','#696969','linewidth',2)
    hold on
    plot(greatlakes(3).ant,'r--','linewidth',2)
    hold on 
    plot(greatlakes(3).mar,'b--','linewidth',2)
    hold on     
    plot(greatlakes(3).terr,'g--','linewidth',2)
    hold on
    ylabel({'Model [emission]', '(ng/m^3)'})
    xlim([1 365])       
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});     
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 6];

subplot(5,5,24)
    plot(greatlakes(3).enh,'color','b','linewidth',2)
    ylabel('Se enhancement')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];
    ax.YLim = [0 4e-4];            

subplot(5,5,25)
    plot(greatlakes(3).ppt,'color','#4DBEEE','linewidth',2)
    ylabel('precipitation (mm)')
    ax = gca;
    ax.XTick = ([15 45 74 105 135 166 196 227 258 288 319 349]);
    ax.XTickLabel = ({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    ax.XAxis.FontSize = 12;
    ax.YAxis.FontSize = 12;
    ax.YLabel.FontSize = 12;
    ax.XLim = [1 365];    
    ax.YLim = [0 5];    
    