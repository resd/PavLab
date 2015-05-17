function [ output_args ] = TestTest( input_args )
%TESTTEST Summary of this function goes here
%   Detailed explanation goes here
clc;
ws = load ('classes2.mat');
class1 = ws.class1;
class2 = ws.class2;
pr = 2;
% Amain(class1, class2, pr) % 68.5000   18.0000   45.0000
global w;
plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');
hold on;
minX = round(min(min(min(class1, class2)))); % -19
maxX = round(max(max(max(class1, class2)))); %  26
% -1.6743    1.7086    0.4728   -0.5068
% w(3)/w(1)%, 0
%0, 
% w(3)/w(2)
% y=(0.07814008+0.2767x)/0.2824
z = minX:maxX;
x1 = w(3)/w(1);
x2 = 0;
y1 = 0;
y2 = w(3)/w(2);
a1 = -(x1*y2 - x2*y1);
a2 = y1 - y2;
a3 = x2 - x1;
for i = 1:length(z)
    y(i) = (a1 - a2 * z(i))/a3;
end
w1 = [w(3)/w(1),0];%/w(1)
w2 = [0,w(3)/w(2)];%/w(2)
% plot(w1, w2,'g');
plot(z, y, 'g');
end

