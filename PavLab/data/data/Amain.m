function [ res ] = Amain( a, b, prIn)% add pr
clc;
clear n det kr;
global n det kr Acell;
ws = load ('classes12.mat');
a = ws.class1;
b = ws.class2;
prIn = 5;
mo = [];
Acell = [];
d=[];
i =[];
j=[];
k =[];
n=[];
ord =[];
rz=[];
x =[];
result=[];
kr = [];
det = [];
cov = [];
%a = [1 2;3 1];
%b = [2 4;6 8];
% 1 2 2 4
% 3 1 6 8
%format long;
n(1) = length(a);
n(2) = length(b);
pr = prIn;
kr = struct('np',[], 'zn',[], 'sc',[]);
%kr(1).zn = 11;
%a
%b
for i = 1:n(1)% add one more cikl for n(K) elements automatization
    for j = 1:pr
        rz(j, i, 1) = a(i, j);
        %a(i, j);
        %rz(:, :, :);
    end
end
for i = 1:n(2)
    for j = 1:pr
        rz(j, i, 2) = b(i, j);
    end
end
% a(1,2) % i j
% rz(2, 1, 1)% j i
% b(1,2) % i j
% rz(2, 1, 2)% j i
%Вычисление мат. ожид. и ковар. матриц параметров объектов обучения 
% mo = [mean(a);mean(b)]';
% c = [var(a);var(b)]';
% [m1, c1] = Amocov(1, rz, pr, n);
% [m2, c2] = Amocov(2, rz, pr, n);
% [m1, c1] = Amocov(1, rz, a, b, pr, n);
% [m2, c2] = Amocov(2, rz, a, b, pr, n);
% mo, cov
% mo = [m1;m2];
% c = [c1;c2];
for k = 1:2
    [mo, cov] = Amocov(k, rz, pr);%( nkl, n, rz, pr)
end
% covv;
% Обращение ковар. матриц и вывод результата 
for k = 1:2
    [d] = Aobr(k, pr);% ( pel, pr )
     det(k) = d;%% ???????? ?????????? ?????????? ? Aobr(k)
end
% for k = 1:2
%     [d] = Aobr(k, pr);% ( pel, pr )
%      dett(k) = d; % допилить глобальную переменную в Aobr(k)
% end
% S1 = cov(a);
% S2 = cov(b);
% % AS1 = inv(S1)
% % AS2 = inv(S2)
% % DS1 = cond(S1)
% % DS2 = cond(S2)
% DS11 = det(S1);
% DS22 = det(S2);
% d = [DS11; DS22];
% dett
%det
% Вычисление картины распознавания для двух классов 
Aopr(1, rz, pr);% ( nkl, rz, kr)
%kr().zn
Aopr(2, rz, pr);
% Aopr(1, rz, pr, n, mo, c, d );% ( nkl, rz, kr)
% %kr().zn
% Aopr(2, rz, pr, n, mo, c, d );
%kr().zn
% Упорядочение картины распознавания по значению дискрим. функции 
%as = qsort(str2array(kr));
%nestedSortStruct(kr, 'zn')
[x,ord] = sort([kr.zn]);
kr = kr(ord);
%for id = 1:length(kr)
%    fprintf('%d\n',id)
%    disp(kr(id))
%end

% Convert to a cell array:
Acell = struct2cell(kr);
% Convert to a matrix
%Acell = reshape(Acell, sz(1), []);      % Px(MxN)
% Make each field a column
%Acell = Acell';    
Acell = cell2mat(Acell);
Acell = sortCell(Acell);
%Acell

% for id = 1:length(Acell)
%   fprintf('%d\t%d\t%f\t%f\n',id, Acell(1, 1, id), Acell(2, 1, id), Acell(3, 1, id))
%    %disp(Acell(2)Acell(3));
% end
%kr().zn
%Afields = fieldnames(kr);
%Acell
%Afields'
%kr = cell2struct(Acell, Afields', 3);
%disp(Acell)

%v = evalin('base', 'class1');
% Выбор порога распознавания
result = Aprobb(Acell, n);% ( kr )

res(1) = result(1);
res(2) = result(2);
res(3) = result(3);
res(4) = result(4);
% opr = det;
%clear Acell a b d i j k n ord pr rz x prIn result;

% class1 = a;
% class2 = b;
% class1M = mean(a);
% class2M = mean(b);
% X1 = class1M(1)+(class2M(1)-class1M(1))/2;
% X2 = class1M(2)+(class2M(2)-class1M(2))/2;
% k = -(class1M(1)-class2M(1))/(class1M(2)-class2M(2));
% bb = X2-X1*k;
% tmin = min(class1(:,1));
% tmax = max(class2(:,1));
% tt1 = min(class1);
% tt2 = max(class2);
% t1 = min(tt1);
% t2 = max(tt2);
% tmin = t1;
% tmax = t2;
% X2min = k*tmin + bb;
% X2max = k*tmax + bb;
% p = 20;
% i=1;
% for t=tmin:((tmax-tmin)/p):tmax,
%     z(i) = t;
%     X = z(i);
%     Y1(i) = (-(a5 * X + a2)+((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
% 	Y2(i) = (-(a5 * X + a2)-((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
%     i=i+1;
% end
% figure(2);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');hold on;
% save output;
 end

