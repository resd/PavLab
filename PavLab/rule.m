function [ solver, c ] = rule( class1, class2, pr, mod )
%RULE Summary of this function goes here
%   Detailed explanation goes here
% clc;
% ws = load ('classes.mat');
% pr = 10; % 5 <; 7 <; 9 <;
% class1 = ws.class1(:, 1:pr);
% class2 = ws.class2(:, 1:pr);
% Amain(class1, class2, pr)
% mod = true;
class = [class1; class2];
format short;
M1 = mean(class1);
M2 = mean(class2);
n1 = length(class1);
n2 = length(class2);
N = n1 + n2;
err1=0;
err2=0;
S1 = cov(class1);
S2 = cov(class2);
AS1 = inv(S1);
AS2 = inv(S2);
DS1 = det(S1); % 81.0000   30.0000    8.0000 
DS2 = det(S2); % 0.3000    0.0800    -0.1021
% a(6) = 0.5*(AS2(1,1) - AS1(1,1));
% a(5) = (AS2(1,2) - AS1(1,2));
% a(4) = 0.5*(AS2(2,2) - AS1(2,2));
% b1 = AS1*M1' - AS2*M2';
% a(3) = b1(1);
% a(2) = b1(2);
% a(1) = -0.5*(M1*AS1*M1' - M2*AS2*M2') + 0.5*log(DS2/DS1);
at = 0.5 * (AS2 - AS1);
amCount = 1;
for i = 1:pr
    for j = i:pr
        if j == i
            am(amCount) = at(i,j);
        else
            am(amCount) = 2 * at(i,j);
        end
        amCount = amCount + 1;
    end
end
am;
bt = AS1*M1' - AS2*M2';
bt = bt';
c1t = -0.5*(M1*AS1*M1' - M2*AS2*M2') + 0.5*log(DS2/DS1);
% c = [c1t, bt(1,1),bt(1,2),at(2,2),2*at(1,2),at(1,1)];
% ctt = [ c1t , bt(1,:), am(1,length(am):-1:1)];
% ctt = ctt(1, length(ctt):-1:1);
ctt = [am(1, :), bt(1,:),c1t];
% a
% c
ctt;
length(ctt);
% a = c;
c = ctt;

% ѕредварительные вычисление
x = [];
for (j = 1:N)
    xCount = 1;
    for i = 1:pr
        for k = i:pr
             x(j, xCount) = class(j,k) * class(j,i);
             xCount = xCount + 1;
        end
    end
    for i = 1:pr
        x(j, xCount) = class(j, i);
        xCount = xCount + 1;
    end
    x(j, xCount) = 1;
end
class1 = class(1:n1, :);
class2 = class(n1+1:n1+n2, :);

%find errors
% 2.5
for i=1:n1
%     d1(i)=a(6)*class1(i,1)^2+a(5)*class1(i,1)*class1(i,2)+a(4)*class1(i,2)^2+a(3)*class1(i,1)+a(2)*class1(i,2)+a(1);
    di1(i) = x(i, :) * c';
    if(di1(i)<0)
        err1=err1+1;
    end
end
for i=1:n2
%     d2(i)=a(6)*class2(i,1)^2+a(5)*class2(i,1)*class2(i,2)+a(4)*class2(i,2)^2+a(3)*class2(i,1)+a(2)*class2(i,2)+a(1);
    di2(i) = x(i+n1, :) * c';
    if(di2(i)>0)
        err2=err2+1;
    end
end
S12 = err1/n1 * 100;
S22 = err2/n2 * 100;
P1 = (1 - (err1+err2)/(n1+n2))*100;
solver = [P1 err1 err2 S12 S22];

%modificate ruler
%sort d array
if (mod)
d=sort( [di1 di2]);
P2Max = 0;
dk = 0;
for k=1:(n1+n2)
    err1_2 = 0;
    err2_2 = 0;
    for i=1:n1
%         d1_2(i)=a(6)*class1(i,1)^2+a(5)*class1(i,1)*class1(i,2)+a(4)*class1(i,2)^2+a(3)*class1(i,1)+a(2)*class1(i,2)+a(1)+d(k);
        di1(i) = x(i, :) * c' + d(k);
        if(di1(i)<0)
            err1_2=err1_2+1;
        end
    end
    for i = 1:n2
%         d2_2(i)=a(6)*class2(i,1)^2+a(5)*class2(i,1)*class2(i,2)+a(4)*class2(i,2)^2+a(3)*class2(i,1)+a(2)*class2(i,2)+a(1)+d(k);
        di2(i) = x(i+n1, :) * c' + d(k);
        if(di2(i)>0)
            err2_2=err2_2+1;
        end
    end
    P2(k) = 1 - (err1_2+err2_2)/(n1+n2);
    if P2(k) > P2Max
        P2Max = P2(k);
        err1 = err1_2;
        err2 = err2_2;
        dk = d(k);
    end
end
P2p = P2';
P1 = (1 - (err1+err2)/(n1+n2))*100;
S12 = err1/n1 * 100;
S22 = err2/n2 * 100;
c(length(c)) = c(length(c)) + dk; % todo change to c
solver = [P1 err1 err2 S12 S22 dk];
end

c = c(1, length(c):-1:1);
% 2.4
% ќтображение полинома в пространстве признаков
% if pr == 2
%     tmin = min(min(class1(:)), min(class2(:)));
%     tmax = max(max(class1(:)), max(class2(:)));
%     p = 1000;
%     i=1;
%     a = c; % todo rename
%     for t=tmin:((tmax-tmin)/p):tmax,
%         z(i) = t;
%         X = z(i);
%         Y1(i) = (-(a(5) * X + a(2))+((a(5) * X + a(2)).^2 - 4 * a(4) * (a(6) * X.^2 + a(3) * X + a(1))).^0.5)/(2 * a(4));
%         Y2(i) = (-(a(5) * X + a(2))-((a(5) * X + a(2)).^2 - 4 * a(4) * (a(6) * X.^2 + a(3) * X + a(1))).^0.5)/(2 * a(4));
%         i=i+1;
%     end
%     arrayInd = [];
%     arrayCount = 1;
%     flagImag = false;
%     flagAllImg = false;
%     zLen = length(z);
%     for i = 1:zLen
%         if isreal(Y1(i)) == 0
%             arrayInd(arrayCount) = i;
%             arrayCount = arrayCount + 1;
%             flagImag = true;
%         end
%     end
%     if zLen == length(arrayInd)
%         flagAllImg = true;
%     end
%     for i = length(arrayInd):-1:1
%         z(arrayInd(i)) = [];
%         Y1(arrayInd(i)) = [];
%         Y2(arrayInd(i)) = [];
%     end
%     figure(2);
%     plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');
%     hold on;
%     legend('Ёлементы 1 класса', 'Ёлементы 2 класса');
%     if ~flagAllImg
%         plot(z,real(Y1),'-k');
%         plot(z,real(Y2),'-k');
%         if flagImag
%             zLen = length(z);
% %            —оеденить конци  Y1 и Y2
%             plot([z(1), z(1)],[Y1(1), Y2(1)],'-k');
%             plot([z(zLen), z(zLen)],[Y1(zLen), Y2(zLen)],'-k');
%         end
%     end
%     hold off;    
% end