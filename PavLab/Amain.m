function [ res ] = Amain( class1, class2, prIn)
clear global kr Acell;
global kr Acell;
n(1) = length(class1);
n(2) = length(class2);
pr = prIn;
kr = struct('np',[], 'zn',[], 'sc',[]);
% format long;
for i = 1:n(1)
    for j = 1:pr
        rz(j, i, 1) = class1(i, j);
    end
end
for i = 1:n(2)
    for j = 1:pr
        rz(j, i, 2) = class2(i, j);
    end
end

%Вычисление мат. ожид. и ковар. матриц параметров объектов обучения 
for k = 1:2
    Amocov(k, rz, pr, n);
end

% Обращение ковар. матриц и вывод результата 
for k = 1:2
    [d] = Aobr(k, pr);
    dett(k) = d;
end
S1 = cov(class1);
S2 = cov(class2);
DS11 = det(S1);
DS22 = det(S2);
dett = [DS11; DS22];

% Вычисление картины распознавания для двух классов 
Aopr(1, rz, pr, n, dett);
Aopr(2, rz, pr, n, dett);

% Упорядочение картины распознавания по значению дискрим. функции 
[x,ord] = sort([kr.zn]);
kr = kr(ord);

% Convert to a cell array:
Acell = struct2cell(kr);

% Convert to a matrix
Acell = cell2mat(Acell);
Acell = sortCell(Acell);

% Выбор порога распознавания
result = Aprobb(Acell, n);% ( kr )

% Запись результатов
res(1) = result(1);
res(2) = result(2);
res(3) = result(3);
res(4) = result(4);

% res
% Запись кожфициентов решающего правила
class1M = mean(class1);
class2M = mean(class2);
S1 = cov(class1);
S2 = cov(class2);
AS1 = inv(S1);
AS2 = inv(S2);
DS1 = det(S1);
DS2 = det(S2);
a = 0.5 * (AS2 - AS1);
b = AS1*class1M' - AS2*class2M';
c1 = -0.5*(class1M*AS1*class1M' - class2M*AS2*class2M') + 0.5*log(DS2/DS1);
% res(4);
% kr(result(5)).zn;
c1 = c1 - res(4);
c = [c1, b(2,1),b(1,1),a(2,2),2*a(1,2),a(1,1)];

err1 = 0;
err2 = 0;
P = 0;
for i=1:n(1)
    D1 = c(6)*class1(i,1)^2 + c(5)*class1(i,1)*class1(i,2) + c(4)*class1(i,2)^2 + c(3)*class1(i,1) + c(2)*class1(i,2) + c(1);
    if(D1<0)
        err1=err1+1;
    end
    D2 = c(6)*class2(i,1)^2 + c(5)*class2(i,1)*class2(i,2) + c(4)*class2(i,2)^2 + c(3)*class2(i,1) + c(2)*class2(i,2) + c(1);
    if(D2>0)
        err2=err2+1;
    end
end
err1;
err2;
P = 1 - (err1+err2)/(n(1) + n(2));
% Построение графика
if pr == 2 
    tmin = min(min(class1(:)), min(class2(:)));
    tmax = max(max(class1(:)), max(class2(:)));
    p = 1000;
    i = 1;
    for t=tmin:((tmax-tmin)/p):tmax,
        z(i) = t;
        X = z(i);
        Y1(i) = (-(c(5) * X + c(2))+((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
        Y2(i) = (-(c(5) * X + c(2))-((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
        i=i+1;
    end
    arrayInd = [];
    arrayCount = 1;
    flagImag = false;
    zLen = length(z);
    for i = 1:zLen
        if isreal(Y1(i)) == 0
            arrayInd(arrayCount) = i;
            arrayCount = arrayCount + 1;
            flagImag = true;
        end
    end
    for i = length(arrayInd):-1:1
        z(arrayInd(i)) = [];
        Y1(arrayInd(i)) = [];
        Y2(arrayInd(i)) = [];
    end
    
    figure(50);
    plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');
    hold on;
    plot(z,Y1,'-k');
    plot(z,Y2,'-k');
    if flagImag
        zLen = length(z);
%         Соединить концы  Y1 и Y2
        plot([z(1), z(1)],[Y1(1), Y2(1)],'-k');
        plot([z(zLen), z(zLen)],[Y1(zLen), Y2(zLen)],'-k');
    end
end
clear global kr Acell;
