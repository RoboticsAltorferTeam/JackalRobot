% clc;

% setenv('ROS_MASTER_URI','http://10.10.10.101:11311')
% setenv('ROS_IP','10.10.10.102')
% rosDevice = rosdevice('10.10.10.101','administrator','clearpath');
% rosDevice = rosdevice('192.168.1.11','administrator','clearpath');
% openShell(rosDevice)
clear
[velPub, velMsg] = rospublisher('cmd_vel');
velMsg.Linear.X = -0.2;

% imuSub = rossubscriber('imu/data_raw');
% odomSub = rossubscriber('odometry/filtered');
% imuData = receive(imuSub,1);
% odomData = receive(odomSub,1);
% imuLog(1) = imuData;
% odomLog(1) = odomData;
lidarSub = rossubscriber('/velodyne_points');
lidarData(1) = receive(lidarSub,1);

for i = 1:1000000
    send(velPub, velMsg);
%     imuData = receive(imuSub,1);
%     odomData = receive(odomSub,1);
%     imuLog(i) = imuData;
%     odomLog(i) = odomData;
    lidarData(i) = receive(lidarSub,1);
%     pause(1);
end