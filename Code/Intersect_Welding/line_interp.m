function temp_p = line_interp(AA,BB,num)
%LINE_INTERP 此处显示有关此函数的摘要
%   此处显示详细说明
temp_p = zeros(num,3);
for ii = 1:num+1
    temp_p(ii,1)=AA(1)+(BB(1)-AA(1))/num*(ii-1);
    temp_p(ii,2)=AA(2)+(BB(2)-AA(2))/num*(ii-1);
    temp_p(ii,3)=AA(3)+(BB(3)-AA(3))/num*(ii-1);
end


