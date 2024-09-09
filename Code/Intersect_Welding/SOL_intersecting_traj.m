clear,clc;
% run('welding_robot_params.m')
load xiangguanxian.mat

zz_off=1.20;
z_off = 3;
z_or = 50;
distance_center_xof = 100;%cm
distance_center_zof = 50;
tool_home=[20+distance_center_xof 50 50];   %Tool Home 

time_temp = 2:18/86:20-18/86;
Time_0 = [0 1 time_temp];

Q_tool0;

% Start tool path in home configuration
tool_path = [...
    0 tool_home; ...
    1 tool_home; ...
    ];

%% intersecting line
intersecet = [ ...
                time_temp',Q_tool0(:,1)*100+distance_center_xof, Q_tool0(:,2)*100 , Q_tool0(:,3)*100+distance_center_zof;            
                ];
tool_path = [tool_path;intersecet];


%% End tool path in home configuration
home = [...
    0 [-100,-100,z_or+zz_off*z_off+20]; ...
    1 [-100,-100,z_or+zz_off*z_off+20]; ...
    ];
home(:,1) = home(:,1) + tool_path(end, 1) + 1;
tool_path = [tool_path; home];
Time_sect=tool_path(:,1);
Pos_sect=tool_path(:,2:4);
save('IntersectingTraj.mat','Time_sect','Pos_sect');