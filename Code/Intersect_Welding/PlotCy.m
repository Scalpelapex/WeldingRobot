function PlotCy(originPoint,cylinderRadius,cylinderHeight)
%% �������ܣ� ����Բ����
% ���룺
%       originPoint��Բ�����ԭ��,����������[0��0��0];
%       cylinderRadius��Բ����İ뾶;
%       cylinderHeight:Բ����ĸ߶�
% �����Բ����ͼ��

%% ���ݰ뾶����Բ����Ļ�����ά�����,100ָ������100������ϵ���Ͷ�Բ
[xOrigin,yOrigin,zOrigin]=cylinder(cylinderRadius,100);

%% ���ݸ߶�ȷ��z�����꣬�൱������Բ���ĸ߶�
zOrigin=zOrigin*cylinderHeight;

%% ����Բ����ԭ��ƽ�Ƹ��������
x=xOrigin+originPoint(1);
y=yOrigin+originPoint(2);
z=zOrigin+originPoint(3);

%% ���Ʋ�չʾͼ��
% �����colorָ�����Ƶ������ɫ��ֻҪά����z��ͬ���ɣ�����ȱʡ
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