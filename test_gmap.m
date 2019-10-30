plot_google_map('apiKey', 'GAPI key here') % You only need to run this once, which will store the API key in a mat file for all future usages
lat = [39.9416916667];
lon = [-75.1986966667];
plot(lon, lat, '.r', 'MarkerSize', 20)


plot_google_map('MapScale', 1, 'MapType', 'satellite', 'FigureResizeUpdate', 1)