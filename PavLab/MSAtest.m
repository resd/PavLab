function [ res, c0, cmax ] = MSAtest( class1, class2, pr , vers )
%MSAOLD Summary of this function goes here
%   Detailed explanation goes here
clc;
clear global;
global ca;
vers = 1;
ws = load ('classessss2.mat');
class1 = ws.class1;
class2 = ws.class2;
pr = 2;


class1D = var(class1);
class2D = var(class2);
class1M = mean(class1);
class2M = mean(class2);
% class1D = [0.7, 1.1];
% class2D = [0.9, 1.0];
% class1M = [1.8, 1.1];
% class2M = [4.3, 2.7];
% class1 = uniformClass(2, 100, class1M, class1D);
% class2 = uniformClass(2, 100, class2M, class2D);
% save ('classessss2.mat', 'class1', 'class2');
cnum = 6;
Imax = 20;
c=[];
S1 = cov(class1);
S2 = cov(class2); 
AS1 = inv(S1);
AS2 = inv(S2);
DS1 = cond(S1);
DS2 = cond(S2);
if(vers == 1)
    c(1:cnum) = 1;
else
    a = 0.5 * (AS2 - AS1);
    b = AS1*class1M' - AS2*class2M';
    c1 = -0.5*(class1M*AS1*class1M' - class2M*AS2*class2M') + 0.5*log(DS2/DS1);
    c = [c1, b(2,1),b(1,1),a(2,2),2*a(1,2),a(1,1)];
end
c0 = c;
n1 = length(class1);
n2 = length(class2);
N = n1+n2;
nn1 = 1;
nn2 = 1;
yn = 1;
% y(1:n1)=1;
% y(n1+1:n1+n2)=-1;

for i = 1:n1+n2
    if mod(i, 2) == 1
        class(i, :) = class1(nn1,:);
        y(yn) = 1;
        nn1 = nn1+1;
        yn = yn+1;
    else
        class(i, :) = class2(nn2,:);
        y(yn) = -1;
        nn2 = nn2+1;
        yn = yn+1;
    end
end

% class = [class1; class2];
Pmax = 0;
err1max=0;
err2max=0;
iimax=0;
jjmax=0;
cmax=[];
ca = [];
cc = [];
% Предварительные вычисление
x = [];
for (j = 1:N)
    x(j, 6) = class(j,1)*class(j,1);
    x(j, 5) = class(j,1)*class(j,2);
    x(j, 4) = class(j,2)*class(j,2);
    x(j, 3) = class(j,1);
    x(j, 2) = class(j,2);
    x(j, 1) = 1;
    q=0;
    r(1:cnum, 1:cnum) = 0;
    for(k=1:cnum)
        for(t=1:cnum)
            r(k,t)=x(j, k)*x(j, t);
            q=q+r(k,t)*r(k,t);
            if(k==t)
                s=r(k,t);
            end
        end
        G(j, k) = s/q;
    end
end
% Итерационная процедура метода стохастической аппроксимации
for (ii = 1:Imax)
    for (j = 1:N)
        sum = c*x(j,:)';
        ysum = y(j) - sum;
        r(1:cnum, 1:cnum) = 0;
        if(((y(j) > 0) && (ysum > 0)) || ((y(j) < 0) && (ysum < 0)))
%         if(((y(jj) > 0) & (ysum < 0)) | ((y(jj) < 0) & (ysum > 0)))
%         if(((y(jj) > 0) && (sum < 0)) || ((y(jj) < 0) && (sum > 0)))
            q=0;
            for(k=1:cnum)
                c(k) = c(k)+G(j, k)*ysum*x(j, k);
            end
        end
        
        %вычисление параметров качества распознаваниа
        err1 = 0;
        err2 = 0;
        P = 0;
        for i=1:n1
            f(i,1) = c(6)*class1(i,1)^2 + c(5)*class1(i,1)*class1(i,2) + c(4)*class1(i,2)^2 + c(3)*class1(i,1) + c(2)*class1(i,2) + c(1);
%             x1 = [1 class1(i, 1) class1(i, 2) class1(i, 1)*class1(i, 1) class1(i, 1) * class1(i, 2) class1(i, 2)* class1(i, 2)];
%             f(i,1) = x1*c';
%             x1, f(i,1)
            if(f(i,1)<0)
                err1=err1+1;
            end
            
%             x2 = [1 class2(i, 1) class2(i, 2) class2(i, 1)*class2(i, 1) class2(i, 1) * class2(i, 2) class2(i, 2)* class2(i, 2)];
%             f(i+n1,1) = x2*c';
%             x2, f(i+n1,1)
            f(i+n1,1) = c(6)*class2(i,1)^2 + c(5)*class2(i,1)*class2(i,2) + c(4)*class2(i,2)^2 + c(3)*class2(i,1) + c(2)*class2(i,2) + c(1);
            if(f(i+n1,1)>0)
                err2=err2+1;
            end
        end
        
        err1;
        err2;
        P = 1 - (err1+err2)/N
        ca (ii, j) = P;
        cc{ii, j} = c;
        if (P > Pmax)
            Pmax=P;
            err1max=err1;
            err2max=err2;
            iimax=ii;
            jjmax=j;
            cmax=c;
        end
    end
    end
ca = ca';
cc = cc';
cmax 

% err1 = 0;
% err2 = 0;
% P = 0;
% l=[0.996388 0.937562 0.938447 -0.007734 -0.049929 -0.074972 ];
%c =[ l(1),l(3),l(2),l(6),l(5),l(4)];
%c = [-0.907631 0.776168  -0.570490 3.878084  -1.733026 -2.374465];
% for i=1:n1
%     f(i,1) = c(6)*class1(i,1)^2 + c(5)*class1(i,1)*class1(i,2) + c(4)*class1(i,2)^2 + c(3)*class1(i,1) + c(2)*class1(i,2) + c(1);
%     if(f(i,1)<0)
%         err1=err1+1;
%     end
%     
%     f(i+n1,1) = c(6)*class2(i,1)^2 + c(5)*class2(i,1)*class2(i,2) + c(4)*class2(i,2)^2 + c(3)*class2(i,1) + c(2)*class2(i,2) + c(1);
%     if(f(i+n1,1)>0)
%         err2=err2+1;
%     end
% end
% 
% err1;
% err2;
% P = 1 - (err1+err2)/N

%отображение полинома в пространстве признаков

X1 = class1M(1)+(class2M(1)-class1M(1))/2;
X2 = class1M(2)+(class2M(2)-class1M(2))/2;
k = -(class1M(1)-class2M(1))/(class1M(2)-class2M(2));
bb = X2-X1*k;
tmin = min(class1(:,1));
tmax = max(class2(:,1));
tt1 = min(class1);
tt2 = max(class2);
t1 = min(tt1);
t2 = max(tt2);
tmin = t1;
tmax = t2;
X2min = k*tmin + bb;
X2max = k*tmax + bb;
p = 20;
i = 1;
c = cmax;
for t=tmin:((tmax-tmin)/p):tmax,
    z(i) = t;
    X = z(i);
    Y1(i) = (-(c(5) * X + c(2))+((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
    Y2(i) = (-(c(5) * X + c(2))-((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
    i=i+1;
end
% figure(21);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');hold on;

Amain(class1, class2, 2)
res(1) = Pmax;
res(2) = err1max;
res(3) = err2max;
res(4) = iimax;
res(5) = jjmax;
% res
end

