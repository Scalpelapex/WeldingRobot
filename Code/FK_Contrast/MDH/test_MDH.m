clear,clc,close all;
%% AUBO-I10机械臂参数
L1 = RevoluteMDH('d',163,'a',0,'alpha',0);
L2 = RevoluteMDH('d',0,'a',0,   'alpha',   pi/2  ,'offset',-pi/2 );
L3 = RevoluteMDH('d',0,'a', -647,  'alpha',0);
L4 = RevoluteMDH('d', 201.3,'a', -600.5,'alpha',0 ,'offset',-pi/2  );
L5 = RevoluteMDH('d', 102.5,'a', 0, 'alpha', pi/2 );
L6 = RevoluteMDH('d', 94, 'a', 0,'alpha', -pi/2 );
%% 建立AUBO-I10机械臂
robot_UR5=SerialLink([L1,L2,L3,L4,L5,L6],'name','UR5');   %SerialLink 类函数
%% 测试机械臂
Theta = zeros(1,6)*30;
Theta = Theta/180*pi;

forwarda = robot_UR5.fkine(Theta);

W = [-1500,+1500,-1500,+1500,-2000,+2000];
robot_UR5.plot(Theta,'tilesize',150,'workspace',W);
q1 = robot_UR5.ikine(forwarda)*180/pi;
rpy = tr2rpy(forwarda,'xyz')*180/pi;
EUL = tr2eul(forwarda,'deg');
[THETA, V]=tr2angvec(forwarda,'deg');
robot_UR5.teach(forwarda,'rpy'); %可以自由拖动的关节角度

% robot_UR5.display();  %Link 类函数
% robot_UR5.teach(); %可以自由拖动的关节角度
 
% Theta=[0,0,-pi/2,-pi/2,0,0];%没有什么含义，随便取的
%  
% % robot_UR5.plot(theta);   %SerialLink 类函数
%  
% %利用机器人工具箱求正、逆运动学
% A=fkine(robot_UR5,Theta);
% AA=ikine(robot_UR5,A);
%  
% %利用刚写的函数求正、逆运动学
% B=zhengyundongxue(Theta);
% BB=niyundongxue(B);