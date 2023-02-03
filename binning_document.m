%
addpath C:\Users\laois\Documents\NBD\data
addpath C:\Users\laois\OneDrive\Desktop\NBD\data\m_map

%% binned map 
load('station_average_Se_binned.mat')
figure(1)
m_proj('lambert','long',[-140 -60],'lat',[15 55]);
m_coast('patch',[1 .85 .7]);
m_grid('box','fancy','tickdir','in');
hold on 
for i = 1:length(station_average_Se)
    if string(station_average_Se(i).bin) == 'North Northeast'
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','r','markeredgecolor','r')
        hold on
        figure(2)
        se_smooth = movmean(station_average_Se(i).all(1:365),30.4,'omitnan');        
        subplot(241)
        title('North Northeast')
        plot(1:365, se_smooth, 'color','r','linewidth',2)
        xticks([15 45 74 105 135 166 196 227 258 288 319 349])
        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
        ylabel('[Se]')        
        xlim([1 365])
        axis square
        hold on        
    elseif string(station_average_Se(i).bin) == 'Northeast Coal'
        figure(1)        
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','g','markeredgecolor','g')
        hold on
        figure(2)
        se_smooth = movmean(station_average_Se(i).all(1:365),30.4,'omitnan');        
        subplot(242)
        title('Northeast Coal')        
        plot(1:365, se_smooth, 'color','g','linewidth',2)
        xticks([15 45 74 105 135 166 196 227 258 288 319 349])
        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
        ylabel('[Se]')        
        xlim([1 365])
        axis square
        hold on         
    elseif string(station_average_Se(i).bin) == 'West Coast'
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','b','markeredgecolor','b')
        hold on
        figure(2)
        se_smooth = movmean(station_average_Se(i).all(1:365),30.4,'omitnan');        
        subplot(243)
        title('West Coast')                
        plot(1:365, se_smooth, 'color','b','linewidth',2)
        xticks([15 45 74 105 135 166 196 227 258 288 319 349])
        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
        ylabel('[Se]')        
        xlim([1 365])
        axis square
        hold on         
    elseif string(station_average_Se(i).bin) == 'Midwest'
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','m','markeredgecolor','m')
        hold on
        figure(2)
        se_smooth = movmean(station_average_Se(i).all(1:365),30.4,'omitnan');        
        subplot(244)
        title('Midwest')                
        plot(1:365, se_smooth, 'color','m','linewidth',2)
        xticks([15 45 74 105 135 166 196 227 258 288 319 349])
        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
        ylabel('[Se]')        
        xlim([1 365])
        axis square
        hold on         
    elseif string(station_average_Se(i).bin) == 'Dry Southwest'
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','c','markeredgecolor','c')
        hold on
        figure(2)
        title('Dry Southwest')        
        se_smooth = movmean(station_average_Se(i).all(1:365),30.4,'omitnan');        
        subplot(245)
        plot(1:365, se_smooth, 'color','c','linewidth',2)
        xticks([15 45 74 105 135 166 196 227 258 288 319 349])
        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
        ylabel('[Se]')        
        xlim([1 365])
        axis square
        hold on         
    elseif string(station_average_Se(i).bin) == 'Florida'
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','#A52A2A','markeredgecolor','#A52A2A')
        hold on
        figure(2)
        se_smooth = movmean(station_average_Se(i).all(1:365),30.4,'omitnan');        
        subplot(246)
        title('Florida')        
        plot(1:365, se_smooth, 'color','#A52A2A','linewidth',2)
        xticks([15 45 74 105 135 166 196 227 258 288 319 349])
        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
        ylabel('[Se]')        
        xlim([1 365])
        axis square
        hold on         
    elseif string(station_average_Se(i).bin) == 'Unbinned'
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','k','markeredgecolor','k')
        hold on           
        figure(2)        
        se_smooth = movmean(station_average_Se(i).all(1:365),30.4,'omitnan');        
        subplot(247)
        title('Unbinned')        
        plot(1:365, se_smooth, 'color','k','linewidth',2)
        xticks([15 45 74 105 135 166 196 227 258 288 319 349])
        xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
        ylabel('[Se]')        
        xlim([1 365])
        axis square
        hold on         
    end
end    

