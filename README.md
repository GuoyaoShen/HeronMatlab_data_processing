# HeronMatlab_data_processing
This is a repo used for data&amp;msg processing for Heron USV.

To start, you need to establish a new folder named "data" and put your bagfiles inside.

* "gps_utils": for gps topics data plotting
* "imu_utils": for imu topics data plotting
* "gmap": plotting RTK GPS data plotting using Google map, you'll need Gmap API key to do this
* "nmea_decoding": decode nmea sentence from GPS topic
* "test_readbag": a test script to read bag file from ROS

![](https://github.com/GuoyaoShen/HeronMatlab_data_processing/blob/master/figs/gmap_eg1.png "gmap_example")
