addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data'
addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data/m_map/'

load('station_average_Se_binned.mat')
load('station_average_MF.mat')

%%

for i = [1:length(station_average_Se)]

    % se time series
    Se_alltime_average   = station_average_Se(i).all(1:365);
    se_smooth            = movmean(Se_alltime_average,30,'omitnan');
    curr_lat             = station_average_Se(i).lat;
    curr_lon             = station_average_Se(i).lon;
    
    % fine mass time series
    movmean_mf = movmean(station_average_MF(i).all(1:365),30.4,'omitnan');
    
    % precipitation r^2
    [R_finemass,p]                  = corr(se_smooth,movmean_mf);

    station_average_Se(i).Rfinemass     = R_finemass;

end

%% one year corr 
redbluecm = redblue;
figure
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(station_average_Se,'lon'),extractfield(station_average_Se,'lat'),75,extractfield(station_average_Se,'Rfinemass'),'filled')
    caxis([-1 1])   

    c1= colorbar;
    c1.Label.String = '[Se] v. Fine Mass Correlation';
    c1.Label.FontSize = 16;        
    c1.Location = 'southoutside';
    c1.Label.FontSize = 20;
    c1.FontSize = 16; 
    c1.Limits = [-1 1];
    c1.TickDirection = 'out';
    c1.Ticks = [-1 -0.5 0 0.5 1];
    c1.TickLabels = {'Anti-correlated','-0.5','0','0.5','Correlated'};
    colormap(redbluecm) 
