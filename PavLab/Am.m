function [ acell, outStr ] = Am( cl1, cl2,  pr, t1)
%AM Summary of this function goes here
%clc;
listOfIndex = MainS(pr);
% res = struct('p',[], 'q1',[], 'q2',[], 's', []);
acell{4,1,length(listOfIndex)} = [];
%fprintf('Данные по 1 признаку:');
%outStr = fprintf('Xi\t\t\tP\t\t\tq1\t\t\tq2\n');
%fprintf('Xi\t\t\tP\t\t\tq1\t\t\tq2\n');
%outStr = sprintf('N          P             q1             q2        Xi\n');
outStr = sprintf('Полный перебор:\n');
%outStr = outStr(1:length(outStr) - 1);
for j = 1:pr
    q = [listOfIndex{j}];
    a = cl1(:, q);
    b = cl2(:, q);
    wq = Amain(a, b, 1);
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

len = 2;
%printf('Данные по 1 признаку:');
s = '';
idStart = pr+1;
for i = pr+1:length(listOfIndex)
    q = [listOfIndex{i}];
    %     len
    %     length(q)
    %     i
    if (len < length(q))
        acell = AsortPP(acell, idStart, i - 1);
        idStart = i;
        len = length(q);
    end
    %fprintf('Данные по %d признакам:', len);
    % Сформировать массивы иходных данных
    % по номерам признаков
    for j = 1:length(q)
        a(:, j) = cl1(:, q(j));
        b(:, j) = cl2(:, q(j));
        ew = strvcat(q(j) + '0', '-');
        s = strvcat(s, ew);%q(j) + '0'
    end
    s = s(1:length(s) - 1);
    %unique(s)
    wq = Amain(a, b, length(q));
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

%whos acell
len = length(acell(1, : , :));
for id = 1:len
  %fprintf('%d\t\t%.2f\t\t%.2f\t\t%.2f\t\t%s\n',id, [acell{1, 1, id}], [acell{2, 1, id}], [acell{3, 1, id}], num2str(cell2mat(acell(4,1,id))));
  outStr = strvcat(outStr, sprintf('%d:\t%.2f\t%.2f\t%.2f\t%s',id, [acell{1, 1, id}], [acell{2, 1, id}], [acell{3, 1, id}], num2str(cell2mat(acell(4,1,id)))));
end
% outStr = strvcat('Вероятности:', sprintf([repmat('%f\t%f\t%f\t%s\t', 1, size(acell, 2)) '\n'], [acell}]));
end


