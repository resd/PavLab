function [ res ] = NS( cl1, cl2, pr )
%NS Summary of this function goes here
%   Detailed explanation goes here
%-------------------------------------LAB6
% for i = len-1: -1 :2
%     cl1 = getcl(i-1);
%     cl2 = getcli(i, len);
% end

%настройки программы
%n=2;        %количество признаков в классах
%N=20;      %количество объектов в обучающей выборке
%s=20;       %количество циклов обучения
n1 = length(cl1);
n2 = length(cl2);
N = n1 + n2;

%настройки алгоритма
err1 = 0;   %ошибка первого рода
err2 = 0;   %ошибка вторгог рода
P = 0;      %вероатность правильного распознаваниа

%todo
%отображение элементов статистической выборки в пространстве признаков X1, X2
%figure(12);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');hold on;

y(1:n1)=0;
y(n1+1:n1+n2)=1;

X=[cl1; cl2];

X = X'
y

%создание нейронной сети
%minmax(X) - матрица размерностью nx2 минимальных и максимальных значений вектора X
%[3,2] - количество нейронов в первом и втором слоах
%{'tansig','purelin'} - активационные функции слоев
net=newff(minmax(X),[20,1],{'tansig','purelin'});
%net=newff(minmax(X),[20,1],{'tansig','tansig','purelin'},'traingd');


%Настройка обучениа сети
net.trainParam.show = 20;       %врема обновлениа графика обучениа сети
net.trainParam.lr = 0.01;
net.trainParam.epochs = 100;    %врема обучениа сети
net.trainParam.goal = 5e-2;     %точность обучениа сети

%обучение сети обратного распространениа
[net,tr]=train(net,X,y);

%определение ошибок 1 и 2 рода и вероатности правильного распознаваниа
s = sim(net,X);

s1 = s(1,1:N);
%s1

err1=0;
err2=0;
for i=1:1:(N)
    if (i<(N+1))&&(s1(i)>1)% todo Изменил здесь с 0.5 на 1
        err1=err1+1;
    end
    if (i>N)&&(s1(i)<1)% и здесь с 0.5 на 1 
        err2=err2+1;
    end
end
tppr = (1 - (err1 + err2) / (n1 + n2)) * 100.0;

tppr
err1
err2
res(1) = tppr;
res(2) = err1;
res(3) = err2;
end
