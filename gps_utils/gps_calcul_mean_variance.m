function [means,variances] = gps_calcul_mean_variance(path,disp_type,n)
% GPS_CALCUL_MEAN_VARIANCE Function for calculating mean and variance from
% GPS
% INPUT:
% path: str, path for the bag package
% n: int, number of segments to divided the whole data. This can be used to see
% disp_type: str, displaying type. "degree" or "meter"
% how mean and variance change along time
% OUTPUT:
% means: (n,2) double list, mean values on each segment
% variances: (n,2) double list, variance values on each segment

% get data
bag_circled = rosbag(path);
bag_circled.AvailableTopics;
% get gps topic data
NFIX = select(bag_circled,'Topic','/novatel/fix');
% convert to matlab struct
msgStructs = readMessages(NFIX,'DataFormat','struct');
% get longitude and latitude, double
Lo = cellfun(@(m) double(m.Longitude),msgStructs);  % longitude (n,1)
La = cellfun(@(m) double(m.Latitude),msgStructs); % latitude (n,1)

% get each length of segment
length_segment  = floor(length(Lo)/n);
% set the variables
means = [];
variances = [];

% for means and variances in meter, do the following
if disp_type == "meter"
    % convert from longitude and latitude into meter
    % shift total plot from minimun to (0,0)
    la_meter = 111034.61;
    lo_meter = 85393.83;
    Lo_m = (Lo - min(Lo)) * lo_meter;
    La_m = (La - min(La)) * la_meter;
    
    % append each mean and variance into variables
    for i = 1:n-1
        means = [means ;[mean(Lo_m(1 + length_segment * (i-1) : 1 + length_segment * (i))) , mean(La_m(1 + length_segment * (i-1) : 1 + length_segment * (i)))] ];
        variances = [variances ;[var(Lo_m(1 + length_segment * (i-1) : 1 + length_segment * (i))) , var(La_m(1 + length_segment * (i-1) : 1 + length_segment * (i)))] ];
    end
    means = [means ; [mean(Lo_m(1 + length_segment * (n-1) : end)) , mean(La_m(1 + length_segment * (n-1) : end))] ];
    variances = [variances ; [var(Lo_m(1 + length_segment * (n-1) : end)) , var(La_m(1 + length_segment * (n-1) : end))] ];
    
    % display the means v.s. segments
    x = 1:n;
    figure();
    plot(x,means(:,1),'*-',x,means(:,2),'*-');
    xlim([0,n+1])
    legend('Logitude','Latitude');
    title('Means v.s. Segments in meter');
    xlabel('Segments');
    ylabel('mean (meter)');
    % display the variances v.s. segments
    figure();
    plot(x,variances(:,1),'*-',x,variances(:,2),'*-');
    xlim([0,n+1])
    legend('Logitude','Latitude');
    title('Variances v.s. Segments in meter');
    xlabel('Segments');
    ylabel('variance (meter)');
end
% for means and variances in degree, do the following
if disp_type == "degree"
    % append each mean and variance into variables
    for i = 1:n-1
        means = [means ;[mean(Lo(1 + length_segment * (i-1) : 1 + length_segment * (i))) , mean(La(1 + length_segment * (i-1) : 1 + length_segment * (i)))] ];
        variances = [variances ;[var(Lo(1 + length_segment * (i-1) : 1 + length_segment * (i))) , var(La(1 + length_segment * (i-1) : 1 + length_segment * (i)))] ];
    end
    means = [means ; [mean(Lo(1 + length_segment * (n-1) : end)) , mean(La(1 + length_segment * (n-1) : end))] ];
    variances = [variances ; [var(Lo(1 + length_segment * (n-1) : end)) , var(La(1 + length_segment * (n-1) : end))] ];    
    
    % display the means v.s. segments
    x = 1:n;
    figure();
    plot(x,means(:,1),'*-',x,means(:,2),'*-');
    xlim([0,n+1])
    legend('Logitude','Latitude');
    title('Means v.s. Segments in degree');
    xlabel('Segments');
    ylabel('mean (degree)');
    % display the variances v.s. segments
    figure();
    plot(x,variances(:,1),'*-',x,variances(:,2),'*-');
    xlim([0,n+1])
    legend('Logitude','Latitude');
    title('Variances v.s. Segments in degree');
    xlabel('Segments');
    ylabel('variance (degree)');
end

end

