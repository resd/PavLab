function [  ] = lab5(  )
clc;
y(1:100,1)=0; % ������ ������� �������� ����� �������
y(101:200,1)=1; % ���-�� �������� ����� ���-�� ��������
y(1:100,2)=1;
y(101:200,2)=0;
ws = load ('classes2.mat');
class1 = ws.class1;
class2 = ws.class2;
pr = 2;
Amain(class1, class2, pr)
n1 = 100;
n2 = 100;
N = n1 + n2;
X=[class1; class2];
yn  = 1;
nn1 = 1;
nn2 = 1;
s = 40;
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
W=[1, 1; 1, 1];%; 1, 1
class01 = class*0.1;
e1 = 0;
e2 = 0;
Pmax = 0;
err1max=0;
err2max=0;
jjmax=0;
Wmax=[];
flag = false;
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
        if (mod(i, 2) == 1)&&((yy1==1)||(yy2==0)) % ���� ������� �� ������� ����� 1
            err1=err1+1;
            flag = true;
        end
        if (mod(i, 2) == 0)&&((yy1==0)||(yy2==1)) % ���� ������� �� ������� ����� 0
            err2=err2+1;
            flag = true;
        end
        for ii = 1:N
            s1 = class(ii,:)*W(1,:)';
            s2 = class(ii,:)*W(2,:)';
            if (s1>0) yy1 = 1;
            else yy1 = 0;
            end
            if (s2>0) yy2 = 1;
            else yy2 = 0;
            end
            if (mod(ii, 2) == 1)&&((yy1==1)||(yy2==0)) % ���� ������� �� ������� ����� 1
                err1=err1+1;
            end
            if (mod(ii, 2) == 0)&&((yy1==0)||(yy2==1)) % ���� ������� �� ������� ����� 0
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
%         flag = false;
    end
end
Pn = Pn';
P
err1
err2
Pmax    % 54.5
err1max % 50
err2max % 41
jjmax   % 24
% Wmax
