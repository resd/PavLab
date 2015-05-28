function [ maxP, ac, outStr, acell] = Am( cl1, cl2, t1, v2)
%AM Summary of this function goes here
% clc;
% cl1 = [];
% cl2 = [];
% ws = load ('lab4.mat');
% cl1t = ws.class1;
% cl2t = ws.class2;
% t1 = [2, 4, 6, 8];
pr = length(t1);
for i = 1:pr
    array(i) = i;
end
% for i = 1:length(t1)
%     cl1(:, i) = cl1t(:, t1(i));
%     cl2(:, i) = cl2t(:, t1(i));
% end
listOfIndex = nchoosek(array, 1);
countPerms(1) = length(listOfIndex);
% res = struct('p',[], 'q1',[], 'q2',[], 's', []);
acell{4,1,pr} = [];
ac{pr} = [];
%fprintf('Данные по 1 признаку:');
%outStr = fprintf('Xi\t\t\tP\t\t\tq1\t\t\tq2\n');
%fprintf('Xi\t\t\tP\t\t\tq1\t\t\tq2\n');
%outStr = sprintf('N          P             q1             q2
%Xi\n');
%outStr = outStr(1:length(outStr) - 1);
for j = 1:pr
    q = listOfIndex(j);
    a = cl1(:, q);
    b = cl2(:, q);
%     wq = Amain(a, b, 1);
%     [ out, wq ] = getsingleout( v2, a, b, 1 );
    switch v2
        case 1
            wq = rule(a, b, 1, false);%[res, a]
            %                 res = Amain(cl1t, cl2t, col);
        case 2
            wq = rule(a, b, 1, true);%[res, a]
            %                 res = MSAnew(cl1t, cl2t, col, 1);
        case 3
            wq = MSA(a, b, 1, 1);%[res, c0, c1max]
            %                 res = MSA(cl1t, cl2t, col, 1);
        case 4
            wq = MSA(a, b, 1, 2);%[res, c0, c1max]
    end
    acell(1, 1, j) = {wq(1)};
    acell(2, 1, j) = {wq(2)};
    acell(3, 1, j) = {wq(3)};
    for e = 1:length(q)
        qq(e) = t1(q(e));
    end
    acell(4, 1, j) = {qq};
    %     res(j).p = wq(1);
    %     res(j).q1 = wq(2);
    %     res(j).q2 = wq(3);
    %     res(j).s = q;
    %fprintf('%d:\t\t%.2f\t\t%.2f\t\t%.2f\n', q, wq(1), wq(2), wq(3));
    %outStr = strvcat(outStr, sprintf('     %d:         %.2f          %.2f          %.2f', q, wq(1), wq(2), wq(3)));
    %outStr = outStr(j:length(outStr) - 1);
end
acell = AsortPP(acell, 1, pr-1);
ac{1} = acell;
len = 2;
%printf('Данные по 1 признаку:');
s = '';
for ii = 2:pr
    listOfIndex = nchoosek(array, ii);
    [row, col] = size(listOfIndex);
    acell = [];
    acell{4,1,row} = [];
    a = [];
    b = [];
    countPerms(ii) = row;
    for i = 1 : row
        q = listOfIndex(i,:);
        %     len
        %     length(q)
        %     i
        %         if (len < length(q))
        %             acell = AsortPP(acell, idStart, i - 1);
        %             idStart = i;
        %             len = length(q);
        %         end
        %fprintf('Данные по %d признакам:', len);
        % Сформировать массивы исходных данных
        % по номерам признаков
        for j = 1:length(q)
            a(:, j) = cl1(:, q(j));
            b(:, j) = cl2(:, q(j));
            ew = strvcat(q(j) + '0', '-');
            s = strvcat(s, ew);%q(j) + '0'
        end
        s = s(1:length(s) - 1);
        %unique(s)
%         wq = Amain(a, b, length(q));
%         [ out, wq ] = getsingleout( v2, a, b, length(q) );
        switch v2
            case 1
                wq = rule(a, b, length(q), false);%[res, a]
                %                 res = Amain(cl1t, cl2t, col);
            case 2
                wq = rule(a, b, length(q), true);%[res, a]
                %                 res = MSAnew(cl1t, cl2t, col, 1);
            case 3
                wq = MSA(a, b, length(q), 1);%[res, c0, c1max]
                %                 res = MSA(cl1t, cl2t, col, 1);
            case 4
                wq = MSA(a, b, length(q), 2);%[res, c0, c1max]
        end
        acell(1, 1, i) = {wq(1)};
        acell(2, 1, i) = {wq(2)};
        acell(3, 1, i) = {wq(3)};
        for e = 1:length(q)
            qq(e) = t1(q(e));
        end
        acell(4, 1, i) = {qq};
        %     res(i).p = wq(1);
        %     res(i).q1 = wq(2);
        %     res(i).q2 = wq(3);
        %     res(i).s = q;
        %fprintf('%s:\t\t%.2f\t\t%.2f\t\t%.2f\n', s, wq(1), wq(2), wq(3));
        %outStr = strvcat(outStr, sprintf('     %s:     %.2f         %.2f           %.2f', s, wq(1), wq(2), wq(3)));
        %outStr = outStr(i:length(outStr) - 1);
        s = '';
    end
    acell = AsortPP(acell, 1, row-1);
    ac{ii} = acell;
end
%whos acell
%a{4,1,row} = [];
outStr = sprintf('Полный перебор:\nПорядковый номер набора признаков / Вероятность правильного распознавания / Набор признаков\n');
acellLen = 0;
acell = [];
acell{4,1,pr} = [];
maxP = [];
for ii = 1:pr
    acellTemp = ac{ii};
    maxP(ii) = acellTemp{1,1,1};
    for id = 1:countPerms(ii)
        acellLen = acellLen + 1;
        acell{1,1,acellLen} = acellTemp{1,1,id};
        acell{2,1,acellLen} = acellTemp{2,1,id};
        acell{3,1,acellLen} = acellTemp{3,1,id};
        acell{4,1,acellLen} = acellTemp{4,1,id};
    end
end
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
% outStr = strvcat('Вероятности:', sprintf([repmat('%f\t%f\t%f\t%s\t', 1,
% size(acell, 2)) '\n'], [acell}]));


