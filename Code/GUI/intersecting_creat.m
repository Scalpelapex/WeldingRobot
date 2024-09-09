function [xt,yt,zt]=intersecting_creat(r1,r2)
% r1 = 0.3;
% r2 = 0.5;
pusai = asin(r1/r2);
st1_1 = 0:pi/100:pi/4;
st1_2 = pi/4+pi/10:pi/10:3*pi/4;
st1_3 = 3*pi/4+pi/50:pi/50:5*pi/4;
st1_4 = 5*pi/4+pi/10:pi/10:7*pi/4;
st1_5 = 7*pi/4+pi/100:pi/100:2*pi;
st1 = [st1_1 st1_2 st1_3 st1_4 st1_5];
% ft2 = 0:0.001:pi/2;
% st2 = (1/2).*acos(abs((2*r1*r1/(r2^2))-(2./(sin(ft2).^2))+1));
% st2 = st1.*2.*pusai./pi;
st2 = asin((r1/r2).*sin(st1));
%ft2 = atan(r2./(r1.*cos(st1)));
ft2 = atan2(r2,(r1.*cos(st1)));  

%修正theta2
% st2(26:51)=2*st2(26)-st2(26:51);
%修正fat2
%ft2(26:51)=pi+ft2(26:51);
rt = r2./sin(ft2);
xt = rt.*sin(ft2).*cos(st2);
yt = rt.*sin(ft2).*sin(st2);
zt = rt.*cos(ft2);
% p = plot3(xt,yt,zt,'o','Color','r','MarkerSize',6,'MarkerFaceColor','#D9FFFF')
%p.LineWidth = 3;
% hold on
% [x1,y1,z1]=cylinder(r2);
% [z2,y2,x2]=cylinder(r1);
% z1 = 10.*z1-5;
% x2 = 10.*x2-5;
% mesh(x1,y1,z1);
% hold on;
% mesh(x2,y2,z2);
% a = -5:0.01:5;
% b = -5:0.01:5;
% figure();
% hold on;
% [x3,y3]=meshgrid(a,b);
% z3 = sqrt(r1^2+r2^2-(2.*x3.^2+y3.^2));
% plot3(x3,y3,z3);
% Q_tool0 = [xt',yt',zt'];
% save('xiangguanxian.mat','Q_tool0');
