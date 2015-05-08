function [ res, outf, c, cmax] = MSAnew( class1, class2, pr , vers)
%MSA Summary of this function goes here
%   Detailed explanation goes here
%������������� ��������
%Imax = 20 � ���������� ������ ��������
%L=L1+L2 � ���������� ��������� � ��������� �������
%� � ������ ������������� ������������� ���������������� ������������ cnum
Imax = 200;
L = 100;
p=20;
Pmax = 0;
err1max=0;
err2max=0;
iimax=0;
jjmax=0;
cmax=[];

warning('off', 'all');

clc;
vers = 2;
ws = load ('classessss.mat');
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
% save ('classessss.mat', 'class1', 'class2');

n1 = length(class1);
n2 = length(class2);
cnum = 6; % todo
nn1 = 1;
nn2 = 1;
% if n1 > n2
%     for i = 1:n2
%         if mod(i, 2) == 1
%             class(i, :) = class2(nn2,:);
%             nn2=nn2+1;
%         else
%             class(i, :) = class1(nn1,:);
%             nn1=nn1+1;
%         end
%     end
%     for i = n2+1:n1+n2
%         class(i,:) = class1(i,:);
%     end
% else if n2 > n1
%         for i = 1:n1
%             if mod(i, 2) == 1
%                 class(i, :) = class1(nn1,:);
%                 nn1=nn1+1;
%             else
%                 class(i, :) = class2(nn2,:);
%                 nn2=nn2+1;
%             end
%         end
%         for i = n1+1:n2+n1
%             class(i,:) = class2(i,:);
%         end
%     else
%         for i = 1:n1+n2
%             if mod(i, 2) == 1
%                 class(i, :) = class1(nn1,:);
%                 nn1=nn1+1;
%             else
%                 class(i, :) = class2(nn2,:);
%                 nn2=nn2+1;
%             end
%         end
%     end
% end



    %class = [class1; class2];
% c(1:cnum) = 1;

%cmax(6) = 0.5*(AS2(1,1) - AS1(1,1));
%cmax(5) = (AS2(1,2) - AS1(1,2));
%cmax(4) = 0.5*(AS2(2,2) - AS1(2,2));
%b1 = AS1*class1M' - AS2*class2M';
%cmax(3) = b1(1);
%cmax(2) = b1(2);
%cmax(1)=-0.5*(class1M*AS1*class1M'-class2M*AS2*class2M')+� 0.5*log(DS2/DS1);

S1 = cov(class1);
S2 = cov(class2);

AS1 = inv(S1);
AS2 = inv(S2);

% DS1 = cond(S1);
% DS2 = cond(S2);

DS1 = det(S1);
DS2 = det(S2);

kk = 0.5*log(DS2/DS1);
a6 = 0.5*(AS2(1,1) - AS1(1,1));
a5 = (AS2(1,2) - AS1(1,2));
a4 = 0.5*(AS2(2,2) - AS1(2,2));
b1 = AS1*class1M' - AS2*class2M';
a3 = b1(1);
a2 = b1(2);
a1 = -0.5*(class1M*AS1*class1M' - class2M*AS2*class2M') + 0.5*log(DS2/DS1);

c=[];
if(vers == 1)
    c(1:cnum) = 1;
else
    a = 0.5 * (AS2 - AS1);
    b = AS1*class1M' - AS2*class2M';
    c1 = -0.5*(class1M*AS1*class1M' - class2M*AS2*class2M') + 0.5*log(DS2/DS1);
    
    % a, b, c1
%     c = [a(1,1), 2*a(1,2), a(2,2), b(1,1), b(2,1), c1];
    c = [c1, b(2,1),b(1,1),a(2,2),2*a(1,2),a(1,1)];
end
X1 = class1M(1)+(class2M(1)-class1M(1))/2;
X2 = class1M(2)+(class2M(2)-class1M(2))/2;
k = -(class1M(1)-class2M(1))/(class1M(2)-class2M(2));
bb = X2-X1*k;

tmin = min(class1(:,1));
tmax = max(class2(:,1));

X2min = k*tmin + bb;
X2max = k*tmax + bb;

y(1:n1)=1;
y(n1+1:n1+n2)=-1;

P = 0;
err1 = 0;
err2 = 0;

