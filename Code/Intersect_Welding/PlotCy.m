function PlotCy(originPoint,cylinderRadius,cylinderHeight)
%% 函数功能： 绘制圆柱体
% 输入：
%       originPoint：圆柱体的原点,行向量，如[0，0，0];
%       cylinderRadius：圆柱体的半径;
%       cylinderHeight:圆柱体的高度
% 输出：圆柱体图形

%% 根据半径生成圆柱体的基础三维坐标点,100指的是用100个点拟合底面和顶圆
[xOrigin,yOrigin,zOrigin]=cylinder(cylinderRadius,100);

%% 根据高度确定z的坐标，相当于缩放圆柱的高度
zOrigin=zOrigin*cylinderHeight;

%% 根据圆柱的原点平移各个坐标点
x=xOrigin+originPoint(1);
y=yOrigin+originPoint(2);
z=zOrigin+originPoint(3);

%% 绘制并展示图像
% 这里的color指定绘制的面的颜色，只要维度与z相同即可，可以缺省
color=x+y+z;
surf(x,y,z,color,'FaceAlpha',0.5);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Cylinder');
fig=gcf;
fig.Color=[1 1 1];
fig.Name='cylinder';
fig.NumberTitle='off';