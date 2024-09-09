function PlotCylinder(obstracle_R,obstracle_L_center,obstracle_H_center)
%PLOTCYLINDER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%����Բ��
%��Ҫ֪���������߶ε�λ�ã��Լ�ԲͲ�İ뾶
%���������˵�����꣬Բ���ĸ߶ȡ�
% obstracle_R=5;
% obstracle_L_center=[10 70 0];
% obstracle_H_center=[10 10 40];

 
%��������Բ�����ڵ�����ϵ
Vector=obstracle_H_center-obstracle_L_center;
obstracle_hight=norm(Vector);
CZ=Vector/norm(Vector);
CZout=null(CZ);
CX=CZout(:,1);
CY=CZout(:,2);
CZ=CZ';
Trans=[[CX CY CZ obstracle_L_center'];0 0 0 1];
Lx=zeros(2,51);
Ly=Lx;
Lz=Lx;
 
for i=1:50
   Lx(1,i)=obstracle_R*cos(i*2*pi/50);
   Ly(1,i)=obstracle_R*sin(i*2*pi/50);
   Lz(2,i)=obstracle_hight;
   Lz(1,i)=0;
end
Lx(1,51)=Lx(1,1);
Ly(1,51)=Ly(1,1);
Lz(1,51)=0;
Lz(2,51)=obstracle_hight;
 
 
Lx(2,:)=Lx(1,:);
Ly(2,:)=Ly(1,:);
 
for i=1:51
    out=Trans*[Lx(1,i);Ly(1,i);Lz(1,i);1];
    Lx(1,i)=out(1);
    Ly(1,i)=out(2);
    Lz(1,i)=out(3);
    out=Trans*[Lx(2,i);Ly(2,i);Lz(2,i);1];
    Lx(2,i)=out(1);
    Ly(2,i)=out(2);
    Lz(2,i)=out(3);    
end
hold on; grid on;
% axis equal;
% axis([0 160 -10 160 -10 120]);
% view(-50,20);
surf(Lx,Ly,Lz,'FaceColor',[139/255,139/255,131/255]);
fill3(Lx(1,:),Ly(1,:),Lz(1,:),[139/255,139/255,131/255]);
fill3(Lx(2,:),Ly(2,:),Lz(2,:),[139/255,139/255,131/255]);
end

