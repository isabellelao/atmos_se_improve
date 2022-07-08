addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data'
addpath '/Users/isabellelao/Desktop/atmos_se_improve_figures/data/m_map/'

load('station_average_Se_binned.mat')
ncid            = netcdf.open('precip.V1.0.day.1981-2010.ltm.nc');
    precip_lon  = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lon')); % deg E, 20x1
    precip_lat  = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lat')); % deg N, 38x1
    precip_data = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'precip')); % anthropogenic (lon, lat, height, time)
    netcdf.close(ncid)

%% County data 

% first read shapefile data of all counties
counties = shaperead('UScounties.shp','UseGeoCoords', true); %Load counties shapefile

% loop through, fill in FIPS of each row
FIPS_shapefile = {};
for i = 1:length(counties)
    FIPS_shapefile{i} = counties(i).FIPS;
end
% convert to array of strings
FIPS_shapefile = string(FIPS_shapefile);
%% USGS Soil data
% next load Se data from USGS
USGS_data = readtable('county-averages.xls');

% get FIPS data from counties in USGS
FIPS_Se = USGS_data.FIPS;

% get Se concentration data from counties in USGS
Se_conc = USGS_data.Se;
Se_conc_std = USGS_data.x__Se; % standard deviation
%% Loop through counties, assign a Se conc to each county
n_counties = length(FIPS_Se); % number of counties in US
% loop through counties, plot each one
for i = 1:n_counties 
    FIPS_Se_use = sprintf( '%05d', FIPS_Se(i) ) ;% add leading zero if necessary, since shapefile dataset has 5 digits
    % find which row of the county shapefile the FIPS code corresponds to
    ind_use = find(FIPS_shapefile == FIPS_Se_use);
    if isempty(ind_use)
        continue % skip loop if can't find shapefile
    end
    % select correct county and add a field for Se conc and std
    counties(ind_use).Se_conc = Se_conc(i);
    counties(ind_use).Se_conc_std = Se_conc_std(i);
end
%% Make sure that all NaN or empty values are set to zero
for i = 1:length(counties)
    if isempty(counties(i).Se_conc)
        counties(i).Se_conc = NaN;
    end
end
    
%%


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

for i = [1:length(station_average_Se)]

    % se time series
    Se_alltime_average   = station_average_Se(i).all(1:365);
    se_smooth            = movmean(Se_alltime_average,30,'omitnan');
    curr_lat             = station_average_Se(i).lat;
    curr_lon             = station_average_Se(i).lon;
    
    % precipitation time series
    [~,minlat_idx]       = min(abs(precip_lat-curr_lat));
    [~,minlon_idx]       = min(abs(precip_lon-(curr_lon+360)));
    rain_alltime_average = squeeze(precip_data(minlon_idx,minlat_idx,:));
    rain_smooth          = movmean(rain_alltime_average,30.4,'omitnan');
    
    % precipitation r^2
    [R_ppt,p]                  = corr(se_smooth,rain_smooth);
    R_ppt_winter                 = corrcoef(se_smooth(1:91),rain_smooth(1:91));  
    R_ppt_spring                 = corrcoef(se_smooth(92:182),rain_smooth(92:182));    
    R_ppt_summer                 = corrcoef(se_smooth(183:273),rain_smooth(183:273));    
    R_ppt_autumn                 = corrcoef(se_smooth(274:365),rain_smooth(274:365));        
    station_average_Se(i).Rprecip      = R_ppt;
    station_average_Se(i).rho          = p;    
    station_average_Se(i).Rpptwinter   = R_ppt_winter(2);
    station_average_Se(i).Rpptspring   = R_ppt_spring(2);
    station_average_Se(i).Rpptsummer   = R_ppt_summer(2);
    station_average_Se(i).Rpptautumn   = R_ppt_autumn(2);  

    if string(station_average_Se(i).bin) == 'North Northeast'          
        bin1(:,count_bin1) = rain_smooth;
        count_bin1 = count_bin1+1;
    elseif string(station_average_Se(i).bin) == 'West Coast' 
        bin2(:,count_bin2) = rain_smooth;
        count_bin2 = count_bin2+1;

    elseif string(station_average_Se(i).bin) == 'Northeast Coal' 
        bin3(:,count_bin3) = rain_smooth;
        count_bin3 = count_bin3+1;

    elseif string(station_average_Se(i).bin) == 'Midwest' 
        bin4(:,count_bin4) = rain_smooth;
        count_bin4 = count_bin4+1;

    elseif string(station_average_Se(i).bin) == 'Dry Southwest' 
        bin5(:,count_bin5) = rain_smooth;
        count_bin5 = count_bin5+1;

    elseif string(station_average_Se(i).bin) == 'Florida' 
        bin6(:,count_bin6) = rain_smooth;
        count_bin6 = count_bin6+1;
    end 

