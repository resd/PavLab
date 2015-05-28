function [ maxP, outStr, acell ] = SokraPer( cl1, cl2, pr, v2, t1 )
%SOKRAPER Summary of this function goes here
%   Detailed explanation goes here
% clc;
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
% pr = length(t1);
for i = 1 : pr
    t(i,1) = i;
end
nt = length(t);
msr = [];
%countLimit = pr * (pr + 1) / 2;
countLimit = pr - 1;
% out = sprintf('����������� �������:\n���������� ����� ������ ��������� / ����������� ����������� ������������� / ����� ���������\n');
resmax = 0;
imax=0;
% new
countPerms = [];
% acell{4,1,pr} = [];
% ac{pr} = [];
acLen = 1;
% /new/
for count = 1 : countLimit
    [row, col] = size(t);
    % new
    countPerms(count) = row;
    % /new/
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
                res = rule(cl1t, cl2t, col, false);%[res, a]
                %                 res = Amain(cl1t, cl2t, col);
            case 2
                res = rule(cl1t, cl2t, col, true);%[res, a]
%                 res = MSAnew(cl1t, cl2t, col, 1);
            case 3
                res = MSA(cl1t, cl2t, col, 1);%[res, c0, c1max]
%                 res = MSA(cl1t, cl2t, col, 1);
            case 4
                res = MSA(cl1t, cl2t, col, 2);%[res, c0, c1max]
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
        % new
        acell(1, 1, i) = {res(1)};
        acell(2, 1, i) = {res(2)};
        acell(3, 1, i) = {res(3)};
        acell(4, 1, i) = {qq};
        % /new/
        %         str = num2str(res(1));
        %         str = [str '  -  ' [num2str(qq)]];
%         str = sprintf('%d:\t%.2f\t%s',i, res(1), num2str(qq));
%         out = strvcat(out, str);
    end
    % new
    acell = AsortPP(acell, 1, row - 1);
    ac{acLen} = acell;
    acell = [];
    acell{4,1,row-1} = [];
    acLen = acLen + 1;
    % /new/
%     out;
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
% acell(1, 1, j) = {res(1)};
% acell(2, 1, j) = {res(2)};
% acell(3, 1, j) = {res(3)};
% acell(4, 1, j) = {qq};
% new
acellLen = 1;
acell = [];
acell{4,1,pr} = [];
for ii = 1:countLimit
    acellTemp = ac{ii};
    for id = 1:countPerms(ii)
        acell{1,1,acellLen} = acellTemp{1,1,id};
        acell{2,1,acellLen} = acellTemp{2,1,id};
        acell{3,1,acellLen} = acellTemp{3,1,id};
        acell{4,1,acellLen} = acellTemp{4,1,id};
        acellLen = acellLen + 1;
    end
end
% /new/
% switch v2
%     case 1
%         res = Amain(cl1, cl2, pr);
%     case 2
%         res = MSAnew(cl1t, cl2t, col, 1);
% end
switch v2
    case 1
        res = rule(cl1, cl2, pr, false);%[res, a]
        %                 res = Amain(cl1t, cl2t, col);
    case 2
        res = rule(cl1, cl2, pr, true);%[res, a]
        %                 res = MSAnew(cl1t, cl2t, col, 1);
    case 3
        res = MSA(cl1, cl2, pr, 1);%[res, c0, c1max]
        %                 res = MSA(cl1t, cl2t, col, 1);
    case 4
        res = MSA(cl1, cl2, pr, 2);%[res, c0, c1max]
end

acell(1, 1, acellLen) = {res(1)};
acell(2, 1, acellLen) = {res(2)};
acell(3, 1, acellLen) = {res(3)};
acell(4, 1, acellLen) = {qq};
ac{pr} = acell;
countPerms(pr) = 1;
% str = [str '  -  ' [num2str(qq)]];
% out = sprintf('%d:\t%.2f\t%s',countOut, res(1), num2str(qq));
% str = sprintf('%d:\t%.2f\t%s',1, res(1), num2str(qq));
% out = strvcat(out, str, sprintf('\n'));
outStr = sprintf('����������� �������:\n���������� ����� ������ ��������� / ����������� ����������� ������������� / ����� ���������\n');
% maxP = [];
% for ii = 1:pr
%     acell = [];
%     acell = ac{ii};
%     maxP(ii) = acell{1,1,1};
%     for id = 1:countPerms(ii)
%         %fprintf('%d\t\t%.2f\t\t%.2f\t\t%.2f\t\t%s\n',id, [acell{1, 1, id}], [acell{2, 1, id}], [acell{3, 1, id}], num2str(cell2mat(acell(4,1,id))));
% %         outStr = strvcat(outStr, sprintf('%d:\t%.2f\t%.2f\t%.2f\t%s',id, [acell{1, 1, id}], [acell{2, 1, id}], [acell{3, 1, id}], num2str(cell2mat(acell(4,1,id)))));
%         outStr = strvcat(outStr, sprintf('%d:\t%.2f\t%s',id, [acell{1, 1, id}], num2str(cell2mat(acell(4,1,id)))));
%     end
% end
for id = 1:acellLen
    %fprintf('%d\t\t%.2f\t\t%.2f\t\t%.2f\t\t%s\n',id, [acell{1, 1, id}], [acell{2, 1, id}], [acell{3, 1, id}], num2str(cell2mat(acell(4,1,id))));
    %         outStr = strvcat(outStr, sprintf('%d:\t%.2f\t%.2f\t%.2f\t%s',id, [acell{1, 1, id}], [acell{2, 1, id}], [acell{3, 1, id}], num2str(cell2mat(acell(4,1,id)))));
    outStr = strvcat(outStr, sprintf('%d:\t%.2f\t%s',id, [acell{1, 1, id}], num2str(cell2mat(acell(4,1,id)))));
end
outStr = strvcat(outStr, sprintf('\n'));

maxP(pr) = res(1);