Pmax=0;
err1max=0;
err2max=0;
iimax=0;
jjmax=0;
cmax=0;
i = 1;
%     a = 0.5 * (AS2 - AS1);
%     b = AS1*class1M' - AS2*class2M';
%     c1 = -0.5*(class1M*AS1*class1M' - class2M*AS2*class2M') + 0.5*log(DS2/DS1);
%     
%     % a, b, c1
%     c = [a(1,1), 2*a(1,2), a(2,2), b(1,1), b(2,1), c1];
%     c
% for t=tmin:((tmax-tmin)/p):tmax,
%     z(i) = t;
%     X = z(i);
%     Y1(i) = (-(c(5) * X + c(2))+((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
%     Y2(i) = (-(c(5) * X + c(2))-((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
%     i=i+1;
% end
% figure(21);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');hold on;

% for t=tmin:((tmax-tmin)/p):tmax,
%     z(i) = t;
%     X = z(i);
%     Y1(i) = (-(c(2) * X + c(5))+((c(2) * X + c(5)).^2 - 4 * c(3) * (c(1) * X.^2 + c(4) * X + c(6))).^0.5)/(2 * c(3));
%     Y2(i) = (-(c(2) * X + c(5))-((c(2) * X + c(5)).^2 - 4 * c(3) * (c(1) * X.^2 + c(4) * X + c(6))).^0.5)/(2 * c(3));
%     i=i+1;
% end
% figure(21);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');hold on;
% 
% 
% i=1;
% a = [a1,a2,a3,a4,a5,a6]
% for t=tmin:((tmax-tmin)/p):tmax,
%     z(i) = t;
%     X = z(i);
%     Y1(i) = (-(a5 * X + a2)+((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
% 	Y2(i) = (-(a5 * X + a2)-((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
%     i=i+1;
% end
% figure(2122);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');hold on;
% Amain(class1,class2,2)
%������������ ��������� ������ �������������� �������������

%cmax = c;
class = [class1; class2];
err = 0;
for (ii = 1:Imax)
    for (jj = 1:n1)
        f = [];
        f(6) = class(jj,1)*class(jj,1);
        f(5) = class(jj,1)*class(jj,2);
        f(4) = class(jj,2)*class(jj,2);
        f(3) = class(jj,1);
        f(2) = class(jj,2);
        f(1) = 1;
        clc;
        %         c = cmax;
%         f
        %         c
        
        sum = f*c';
        ysum = y(jj) - sum;
        r(1:cnum, 1:cnum) = 0;
        
%         sum, ysum, y(jj) =====================================
        %         if (y(jj) > 0) && (ysum > 0)%(di<0 && y(jj) >0)
        %             err1=err1+1;
        %         end
        
        if(((y(jj) > 0) && (ysum > 0)) || ((y(jj) < 0) && (ysum < 0)))
            q=0;
            for(k=1:cnum)
                for(t=1:cnum)
                    r(k,t)=f(k)*f(t);
                    q=q+r(k,t)*r(k,t);
                    if(k==t)
                        s=r(k,t);
                    end
                end
                G = s/q;
                c(k) = c(k)+G*ysum*f(k);
            end
        else
            err1 = err1 + 1;
        end
    end
%     c
    for (jj = 1:n2)
        f = [];
        f(6) = class(jj,1)*class(jj,1);
        f(5) = class(jj,1)*class(jj,2);
        f(4) = class(jj,2)*class(jj,2);
        f(3) = class(jj,1);
        f(2) = class(jj,2);
        f(1) = 1;
%         clc;
%         f
%         c
        %         c = cmax;
        sum = f*c';
        ysum = y(jj) - sum;
        
        r(1:cnum, 1:cnum) = 0;
        
        di = c(1)*f(6) + c(2)*f(5) + c(3)*f(4) + c(4)*f(3) + c(5)*f(2) + c(6)*f(1);
        
        
        if(y(jj) < 0) && (ysum < 0)%(di>0  && y(jj) <0)
            err2=err2+1;
        end
        
        if(((y(jj) > 0) && (ysum > 0)) || ((y(jj) < 0) && (ysum < 0)))
            q=0;
            for(k=1:cnum)
                for(t=1:cnum)
                    r(k,t)=f(k)*f(t);
                    q=q+r(k,t)*r(k,t);
                    if(k==t)
                        s=r(k,t);
                    end
                end
                G = s/q;
                c(k) = c(k)+G*ysum*f(k);
            end
        else
            err2 = err2 + 1;
        end
    end
    err1 
    err2
    c
    %���������� ���������� �������� �������������
    %         err1 = 0;
    %         err2 = 0;
    
    %         for i=1:L
    % %             f(i,1) = a6*class1(i,1)^2 + a5*class1(i,1)*class1(i,2) + a4*class1(i,2)^2 + a3*class1(i,1) + a2*class1(i,2) + a1;
    %             f(i,1) =
    %             if(f(i,1)<0)
    %                 err1=err1+1;
    %             end
    %
    % %             f(i+L,1) = a6*class2(i,1)^2 + a5*class2(i,1)*class2(i,2) + a4*class2(i,2)^2 + a3*class2(i,1) + a2*class2(i,2) + a1;
    %             f(i+L,1)
    %             if(f(i+L,1)>0)
    %                 err2=err2+1;
    %             end
    %         end
    
    
    
    %����������� �������� � ������������ ���������
    %i=1;
    %         for t=tmin:((tmax-tmin)/p):tmax,
    %             z(i) = t;
    %             X = z(i);
    %             Y1(i) = (-(c(5) * X + c(2))+((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
    %             Y2(i) = (-(c(5) * X + c(2))+((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
    %             i=i+1;
    %         end
    %         figure(21);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');hold on;
    
    err1;
    err2;
    P = 1 - (err1+err2)/(2*L);
    if (P > Pmax)
        Pmax=P*100;
        err1max=err1;
        err2max=err2;
        %             iimax=ii;
        jjmax=jj;
        cmax=c;
    end
    err1 = 0;
    err2 = 0;
end
clc;
P*10000
err1
err2
c
i = 1;
for t=tmin:((tmax-tmin)/p):tmax,
    z(i) = t;
    X = z(i);
    Y1(i) = (-(c(5) * X + c(2))+((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
    Y2(i) = (-(c(5) * X + c(2))-((c(5) * X + c(2)).^2 - 4 * c(4) * (c(6) * X.^2 + c(3) * X + c(1))).^0.5)/(2 * c(4));
    i=i+1;
end
figure(21);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');hold on;

i=1;
for t=tmin:((tmax-tmin)/p):tmax,
    z(i) = t;
    X = z(i);
    Y1(i) = (-(a5 * X + a2)+((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
	Y2(i) = (-(a5 * X + a2)-((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
    i=i+1;
end
figure(2122);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');hold on;
Amain(class1,class2,2)
err1max
err2max
Pmax
iimax;
jjmax;
cmax;
res(1) = Pmax;
res(2) = err1max;
res(3) = err2max;
%res(4) = result(4); todo
outf = sprintf('�����������  =  %f\n������ 1 ����  =  %f\n������ 2 ����  =  %f\n', res(1), res(2), res(3));

%MSR(class1, class2, 2)

%res = Amain(class1, class2, 2);
end

