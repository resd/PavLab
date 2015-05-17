function [ res, v ] = lab6DontWork( class1, class2, pr )
%-------------------------------------LAB6
clc;
% clear all;
% s=sprintf('%s','LAB6:');disp(s);

%��������� ���������

%��������� ���������
eps = 0.1;
err1 = 0;   %������ ������� ����
err2 = 0;   %������ ������� ����
P = 0;      %����������� ����������� �������������
% ws = load ('classessss1.mat');
% class1 = ws.class1(1:100, :);
% class2 = ws.class2(1:100, :);
% pr = 2;
% Amain(class1, class2, pr)
n1 = length(class1);
n2 = length(class2);
N = n1 + n2;%���������� �������� � ��������� �������
%todo
%����������� ��������� �������������� ������� � ������������ ��������� X1, X2
%figure(12);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');hold on;

yp = zeros(n1,pr);
yp(:,2)=1;
yp1 = yp';
yp = [];
yp = zeros(n2,pr);
yp(:,1)=1;
yp2 = yp';
yn  = 1;
nn1 = 1;
nn2 = 1;
y2 = zeros(N,pr);
for i = 1:N
    if mod(i, 2) == 1 % ���� ������� �� ������� ����� 1
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
neuron = 200;
layout = pr;
v = [neuron, layout];
%�������� ��������� ����
%minmax(X) - ������� ������������ nx2 ����������� � ������������ �������� ������� X
%[3,2] - ���������� �������� � ������ � ������ �����
%{'tansig','purelin'} - ������������� ������� �����
% net=newff(minmax(X),[200,1],{'tansig','purelin'});
% net=newff(minmax(X),[200,2],{'tansig','tansig','purelin'},'traingd');
net=newff(minmax(X),[neuron,layout],{'tansig','tansig'},'traingd');


%��������� �������� ����
net.trainParam.show = 1;       %����� ���������� ������� �������� ����
net.trainParam.lr = 0.01;       
net.trainParam.epochs = 1000;    %����� �������� ����
net.trainParam.goal = 5e-2;     %�������� �������� ����

%�������� ���� ��������� ���������������
[net, tr, yy, e]=train(net,X,y);

%����������� ������ 1 � 2 ���� � ����������� ����������� �������������
s = sim(net,X);
s = s';
% size(s)
s1 = s(1:n1, :);
s2 = s(n1+1:N, :);
% s1
% net = train(net,p,t);

% y2 = sim(net,p);

% plot(p,t,'o',p,y1,'x',p,y2,'*')
xminmax = [0, n1+1];
pcolor = 'm';
z1 = 1:n1;
z2 = 1:n2;
%plot(X,y,'o', 'Color','r');
figure(1);
hold on;
title('Class 1');
plot(z1,yp1(1, :),'o', 'Color','r');
plot(z1,yp1(2, :),'o', 'Color','b');
plot(z1,s1(:, 1)','x', 'Color','r');
plot(z1,s1(:, 2)','x', 'Color','b');
plot(xminmax,[1+eps,1+eps],'Color',pcolor,'LineWidth',1)
plot(xminmax,[1-eps,1-eps],'Color',pcolor,'LineWidth',1)
plot(xminmax,[0+eps,0+eps],'Color',pcolor,'LineWidth',1)
plot(xminmax,[0-eps,0-eps],'Color',pcolor,'LineWidth',1)
legend('�������� �������� 1 ������ ��� 1 ��������', '�������� �������� 1 ������ ��� 2 ��������',...
    '��������� �������� 1 ������ ��� 1 ��������', '��������� �������� 1 ������ ��� 2 ��������', '���������� �������� �����������');
figure(2);
hold on;
title('Class 2');
plot(z2,yp2(1, :),'o', 'Color','r');
plot(z2,yp2(2, :),'o', 'Color','b');
plot(z2,s2(:, 1)','x', 'Color','r');
plot(z2,s2(:, 2)','x', 'Color','b');
plot(xminmax,[1+eps,1+eps],'Color',pcolor,'LineWidth',1)
plot(xminmax,[1-eps,1-eps],'Color',pcolor,'LineWidth',1)
plot(xminmax,[0+eps,0+eps],'Color',pcolor,'LineWidth',1)
plot(xminmax,[0-eps,0-eps],'Color',pcolor,'LineWidth',1)
legend('�������� �������� 2 ������ ��� 1 ��������', '�������� �������� 2 ������ ��� 2 ��������',...
        '��������� �������� 2 ������ ��� 1 ��������', '��������� �������� 2 ������ ��� 2 ��������', '���������� �������� �����������');
% close(1); % del
% close(2); % del
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

tppr = (1 - (err1 + err2) / N) * 100.0;

res(2) = err1;
res(3) = err2;
res(1) = tppr;