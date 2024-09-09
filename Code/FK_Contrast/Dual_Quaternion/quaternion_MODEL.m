close all;
clear;
syms ee;
%变量
theta=[0,0,pi/2,0,0,0];
%Step1:define the vector of axis
d0 = [0,0,1]; 
d1 = [0,1,0];
d2 = [0,1,0];
d3 = [0,1,0];
d4 = [0,0,1];
d5 = [0,1,0];
d6 = [0,1,0];
%and select a point on the axis (单位：m)
p0 = [0,0,0.1273];
p1 = [0,0,0.1273];
p2 = [0.612,0,0.1273];
p3 = [0.612+0.5723,0,0.1273];
p4 = [0.612+0.5723,0,0.1273-0.163941];
p5 = [0.612+0.5723,0,0.1273-0.163941];
p6 = [0.612+0.5723,0,0.1273-0.163941];
%and caculate the moment vectors
m0 = cross(p0,d0);
m1 = cross(p1,d1);
m2 = cross(p2,d2);
m3 = cross(p3,d3);  
m4 = cross(p4,d4);
m5 = cross(p5,d5);
%and define the line operater
L6 = quaternion(0,d5(1),d5(2),d5(3));
L06 = quaternion(0,m5(1),m5(2),m5(3));
L5 = quaternion(0,d4(1),d4(2),d4(3));
L05 = quaternion(0,m4(1),m4(2),m4(3));
%Step2:dual-quaternion form
q0 = quaternion(cos(theta(1)/2),sin(theta(1)/2).*d0(1),sin(theta(1)/2).*d0(2),sin(theta(1)/2).*d0(3));
q1 = quaternion(cos(theta(2)/2),sin(theta(2)/2).*d1(1),sin(theta(2)/2).*d1(2),sin(theta(2)/2).*d1(3));
q2 = quaternion(cos(theta(3)/2),sin(theta(3)/2).*d2(1),sin(theta(3)/2).*d2(2),sin(theta(3)/2).*d2(3));
q3 = quaternion(cos(theta(4)/2),sin(theta(4)/2).*d3(1),sin(theta(4)/2).*d3(2),sin(theta(4)/2).*d3(3));
q4 = quaternion(cos(theta(5)/2),sin(theta(5)/2).*d4(1),sin(theta(5)/2).*d4(2),sin(theta(5)/2).*d4(3));
q5 = quaternion(cos(theta(6)/2),sin(theta(6)/2).*d5(1),sin(theta(6)/2).*d5(2),sin(theta(6)/2).*d5(3));
    
q00 = quaternion(0,sin(theta(1)/2).*m0(1),sin(theta(1)/2).*m0(2),sin(theta(1)/2).*m0(3));
q01 = quaternion(0,sin(theta(2)/2).*m1(1),sin(theta(2)/2).*m1(2),sin(theta(2)/2).*m1(3));
q02 = quaternion(0,sin(theta(3)/2).*m2(1),sin(theta(3)/2).*m2(2),sin(theta(3)/2).*m2(3));
q03 = quaternion(0,sin(theta(4)/2).*m3(1),sin(theta(4)/2).*m3(2),sin(theta(4)/2).*m3(3));
q04 = quaternion(0,sin(theta(5)/2).*m4(1),sin(theta(5)/2).*m4(2),sin(theta(5)/2).*m4(3));
q05 = quaternion(0,sin(theta(6)/2).*m5(1),sin(theta(6)/2).*m5(2),sin(theta(6)/2).*m5(3));
%vector:q_12 = q0*q1 + ee*(q0*q01+q00*q1);
q_12 = q0*q1 ;
q0_12 = q0*q01+q00*q1;
q_13 = q_12*q2;
q0_13 = q_12*q02+q0_12*q2;
q_14 = q_13*q3;
q0_14 = q_13*q03+q0_13*q3;
q_15 = q_14*q4;
q0_15 = q_14*q04+q0_14*q4;
q_16 = q_15*q5;
q0_16 = q_15*q05+q0_15*q5;
%conj quater : q16 and q15 where: q16 = q_16+ee q0_16
q16_conj = conj(q_16);
q016_conj = -conj(q0_16);
q15_conj = conj(q_15);
q015_conj = -conj(q0_15);
%calculate the mid step
q16_L6 = q_16 * L6;
q16_L6_0 = q_16*L06 +q0_16*L6;
q15_L5 = q_15 * L5;
q15_L5_0 = q_15 * L05 + q0_15 * L5;
%out_temp
L6_final = q16_L6 * q16_conj;
L06_final = q16_L6 * q016_conj + q16_L6_0 * q16_conj;
L5_final = q15_L5 * q15_conj;
L05_final = q15_L5 * q015_conj + q15_L5_0 * q15_conj;

VR_L6 = [x(L6_final),y(L6_final),z(L6_final)];
VD_L6 = [x(L06_final),y(L06_final),z(L06_final)];
VR_L5 = [x(L5_final),y(L5_final),z(L5_final)];
VD_L5 = [x(L05_final),y(L05_final),z(L05_final)];
%position
P_end = cross(VR_L6,VD_L6)+(cross(VR_L5,VD_L5).*VR_L6).*VR_L6;
