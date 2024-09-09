clear,clc;
auboi10 = importrobot('MATLAB_AUBOI10_URDF.urdf');
showdetails(auboi10);%显示连杆父子关系
initialguess=homeConfiguration(auboi10);
show(auboi10,initialguess,'Frames','off','Visuals','on');
axis([-1.2,1.2,-1.2,1.2,0,2]);
auboi10_SIM = smimport('MATLAB_AUBOI10_URDF.urdf');
