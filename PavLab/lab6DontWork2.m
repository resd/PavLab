function [ output_args ] = lab6DontWork2( class1, class2, pr )
%-------------------------------------LAB6
clc;
clear all;
% s=sprintf('%s','LAB6:');disp(s);

%настройки программы

%настройки алгоритма
eps = 0.1;
err1 = 0;   %ошибка первого рода
err2 = 0;   %ошибка вторгог рода
P = 0;      %вероатность правильного распознаваниа
ws = load ('classessss1.mat');
class1 = ws.class1(1:2, :);
class2 = ws.class2(1:2, :);
pr = 2;
% Amain(class1, class2, pr)
n1 = length(class1);
n2 = length(class2);
N = n1 + n2;%количество объектов в обучающей выборке
%todo
%отображение элементов статистической выборки в пространстве признаков X1, X2
%figure(12);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');hold on;

yp(1:n1,1)=0;
yp(1:n1,2)=1;
yp1 = yp';
yp = [];
yp(1:n2,1)=1;
yp(1:n2,2)=0;
yp2 = yp';
yn  = 1;
nn1 = 1;
nn2 = 1;
y2 = zeros(N,pr);
for i = 1:N
    if mod(i, 2) == 1 % ≈сли остаток от делени€ равен 1
        class(i, :) = class1(nn1,:);
        y2(yn, 2)   = 1;
        nn1         = nn1+1;
        yn          = yn+1;
    else
        class(i, :) = class2(nn2,:);
        y2(yn, 1)   = 1;
        nn2         = nn2+1;
        yn          = yn+1;
    end
end
% [2, 200]
% X=[class1; class2]';

X = class';
y = y2';
% y

%создание нейронной сети
%minmax(X) - матрица размерностью nx2 минимальных и максимальных значений вектора X
%[3,2] - количество нейронов в первом и втором слоах
%{'tansig','purelin'} - активационные функции слоев
% net=newff(minmax(X),[200,1],{'tansig','purelin'});
% net=newff(minmax(X),[200,2],{'tansig','tansig','purelin'},'traingd');
net=newff(minmax(X),[N,pr],{'tansig','tansig'},'traingd');


%Ќастройка обучениа сети
net.trainParam.show = 1;       %врема обновлениа графика обучениа сети
net.trainParam.lr = 0.01;       
net.trainParam.epochs = 100;    %врема обучениа сети
net.trainParam.goal = 0;     %точность обучениа сети

%обучение сети обратного распространениа
[net, tr, yy, e]=train(net,X,y);%, ye, ee

%определение ошибок 1 и 2 рода и вероатности правильного распознаваниа
s = sim(net,X);
s = s';
% size(s)
s1 = s(1:n1, :);
s2 = s(n1+1:N, :);
% s1
% net = train(net,p,t);

% y2 = sim(net,p);

% plot(p,t,'o',p,y1,'x',p,y2,'*')
tt = minmax(X);
tmin = min(tt(:));
tmax = max(tt(:));
tminmax = [tmin, tmax];
pcolor = 'm';
%plot(X,y,'o', 'Color','r');
figure(1);
hold on;
title('Class 1');
plot(class1(:, 1)',yp1(1, :),'o', 'Color','r');
plot(class1(:, 2)',yp1(2, :),'o', 'Color','b');
plot(class1(:, 1)',s1(:, 1)','x', 'Color','r');
plot(class1(:, 2)',s1(:, 2)','x', 'Color','b');
legend('»сходное значение 1 класса дл€ 1 признака', '»сходное значение 1 класса дл€ 2 признака',...
    'Ќайденное значение 1 класса дл€ 1 признака', 'Ќайденное значение 1 класса дл€ 2 признака');
plot(tminmax,[1+eps,1+eps],'Color',pcolor,'LineWidth',1)
plot(tminmax,[1-eps,1-eps],'Color',pcolor,'LineWidth',1)
plot(tminmax,[0+eps,0+eps],'Color',pcolor,'LineWidth',1)
plot(tminmax,[0-eps,0-eps],'Color',pcolor,'LineWidth',1)
% plot(X,s,'x');
figure(2);
hold on;
title('Class 2');
plot(class2(:, 1)',yp2(1, :),'o', 'Color','r');
plot(class2(:, 2)',yp2(2, :),'o', 'Color','b');
plot(class2(:, 1)',s2(:, 1)','x', 'Color','r');
plot(class2(:, 2)',s2(:, 2)','x', 'Color','b');
legend('»сходное значение 2 класса дл€ 1 признака', '»сходное значение 2 класса дл€ 2 признака',...
    'Ќайденное значение 2 класса дл€ 1 признака', 'Ќайденное значение 2 класса дл€ 2 признака');
plot(tminmax,[1+eps,1+eps],'Color',pcolor,'LineWidth',1)
plot(tminmax,[1-eps,1-eps],'Color',pcolor,'LineWidth',1)
plot(tminmax,[0+eps,0+eps],'Color',pcolor,'LineWidth',1)
plot(tminmax,[0-eps,0-eps],'Color',pcolor,'LineWidth',1)
% plot(class1(:,1),class1(:,2),'ro');
% plot(class2(:,1),class2(:,2),'b+');
% plot(s1(:,1),s1(:,2),'m*');
% plot(s2(:,1),s2(:,2),'gx');


err1=0;
err2=0;
% abs(s1(1,i)-t(1,i)) > 0.01
% y1 = [0, 1]
% y2 = [1, 0]
% s1 = [-0.1/0.1, 0.9/1.1]
% s2 = [0.9/1.1, -0.1/0.1]
for i=1:1:(N)
    % (mod(ii, 2) == 1)&&
    if (mod(i, 2) == 1)&&(s(i,1) > 0 + eps || s(i,1) < 0- eps || ...
            s(i,2) > 1 + eps || s(i,2) < 1 - eps)
        err1=err1+1;
    end
    if (mod(i, 2) == 0)&&(s(i,1) > 1 + eps || s(i,1) < 1 - eps || ...
            s(i,2) > 0 + eps || s(i,2) < 0 - eps)
        err2=err2+1;
    end
end
err1
err2
err1 = 0;
err2 = 0;
for i=1:1:(N)
    % (mod(ii, 2) == 1)&&
    if (mod(i, 2) == 1)&&(s(i,1) > 0 + eps || s(i,1) < 0- eps || ...
            s(i,2) > 1 + eps || s(i,2) < 1 - eps)
        err1=err1+1;
    end
    if (mod(i, 2) == 0)&&(s(i,1) > 1 + eps || s(i,1) < 1 - eps || ...
            s(i,2) > 0 + eps || s(i,2) < 0 - eps)
        err2=err2+1;
    end
end

tppr = (1 - (err1 + err2) / N) * 100.0;

err1
err2
tppr