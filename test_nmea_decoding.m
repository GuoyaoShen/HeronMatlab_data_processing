clear;
clc;

path_bag = '/data/2019-10-15-16-05-29.bag';

heron_bag = rosbag(path_bag);
heron_bag.AvailableTopics;
% % get gps topic data
% NFIX = select(heron_bag,'Topic','/novatel/fix');
% % convert to matlab struct
% msgStructs = readMessages(NFIX,'DataFormat','struct')

novatelNMEABag    = select(heron_bag, 'Topic', '/novatel/nmea_sentence');
novatelNMEAStruct = readMessages(novatelNMEABag, 'DataFormat', 'struct');

table1 = [];
table2 = [];
for i=1:length(novatelNMEAStruct)
    a = cell2table(strsplit(novatelNMEAStruct{i}.Sentence, ','));
    nmea_line = novatelNMEAStruct{i}.Sentence;
    [data,ierr]  =  nmealineread(nmea_line);
    
    nmea_decoding(i).data = data;
    nmea_decoding(i).ierr = ierr;
    
    if (width(a) == 15)
        table1 = [table1; a];
    elseif (width(a) == 13)
        table2 = [table2; a];
    else
        disp('error in row:'); disp(i);
    end
end
save('nmea_decoding.mat', 'nmea_decoding');
writetable(table1, 'table1_data.xlsx');
writetable(table2, 'table2_data.xlsx');