%%
% save station_average_Se_binned.mat station_average_Se

% fourier 1 for whole year

Se_fourier_mat = nan(6,length(station_average_Se));

for  i = 1:length(station_average_Se)
    
    currsitename = station_average_Se(i).name;

    y = station_average_Se(i).all(1:365);
    y = movmean(y,30.4,'omitnan');
    x = 1:365;
       
        
    f  = fit(x',y,'fourier2');
    
    Se_fourier_mat(1,i) = f.a0;
    Se_fourier_mat(2,i) = f.a1;
    Se_fourier_mat(3,i) = f.b1;
    Se_fourier_mat(4,i) = f.a2;
    Se_fourier_mat(5,i) = f.b2;
    Se_fourier_mat(6,i) = f.w;
    
%     figure('units','normalized','outerposition',[0 0 1 1])
%     plot(x,y)
%     hold on 
%     plot (f)
%     xlabel('')
%     xticks([15 45 74 105 135 166 196 227 258 288 319 349])
%     xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})                
%     ylabel('[Se] (ng m^{-3})','fontsize',12)
%     xlim([1 365])    
%     a = get(gca,'XTickLabel');
%     set(gca,'XTickLabel',a,'fontsize',12)
%     hold on
%     axis square
%     sgtitle(currsitename,'fontsize',24) 
%     saveas(gcf,string(strcat(currsitename,'_fourier2fit.png')))    
%     close all
    
end

Se_fourier_mat_normal = normalize(Se_fourier_mat);


% fourier 2 for whole year

Se_fourier_mat_2 = nan(12,length(station_average_Se));

for  i = 1:length(station_average_Se)
    
    currsitename = station_average_Se(i).name;

    y = station_average_Se(i).all(1:365);
    y = movmean(y,30.4,'omitnan');
    x = 1:365;
               
    f1  = fit(x(1:182)',y(1:182),'fourier2');
    f2  = fit(x(183:end)',y(183:end),'fourier2');    
    
    Se_fourier_mat_2(1,i) = f1.a0;
    Se_fourier_mat_2(2,i) = f1.a1;
    Se_fourier_mat_2(3,i) = f1.b1;
    Se_fourier_mat_2(4,i) = f1.a2;
    Se_fourier_mat_2(5,i) = f1.b2;
    Se_fourier_mat_2(6,i) = f1.w;
    Se_fourier_mat_2(7,i) = f2.a0;
    Se_fourier_mat_2(8,i) = f2.a1;
    Se_fourier_mat_2(9,i) = f2.b1;
    Se_fourier_mat_2(10,i) = f2.a2;
    Se_fourier_mat_2(11,i) = f2.b2;
    Se_fourier_mat_2(12,i) = f2.w;    
    
%     figure('units','normalized','outerposition',[0 0 1 1])
%     hold on 
%     plot(x,y,'k')
%     plot(f1,x(1:182),y(1:182),'k-','r')
%     hold on
%     plot(f2,x(183:end),y(183:end),'k-','b')
%     xlabel('')
%     xticks([15 45 74 105 135 166 196 227 258 288 319 349])
%     xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})                
%     ylabel('[Se] (ng m^{-3})','fontsize',12)
%     xlim([1 365])    
%     a = get(gca,'XTickLabel');
%     set(gca,'XTickLabel',a,'fontsize',12)
%     hold on
%     legend off
%     axis square
%     sgtitle(currsitename,'fontsize',24) 
%     saveas(gcf,string(strcat(currsitename,'_fourier2fit_halfyear.png')))    
%     close all
    
end

Se_fourier_mat_2_normal = normalize(Se_fourier_mat_2);

% se all

Se_all_raw     = nan(365,82);
Se_all_movmean = nan(365,82);
for i = 1:length(station_average_Se)
    Se_all_raw(:,i)     = station_average_Se(i).all(1:365);    
    Se_all_movmean(:,i) = movmean(station_average_Se(i).all(1:365),30.4,'omitnan');
end 

Se_all_raw_normal     = normalize(Se_all_raw);
Se_all_movmean_normal = normalize(Se_all_movmean);

%% PCA 

