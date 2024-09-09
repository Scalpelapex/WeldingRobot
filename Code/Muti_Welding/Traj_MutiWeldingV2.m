clear, clc, close all
Pos_MW = [];
%% 焊缝属性
Seam_H = 5;  %焊缝高度cm
% Seam_W = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% % - Generation @2 - % %%%%%%
Seam_W = ones(5,1).*10;
Seam_W_init = 10; %焊缝宽度cm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L_piece = 80; %焊缝长度cm
Num_interpor = 10; %单条焊缝插值数量
alpha = 45*pi/180;
LayerNUM = 5;%层数
SeamNum = ones(1,LayerNUM);%焊缝数目每层
%每层焊道数目计算
for Fi = 2:5
    SeamNum(Fi) = floor(3*(2*(Seam_H+(Fi-2)*Seam_H)/tan(alpha))/(2*Seam_W_init)+1);
end
%焊道宽度修正
for Fi = 2:5
    Seam_W(Fi) = 3*((2*Seam_H+(2*Fi-3)*Seam_H)/tan(alpha))/(4*floor(SeamNum(Fi)-1));
end
%% 工件中心位置
Piece_Cx = 100;
Piece_Cy = 0;
Piece_Cz = 0;
%% 焊接过程安全点
Safe_Point = [Piece_Cx,Piece_Cy,Piece_Cz+30];
%% 1 LAYER Star-End Point Coordinate
P1s = [Piece_Cx,Piece_Cy+L_piece/2,Piece_Cz];
P1e = [Piece_Cx,Piece_Cy-L_piece/2,Piece_Cz];
layer1 = line_interp(P1s,P1e,Num_interpor);
% Pos_MW = [Safe_Point;Safe_Point;layer1];
%% 2 LAYER Star-End Point Coordinate
Lay_sn = 2; %表示这是第2层
layer2 = zeros(Num_interpor+1,3,SeamNum(Lay_sn));  % 51 x 3 x 2 的矩阵，2代表2条焊缝
P2se = zeros(2,3,SeamNum(Lay_sn));
for ij = 1:SeamNum(Lay_sn)
    P2se(1,:,ij) = [Piece_Cx-floor(SeamNum(Lay_sn)-1)*Seam_W(Lay_sn)/3+(ij-1)*(2/3)*Seam_W(Lay_sn), ...
                        Piece_Cy+L_piece/2, ...
                        Piece_Cz+Seam_H+(Lay_sn-2)*Seam_H];%第 Lay_sn 层，第 ij 道焊缝的 起点 坐标
    P2se(2,:,ij) = [Piece_Cx-floor(SeamNum(Lay_sn)-1)*Seam_W(Lay_sn)/3+(ij-1)*(2/3)*Seam_W(Lay_sn), ...
                        Piece_Cy-L_piece/2, ...
                        Piece_Cz+Seam_H+(Lay_sn-2)*Seam_H];%第 Lay_sn 层，第 ij 道焊缝的 终点 坐标
    layer2(:,:,ij) = line_interp(P2se(1,:,ij),P2se(2,:,ij),Num_interpor);
end
%% 3 LAYER Star-End Point Coordinate
Lay_sn = 3; %表示这是第3层
layer3 = zeros(Num_interpor+1,3,SeamNum(Lay_sn));  % 51 x 3 x 3 的矩阵
P3se = zeros(2,3,SeamNum(Lay_sn));
for ij = 1:SeamNum(Lay_sn)
    P3se(1,:,ij) = [Piece_Cx-floor(SeamNum(Lay_sn)-1)*Seam_W(Lay_sn)/3+(ij-1)*(2/3)*Seam_W(Lay_sn), ...
                        Piece_Cy+L_piece/2, ...
                        Piece_Cz+Seam_H+(Lay_sn-2)*Seam_H];%第 Lay_sn 层，第 ij 道焊缝的 起点 坐标
    P3se(2,:,ij) = [Piece_Cx-floor(SeamNum(Lay_sn)-1)*Seam_W(Lay_sn)/3+(ij-1)*(2/3)*Seam_W(Lay_sn), ...
                        Piece_Cy-L_piece/2, ...
                        Piece_Cz+Seam_H+(Lay_sn-2)*Seam_H];%第 Lay_sn 层，第 ij 道焊缝的 终点 坐标
    layer3(:,:,ij) = line_interp(P3se(1,:,ij),P3se(2,:,ij),Num_interpor);
