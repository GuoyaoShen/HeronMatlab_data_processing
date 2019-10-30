% path_bag = '/data/2019-10-15-16-05-29.bag';
path_bag = '/data/2019-10-25-16-40-57.bag';


bag_circled = rosbag(path_bag);
bag_circled.AvailableTopics;
% get gps topic data
T1 = select(bag_circled,'Topic','/imu/data');
T2 = select(bag_circled,'Topic','/imu/data_compass');
T3 = select(bag_circled,'Topic','/imu/mag');
T4 = select(bag_circled,'Topic','/imu/mag_calib');
T5 = select(bag_circled,'Topic','/imu/rpy');
T6 = select(bag_circled,'Topic','/echosounder');
% convert to matlab struct
msgStructs1 = readMessages(T1,'DataFormat','struct');
msgStructs2 = readMessages(T2,'DataFormat','struct');
msgStructs3 = readMessages(T3,'DataFormat','struct');
msgStructs4 = readMessages(T4,'DataFormat','struct');
msgStructs5 = readMessages(T5,'DataFormat','struct');
msgStructs6 = readMessages(T6,'DataFormat','struct');

q = [msgStructs1{1,1}.Orientation.X, msgStructs1{1,1}.Orientation.Y, msgStructs1{1,1}.Orientation.Z, msgStructs1{1,1}.Orientation.W];
quat = quaternion(q);
eulerAnglesDegrees = eulerd(quat,'XYZ','frame')

depth = cellfun(@(m) double(m.Data),msgStructs6);  % longitude (n,1)

% path_bag = '/data/2019-10-15-16-05-29.bag';
% bag = rosbag(path_bag);
% msgs = readMessages(bag)

% Display rosbag Information from File
% rosbag info '/data/2019-10-15-16-05-29.bag'
% rosbag info '/data/2019-10-25-16-40-57.bag'