end

median_ppt_bin1 = median(bin1,2);
median_ppt_bin2 = median(bin2,2);
median_ppt_bin3 = median(bin3,2);
median_ppt_bin4 = median(bin4,2);
median_ppt_bin5 = median(bin5,2);
median_ppt_bin6 = median(bin6,2);


%% Soil conc map only 

figure
    axesm('lambert','MapLatLimit',[24 50],'MapLonLimit',[-128 -65],'frame','off')
    coast = load('coastlines');%show coastline
    n_colors = 256;
    colormap(flipud(hot(n_colors)))
    Upper_threshold = 1.2; % ppm of Se, highest color value displayed on map    
    SeSymbolSpec = makesymbolspec('Polygon', ...
      {'Se_conc',[0 Upper_threshold],'FaceColor',colormap});
    geoshow(counties,'SymbolSpec',SeSymbolSpec)
    box off
    axis off   

    c = colorbar;
    c.Limits = [0 Upper_threshold];
    c.Label.String = 'Soil Se conc (ppm)';
    c.Label.FontSize = 24;      
    c.FontSize = 24;   
    c.Location='southoutside';    

%% one year corr 
redbluecm = redblue;
figure
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(station_average_Se,'lon'),extractfield(station_average_Se,'lat'),75,extractfield(station_average_Se,'Rprecip'),'filled')
    caxis([-1 1])   

    c1= colorbar;
    c1.Label.String = '[Se] v. Precipitation Correlation';
    c1.Label.FontSize = 16;        
    c1.Location = 'southoutside';
    c1.Label.FontSize = 20;
    c1.FontSize = 16; 
    c1.Limits = [-1 1];
    c1.TickDirection = 'out';
    c1.Ticks = [-1 -0.5 0 0.5 1];
    c1.TickLabels = {'Anti-correlated','-0.5','0','0.5','Correlated'};
    colormap(redbluecm) 


%% Create map, plotting each county with Se concentration   

