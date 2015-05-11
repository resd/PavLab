function [ maxP, out ] = MK( cl1, cl2, pr, v2 , t1)
%MK Summary of this function goes here
%   Detailed explanation goes here
clc;
% todo ¬ынести за пределы этого
% v2 = 1;
% pr = 5;
for i = 1:pr
    w(i) = i;
end
% ws = load ('classessss.mat');
% cl1 = ws.class1;
% cl2 = ws.class2;
% /todo
k = 2; % количество выбираемых за 1 шаг перестановок из pr
out = sprintf('ћетод ћонте- арло:\nћаксимальна€ веро€тность правильного распознавани€ дл€ каждого набора признаков / Ќабор признаков\n');
maxP = [];
addpath config;

for q = 1:pr-1
    prp = nchoosek(w, q);    % текуща€ выборка по признаком i
    [prl, col] = size(prp);  % длина текущей выборки
    t = 1 / prl;             % количество интервалов
    %   h     - велечина, на которую мен€етс€ интервал
    %   s     - количество сравнений на каждом шаге
    [h, s] = MKconfig(t, prl, q);
    %     s = 5; %floor(row*0.1) + 1
    len(1 : prl) = t;
    for i = 1 : prl
        diap(i) = i / prl;  % значени€ дл€ каждого эл-та выборки
    end
    for ss = 1 : s
        % ѕри k = 2
        if fix(max(len)) == 1.0 break; end;
        while true
            qw = rand(1, k);
            b(1) = find(qw(1), prl, diap);
            b(2) = find(qw(2), prl, diap);
            if (b(1) ~= b(2)) break; end;
        end
        %b
        cl11 = [];
        cl12 = [];
        cl21 = [];
        cl22 = [];
        for jj = 1:q
            cl11(:, jj) = cl1(:, prp(b(1), jj));
            cl12(:, jj) = cl2(:, prp(b(1), jj));
            cl21(:, jj) = cl1(:, prp(b(2), jj));
            cl22(:, jj) = cl2(:, prp(b(2), jj));
        end
        res1 = Amain(cl11, cl12, q);
        res2 = Amain(cl21, cl22, q);
        if res1(1) >= res2(1)
            k1 = b(1);
            k2 = b(2);
        else
            k1 = b(2);
            k2 = b(1);
        end
        % k1 - расшир€ем
        % k2 - сужаем
        %     k1
        %     k2
        len(k1) = len(k1) + h;
        len(k2) = len(k2) - h;
        if len(k2) < 2.0817e-010
            len (k2) = 0;
        end
        diap(1) = len(1);
        for i = 2 : prl
            diap(i) = len(i) + diap(i - 1);
        end
        %     if k1 ~= prl
        %         diap(k1) = diap(k1) + h;
        %     end
        %     if k2 ~= 1
        %         diap(k2) = diap(k2) - h;
        %     end
        %     %diap
        %     if(k1 ~= 1)
        %         diap(k1-1) = diap(k1-1) - h;
        %     end
        %     if k2 ~= 1
        %         diap(k2-1) = diap(k2-1) + h;
        %     end
        %     diap
        %     len
    end
    %diap
    len;
    %     for j = 1 : 5
    %         Amain(cl1(:, prp(j)), cl2(:, prp(j)), 1);
    %     end
    %prp = [1 2; 2 3; 3 4; 5 6; 6 7];
    % for i = 1: prl
    %     ii(i) = i;
    %     ip{i} = prp(i, :);
    % end
    % %[ip{1}]
    % ip
    % ii
    maxl = 0;
    for i = 1: prl
        if len(i) >  maxl
            maxl = len(i);
            imax = i;
        end
    end
    [row, col] = size(prp);
    for i = 1:col
        cl11(:, i) = cl1(:, prp(imax, i));
        cl12(:, i) = cl2(:, prp(imax, i));
    end
    res = Amain(cl11, cl12, col);
    %out1 = ['i = ' num2str(q)];
    q = prp(imax,:);
    for e = 1:length(q)
        qq(e) = t1(q(e));
    end
    %     str = [num2str(qq)];
    %     out2 = [num2str(res(1)) '  -  ' str];
    %     out = strvcat(out, out2);
    str = sprintf('%.2f\t%s', res(1), num2str(qq));
    out = strvcat(out, str);
    maxP(i) = res(1);
end

MKconfig(t, 1, pr);
rmpath config;
q = w;
for e = 1:length(q)
    qq(e) = t1(q(e));
end
res = Amain(cl1, cl2, pr);
str = sprintf('%.2f\t%s', res(1), num2str(qq));
out = strvcat(out, str);
maxP(pr) = res(1);
% str = [num2str(qq)];
% out2 = [num2str(res(1)) '  -  ' str];
% out = strvcat(out, out2);


function b = find(sk, prl, diap)
lb = 1;
ub = prl;
while(1)
    ci = ceil((lb + ub) / 2); %round
    if diap(ci) == sk
        b = ci;
        break;
    else if lb > ub
            b = ci;
            break;
        else if diap(ci) < sk
                lb = ci + 1;
            else
                ub = ci -1;
            end
        end
    end
end