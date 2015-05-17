function [  ] = lab5Testt(  )
clc;
ws = load ('classes10.mat');
class1 = ws.class1;
class2 = ws.class2;
pr = 1;
% Amain(class1, class2, pr)
n1 = length(class1);
n2 = length(class2);
N = n1 + n2;
X=[class1; class2];
y(1:n1,1)=0; % Второй столбец означает выход нейрона
y(n1 + 1:N,1)=1; % Кол-во столбцов равно кол-ву нейронов
y(1:n2,2)=1;
y(n2 + 1:N,2)=0;
% OneLayerPerc(X, y)
yn  = 1;
nn1 = 1;
nn2 = 1;
s = 2000; % S
Y = zeros(N,pr);
for i = 1:N
    if mod(i, 2) == 1 % Если остаток от деления равен 1
        class(i, :) = class1(nn1,:);
        Y(yn, 2)   = 1;
        nn1         = nn1+1;
        yn          = yn+1;
    else
        class(i, :) = class2(nn2,:);
        Y(yn, 1)   = 1;
        nn2         = nn2+1;
        yn          = yn+1;
    end
end
W=[1, 1; 1, 1];%; 1, 1
Pmax = 0;
err1max=0;
err2max=0;
jjmax=0;
Wmax=[];
flag = false;
for j=1:1:s
    err1 = 0;
    err2 = 0;
    for i=1:1:N
        s1 = class(i,:)*W(1,:)';
        s2 = class(i,:)*W(2,:)';
        if (s1>0)
            yy1 = 1;
        else
            yy1 = 0;
        end
        if (s2>0)
            yy2 = 1;
        else
            yy2 = 0;
        end
        y1=Y(i,1)-yy1;
        y2=Y(i,2)-yy2;
        if (mod(i, 2) == 1)&&((yy1==1)||(yy2==0)) % Если остаток от деления равен 1
            err1=err1+1;
            flag = true;
        end
        if (mod(i, 2) == 0)&&((yy1==0)||(yy2==1)) % Если остаток от деления равен 0
            err2=err2+1;
            flag = true;
        end
        if flag
        W(1,1) = W(1,1) + 0.1*y1*class(i,1);
        W(1,2) = W(1,2) + 0.1*y1*class(i,2);
        W(2,1) = W(2,1) + 0.1*y2*class(i,1);
        W(2,2) = W(2,2) + 0.1*y2*class(i,2);
        end
        flag = false;
    end
    P = 1 - (err1+err2)/N;
    if (P > Pmax)
        Pmax=P;
        err1max=err1;
        err2max=err2;
        jjmax=j;
        Wmax=W;
    end
    Pn(j) = P;
end

% Отображение полинома в пространстве признаков
w = Wmax(:);
plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');
hold on;
minX = round(min(min(min(class1, class2))));
maxX = round(max(max(max(class1, class2))));
z = minX:maxX;
x1 = w(2)/w(4);%w(3)/w(1);
x2 = 0;
y1 = 0;
y2 = w(1)/w(3);%w(4)/w(2);
a1 = -(x1*y2 - x2*y1);
a2 = y1 - y2;
a3 = x2 - x1;
for i = 1:length(z)
    Yp(i) = (a1 - a2 * z(i))/a3;
end
plot(z, Yp, 'g');

% Вывод результатов 
Pn = Pn';
max(Pn)
P
err1
err2
Pmax    % 55.5
err1max % 45
err2max % 44
jjmax   % 1738
% Wmax

