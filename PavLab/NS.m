function [ res ] = NS( cl1, cl2, pr )
%NS Summary of this function goes here
%   Detailed explanation goes here
%-------------------------------------LAB6
% for i = len-1: -1 :2
%     cl1 = getcl(i-1);
%     cl2 = getcli(i, len);
% end

%��������� ���������
%n=2;        %���������� ��������� � �������
%N=20;      %���������� �������� � ��������� �������
%s=20;       %���������� ������ ��������
n1 = length(cl1);
n2 = length(cl2);
N = n1 + n2;

%��������� ���������
err1 = 0;   %������ ������� ����
err2 = 0;   %������ ������� ����
P = 0;      %����������� ����������� �������������

%todo
%����������� ��������� �������������� ������� � ������������ ��������� X1, X2
%figure(12);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');hold on;

y(1:n1)=0;
y(n1+1:n1+n2)=1;

X=[cl1; cl2];

X = X'
y

%�������� ��������� ����
%minmax(X) - ������� ������������ nx2 ����������� � ������������ �������� ������� X
%[3,2] - ���������� �������� � ������ � ������ �����
%{'tansig','purelin'} - ������������� ������� �����
net=newff(minmax(X),[20,1],{'tansig','purelin'});
%net=newff(minmax(X),[20,1],{'tansig','tansig','purelin'},'traingd');


%��������� �������� ����
net.trainParam.show = 20;       %����� ���������� ������� �������� ����
net.trainParam.lr = 0.01;
net.trainParam.epochs = 100;    %����� �������� ����
net.trainParam.goal = 5e-2;     %�������� �������� ����

%�������� ���� ��������� ���������������
[net,tr]=train(net,X,y);

%����������� ������ 1 � 2 ���� � ����������� ����������� �������������
s = sim(net,X);

s1 = s(1,1:N);
%s1

err1=0;
err2=0;
for i=1:1:(N)
    if (i<(N+1))&&(s1(i)>1)% todo ������� ����� � 0.5 �� 1
        err1=err1+1;
    end
    if (i>N)&&(s1(i)<1)% � ����� � 0.5 �� 1 
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
