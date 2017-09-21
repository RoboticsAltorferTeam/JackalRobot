% clc;

% setenv('ROS_MASTER_URI','http://10.10.10.101:11311')
% setenv('ROS_IP','10.10.10.102')
% [velPub, velMsg] = rospublisher('cmd_vel');

imuSub = rossubscriber('imu/data_raw');
odomSub = rossubscriber('odometry/filtered');
imuData = receive(imuSub,1);
odomData = receive(odomSub,1);
imuLog(1) = imuData;
odomLog(1) = odomData;

for i = 1:1000000
    send(velPub, velMsg);
    imuData = receive(imuSub,1);
    odomData = receive(odomSub,1);
    imuLog(i) = imuData;
    odomLog(i) = odomData;
%     pause(1);
end