function gps_plot_time_series(path,disp_type)
% GPS_PLOT_TIME_SERIES Function for plotting data from GPS along with time.
% INPUT:
% path: str, path for the bag package
% disp_type: str, displaying type. "degree" or "meter"

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

% create a new figure and plot according to 'disp_type'
% for plot in degree
if disp_type == "degree"
    x = 1:length(Lo);
    figure();
    subplot(2,1,1);
    plot(x, Lo, '.');
    xlabel('Timestamp');
    ylabel('Longitude (deg)');
    subplot(2,1,2);
    plot(x, La, '.');
    xlabel('timestamp');
    ylabel('Latitude (deg)');
    title('Timeseries of Latitude & Longitude in degree');
end
% for plot in meter
if disp_type == "meter"
    x = 1:length(Lo);
    
    % convert from longitude and latitude into meter
    % shift total plot from minimun to (0,0)
    la_meter = 111034.61;
    lo_meter = 85393.83;
    Lo_m = (Lo - min(Lo)) * lo_meter;
    La_m = (La - min(La)) * la_meter;
    
    figure();
    title('Timeseries of Latitude & Longitude in meter');
    subplot(2,1,1);
    plot(x, Lo_m,'.');
    xlabel('Timestamp');
    ylabel('Longitude (meter)');
    subplot(2,1,2);
    plot(x, La_m,'.');
    xlabel('Timestamp');
    ylabel('latitude (meter)');
    
end

end

