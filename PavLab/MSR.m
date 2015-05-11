function [ res, outf ] = MSR( class1, class2, pr )
%MSR Summary of this function goes here
%   Detailed explanation goes here
%определение статистических характеристик
%метода статистических решений
class1D = var(class1);
class2D = var(class2);
% class1M = [1.8, 1.1];
% class2M = [4.3, 2.7];

class1M = mean(class1);
class2M = mean(class2);


%масштабирование элементов статистической выборки согласно варианту (таблица 1) дла первого признака
% class1(:,1) = class1M(1) + class1D(1)*(class1(:,1));
% class2(:,1) = class2M(1) + class2D(1)*(class2(:,1));
% %дла равномерного закона распределения
% %class1(:,1) = class1M(1) + 6*class1D(1)*(class1(:,1)-0.5);
% %class2(:,1) = class2M(1) + 6*class2D(1)*(class2(:,1)-0.5);
% 
% %дла второго признака
% class1(:,2) = class1M(2) + class1D(2)*(class1(:,2));
% class2(:,2) = class2M(2) + class2D(2)*(class2(:,2));

S1 = cov(class1);        
S2 = cov(class2);

AS1 = inv(S1);
AS2 = inv(S2);

DS1 = COND(S1);
DS2 = COND(S2);

c = 0.5*log(DS2/DS1);
a6 = 0.5*(AS2(1,1) - AS1(1,1));
a5 = (AS2(1,2) - AS1(1,2));
a4 = 0.5*(AS2(2,2) - AS1(2,2));
b1 = AS1*class1M' - AS2*class2M';
a3 = b1(1);
a2 = b1(2);
a1 = -0.5*(class1M*AS1*class1M' - class2M*AS2*class2M') + 0.5*log(DS2/DS1);

% %отображение полинома в пространстве признаков
% i=1;
% for t=tmin:((tmax-tmin)/p):tmax,
%     z(i) = t;
%     X = z(i);
%     Y1(i) = (-(a5 * X + a2)+((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
% 	Y2(i) = (-(a5 * X + a2)-((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
%     i=i+1;
% end
% 
% %todo
% figure(21);plot(class1(:,1),class1(:,2),'b+',class2(:,1),class2(:,2),'ro', z,Y1,'-k',  z,Y2,'-k');hold on;

%вычисление параметров качества распознаваниа
err1 = 0;
err2 = 0;
P = 0;

n1 = length(class1);
n2 = length(class2);
N = n1 + n2;

j=-1;
for i=1:n1
    f(i,1)=0;
    f(i,2)=j;
end
j=1;
for i=n1+1:N
    f(i,1)=0;
    f(i,2)=j;
end

for i=1:n1
    f(i,1) = a6*class1(i,1)^2 + a5*class1(i,1)*class1(i,2) + a4*class1(i,2)^2 + a3*class1(i,1) + a2*class1(i,2) + a1;
    if(f(i,1)<0)
        err1=err1+1;    
    end
end
for i = 1 : n2
    f(i,1) = a6*class2(i,1)^2 + a5*class2(i,1)*class2(i,2) + a4*class2(i,2)^2 + a3*class2(i,1) + a2*class2(i,2) + a1;
    if(f(i,1)>0)
        err2=err2+1;    
    end
end

err1;
err2;
P = 1 - (err1+err2)/N;
res(1) = P;
res(2) = err1;
res(3) = err2;
%res(4) = result(4); todo
outf = sprintf('Вероятность  =  %f\nОшибка 1 рода  =  %f\nОшибка 2 рода  =  %f\n', res(1), res(2), res(3));

end