end
%% 4 LAYER Star-End Point Coordinate
Lay_sn = 4; %表示这是第4层
layer4 = zeros(Num_interpor+1,3,SeamNum(Lay_sn));  % 51 x 3 x 4 的矩阵
P4se = zeros(2,3,SeamNum(Lay_sn));
for ij = 1:SeamNum(Lay_sn)
    P4se(1,:,ij) = [Piece_Cx-floor(SeamNum(Lay_sn)-1)*Seam_W(Lay_sn)/3+(ij-1)*(2/3)*Seam_W(Lay_sn), ...
                        Piece_Cy+L_piece/2, ...
                        Piece_Cz+Seam_H+(Lay_sn-2)*Seam_H];%第 Lay_sn 层，第 ij 道焊缝的 起点 坐标
    P4se(2,:,ij) = [Piece_Cx-floor(SeamNum(Lay_sn)-1)*Seam_W(Lay_sn)/3+(ij-1)*(2/3)*Seam_W(Lay_sn), ...
                        Piece_Cy-L_piece/2, ...
                        Piece_Cz+Seam_H+(Lay_sn-2)*Seam_H];%第 Lay_sn 层，第 ij 道焊缝的 终点 坐标
    layer4(:,:,ij) = line_interp(P4se(1,:,ij),P4se(2,:,ij),Num_interpor);
end
%% 5 LAYER Star-End Point Coordinate
Lay_sn = 5; %表示这是第5层
layer5 = zeros(Num_interpor+1,3,SeamNum(Lay_sn));  % 51 x 3 x 5 的矩阵
P5se = zeros(2,3,SeamNum(Lay_sn));
for ij = 1:SeamNum(Lay_sn)
    P5se(1,:,ij) = [Piece_Cx-floor(SeamNum(Lay_sn)-1)*Seam_W(Lay_sn)/3+(ij-1)*(2/3)*Seam_W(Lay_sn), ...
                        Piece_Cy+L_piece/2, ...
                        Piece_Cz+Seam_H+(Lay_sn-2)*Seam_H];%第 Lay_sn 层，第 ij 道焊缝的 起点 坐标
    P5se(2,:,ij) = [Piece_Cx-floor(SeamNum(Lay_sn)-1)*Seam_W(Lay_sn)/3+(ij-1)*(2/3)*Seam_W(Lay_sn), ...
                        Piece_Cy-L_piece/2, ...
                        Piece_Cz+Seam_H+(Lay_sn-2)*Seam_H];%第 Lay_sn 层，第 ij 道焊缝的 终点 坐标
    layer5(:,:,ij) = line_interp(P5se(1,:,ij),P5se(2,:,ij),Num_interpor);
end
%% 焊道顺序调整
Layer_ = {layer1,layer2,layer3,layer4,layer5};
for ilay = 1:LayerNUM    %按层数进行遍历
% if mod(SeamNum(ilay),2)  %如果该层的焊道数为奇数
    odd_count = 0;
    even_count = 0;
    for ifr = 1:SeamNum(ilay)   %按该层焊道数开始遍历
        if mod(ifr,2)             %如果此次为第奇数次循环
            odd_count = odd_count + 1;
            Pos_MW = [Pos_MW;...
                      Safe_Point;...
                      Layer_{ilay}(:,:,odd_count)];
        else
            even_count = even_count + 1;
            Pos_MW = [Pos_MW;...
                      Safe_Point;...
                      Layer_{ilay}(:,:,end-even_count+1)];
        end
    end
end
Pos_MW = [Pos_MW;Safe_Point;Safe_Point];
Time_MW =1:21/length(Pos_MW):22-21/length(Pos_MW);
Time_MW=Time_MW';
save('MW_Traj.mat','Pos_MW','Time_MW');