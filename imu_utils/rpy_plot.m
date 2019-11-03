clear;
clc;
close;
% path_bag = '/data/2019-10-15-16-05-29.bag';
path_bag = '/data/2019-10-25-16-40-57.bag';


% get data
bag_circled = rosbag(path_bag);
bag_circled.AvailableTopics;
% get gps topic data
IMU_RPY = select(bag_circled,'Topic','/imu/rpy');
% convert to matlab struct
msgStructs = readMessages(IMU_RPY,'DataFormat','struct')
% get RPY
X = cellfun(@(m) double(m.Vector.X),msgStructs);
Y = cellfun(@(m) double(m.Vector.Y),msgStructs);
Z = cellfun(@(m) double(m.Vector.Z),msgStructs);

% offset
Y = Y - pi;
Z = Z + pi/2;

% from rad to degree
X = X/pi*180;
Y = Y/pi*180;
Z = Z/pi*180;

% plot
t = (1: length(X))/20;
figure();
% title('RPY vs Time');
subplot(3,1,1);
plot(t, X, '.');
title('RPY vs Time');
xlabel('Timestamp (s)');
ylabel('X (degree)');

subplot(3,1,2);
plot(t, Y, '.');
xlabel('Timestamp (s)');
ylabel('Y (degree)');

subplot(3,1,3);
plot(t, Z, '.');
xlabel('Timestamp (s)');
ylabel('Z (degree)');
