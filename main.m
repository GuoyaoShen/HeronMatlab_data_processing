clc; close all;

path_bag = '/data/2019-10-15-16-05-29.bag';

gps_raw_scatter(path_bag,'degree');
gps_plot_time_series(path_bag,'degree');
% [means,variances] = gps_calcul_mean_variance(path_bag,'meter',4);