%raw
figure
[coeff,score,latent,tsquared,explained,mu] = pca(Se_all_raw_normal);
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',char(station_average_Se.bin));
xlabel(strcat('PC1 (',string(explained(1)),'%)'))
ylabel(strcat('PC2 (',string(explained(2)),'%)'))
title('PCA with Normalized Annual Mean')

% movmean
figure
[coeff,score,latent,tsquared,explained,mu] = pca(Se_all_movmean_normal);
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',char(station_average_Se.bin));
xlabel(strcat('PC1 (',string(explained(1)),'%)'))
ylabel(strcat('PC2 (',string(explained(2)),'%)'))
title('PCA with Normalized Annual Running Mean')

% fourier
figure
[coeff,score,latent,tsquared,explained,mu] = pca(Se_fourier_mat_normal);
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',char(station_average_Se.bin));
xlabel(strcat('PC1 (',string(explained(1)),'%)'))
ylabel(strcat('PC2 (',string(explained(2)),'%)'))
title('PCA with Normalized Fourier Coefficients fitted to whole year')

% fourier2
figure
[coeff,score,latent,tsquared,explained,mu] = pca(Se_fourier_mat_2_normal);
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',char(station_average_Se.bin));
xlabel(strcat('PC1 (',string(explained(1)),'%)'))
ylabel(strcat('PC2 (',string(explained(2)),'%)'))
title('PCA with Normalized Fourier Coefficients fitted to half year')