figure
    subplot(221)
    title('Autumn','fontsize',24)
    axesm('lambert','MapLatLimit',[24 50],'MapLonLimit',[-128 -65],'frame','off')
    coast = load('coastlines');%show coastline
    n_colors = 256;
    colormap(flipud(summer(n_colors)))
    Upper_threshold = 1.2; % ppm of Se, highest color value displayed on map    
    SeSymbolSpec = makesymbolspec('Polygon', ...
      {'Se_conc',[0 Upper_threshold],'FaceColor',colormap});
    geoshow(counties,'SymbolSpec',SeSymbolSpec)
    %geoshow(coast.coastlat, coast.coastlon, 'Color', 'black','LineWidth', 3, 'Handlevisibility','off') 
    hold on
    for i = 1:length(station_average_Se)
        if station_average_Se(i).Rpptautumn > 0.7
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,'r','filled')
        elseif station_average_Se(i).Rpptautumn < -0.7
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,'b','filled')
        else
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,[0.33 0.33 0.33],'filled')            
        end 
    end 
    grid on
    box off
    axis off    
    subplot(222)
    title('Winter','fontsize',24)
    axesm('lambert','MapLatLimit',[24 50],'MapLonLimit',[-128 -65],'frame','off')
    coast = load('coastlines');%show coastline
    n_colors = 256;
    colormap(flipud(summer(n_colors)))
    Upper_threshold = 1.2; % ppm of Se, highest color value displayed on map    
    SeSymbolSpec = makesymbolspec('Polygon', ...
      {'Se_conc',[0 Upper_threshold],'FaceColor',colormap});
    geoshow(counties,'SymbolSpec',SeSymbolSpec)
    %geoshow(coast.coastlat, coast.coastlon, 'Color', 'black','LineWidth', 3, 'Handlevisibility','off') 
    hold on
    for i = 1:length(station_average_Se)
        if station_average_Se(i).Rpptwinter > 0.7
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,'r','filled')
        elseif station_average_Se(i).Rpptwinter < -0.7
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,'b','filled')
        else
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,[0.33 0.33 0.33],'filled')            
        end 
    end  
    grid on
    box off
    axis off       

    subplot(223)
    title('Spring','fontsize',24)
    axesm('lambert','MapLatLimit',[24 50],'MapLonLimit',[-128 -65],'frame','off')
    coast = load('coastlines');%show coastline
    n_colors = 256;
    colormap(flipud(summer(n_colors)))
    Upper_threshold = 1.2; % ppm of Se, highest color value displayed on map    
    SeSymbolSpec = makesymbolspec('Polygon', ...
      {'Se_conc',[0 Upper_threshold],'FaceColor',colormap});
    geoshow(counties,'SymbolSpec',SeSymbolSpec)
    %geoshow(coast.coastlat, coast.coastlon, 'Color', 'black','LineWidth', 3, 'Handlevisibility','off') 
    hold on
    for i = 1:length(station_average_Se)
        if station_average_Se(i).Rpptspring > 0.7
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,'r','filled')
        elseif station_average_Se(i).Rpptspring < -0.7
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,'b','filled')
        else
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,[0.33 0.33 0.33],'filled')            
        end 
    end 
    grid on
    box off
    axis off       

    subplot(224)
    title('Summer','fontsize',24)
    axesm('lambert','MapLatLimit',[24 50],'MapLonLimit',[-128 -65],'frame','off')
    coast = load('coastlines');%show coastline
    n_colors = 256;
    colormap(flipud(summer(n_colors)))
    Upper_threshold = 1.2; % ppm of Se, highest color value displayed on map    
    SeSymbolSpec = makesymbolspec('Polygon', ...
      {'Se_conc',[0 Upper_threshold],'FaceColor',colormap});
    geoshow(counties,'SymbolSpec',SeSymbolSpec)
    %geoshow(coast.coastlat, coast.coastlon, 'Color', 'black','LineWidth', 3, 'Handlevisibility','off') 
    hold on
    for i = 1:length(station_average_Se)
        if station_average_Se(i).Rpptsummer > 0.7
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,'r','filled')
        elseif station_average_Se(i).Rpptsummer < -0.7
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,'b','filled')
        else
            scatterm(station_average_Se(i).lat,station_average_Se(i).lon,75,[0.33 0.33 0.33],'filled')            
        end 
    end 
    grid on
    box off
    axis off         

    %%
    c = colorbar;
    c.Limits = [0 Upper_threshold];
    c.Label.String = 'Soil Se conc (ppm)';
    c.Label.FontSize = 24;      
    c.FontSize = 24;   
    c.Location='southoutside';

%%
figure
    subplot(221)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(station_average_Se,'lon'),extractfield(station_average_Se,'lat'),75,extractfield(station_average_Se,'Rpptwinter'),'filled')
    caxis([-1 1])    
    title('Winter','fontsize',24)
    
    subplot(222)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(station_average_Se,'lon'),extractfield(station_average_Se,'lat'),75,extractfield(station_average_Se,'Rpptspring'),'filled')
    caxis([-1 1])        
    title('Spring','fontsize',24)
%     c1= colorbar;
%     c1.Label.String = '[Se] v. Precipitation Correlation';
%     c1.Label.FontSize = 16;        
%     c1.Location = 'westoutside';
%     c1.Label.FontSize = 16;
%     c1.FontSize = 16; 
%     c1.Limits = [-1 1];
%     c1.TickDirection = 'in';
%     %c1.AxisLocation = 'in';
%     c1.Ticks = [-1 -0.5 0 0.5 1];
%     c1.TickLabels = {'Anti-correlated','-0.5','0','0.5','Correlated'};
     colormap(redbluecm)     

    subplot(223)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(station_average_Se,'lon'),extractfield(station_average_Se,'lat'),75,extractfield(station_average_Se,'Rpptsummer'),'filled')
    caxis([-1 1])        
    title('Summer','fontsize',24)  
    
    subplot(224)
    m_proj('lambert','long',[-128 -65],'lat',[24 50]);
    m_coast('patch',[1 .85 .7]);
    m_grid('box','fancy','tickdir','in','fontsize',16);    
    hold on
    m_scatter(extractfield(station_average_Se,'lon'),extractfield(station_average_Se,'lat'),75,extractfield(station_average_Se,'Rpptautumn'),'filled')    
    caxis([-1 1])        
    title('Autumn','fontsize',24)   
%     box off 
%     axis off
%     hold on    
