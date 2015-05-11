function [ res, c0, cmax ] = MSA( class1, class2, pr , vers )
%MSAOLD Summary of this function goes here
%   Detailed explanation goes here
clc;

% vers = 2; % 1 - ���; 2 - ����
% ws = load ('classessss_3.mat');
% class1 = ws.class1;
% class2 = ws.class2;

% ���������� ����������

Imax = 20; % ���������� ������ ��������
class1M = mean(class1);
class2M = mean(class2);
cnum = 6;
c=[]; % ������ �������������
if(vers == 1)
    c(1:cnum) = 1;
else
    S1 = cov(class1);
    S2 = cov(class2);
    AS1 = inv(S1);
    AS2 = inv(S2);
    DS1 = cond(S1);
    DS2 = cond(S2);
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
for i = 1:n1+n2
    if mod(i, 2) == 1
        class(i, :) = class1(nn1,:);
        y(yn)=1;
        nn1=nn1+1;
        yn = yn+1;
    else
        class(i, :) = class2(nn2,:);
        y(yn)=-1;
        nn2=nn2+1;
        yn = yn+1;
    end
end
Pmax = 0;
err1max=0;
err2max=0;
iimax=0;
jjmax=0;
cmax=[];

% ��������������� ����������

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

% ������������ ��������� ������ �������������� �������������

for (ii = 1:Imax)
    for (j = 1:N)
        % ����������� ����������� ���������� � �������� �������
        % ������������� ��� �������������
        sum = c*x(j,:)';
        ysum = y(j) - sum;
        r(1:cnum, 1:cnum) = 0;
        if(((y(j) > 0) && (ysum > 0)) || ((y(j) < 0) && (ysum < 0)))
            for(k=1:cnum)
                c(k) = c(k)+G(j, k)*ysum*x(j, k);
            end
        end
        
        % ���������� ����������� ����������� �������������
        err1 = 0;
        err2 = 0;
        P = 0;
        for i=1:n1
            D1 = c(6)*class1(i,1)^2 + c(5)*class1(i,1)*class1(i,2) + c(4)*class1(i,2)^2 + c(3)*class1(i,1) + c(2)*class1(i,2) + c(1);
            if(D1<0)
                err1=err1+1;
            end
            D2 = c(6)*class2(i,1)^2 + c(5)*class2(i,1)*class2(i,2) + c(4)*class2(i,2)^2 + c(3)*class2(i,1) + c(2)*class2(i,2) + c(1);
            if(D2>0)
                err2=err2+1;
            end
        end
        P = 1 - (err1+err2)/N;
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

% ����������� �������� � ������������ ���������
if pr == 2 
    tmin = min(min(class1(:)), min(class2(:)));
    tmax = max(max(class1(:)), max(class2(:)));
    c = cmax;
    p = 20;
    i = 1;
    for t=tmin:((tmax-tmin)/p):tmax,
        z(i) = t;
        X = z(i);
        Y1(i) = (-(c(5) * X + c(2))+((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
        Y2(i) = (-(c(5) * X + c(2))-((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
        i=i+1;
    end
    figure(21);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');
    hold on;
    % ��� ���
    plot(z,real(Y1),'-k');
    plot(z,real(Y2),'-k');
    % plot(z,imag(Y1),'-k');
    % plot(z,imag(Y2),'-k');
end

res(1) = Pmax*100;
res(2) = err1max;
res(3) = err2max;
res(4) = iimax;
res(5) = jjmax;
end

