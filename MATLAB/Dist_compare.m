% clear
% load('100220171200.mat')

[~,len] = size(odomLog);
a = zeros(len,3,'double');
av = zeros(len,3,'double');
t = zeros(len,3,'double');
pos = zeros(len,3,'double');

velmagNoG = zeros(len,3,'double');
DisplacementmagNoG =zeros(len,3,'double');

for i = 1:len
    a(i,1) = imuLog(i).LinearAcceleration.X;
    a(i,2) = imuLog(i).LinearAcceleration.Y;
    a(i,3) = imuLog(i).LinearAcceleration.Z;
    
    av(i,1) = imuLog(i).AngularVelocity.X;
    av(i,2) = imuLog(i).AngularVelocity.Y;
    av(i,3) = imuLog(i).AngularVelocity.Z;
    
    pos(i,1) = odomLog(i).Pose.Pose.Position.X;
    pos(i,2) = odomLog(i).Pose.Pose.Position.Y;
    pos(i,3) = odomLog(i).Pose.Pose.Position.Z;
    
    t(i) = imuLog(i).Header.Stamp.Sec;
end

start_end = [pos(1,1), pos(1,2);pos(len,1),pos(len,2)];
distance = pdist(start_end,'euclidean')

t_vec = t(:,1);

% a(:,3) = a(:,3) - mean(a(:,3));
a(:,3) = 0;
velmagNoG = cumtrapz(t_vec,a);
DisplacementmagNoG=cumtrapz(t_vec, velmagNoG);

TotalDisplacement = norm(DisplacementmagNoG(len,:));
disp('Total Displcement(m) = ');
disp(TotalDisplacement)
