function [  ] = lab5(  )
clc;
y(1:100,1)=0;
y(101:200,1)=1;
y(1:100,2)=1;
y(101:200,2)=0;
ws = load ('classessss.mat');
class1 = ws.class1;
class2 = ws.class2;
n1 = 100;
n2 = 100;
N = n1 + n2;
X=[class1; class2];
W=[1, 1; 1, 1];
% for i = 1 : N
%     w(i,1) = 1;
%     w(i,2) = 1;
% end
s = 100;
e1 = 0;
e2 = 0;
for j=1:1:s
    err1=0;
    err2=0;
    for i=1:1:N
        s1=X(i,:)*W(1,:)';
        s2=X(i,:)*W(2,:)';
%         s1=X(i,:)*w(i,:)';
%         s2=X(i,:)*w(i,:)';
        if (s1>0)
            s1=1;
        else
            s1=0;
        end
        if (s2>0)
            s2=1;
        else
            s2=0;
        end
        y1=y(i,1)-s1;
        y2=y(i,2)-s2;
        if (i<101)&&((s1==1)||(s2==0))
            err1=err1+1;
            e1 = e1 + 1;
%         else
%             continue;
        end
        if (i>100)&&((s1==0)||(s2==1))
            err2=err2+1;
            e2 = e2 + 1;
%         else
%             continue;
        end
%         w(i,1) = w(i,1) + 0.1*y1*X(i,1);
%         w(i,2) = w(i,2) + 0.1*y1*X(i,2);
        W(1,1) = W(1,1) + 0.1*y1*X(i,1);
        W(1,2) = W(1,2) + 0.1*y1*X(i,2);
        W(2,1) = W(2,1) + 0.1*y2*X(i,1);
        W(2,2) = W(2,2) + 0.1*y2*X(i,2);
    end
end
W
err1
err2
e1
e2
