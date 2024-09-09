clear,clc,close all;
auboi10 = importrobot('MATLAB_AUBOI10_URDF.urdf');
showdetails(auboi10);%显示连杆父子关系
show(auboi10,'Frames','off','Visuals','on');%figure显示
%% 验证正解30*ones（1，6）
Theta=30*ones(1,6);
Theta=Theta/180*pi;
initialguess=homeConfiguration(auboi10);
for ii=1:6
    initialguess(ii).JointPosition = Theta(ii);
end
tform = getTransform(auboi10,initialguess,'tool0','world');
figure('Name','正解姿态显示');
show(auboi10,initialguess,'Frames','off','Visuals','on');
axis([-2,2,-2,2,0,2]);

%% 创建AUBOI10模型的ik对象
ik = robotics.InverseKinematics('RigidBodyTree',auboi10);

weights = [0.25 0.25 0.25 1 1 1];
initialguess = auboi10.homeConfiguration;

[configSoIn,soininfo] = ik('tool0',tform,weights,initialguess);
rad2deg = 180/pi*ones(1,6);

figure('Name','逆解姿态显示');
show(auboi10,configSoIn,'Frames','off','Visuals','on');
axis([-2,2,-2,2,0,2]);