addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data'
addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data/m_map/'

load('station_average_Se_binned.mat')
load('gridpt_average_socolaer.mat')
%%

socol2plot = {};
for i = 1:length(station_average_Se)
    
    % se time series
    Se_alltime_average   = station_average_Se(i).all(1:365);
    se_smooth            = movmean(Se_alltime_average,30,'omitnan');
    curr_lat             = station_average_Se(i).lat;
    curr_lon             = station_average_Se(i).lon;

    % socol-aer time series
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
    allemi               = curr_ant + curr_vol + curr_mar + curr_terr;    

    socol2plot(i).name      = station_average_Se(i).name;
    socol2plot(i).se_smooth = se_smooth;
    socol2plot(i).lat       = curr_lat;
    socol2plot(i).lon       = curr_lon;

    socol2plot(i).allemi    = allemi;
    [R_allemi,p]               = corr(se_smooth,allemi);    
    socol2plot(i).allemir2  = R_allemi;
    socol2plot(i).p  = p;

    currcoeff               = corrcoef(se_smooth(1:91),allemi(1:91));    
    socol2plot(i).allemirs1 = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(92:182),allemi(92:182));    
    socol2plot(i).allemirs2 = currcoeff(2);    
    currcoeff               = corrcoef(se_smooth(183:273),allemi(183:273));    
    socol2plot(i).allemirs3 = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(274:end),allemi(274:end));    
    socol2plot(i).allemirs4 = currcoeff(2);  

    socol2plot(i).ant       = curr_ant;
    currcoeff               = corrcoef(se_smooth,curr_ant);    
    socol2plot(i).antr2     = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(1:91),curr_ant(1:91));    
    socol2plot(i).antrs1    = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(92:182),curr_ant(92:182));    
    socol2plot(i).antrs2    = currcoeff(2);    
    currcoeff               = corrcoef(se_smooth(183:273),curr_ant(183:273));    
    socol2plot(i).antrs3    = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(274:end),curr_ant(274:end));    
    socol2plot(i).antrs4    = currcoeff(2);      

    socol2plot(i).vol       = curr_vol;
    currcoeff               = corrcoef(se_smooth,curr_vol);    
    socol2plot(i).volr2     = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(1:91),curr_vol(1:91));    
    socol2plot(i).volrs1    = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(92:182),curr_vol(92:182));    
    socol2plot(i).volrs2    = currcoeff(2);    
    currcoeff               = corrcoef(se_smooth(183:273),curr_vol(183:273));    
    socol2plot(i).volrs3    = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(274:end),curr_vol(274:end));    
    socol2plot(i).volrs4    = currcoeff(2);   

    socol2plot(i).mar       = curr_mar;
    currcoeff               = corrcoef(se_smooth,curr_mar);    
    socol2plot(i).marr2     = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(1:91),curr_mar(1:91));    
    socol2plot(i).marrs1    = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(92:182),curr_mar(92:182));    
    socol2plot(i).marrs2    = currcoeff(2);    
    currcoeff               = corrcoef(se_smooth(183:273),curr_mar(183:273));    
    socol2plot(i).marrs3    = currcoeff(2);
    currcoeff               = corrcoef(se_smooth(274:end),curr_mar(274:end));    
    socol2plot(i).marrs4    = currcoeff(2);   

    socol2plot(i).terr       = curr_terr;
    currcoeff                = corrcoef(se_smooth,curr_terr);    
    socol2plot(i).terrr2     = currcoeff(2);
    currcoeff                = corrcoef(se_smooth(1:91),curr_terr(1:91));    
    socol2plot(i).terrrs1    = currcoeff(2);
    currcoeff                = corrcoef(se_smooth(92:182),curr_terr(92:182));    
    socol2plot(i).terrrs2    = currcoeff(2);    
    currcoeff                = corrcoef(se_smooth(183:273),curr_terr(183:273));    
    socol2plot(i).terrrs3    = currcoeff(2);
    currcoeff                = corrcoef(se_smooth(274:end),curr_terr(274:end));    
    socol2plot(i).terrrs4    = currcoeff(2);       
    
end

%% 
redbluecm = redblue;
figure
  %  subplot(411)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',12);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'allemir2'),'filled')
    caxis([-1 1])    
    title('Total','fontsize',16)   

 %   subplot(411)
    ax1 = gca;
    c1= colorbar;
    c1.Label.String = '[Se] v. [SOCOL-AER] Correlation';
    c1.Label.FontSize = 16;        
    c1.Location = 'southoutside';
    c1.Label.FontSize = 16;
    c1.FontSize = 16; 
    c1.Limits = [-1 1];
    c1.FontWeight = 'bold';
    c1.TickDirection = 'out';
    c1.Ticks = [-1 -0.5 0 0.5 1];
    c1.TickLabels = {'Anti-correlated','-0.5','0','0.5','Correlated'};
  
    colormap(redbluecm) 
    hold on        
%%
    subplot(412)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',12);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'antr2'),'filled')
    caxis([-1 1])    
    title('Anthropogenic','fontsize',16)      

    subplot(413)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',12);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'marr2'),'filled')
    caxis([-1 1])    
    title('Marine','fontsize',16)        

    subplot(414)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',12);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'terrr2'),'filled')
    caxis([-1 1])    
    title('Terrestrial','fontsize',16)    

