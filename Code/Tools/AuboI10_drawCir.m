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
%% 定义圆的圆心、半径以及插补次数
mm=1;
n=[0 0 1]; %法向量n
r=200*mm; %圆的半径为1
c=[600 600 300]*mm; %圆心的坐标
step=60;   %插补次数
P=drawing_circle(n,r,c,step);  %调用画圆函数进行轨迹生成
%% 将笛卡尔空间圆形进行逆解计算得到每个点的关节角度
ikInitGuess=zeros(1,6);
for i=1:length(P)
    T(:,:,i)=transl(P(i,:))*rpy2tr([0,0,pi],'xyz'); %%使关节五始终竖直向下
    config = robot_UR5.ikunc(T(:,:,i),ikInitGuess);   
    ikInitGuess=config;
    qrt(i,:) =config;
end
%% 绘制末端轨迹
W = [-1500,+1500,-1500,+1500,-2000,+2000];
robot_UR5.plot(qrt,'tilesize',150,'workspace',W,'view','x','trail',{'r','LineWidth',2})  
%% 保存轨迹
save('qrtData.mat','qrt');