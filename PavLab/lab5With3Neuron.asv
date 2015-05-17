function [ output_args ] = lab5With3Neuron( class1, class2, pr )
%LAB5WITH3NEURON Summary of this function goes here
%   Detailed explanation goes here
clc;
ws = load ('classes10.mat');
class1 = ws.class1;
class2 = ws.class2;
pr = 2;
s = 40; % Количество циклов обучения
n1 = length(class1);
n2 = length(class2);
N = n1 + n2;
yn  = 1;
nn1 = 1;
nn2 = 1;
y = zeros(N,3);
for i = 1:N
    if mod(i, 2) == 1 % Если остаток от деления равен 1
        class(i, :) = class1(nn1,:); % и соответственно если это 1 класс
        y(yn, 1)    = -1;
        y(yn, 3)    = 1; 
        nn1         = nn1+1;
        yn          = yn+1;
    else
        class(i, :) = class2(nn2,:);
        y(yn, 1)    = -1;
        y(yn, 3)    = 1; 
        nn2         = nn2+1;
        yn          = yn+1;
    end
end
W=[1, 1; 1, 1];%; 1, 1
class01 = class*0.1;
Pmax = 0;
err1max=0;
err2max=0;
jjmax=0;
Wmax=[];
for j=1:1:s
    for i=1:1:N
        err1 = 0;
        err2 = 0;
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
        y1=y(i,1)-yy1;
        y2=y(i,2)-yy2;
        for ii = 1:N
            s1 = class(ii,:)*W(1,:)';
            s2 = class(ii,:)*W(2,:)';
            if (s1>0) yy1 = 1;
            else yy1 = 0;
            end
            if (s2>0) yy2 = 1;
            else yy2 = 0;
            end
            if (mod(ii, 2) == 1)&&((yy1==1)||(yy2==0)) % Если остаток от деления равен 1
                err1=err1+1;
            end
            if (mod(ii, 2) == 0)&&((yy1==0)||(yy2==1)) % Если остаток от деления равен 0
                err2=err2+1;
            end
        end
        
        P = 1 - (err1+err2)/N;
        Pn(i) = P;
        if (P > Pmax)
            Pmax=P;
            err1max=err1;
            err2max=err2;
            jjmax=j;
            Wmax=W;
        end
        W(1,1) = W(1,1) + y1*class01(i,1);
        W(1,2) = W(1,2) + y1*class01(i,2);
        W(2,1) = W(2,1) + y2*class01(i,1);
        W(2,2) = W(2,2) + y2*class01(i,2);
    end
end
w = Wmax(:);
plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');
hold on;
minX = round(min(min(min(class1, class2))));
maxX = round(max(max(max(class1, class2))));
z = minX:maxX;
x1 = w(4)/w(2);%w(3)/w(1);
x2 = 0;
y1 = 0;
y2 = w(3)/w(1);%w(4)/w(2);
a1 = -(x1*y2 - x2*y1);
a2 = y1 - y2;
a3 = x2 - x1;
for i = 1:length(z)
    Yp(i) = (a1 - a2 * z(i))/a3;
end
plot(z, Yp, 'g');
Pn = Pn';
P
err1
err2
Pmax    % 54.5
err1max % 50
err2max % 41
jjmax   % 24
% Wmax

end

