function [  ] = test(  )
%TEST Summary of this function goes here
%   Detailed explanation goes here
clc;
res1 = getres(1);
len = length(res1(1, : , :));
lenresult = getreslen();
outStr = '';
w{4,1,len} = [];
k1 = 0; k2 = 0; k3 = 0;
pr = getpr();
for j = 1:pr
    for k = 1:lenresult
        res = getres(k);
        k1 = k1 + [res{1, 1, j}];
        k2 = k2 + [res{2, 1, j}];
        k3 = k3 + [res{3, 1, j}];
    end
    k4 = length([res{4,1,j}]);
    w(1,1,j) = {k1};
    w(2,1,j) = {k2};
    w(3,1,j) = {k3};
    w(4,1,j) = {k4};
    k1 = 0; k2 = 0; k3 = 0;
end
w = AsortPP(w, 1, pr);
k4 = 2;
idStart = pr+1;
for j = pr+1:len
    for k = 1:lenresult
        res = getres(k);
        k1 = k1 + [res{1, 1, j}];
        k2 = k2 + [res{2, 1, j}];
        k3 = k3 + [res{3, 1, j}];
    end
    if (k4 < length([res{4,1,j}]))
        w = AsortPP(w, idStart, j - 1);
        idStart = j;
    end
    k4 = length([res{4,1,j}]);
    w(1,1,j) = {k1/2};
    w(2,1,j) = {k2/2};
    w(3,1,j) = {k3/2};
    w(4,1,j) = {k4};
    %outStr = strvcat(outStr, sprintf('%d:\t%4.2f\t%4.2f\t%4.2f\t%d',j, k1/lenresult, k2/lenresult, k3/lenresult, k4));
    k1 = 0; k2 = 0; k3 = 0;
end

for id = 1:len
  outStr = strvcat(outStr, sprintf('%d:\t%.2f\t%.2f\t%.2f\t%d',id, [w{1, 1, id}], [w{2, 1, id}], [w{3, 1, id}], [w{4, 1, id}]));
end

%outStr = strvcat(outStr,
%sprintf('%d:\t%.2f\t%.2f\t%.2f\t%s',id, [acell{1, 1, id}], [acell{2, 1, id}], [acell{3, 1, id}], num2str(cell2mat(acell(4,1,id)))));
out = strvcat('Результирующая выборка ', outStr);
disp(out);
end

