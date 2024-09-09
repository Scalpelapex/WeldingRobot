clear, clc, close all
run('SOL_intersecting_traj.m')
load xiangguanxian.mat
% 
% time_temp = 2:18/86:20-18/86;
% Time_0 = [0 1 time_temp];
% orientation_welding_ = -pi/2:(2*pi)/86:3/2*pi-(2*pi)/86;
orientation_welding_1 = -pi/2:(pi/4)/15:-pi/4-(pi/4)/15;
orientation_welding_2 = -pi/4:(pi/2)/13:pi/4-(pi/2)/13;
orientation_welding_3 = pi/4:(pi/2)/29:3*pi/4-(pi/2)/29;
orientation_welding_4 = 3*pi/4:(pi/4)/7:pi-(pi/4)/7;
orientation_welding_5 = -pi:(pi/4)/7:-3*pi/4-(pi/4)/7;
orientation_welding_6 = -3*pi/4:(pi/4)/15:-pi/2-(pi/4)/15;

orientation_welding_ = [orientation_welding_1,orientation_welding_2,orientation_welding_3,...
                            orientation_welding_4,orientation_welding_5,orientation_welding_6];

orientation_welding = fliplr(orientation_welding_);
Orientation_task = [orientation_welding(1),orientation_welding(1),orientation_welding,orientation_welding(end),orientation_welding(end)]';

%单位转化为m
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
    hTraj = plot3(tool_path(1,2),tool_path(1,3),tool_path(1,4),'b.-');
end
plot3(tool_path(:,2),tool_path(:,3),tool_path(:,4),'ro','LineWidth',2);
hold on
n=length(tool_path);
Q_0=zeros(n,6);
TrajTimes=(1:0.3:n/0.3);
%% Cylinder plot
PlotCylinder(0.3,[1.9-0.7,0,0.5],[1.9+0.7,0,0.5]);
hold on;
PlotCylinder(0.5,[1.9,-0.5,0.5],[1.9,0.5,0.5]);
hold on;
%% Trajectory following loop
for idx = 1:n
    % Solve IK
%     tgtPose = trvec2tform(tool_path(idx,2:4))*eul2tform(orientations(:,2)','ZYZ');
%     tgtPose = trvec2tform(tool_path(idx,2:4))*rpy2tr([pi/2,0,pi/2],'xyz');
    tgtPose = trvec2tform(tool_path(idx,2:4))*eul2tform([Orientation_task(idx) 0 0],'XYZ');
    [config,info] = ik(eeName,tgtPose,ikWeights,ikInitGuess);
    ikInitGuess = config;
    for ii_t=1:6
        Q_0(idx,ii_t)=config(ii_t).JointPosition;
    end
%     Q(idx,:)=config.JointPosition;
    % Show the robot
    show(auboi10,config,'Frames','off','PreservePlot',false);
    title(['Trajectory at t = ' num2str(TrajTimes(idx))])
    drawnow    
end
Time_0=tool_path(:,1);
save('TQ_0.mat','Time_0','Q_0');