%% all
figure
    subplot(411)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'allemir2'),'filled')
    caxis([-1 1])    
    title('All','fontsize',16)   

    subplot(411)
    ax1 = gca;
    c1= colorbar;
    c1.Label.String = '[Se] v. SOCOL-AER Correlation';
    c1.Label.FontSize = 16;        
    c1.Location = 'northoutside';
    c1.Label.FontSize = 16;
    c1.FontSize = 16; 
    c1.Limits = [-1 1];
    c1.TickDirection = 'out';
    c1.Ticks = [-1 -0.5 0 0.5 1];
    c1.TickLabels = {'Anti-correlated','-0.5','0','0.5','Correlated'};
    colormap(redbluecm) 
    hold on        

    subplot(412)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'allemirs1'),'filled')
    caxis([-1 1])    
    title('Winter','fontsize',16) 

    subplot(413)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'allemirs2'),'filled')
    caxis([-1 1])    
    title('Spring','fontsize',16)     

    subplot(414)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'allemirs3'),'filled')
    caxis([-1 1])    
    title('Summer','fontsize',16)   

    subplot(2,4,8)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'allemirs4'),'filled')
    caxis([-1 1])    
    title('Autumn','fontsize',16)    

%% anthropogenic 

figure
    subplot(2,4,[1:4])
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'antr2'),'filled')
    caxis([-1 1])    
    title('Anthropogenic','fontsize',16)   

    subplot(2,4,[1:4])
    ax1 = gca;
    c1= colorbar;
    c1.Label.String = '[Se] v. SOCOL-AER Correlation';
    c1.Label.FontSize = 16;        
    c1.Location = 'southoutside';
    c1.Label.FontSize = 16;
    c1.FontSize = 16; 
    c1.Limits = [-1 1];
    c1.TickDirection = 'out';
    c1.Ticks = [-1 -0.5 0 0.5 1];
    c1.TickLabels = {'Anti-correlated','-0.5','0','0.5','Correlated'};
    colormap(redbluecm) 
    hold on        

    subplot(2,4,5)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'antrs1'),'filled')
    caxis([-1 1])    
    title('Winter','fontsize',16) 

    subplot(2,4,6)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'antrs2'),'filled')
    caxis([-1 1])    
    title('Spring','fontsize',16)     

    subplot(2,4,7)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'antrs3'),'filled')
    caxis([-1 1])    
    title('Summer','fontsize',16)   

    subplot(2,4,8)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'antrs4'),'filled')
    caxis([-1 1])    
    title('Autumn','fontsize',16)     

%% marine 

figure
    subplot(2,4,[1:4])
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'marr2'),'filled')
    caxis([-1 1])    
    title('Marine','fontsize',16)   

    subplot(2,4,[1:4])
    ax1 = gca;
    c1= colorbar;
    c1.Label.String = '[Se] v. SOCOL-AER Correlation';
    c1.Label.FontSize = 16;        
    c1.Location = 'southoutside';
    c1.Label.FontSize = 16;
    c1.FontSize = 16; 
    c1.Limits = [-1 1];
    c1.TickDirection = 'out';
    c1.Ticks = [-1 -0.5 0 0.5 1];
    c1.TickLabels = {'Anti-correlated','-0.5','0','0.5','Correlated'};
    colormap(redbluecm) 
    hold on        

    subplot(2,4,5)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'marrs1'),'filled')
    caxis([-1 1])    
    title('Winter','fontsize',16) 

    subplot(2,4,6)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'marrs2'),'filled')
    caxis([-1 1])    
    title('Spring','fontsize',16)     

    subplot(2,4,7)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'marrs3'),'filled')
    caxis([-1 1])    
    title('Summer','fontsize',16)   

    subplot(2,4,8)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'marrs4'),'filled')
    caxis([-1 1])    
    title('Autumn','fontsize',16) 

%% terrestrial 

figure
    subplot(2,4,[1:4])
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'terrr2'),'filled')
    caxis([-1 1])    
    title('Terrestrial','fontsize',16)   

    subplot(2,4,[1:4])
    ax1 = gca;
    c1= colorbar;
    c1.Label.String = '[Se] v. SOCOL-AER Correlation';
    c1.Label.FontSize = 16;        
    c1.Location = 'southoutside';
    c1.Label.FontSize = 16;
    c1.FontSize = 16; 
    c1.Limits = [-1 1];
    c1.TickDirection = 'out';
    c1.Ticks = [-1 -0.5 0 0.5 1];
    c1.TickLabels = {'Anti-correlated','-0.5','0','0.5','Correlated'};
    colormap(redbluecm) 
    hold on        

    subplot(2,4,5)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'terrrs1'),'filled')
    caxis([-1 1])    
    title('Winter','fontsize',16) 

    subplot(2,4,6)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'terrrs2'),'filled')
    caxis([-1 1])    
    title('Spring','fontsize',16)     

    subplot(2,4,7)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'terrrs3'),'filled')
    caxis([-1 1])    
    title('Summer','fontsize',16)   

    subplot(2,4,8)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(socol2plot,'lon'),extractfield(socol2plot,'lat'),75,extractfield(socol2plot,'terrrs4'),'filled')
    caxis([-1 1])    
    title('Autumn','fontsize',16)  
      


    