%% kmeans and hierarchical clustering 
% Se_all_raw_normal
% Se_all_movmean_normal
% Se_fourier_mat_normal
% Se_fourier_mat_2_normal
clusternum = 4;
idx = kmeans(Se_fourier_mat_2_normal',clusternum);

% idx = clusterdata(Se_all_raw_normal','Maxclust',8); 

figure(1)
m_proj('lambert','long',[-140 -60],'lat',[15 55]);
m_coast('patch',[1 .85 .7]);
m_grid('box','fancy','tickdir','in');
hold on 
for i = 1:length(station_average_Se)
    if idx(i) == 1
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','r','markeredgecolor','r')
        hold on      
    elseif idx(i) == 2
        figure(1)        
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','g','markeredgecolor','g')
        hold on    
    elseif idx(i) == 3
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','b','markeredgecolor','b')
        hold on       
    elseif idx(i) == 4
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','m','markeredgecolor','m')
        hold on       
    elseif idx(i) == 5
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','c','markeredgecolor','c')
        hold on        
    elseif idx(i) == 6
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','#A52A2A','markeredgecolor','#A52A2A')
        hold on         
    elseif idx(i) == 7
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','k','markeredgecolor','k')
        hold on                 
    elseif idx(i) == 8
        figure(1)
        m_scatter(station_average_Se(i).lon,station_average_Se(i).lat,75,'filled','markerfacecolor','y','markeredgecolor','y')
        hold on           
    end
end   

%% coal emissions


addpath C:\Users\laois\Documents\NBD\data
addpath C:\Users\laois\OneDrive\Desktop\NBD\data\m_map

load('station_average_Se.mat')

%

path = dir(fullfile('C:\Users\laois\Documents\NBD\Week 5 (Oct4-8)\coal_emissions\data\'));
path = path(3:end);

lonlim_ncid = 2300:2951;
latlim_ncid = 1140:1401;

curr_emissions = cell(132,3);
monthcount = 1;
  
for i = 1:length(path)
    if monthcount < 13
        ncid    = netcdf.open(strcat(path(i).folder,'\',path(i).name));
            curryear = path(i).name(10:13);
            curr_emissions{i,1} = double(string(curryear));
            curr_emissions{i,2} = monthcount;

        lon     = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lon')); % deg E, 3600x1
        lat     = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lat')); % deg N, 1800x1     
        
        ch4_emissions        = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'emi_ch4')); % kg/m2/s (lon,lat)
        curr_emissions{i,3} = ch4_emissions(lonlim_ncid,latlim_ncid);
        netcdf.close(ncid)
        monthcount = monthcount + 1;
    else 
        monthcount = 1;
        ncid    = netcdf.open(strcat(path(i).folder,'\',path(i).name));
            curryear = path(i).name(10:13);
            curr_emissions{i,1} = double(string(curryear));
            curr_emissions{i,2} = monthcount;

        lon     = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lon')); % deg E, 3600x1
        lat     = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lat')); % deg N, 1800x1     
        
        ch4_emissions        = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'emi_ch4')); % kg/m2/s (lon,lat)
        curr_emissions{i,3} = ch4_emissions(lonlim_ncid,latlim_ncid);
        netcdf.close(ncid)
        monthcount = monthcount + 1;
    end
end     
   

% se processing 

se_lon = extractfield(station_average_Se,'lon');
se_lat = extractfield(station_average_Se,'lat');
se_average = cell(12,1); % 84 x 1
all_average = nan(82,1);
for i = 1:length(station_average_Se)
    curr_data = station_average_Se(i).all;
    all_Average(i) = mean(curr_data,'omitnan');
   
    curr_data_1 = mean(curr_data(1:31));
    se_average{1,1} = [se_average{1,1} curr_data_1];
    
    curr_data_2 = mean(curr_data(32:59));
    se_average{2,1} = [se_average{2,1} curr_data_2];
    
    curr_data_3 = mean(curr_data(60:90));
    se_average{3,1} = [se_average{3,1} curr_data_3];
    
    curr_data_4 = mean(curr_data(91:120));
    se_average{4,1} = [se_average{4,1} curr_data_4];
    
    curr_data_5 = mean(curr_data(121:151));
    se_average{5,1} = [se_average{5,1} curr_data_5];
    
    curr_data_6 = mean(curr_data(151:180));
    se_average{6,1} = [se_average{6,1} curr_data_6];
    
    curr_data_7 = mean(curr_data(181:211));
    se_average{7,1} = [se_average{7,1} curr_data_7];
    
    curr_data_8 = mean(curr_data(212:242));
    se_average{8,1} = [se_average{8,1} curr_data_8];
    
    curr_data_9 = mean(curr_data(243:272));
    se_average{9,1} = [se_average{9,1} curr_data_9];
    
    curr_data_10 = mean(curr_data(273:303));
    se_average{10,1} = [se_average{10,1} curr_data_10];
    
    curr_data_11 = mean(curr_data(304:333));
    se_average{11,1} = [se_average{11,1} curr_data_11];
    
    curr_data_12 = mean(curr_data(334:end));
    se_average{12,1} = [se_average{12,1} curr_data_12];    
end 

% video 

lon_usa      = lon(lonlim_ncid);
lat_usa      = lat(latlim_ncid);
[Plg,Plt]    = meshgrid(lon_usa,lat_usa);
Plg = Plg-360;
currmonth = 1;
all_emi1 = [];
for i = 1:121:132
    curr_emi_coal_usa = curr_emissions{i,3};
    
    figure('units','normalized','outerposition',[0 0 1 1])
    m_proj('lambert','lon',[-130 -65],'lat',[24 50]);
    m_coast('line','color','k','linewidth',2);
    m_coast('patch',[0.8 0.8 0.8]);
    m_grid('box','fancy','tickdir','in');
    hold on
    
    for j = 1:size(curr_emi_coal_usa,1)
        for k = 1:size(curr_emi_coal_usa,2)
            if curr_emi_coal_usa(j,k)>0
                if curr_emi_coal_usa(j,k)>1*10e-8
                    m_scatter(Plg(1,j),Plt(k,1),25,'r','filled','s');
                else
                    m_scatter(Plg(1,j),Plt(k,1),25,'m','filled','s');
                end 
                hold on
            end
        end
    end
    
    hold on
    if currmonth<13
        m_scatter(se_lon,se_lat,100,se_average{currmonth,1},'filled')
    else
        currmonth = 1;
        m_scatter(se_lon,se_lat,100,se_average{currmonth,1},'filled')
    end
    m_scatter(se_lon,se_lat,100,all_Average,'filled')

    h = colorbar;
    h.Limits = [0 2];
    h.Label.String = 'Average Se Concentration (ng/m^3)';
    h.Label.FontSize = 20;
    
    
   sgtitle(strcat(string(curr_emissions{i,1}),'-',string(curr_emissions{i,2})))
    saveas(gcf,strcat(string(curr_emissions{i,1}),'-',string(curr_emissions{i,2}),'.png'));
    currmonth = currmonth+1;
    close all
end