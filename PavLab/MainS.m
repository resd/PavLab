function [ t ] = MainS( pr )
% 
%clc;
s = '';
n(1) = 0;
len = length(n);
i = 1;
j = 1;
% t = 1;
while ( len ~= pr )
    n = Solve(n, pr);
    s = strvcat(s, mat2str(n));
    %len 
    %i
%     for i = 1:length(n)
%         w(j, i) = n(1, i);        
%         i = i + 1;
%     end
    t{j} = n;
    j = j + 1;
    if (len < length(n))
        len = length(n);
        %i = 1;
    end
    %disp(n);
end;
%w
t = t';
%q = n;
end