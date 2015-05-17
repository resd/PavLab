function [ output_args ] = lab6Test( input_args )
%LAB6TEST Summary of this function goes here
%   Detailed explanation goes here
clear all;
clc;
ws = load ('classessss1.mat');
class1 = ws.class1;
class2 = ws.class2;
pr = 2;
Amain(class1, class2, pr)
return;
% n1 = 100;
% n2 = 100;
% N = n1 + n2;
% y(1:n1,1)=0;
% y(1:n1,2)=1;
% y(n1+1:n1+n2,1)=1;
% y(n1+1:n1+n2,2)=0;
% y = y';
% ws = load ('classes2.mat');
% class1 = ws.class1;
% class2 = ws.class2;
% x=[class1; class2]';
% plot(x,y,'o')
% return;
x = [0 1 2 3; 4 5 6 7 ];
t = [0 0.84 0.91 0.14; -0.77 -0.96 -0.28 0.66];
% figure(1);
% plot(x,t,'o')
% net = feedforwardnet(10);
size(x)
size(t)
net=newff(minmax(x),[8 2],{'tansig','purelin'});
net.trainParam.show = 1;
net.trainParam.epochs = 20;
net = train(net,x,t);
y1 = sim(net,x)
s = y1;%[2 4]
n1= 1;
n2 = 1;
N = 8;
s1 = s(1:n1, :);
s2 = s(n1+1:n1+n2, :);
err1=0;
err2=0;
for i=1:1:4
    s1(1,i)
    t(1,i)
    if abs(s1(1,i)-t(1,i)) > 0.01
        err1=err1+1;
    end
    if abs(s2(1,i) - t(2,i)) > 0.01
        err2=err2+1;
    end
end
err1
err2
tppr = (1 - (err1 + err2) / N) * 100.0
figure(2);
plot(x,t,'o',x,y1,'x')
% net = train(net,x,t);
% y2 = sim(net,x)
% figure(3);
% plot(x,t,'o',x,y1,'+',x,y2,'*')
% % % plot(x,t,'o',x,y2,'x')
end

