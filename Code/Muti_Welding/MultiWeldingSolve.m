clear, clc, close all
load MW_Traj.mat

%单位转化为m
tool_path = [Time_MW,Pos_MW];
tool_path(:,2:4)=tool_path(:,2:4)*0.01;
% Define waypoint information
gluon6l3_creatWaypointData;
auboi10 = importrobot('MATLAB_AUBOI10_URDF.urdf');
showdetails(auboi10);%显示连杆父子关系
% show(auboi10,'Frames','off','Visuals','on');%figure显示

% Define IK
ik = inverseKinematics('RigidBodyTree',auboi10);
ikWeights = [0.25 0.25 0.25  1 1 1];
ikInitGuess = auboi10.homeConfiguration;
%Define init DOF degree
initialguess=homeConfiguration(auboi10);
for ii=1:6
%     initialguess(ii).JointPosition = jointAnglesHome(ii);
        initialguess(ii).JointPosition =0.5236;
end
% Set up plot
plotMode =1; % 0 = None, 1 = Trajectory, 2 = Coordinate Frames
show(auboi10,initialguess,'Frames','off','PreservePlot',false);
xlim([-1 2.0]), ylim([-1.5 1.5]), zlim([-1.0 2.0])
hold on
%%
if plotMode == 1
    hTraj = plot3(tool_path(1,2),tool_path(1,3),tool_path(1,4),'b.-','LineWidth',0.2);
end
plot3(tool_path(:,2),tool_path(:,3),tool_path(:,4),'r.','LineWidth',0.01);
hold on
n=length(tool_path);
Q_1=zeros(n,6);
TrajTimes=(1:0.3:n/0.3);
% %% Cylinder plot
% PlotCylinder(0.3,[1.9-0.7,0,0.5],[1.9+0.7,0,0.5]);
% hold on;
% PlotCylinder(0.5,[1.9,-0.5,0.5],[1.9,0.5,0.5]);
% hold on;
%% Trajectory following loop
for idx = 1:n
    % Solve IK
    tgtPose = trvec2tform(tool_path(idx,2:4))*eul2tform([0 pi/2 -37*pi/180],'XYZ');
    [config,info] = ik(eeName,tgtPose,ikWeights,ikInitGuess);
    ikInitGuess = config;
    for ii_t=1:6
        Q_1(idx,ii_t)=config(ii_t).JointPosition;
    end
%     Q(idx,:)=config.JointPosition;
    % Show the robot
    show(auboi10,config,'Frames','off','PreservePlot',false);
    title(['Trajectory at t = ' num2str(TrajTimes(idx))])
    drawnow    
end
Time_1=tool_path(:,1);
save('TQ_1.mat','Time_1','Q_1');