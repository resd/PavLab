function [ maxP, out ] = SokraPer( cl1, cl2, pr, v2, t1 )
%SOKRAPER Summary of this function goes here
%   Detailed explanation goes here
clc;
% delete
% pr = 5;
% v2 = 2;
% a = [1,2,3,4,5];
% na = pr;
% ws = load ('classessss.mat');
% cl1 = ws.class1;
% cl2 = ws.class2;
%

% for i = 1 : pr
%     a(i) = i;
% end
for i = 1 : pr
    t(i,1) = i;
end
nt = length(t);
msr = [];
%countLimit = pr * (pr + 1) / 2;
countLimit = pr - 1;
out = sprintf('Сокращенный перебор:\nПорядковый номер набора признаков / Вероятность правильного распознавания / Набор признаков\n');
resmax = 0;
imax=0;
for count = 1 : countLimit
    [row, col] = size(t);
    for i = 1 : row
        %rez(i) = a(i);
        cl1t = [];
        cl2t = [];
        for j = 1:col
            cl1t(:, j) = cl1(:, t(i, j));
            cl2t(:, j) = cl2(:, t(i, j));
        end
        %         [res, outf] = Am(cl1, cl2, pr);
        switch v2
            case 1
                res = Amain(cl1t, cl2t, col);
            case 2
                res = MSAnew(cl1t, cl2t, col, 1);
        end
        if res(1) > resmax
            resmax = res(1);
            imax = i;
        end
        %out = strvcat(out, strcat(str, '  ', num2str(res(1))));
        q = t(i,:);
        for e = 1:length(q)
            qq(e) = t1(q(e));
        end
        %         str = num2str(res(1));
        %         str = [str '  -  ' [num2str(qq)]];
        str = sprintf('%d:\t%.2f\t%s',i, res(1), num2str(qq));
        out = strvcat(out, str);
    end
    out;
    maxP(count) = resmax;
    %msr(count) = imax;
    cos = t(imax, end);
    t(imax, :) = [];
    [row, col] = size(t);
    %t = t(t~=imax);
    for k = 1 : row
        %t
        t(k,col+1) = t(k, col);
        t(k, col) = cos;
    end
    t;
    resmax = 0;
end
q = t(1,:);
for e = 1:length(q)
    qq(e) = t1(q(e));
end
switch v2
    case 1
        res = Amain(cl1, cl2, pr);
    case 2
        res = MSAnew(cl1t, cl2t, col, 1);
end
% str = [str '  -  ' [num2str(qq)]];
% out = sprintf('%d:\t%.2f\t%s',countOut, res(1), num2str(qq));
str = sprintf('%d:\t%.2f\t%s',1, res(1), num2str(qq));
out = strvcat(out, str, sprintf('\n'));
maxP(pr) = res(1);
