[velPub, velMsg] = rospublisher('cmd_vel');

% path = [2.7, -8.7; 1.7, -4; 5, -6; 6.7, -3; 6.7, -1.3;...
%     4, -1.3; 13.5, -1.3; 13.5 -2];
path = [1.58, 0.07; -0.18, -1.5];
posOffset = 0;

posSub = rossubscriber('/odometry/filtered');
posData = receive(posSub,1);
controller = robotics.PurePursuit('Waypoints', path);
controller.DesiredLinearVelocity = 0.2;
controlRate = robotics.Rate(10);

goalRadius = 0.3;
robotCurrentLocation = path(1,:);
robotGoal = path(end,:);
distanceToGoal = norm(robotCurrentLocation - robotGoal);

while( distanceToGoal > goalRadius )
    % Get robot pose at the time of sensor reading
    pose = receive(posSub,1);
    
    position = [pose.Pose.Pose.Position.X + posOffset, pose.Pose.Pose.Position.Y + posOffset];
    orientation =  quat2eul([pose.Pose.Pose.Orientation.W, pose.Pose.Pose.Orientation.X, ...
        pose.Pose.Pose.Orientation.Y, pose.Pose.Pose.Orientation.Z], 'ZYX');
    robotPose = [position, orientation(1)];
    
    [v, w] = controller(robotPose);
    velMsg.Linear.X = v;
    velMsg.Angular.Z = w;
    send(velPub, velMsg);
    
    distanceToGoal = norm(robotPose(1:2) - robotGoal);
    waitfor(controlRate);
end
velMsg.Linear.X = 0;
velMsg.Angular.Z = 0;
send(velPub, velMsg);