function [ res, w ] = lab5With2Neuron( class1, class2, pr )
%LAB5WITH3NEURON Summary of this function goes here
%   Detailed explanation goes here
clc;
s = 20; % ���������� ������ ��������
n1 = length(class1);
n2 = length(class2);
N = n1 + n2;
yn  = 1;
nn1 = 1;
nn2 = 1;
y = zeros(N,pr);
for i = 1:N
    if mod(i, 2) == 1 % ���� ������� �� ������� ����� 1
        class(i, :) = class1(nn1,:); % � �������������� ���� ��� 1 �����
        y(yn, 2)    = 1; % if pr == 2
        nn1         = nn1+1;
        yn          = yn+1;
    else
        class(i, :) = class2(nn2,:);
        y(yn, 1)    = 1; % if pr == 2
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
pn = [];
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
    end
    pn(j) = Pmax*100;
end
w = Wmax(:);
% plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+');
% hold on;
% minX = round(min(min(min(class1, class2))));
% maxX = round(max(max(max(class1, class2))));
% z = minX:maxX;
% x1 = w(4)/w(2);%w(3)/w(1);
% x2 = 0;
% y1 = 0;
% y2 = w(3)/w(1);%w(4)/w(2);
% a1 = -(x1*y2 - x2*y1);
% a2 = y1 - y2;
% a3 = x2 - x1;
% for i = 1:length(z)
%     Yp(i) = (a1 - a2 * z(i))/a3;
% end
% plot(z, Yp, 'g');
% Pn = Pn';
% P
% err1
% err2
figure(10);
bar(pn);
map = [ 0,      0.3,    0.5 ];
colormap(map)
grid on;
ylim([0 100]);
   % ����� ������ ����������� ���������� ��� �� ����� ������ (����)
xlabel('����� ������(����)');
ylabel('����������� ����������� �������������');
legend('������ �������');
res(1) = Pmax*100; % 54.5
res(2) = err1max; % 50
res(3) = err2max; % 41
res(4) = jjmax  ; % 24
res(5) = s;
% Wmax

end

