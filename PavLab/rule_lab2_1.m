function [solver, a] = rule_lab2_1( class1, class2 )
%UNTITLED Summary of this function goes here
% Detailed explanation goes here
M1 = mean(class1);
M2 = mean(class2);
n1 = length(class1);
n2 = length(class2);
nMin = min(n1,n2);
err1=0;
err2=0;
err1_2=0;
err2_2=0;
err1_3=0;
err2_3=0;
S1 = cov(class1);
S2 = cov(class2);
AS1 = inv(S1);
AS2 = inv(S2);
DS1 = det(S1);
DS2 = det(S2);
c = 0.5*log(DS2/DS1);
a6 = 0.5*(AS2(1,1) - AS1(1,1));
a5 = (AS2(1,2) - AS1(1,2));
a4 = 0.5*(AS2(2,2) - AS1(2,2));
b1 = AS1*M1' - AS2*M2';
a3 = b1(1);
a2 = b1(2);
a1 = -0.5*(M1*AS1*M1' - M2*AS2*M2') + 0.5*log(DS2/DS1);
tmin = min(class1(:,1));
tmax = max(class2(:,1));
tt1 = min(class1, class2);
tt2 = max(class1, class2);
t1 = min(tt1);
t2 = max(tt2);
t1 = min(t1);
t2 = max(t2);
tmin = t1;
tmax = t2;
i=1;
% 2.4
for t=tmin:((tmax-tmin)/(nMin-1)):tmax,
    z(i) = t;
    X = z(i);
    Y1(i) = (-(a5 * X + a2)+((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
    Y2(i) = (-(a5 * X + a2)-((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
    i=i+1;
end
%find errors
% 2.5
for i=1:n1
    d1(i)=a6*class1(i,1)^2+a5*class1(i,1)*class1(i,2)+a4*class1(i,2)^2+a3*class1(i,1)+a2*class1(i,2)+a1;
    if(d1(i)<0)
        err1=err1+1;
    end
end
for i=1:n2
    d2(i)=a6*class2(i,1)^2+a5*class2(i,1)*class2(i,2)+a4*class2(i,2)^2+a3*class2(i,1)+a2*class2(i,2)+a1;
    if(d2(i)>0)
        err2=err2+1;
    end
end
%modificate ruler
%sort d array
d=sort( [d1 d2]);
% 2.6
for k=1:(n1+n2)
    for i=1:n1
        d1_2(i)=a6*class1(i,1)^2+a5*class1(i,1)*class1(i,2)+a4*class1(i,2)^2+a3*class1(i,1)+a2*class1(i,2)+a1+d(k);
        if(d1_2(i)<0)
            err1_2=err1_2+1;
        end
    end
    for i = 1:n2
        d2_2(i)=a6*class2(i,1)^2+a5*class2(i,1)*class2(i,2)+a4*class2(i,2)^2+a3*class2(i,1)+a2*class2(i,2)+a1+d(k);
        if(d2_2(i)>0)
            err2_2=err2_2+1;
        end
    end
    P2(k) = 1 - (err1_2+err2_2)/(n1+n2);
    S12(k) = err1/n1;
    S22(k) = err2/n2; 
end
P2;
p222=max(P2);
u=1;
for j=1:length(P2)
    if (P2(j)== p222)
        O=u;
        break;
    else
        u=u+1;
    end
end
% P2(O)
% S12(O)
% S22(O)
% % 2.6 (2)
% d(1)
for i=1:n1
    d1_3(i)=a6*class1(i,1)^2+a5*class1(i,1)*class1(i,2)+a4*class1(i,2)^2+a3*class1(i,1)+a2*class1(i,2)+a1+d(O);
    if(d1_3(i)<0)
        err1_3=err1_3+1;
    end
end
for i=1:n2
    d2_3(i)=a6*class2(i,1)^2+a5*class2(i,1)*class2(i,2)+a4*class2(i,2)^2+a3*class2(i,1)+a2*class2(i,2)+a1+d(O);
    if(d2_3(i)>0)
        err2_3=err2_3+1;
    end
end
P1 = (1 - (err1+err2)/(n1+n2))*100;
PM = (1 - (err1_3+err2_3)/(n1+n2));%*100);
S1 = err1;
S2 = err2;
S1M =err1_3;
S2M = err2_3;
solver = [P1 S1 S2 PM S1M S2M];
a(1) = a1;
a(2) = a2;
a(3) = a3;
a(4) = a4;
a(5) = a5;
a(6) = a6;
a(7) = c;
figure(2);
plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+',z,Y1,'-k', z,Y2,'-k');
%hold on;
end